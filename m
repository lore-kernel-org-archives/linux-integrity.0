Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752101AbdJTSCi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2017 14:02:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9KI1dxI003130
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 14:02:37 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dqnxr8904-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 14:02:37 -0400
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 20 Oct 2017 12:02:36 -0600
Subject: Re: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
 performance
To: Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
 <20171017203232.2262-3-nayna@linux.vnet.ibm.com>
 <5ef60315f2254b3b8bcc217a572280e5@infineon.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 20 Oct 2017 14:02:33 -0400
MIME-Version: 1.0
In-Reply-To: <5ef60315f2254b3b8bcc217a572280e5@infineon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <7e0b3b9c-3daa-0f44-592a-8d40d0cb8cbf@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 10/20/2017 10:42 AM, Alexander.Steffen@infineon.com wrote:
> 
> This seems to fail reliably with my SPI TPM 2.0. I get EIO when
> trying to send large amounts of data, e.g. with TPM2_Hash, and
> subsequent tests seem to take an unusual amount of time. More
> analysis probably has to wait until November, since I am going to be
> in Prague next week.

I have a guess as to the cause of the failure.  Would it be possible for 
you to test it?

1 - My guess is that EIO is coming from here:

static int tpm_tis_send_data(struct tpm_chip *chip, u8 *buf, size_t len)
...
	/* write last byte */
	rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality), buf[count]);
	if (rc < 0)
		goto out_err;

	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
				&priv->int_queue, false) < 0) {
		rc = -ETIME;
		goto out_err;
	}
	status = tpm_tis_status(chip);
	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
		rc = -EIO;
		goto out_err;
	}
...

Can you verify that this is the cause.

2 - If that's the cause, I believe that there is a latent bug.  Expect 
is not guaranteed to become false immediately.  It only occurs after the 
TPM firmware has emptied the FIFO.  Thus, the tpm_tis_status() really 
should be something like "wait_for_tpm_expect_false()", with a sleep loop.

This missing wait has been in the code for a while.  If may just surface 
now because the patch causes data to be written faster, and thus it 
takes longer for the TPM to empty the FIFO and clear Expect.

It also makes sense that it would occur more often on long commands.
