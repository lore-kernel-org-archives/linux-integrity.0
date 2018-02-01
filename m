Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:31292 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754663AbeBAUMK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 15:12:10 -0500
From: <Mario.Limonciello@dell.com>
To: <pmenzel@molgen.mpg.de>, <James.Bottomley@HansenPartnership.com>
CC: <linux-integrity@vger.kernel.org>, <regressions@leemhuis.info>,
        <Alexander.Steffen@infineon.com>
Subject: RE: TPM selftest failure in 4.15 (Dell XPS 13, Nuvoton 6xx)
Date: Thu, 1 Feb 2018 20:12:07 +0000
Message-ID: <d95f60f2e375446db3987f7d082d5cdd@ausx13mpc120.AMER.DELL.COM>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <4384419e-b2c6-7c51-e905-281ddfe68442@molgen.mpg.de>
 <d9c63b11-363a-2007-d7d5-a0112e58cb46@molgen.mpg.de>
In-Reply-To: <d9c63b11-363a-2007-d7d5-a0112e58cb46@molgen.mpg.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Paul Menzel [mailto:pmenzel@molgen.mpg.de]
> Sent: Thursday, February 1, 2018 1:17 PM
> To: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: linux-integrity <linux-integrity@vger.kernel.org>; Limonciello, Mario
> <Mario_Limonciello@Dell.com>; regressions@leemhuis.info; Alexander Steffen
> <Alexander.Steffen@infineon.com>
> Subject: Re: TPM selftest failure in 4.15 (Dell XPS 13, Nuvoton 6xx)
> 
> [resend with regressions@ address fixed, sorry]
> 
> Am 01.02.2018 um 20:16 schrieb Paul Menzel:
> > Dear James,
> >
> >
> > Am 01.02.2018 um 16:24 schrieb James Bottomley:
> >> On Thu, 2018-02-01 at 12:42 +0000, James Bottomley wrote:
> >>> On Thu, 2018-02-01 at 13:21 +0100, Paul Menzel wrote:
> >
> >>>> On 02/01/18 13:16, James Bottomley wrote:
> >>>>>
> >>>>>
> >>>>> Embarrassingly enough, I'm just on my way to do a TPM talk at
> >>>>> FOSDEM.   I installed my shiny new 4.15 kernel on the 'plane and
> >>>>> this is what I got after I arrived this morning:
> >>>>>
> >>>>> jejb@jarvis:~> dmesg | grep -i tpm
> >>>>> [    0.000000] ACPI: TPM2 0x0000000079446CC0 000034
> >>>>> (v03        Tpm2Tabl 00000001 AMI  00000000)
> >>>>> [    1.598059] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> >>>>> [    1.608863] tpm tpm0: A TPM error (2314) occurred continue selftest
> >>>>> [    1.640052] tpm tpm0: A TPM error (2314) occurred continue selftest
> >>>>> [    1.691215] tpm tpm0: A TPM error (2314) occurred continue selftest
> >>>>> [    1.782377] tpm tpm0: A TPM error (2314) occurred continue selftest
> >>>>> [    1.953539] tpm tpm0: A TPM error (2314) occurred continue selftest
> >>>>> [    2.284701] tpm tpm0: A TPM error (2314) occurred continue selftest
> >>>>> [    2.935743] tpm tpm0: A TPM error (2314) occurred continue selftest
> >>>>> [    4.216236] tpm tpm0: TPM self test failed
> >>>>> [    4.236829] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> >>>>>
> >>>>> The error is TPM_RC_TESTING, which means it looks like we don't
> >>>>> wait long enough for the selftests to complete.  I get this all
> >>>>> the time booting with 4.15.  Fortunately I have a 4.13 backup
> >>>>> kernel which is fine (otherwise I'd be a bit hosed since all my
> >>>>> keys now require a TPM).
> >>>>>
> >>>>> I'll debug on the train; my current suspicion is that the
> >>>>> TPM_LONG duration might be a bit short for this chip (A nuvoton
> >>>>> 6xx in a dell XPS-13).
> >>>>
> >>>> Please join the thread [1], where I reported the same problem for
> >>>> the Dell XPS 13 9360. Unfortunately, no solution was found,
> >>>> especially, as I did not use the TPM. Other owners of that system
> >>>> unfortunately didn't have time to report back if it work for them,
> >>>> so the "conclusion" kind of was, that my TPM was broken, and had to
> >>>> be tested.
> >>>
> >>> OK, I'll try to find a fix.  It's clearly a marginal problem since
> >>> I've booted most -rc kernels without issue, so there's some slight
> >>> timing change in 4.15 that triggered it.  It could also be a shutdown
> >>> issue.  Any NV ram stuff deferred to start up would take a variable
> >>> amount of time.
> >>>
> >>> You'd almost think it's some sort of TPM self protest: the more stuff
> >>> I use it for the more problems it seems to create.  I'm definitely
> >>> motivated to fix it because without a TPM I can't actually do much
> >>> with my laptop.
> >>
> >> OK, I investigated but now my TPM has returned to normal (as in it
> >> passes the selftest immediately).  There's clearly something that makes
> >> it return TPM_RC_TESTING to every self test probe for seconds at a
> >> time, but I don't know what it is.  Sending a different command seems
> >> to cause the problem to clear (Managed to reproduce once with the patch
> >> to verify), so this is my proposed fix.  It's clearly nonsensical to
> >> detach the driver because the self test still returns TPM_RC_TESTING,
> >> so convert that return to a TPM_RC_SUCCESS on timeout.  It prints a
> >> warning message so we'll see it in the logs if it causes problems.
> >>   Given that this seems to be some type of internal TPM issue, I don't
> >> believe changing the timings would work.
> >
> > Maybe Mario can confirm this issue too, now that Linux 4.15 is released.
> > Maybe he also has a way to get the Nuvoton people involved.

