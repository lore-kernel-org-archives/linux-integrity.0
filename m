Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35919 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932918AbeFVVNt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jun 2018 17:13:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id a12-v6so3762390pfi.3
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 14:13:49 -0700 (PDT)
Date: Fri, 22 Jun 2018 15:13:46 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] tpm: Implement tpm_chip_find() for other
 subsystems to find a TPM chip
Message-ID: <20180622211346.GF19151@ziepe.ca>
References: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
 <20180622164613.1609313-3-stefanb@linux.vnet.ibm.com>
 <20180622204319.GE19151@ziepe.ca>
 <6f4d9302-8399-e73a-f8d0-d493658c1980@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6f4d9302-8399-e73a-f8d0-d493658c1980@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 22, 2018 at 04:45:47PM -0400, Stefan Berger wrote:
> On 06/22/2018 04:43 PM, Jason Gunthorpe wrote:
> >On Fri, Jun 22, 2018 at 12:46:11PM -0400, Stefan Berger wrote:
> >>Implement tpm_chip_find() for other subsystems to find a TPM chip and
> >>get a reference to that chip.
> >>
> >>Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>  drivers/char/tpm/tpm-chip.c | 27 +++++++++++++++++++++++++++
> >>  include/linux/tpm.h         |  5 +++++
> >>  2 files changed, 32 insertions(+)
> >>
> >>diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> >>index 4e83695af068..2520555b1e17 100644
> >>+++ b/drivers/char/tpm/tpm-chip.c
> >>@@ -81,6 +81,33 @@ void tpm_put_ops(struct tpm_chip *chip)
> >>  EXPORT_SYMBOL_GPL(tpm_put_ops);
> >>  /**
> >>+ * tpm_chip_find() - find a TPM chip and get a reference to it
> >>+ */
> >>+struct tpm_chip *tpm_chip_find(void)
> >I feel like this should be called 'tpm_default_chip()'
> >
> >>+{
> >>+	struct tpm_chip *chip, *res = NULL;
> >>+	int chip_num = 0;
> >>+	int chip_prev;
> >>+
> >>+	mutex_lock(&idr_lock);
> >>+
> >>+	do {
> >>+		chip_prev = chip_num;
> >>+		chip = idr_get_next(&dev_nums_idr, &chip_num);
> >>+		if (chip) {
> >>+			get_device(&chip->dev);
> >>+			res = chip;
> >>+			break;
> >>+		}
> >>+	} while (chip_prev != chip_num);
> >>+
> >>+	mutex_unlock(&idr_lock);
> >And what was tpm_chip_find_get should just call this function..
> And then after that each time tpm_get_ops() ?

It is best to keep the tpm_chip_find_get/tpm_put_ops for internal use
as it also manages the kref lifetime of chip in a subtle way, it
relies on the ops lock not the kref to keep the memory valid when it
has a NULL parameter..

Something like this:

struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
{
    int rc;

    if (chip) {
          if (!tpm_try_get_ops(chip))
	      return NULL;
	  return chip;
    }

    chip = tpm_default_chip();
    rc = tpm_try_get_ops(chip));
    put_device(&chip->dev);

    if (rc)
           return NULL;
    return chip;
}

Jason
