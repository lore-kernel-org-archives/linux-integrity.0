Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from anor.bigon.be ([91.121.173.99]:44867 "EHLO anor.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753320AbdJUJCk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 21 Oct 2017 05:02:40 -0400
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
To: Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Alexander.Steffen@infineon.com, tpmdd-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org
References: <f9526f55-df96-64fc-a4d6-877ce04e7156@debian.org>
 <dcad0104c46d4d5f88e642862bdb42c2@MUCSE603.infineon.com>
 <47c4300b-8701-79a6-1c58-3a5853f4c5e3@debian.org>
 <595efb25-8d87-f39d-037f-9c9a98462339@debian.org>
 <857106e4bb864bb8a68b1381fffc8f50@MUCSE603.infineon.com>
 <20170831164015.3ajgwydgxtippwoz@rhwork>
 <0d9be244-ace0-030d-6ff9-c4e94c63b7e9@debian.org>
 <20170906040555.fqedhmo5277sd6fq@linux.intel.com>
 <20171014081318.busge2fhteusfjwx@rhwork>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <b63b765d-2477-d9fe-9d80-c2ea7e582bce@debian.org>
Date: Sat, 21 Oct 2017 10:53:55 +0200
MIME-Version: 1.0
In-Reply-To: <20171014081318.busge2fhteusfjwx@rhwork>
Content-Type: multipart/mixed;
 boundary="------------A9FE3B2D3EA7C477C0DA4586"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Le 14/10/17 a 10:13, Jerry Snitselaar a ecrit :
> On Wed Sep 06 17, Jarkko Sakkinen wrote:
>> On Fri, Sep 01, 2017 at 02:10:18PM +0200, Laurent Bigonville wrote:
>>> Le 31/08/17 a 18:40, Jerry Snitselaar a ecrit :
>>> > On Thu Aug 31 17, Alexander.Steffen@infineon.com wrote:
>>> > > > Le 29/08/17 a 18:35, Laurent Bigonville a ecrit :
>>> > > > > Le 29/08/17 a 18:00, Alexander.Steffen@infineon.com a ecrit :
>>> > > > >>> An idea how to troubleshoot this?
>>> > > > >> Can you run git bisect on the changes between 4.11 and 
>>> 4.12, so that
>>> > > > >> we find the offending commit? It is probably sufficient to 
>>> limit the
>>> > > > >> search to commits that touch something in drivers/char/tpm.
>>> > > > >
>>> > > > > I'll try and keep you posted.
>>> > > >
>>> > > > OK I've been able to bisect the problem and the bad commit is:
>>> > > >
>>> > > > e6aef069b6e97790cb127d5eeb86ae9ff0b7b0e3 is the first bad commit
>>> > > > commit e6aef069b6e97790cb127d5eeb86ae9ff0b7b0e3
>>> > > > Author: Jerry Snitselaar <jsnitsel@redhat.com>
>>> > > > Date:   Mon Mar 27 08:46:04 2017 -0700
>>> > > >
>>> > > >      tpm_tis: convert to using locality callbacks
>>> > > >
>>> > > >      This patch converts tpm_tis to use of the new tpm class ops
>>> > > >      request_locality, and relinquish_locality.
>>> > > >
>>> > > >      With the move to using the callbacks, release_locality is
>>> > > > changed so
>>> > > >      that we now release the locality even if there is no
>>> > > > request pending.
>>> > > >
>>> > > >      This required some changes to the tpm_tis_core_init code 
>>> path to
>>> > > >      make sure locality is requested when needed:
>>> > > >
>>> > > >        - tpm2_probe code path will end up calling
>>> > > > request/release through
>>> > > >          callbacks, so request_locality prior to tpm2_probe 
>>> not needed.
>>> > > >
>>> > > >        - probe_itpm makes calls to tpm_tis_send_data which no
>>> > > > longer calls
>>> > > >          request_locality, so add request_locality prior to
>>> > > > tpm_tis_send_data
>>> > > >          calls. Also drop release_locality call in middleof
>>> > > > probe_itpm, and
>>> > > >          keep locality until release_locality called at end of
>>> > > > probe_itpm.
>>> > > >
>>> > > >      Cc: Peter Huewe <peterhuewe@gmx.de>
>>> > > >      Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>> > > >      Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>>> > > >      Cc: Marcel Selhorst <tpmdd@selhorst.net>
>>> > > >      Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>> > > >      Reviewed-by: Jarkko Sakkinen 
>>> <jarkko.sakkinen@linux.intel.com>
>>> > > >      Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>> > > >      Signed-off-by: Jarkko Sakkinen 
>>> <jarkko.sakkinen@linux.intel.com>
>>> > > >
>>> > > > :040000 040000 70234365da69959d47076ebb40c8d17f520c3e44
>>> > > > 72f21b446e45ea1003de75902b0553deb99157fd M drivers
>>> > > >
>>> > >
>>> > > I've looked again at the code in question, but could not find
>>> > > anything that is obviously wrong there. Locality is now
>>> > > requested/released at slightly different points in the process than
>>> > > before, but that's it. It does not seem to cause problems with the
>>> > > majority of TPMs, since you are the first to report any, so 
>>> maybe it
>>> > > is a quirk that only affects this device.
>>> > >
>>> > > Perhaps Jerry can help, since this is his change?
>>> > >
>>> > > Alexander
>>> >
>>> > Getting some caffeine in me, and starting to take a look. Adding
>>> > Jarkko as well since this might involve the general locality changes.
>>> >
>>> > Laurent, if I send you a patch with some debugging code added, would
>>> > you be able to run it on that system? I wasn't running into issues
>>> > on the system I had with a 1.2 device, but I no longer have access
>>> > to it. I'll see if I can find one in our labs and reproduce it there.
>>>
>>> Yes I should be able to do that
>>
>> Any findings?
>>
>> /Jarkko
>
> Okay, finally getting back to this. Looking at the code it isn't clear 
> to me
> why the change is causing this. So while I stare at this some more 
> Laurent
> could you reproduce it with this patch so I can see what the status and
> access registers look like? Does anyone else on here happen to have a 
> Sinosun
> tpm device? The systems I have access to with TPM1.2 devices don't 
> have this
> issue.
>
> --8<--
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c 
> b/drivers/char/tpm/tpm_tis_core.c
> index fdde971bc810..7d60a7e4b50a 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -258,6 +258,7 @@ static int tpm_tis_send_data(struct tpm_chip 
> *chip, const u8 *buf, size_t len)
>     int rc, status, burstcnt;
>     size_t count = 0;
>     bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
> +    u8 access;
>
>     status = tpm_tis_status(chip);
>     if ((status & TPM_STS_COMMAND_READY) == 0) {
> @@ -292,6 +293,11 @@ static int tpm_tis_send_data(struct tpm_chip 
> *chip, const u8 *buf, size_t len)
>         }
>         status = tpm_tis_status(chip);
>         if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
> +            rc = tpm_tis_read8(priv, TPM_ACCESS(priv->locality), 
> &access);
> +            if (rc < 0)
> +                dev_info(&chip->dev, "TPM_STS_DATA_EXPECT == 0: read 
> failure TPM_ACCESS(%d)\n", priv->locality);
> +            else
> +                dev_info(&chip->dev, "TPM_STS_DATA_EXPECT == 0: 
> locality: %d status: %x access: %x\n", priv->locality, status, access);
>             rc = -EIO;
>             goto out_err;
>         }
> @@ -309,6 +315,11 @@ static int tpm_tis_send_data(struct tpm_chip 
> *chip, const u8 *buf, size_t len)
>     }
>     status = tpm_tis_status(chip);
>     if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
> +        rc = tpm_tis_read8(priv, TPM_ACCESS(priv->locality), &access);
> +        if (rc < 0)
> +            dev_info(&chip->dev, "TPM_STS_DATA_EXPECT != 0: read 
> failure TPM_ACCESS(%d)\n", priv->locality);
> +        else
> +            dev_info(&chip->dev, "TPM_STS_DATA_EXPECT != 0: locality: 
> %d status: %x access: %x\n", priv->locality, status, access);
>         rc = -EIO;
>         goto out_err;
>     }

Please find here the dmesg output of the patched kernel


    [ Part 2, Application/GZIP (Name: "dmesg.txt.gz") 20 KB. ]
    [ Unable to print this part. ]
