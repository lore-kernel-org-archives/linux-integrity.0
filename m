Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43792 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754594AbeBAUAI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 15:00:08 -0500
Message-ID: <1517515204.3145.51.camel@HansenPartnership.com>
Subject: Re: TPM selftest failure in 4.15
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 01 Feb 2018 21:00:04 +0100
In-Reply-To: <20180201185909.GW17053@ziepe.ca>
References: <1517487371.3251.9.camel@HansenPartnership.com>
         <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
         <1517488970.3251.26.camel@HansenPartnership.com>
         <1517498648.3145.4.camel@HansenPartnership.com>
         <20180201174053.GQ17053@ziepe.ca>
         <1517510764.3145.38.camel@HansenPartnership.com>
         <20180201185909.GW17053@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-02-01 at 11:59 -0700, Jason Gunthorpe wrote:
> On Thu, Feb 01, 2018 at 07:46:04PM +0100, James Bottomley wrote:
> 
> > 
> > I honestly don't think we should be waiting for the self test at
> > all.
> > We should kick it off and treat any TPM_RC_TESTING error as
> > -EAGAIN.
> > We're already under fire for slow boot sequences and adding 2s just
> > to
> > wait for the TPM to self test adds to that for no real value.
> 
> Arguably the BIOS should have completed the selftest - this stuff
> generally only exists to support embedded.
> 
> I don't like the idea of EAGAIN, that just expose all our users to
> this mess.
> 
> I would support making transmit_cmd genericly wait and retry if the
> TPM insists we need to wait for selftest to complete the specific
> command though.

OK, how about this then?

James

---

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1d6729be4cd6..84ed271c060b 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -521,12 +521,32 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 	const struct tpm_output_header *header = buf;
 	int err;
 	ssize_t len;
+	unsigned int delay_msec = 20;
 
-	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
-	if (len <  0)
-		return len;
+	/*
+	 * on first probe we kick off a TPM self test in the
+	 * background This means the TPM may return RC_TESTING to any
+	 * command that tries to use a subsystem under test, so do an
+	 * exponential backoff wait if that happens
+	 */
+	for (;;) {
+		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
+		if (len <  0)
+			return len;
+
+		err = be32_to_cpu(header->return_code);
+		if (err != TPM2_RC_TESTING ||
+		    (flags & TPM_TRANSMIT_NOWAIT))
+			break;
+
+		delay_msec *= 2;
+		if (delay_msec > TPM2_DURATION_LONG) {
+			dev_err(&chip->dev,"TPM: still running self tests, giving up waiting\n");
+			break;
+		}
+		tpm_msleep(delay_msec);
+	}
 
-	err = be32_to_cpu(header->return_code);
 	if (err != 0 && desc)
 		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
 			desc);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 528cffbd49d3..47c5a5206325 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -495,6 +495,7 @@ extern struct idr dev_nums_idr;
 enum tpm_transmit_flags {
 	TPM_TRANSMIT_UNLOCKED	= BIT(0),
 	TPM_TRANSMIT_RAW	= BIT(1),
+	TPM_TRANSMIT_NOWAIT	= BIT(2),
 };
 
 ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index f40d20671a78..106c126b4fe0 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -849,28 +849,24 @@ static const struct tpm_input_header tpm2_selftest_header = {
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
 	int rc;
-	unsigned int delay_msec = 20;
-	long duration;
 	struct tpm2_cmd cmd;
 
-	duration = jiffies_to_msecs(
-		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
-
-	while (duration > 0) {
-		cmd.header.in = tpm2_selftest_header;
-		cmd.params.selftest_in.full_test = 0;
-
-		rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
-				      0, 0, "continue selftest");
-
-		if (rc != TPM2_RC_TESTING)
-			break;
-
-		tpm_msleep(delay_msec);
-		duration -= delay_msec;
-
-		/* wait longer the next round */
-		delay_msec *= 2;
+	cmd.header.in = tpm2_selftest_header;
+	cmd.params.selftest_in.full_test = 0;
+
+	rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
+			      0, TPM_TRANSMIT_NOWAIT, "continue selftest");
+
+	if (rc == TPM2_RC_TESTING) {
+		/*
+		 * A return of RC_TESTING means the TPM is still
+		 * running self tests.  If one fails it will go into
+		 * failure mode and return RC_FAILED to every command,
+		 * so treat a still in testing return as a success
+		 * rather than causing a driver detach.
+		 */
+		dev_info(&chip->dev,"TPM: Running self test in background\n");
+		rc = TPM2_RC_SUCCESS;
 	}
 
 	return rc;