James,

Did you actually experiment with changing the timings?

I was told that TPMs that are FIPS validated (such as that in the XPS 13) may 
take longer for the self tests to run.

> >
> >> ---
> >>
> >> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> >> index f40d20671a78..3e1b062d8888 100644
> >> --- a/drivers/char/tpm/tpm2-cmd.c
> >> +++ b/drivers/char/tpm/tpm2-cmd.c
> >> @@ -872,6 +872,17 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
> >>           /* wait longer the next round */
> >>           delay_msec *= 2;
> >>       }
> >> +    if (rc == TPM2_RC_TESTING) {
> >> +        /*
> >> +         * A return of RC_TESTING means the TPM is still
> >> +         * running self tests.  If one fails it will go into
> >> +         * failure mode and return RC_FAILED to every command,
> >> +         * so treat a still in testing return as a success
> >> +         * rather than causing a driver detach.
> >> +         */
> >> +        dev_err(&chip->dev,"TPM: Still in testing mode after %dms,
> >> continuing\n", delay_msec);
> >> +        rc = TPM2_RC_SUCCESS;
> >> +    }
> >>       return rc;
> >>   }
> >
> > Alexander replied the following in the other thread. No idea if you read
> > it yet.
> >
> >> The list of "A TPM error (2314) occurred continue selftest" is caused
> >> by my commit 125a2210541079e8e7c69e629ad06cabed788f8c ("tpm: React
> >> correctly to
> >> RC_TESTING from TPM 2.0 self tests") [1]. 2314 is TPM_RC_TESTING, so
> >> the TPM
> >> tells us that self-tests are still running in the background. This
> >> problem was
> >> not visible in previous versions, since it (incorrectly) ignored >
> >> TPM_RC_TESTING.
> >
> > Maybe the commit should be reverted for now until this has cleared up
> > for the Dell XPS 13 9360(?) to adhere to Linux' no regression policy.
> >
> >
> > Kind regards,
> >
> > Paul
> >
> >
> > PS: Alexander will also be at FOSDEM and mentioned your talk [2].
> >
> >
> > [1]
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=125
> a2210541079e8e7c69e629ad06cabed788f8[2]
> > https://lists.01.org/pipermail/tpm2/2018-January/000486.html
