Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:58637 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeEDIUd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 May 2018 04:20:33 -0400
Date: Fri, 4 May 2018 11:20:29 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Laurent Bigonville <bigon@debian.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Alexander.Steffen@infineon.com,
        linux-integrity@vger.kernel.org
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
Message-ID: <20180504082029.GD6373@linux.intel.com>
References: <1510672631.4078.7.camel@HansenPartnership.com>
 <20171117131620.het4yxavz6lco6ow@linux.intel.com>
 <67ca8d8f-bd2c-a1ad-72d1-7f4b8df0a847@debian.org>
 <20180103003355.oaie7tych5lmtxiq@cantor>
 <bea3c5c2-4abe-27bc-3fe0-761457cca897@debian.org>
 <20180214114353.tw72tztmth2agpqu@linux.intel.com>
 <58cd2dfe-24e7-e320-c7ef-153ba5855835@debian.org>
 <d7d5a45fd2479eaf4495adde53391d53ee6d1ca6.camel@linux.intel.com>
 <471775d9-374a-a97b-dacd-a4ca2beb56eb@debian.org>
 <20180503174311.d7bejzqjclvdcfyn@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180503174311.d7bejzqjclvdcfyn@cantor>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 03, 2018 at 10:43:11AM -0700, Jerry Snitselaar wrote:
> On Thu May 03 18, Laurent Bigonville wrote:
> > Le 15/03/18 a 17:24, Jarkko Sakkinen a ecrit :
> > > On Fri, 2018-03-09 at 18:24 +0100, Laurent Bigonville wrote:
> > > > The duration that that was in your patch seems to work, cannot this be
> > > > implemented?
> > > > 
> > > > I'm quite surprised I'm the only one impacted by this...
> > > Sorry it took so long time response but I had forgotten so too many
> > > details.
> > > 
> > > After re-reading (PHEW!) the whole thread I'm thinking if we could
> > > use section 5.5.2.4 as a reference to select a timeout of TIMEOUT_A
> > > (albeit it is for request locality) and use Jerry's suggestion to
> > > put wait_for_tpm_stat() there? Opinions?
> > Hey,
> > 
> > Sorry to bother you again, but are there any progress on getting this
> > mainlined?
> > 
> > Kind regards,
> > 
> > Laurent Bigonville
> 
> Jarkko would something like this work? Building it to test on tpm2.0 system right now.
> I don't have access to a system with a tpm1.2 tis device at the moment. I tested a
> patch similar to this based on the slightly older code that is currently in the
> rhel kernel and it seemed work fine. release_locality was still a void function
> back then, so might have to think more about the return values here and checking
> them. Also wondering if release_locality, check_locality, and wait_for_tpm_stat
> can be refactored since they would all have basically the same chunk of code.
> 
> Jerry
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 5a1f47b43947..31ee154450eb 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -143,12 +143,56 @@ static bool check_locality(struct tpm_chip *chip, int l)
>        return false;
> }
> 
> +static bool locality_inactive(struct tpm_chip *chip, int l)
> +{
> +       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +       int rc;
> +       u8 access;
> +
> +       rc = tpm_tis_read8(priv, TPM_ACCESS(l), &access);
> +       if (rc < 0)
> +               return false;
> +
> +       if ((access & (TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY)) == TPM_ACCESS_VALID)
> +               return true;
> +
> +       return false;
> +}
> +
> static int release_locality(struct tpm_chip *chip, int l)
> {
>        struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +       unsigned long stop, timeout;
> +       long rc;
> 
>        tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> 
> +       stop = jiffies + chip->timeout_a;
> +
> +       if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> +again:
> +               timeout = stop - jiffies;
> +               if ((long)timeout <= 0)
> +                       return -1;
> +
> +               rc = wait_event_interruptible_timeout(priv->int_queue,
> +                                                     (locality_inactive(chip, l)),
> +                                                     timeout);
> +
> +               if (rc > 0)
> +                       return rc;
> +
> +               if (rc == -ERESTARTSYS && freezing(current)) {
> +                       clear_thread_flag(TIF_SIGPENDING);
> +                       goto again;
> +               }
> +       } else {
> +               do {
> +                       if (locality_inactive(chip, l))
> +                               return 0;
> +                       tpm_msleep(TPM_TIMEOUT);
> +               } while (time_before(jiffies, stop));
> +       }

Maybe have the second branch first with a return statement and
convert the thing going on in the first branch as a loop?

/Jarkko
