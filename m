Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:3243 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbeBHNFy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 08:05:54 -0500
Date: Thu, 8 Feb 2018 15:05:50 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180208130550.fjw2gljtl5lp2caw@linux.intel.com>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1517498648.3145.4.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 01, 2018 at 03:24:08PM +0000, James Bottomley wrote:
> On Thu, 2018-02-01 at 12:42 +0000, James Bottomley wrote:
> > On Thu, 2018-02-01 at 13:21 +0100, Paul Menzel wrote:
> > > 
> > > Dear James,
> > > 
> > > 
> > > On 02/01/18 13:16, James Bottomley wrote:
> > > > 
> > > > 
> > > > Embarrassingly enough, I'm just on my way to do a TPM talk at
> > > > FOSDEM.   I installed my shiny new 4.15 kernel on the 'plane and
> > > > this is what I got after I arrived this morning:
> > > > 
> > > > jejb@jarvis:~> dmesg | grep -i tpm
> > > > [    0.000000] ACPI: TPM2 0x0000000079446CC0 000034
> > > > (v03        Tpm2Tabl 00000001 AMI  00000000)
> > > > [    1.598059] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-
> > > > id 
> > > > 2)
> > > > [    1.608863] tpm tpm0: A TPM error (2314) occurred continue
> > > > selftest
> > > > [    1.640052] tpm tpm0: A TPM error (2314) occurred continue
> > > > selftest
> > > > [    1.691215] tpm tpm0: A TPM error (2314) occurred continue
> > > > selftest
> > > > [    1.782377] tpm tpm0: A TPM error (2314) occurred continue
> > > > selftest
> > > > [    1.953539] tpm tpm0: A TPM error (2314) occurred continue
> > > > selftest
> > > > [    2.284701] tpm tpm0: A TPM error (2314) occurred continue
> > > > selftest
> > > > [    2.935743] tpm tpm0: A TPM error (2314) occurred continue
> > > > selftest
> > > > [    4.216236] tpm tpm0: TPM self test failed
> > > > [    4.236829] ima: No TPM chip found, activating TPM-bypass!
> > > > (rc=-
> > > > 19)
> > > > 
> > > > The error is TPM_RC_TESTING, which means it looks like we don't
> > > > wait long enough for the selftests to complete.  I get this all
> > > > the time booting with 4.15.  Fortunately I have a 4.13 backup
> > > > kernel which is fine (otherwise I'd be a bit hosed since all my
> > > > keys now require a TPM).
> > > > 
> > > > I'll debug on the train; my current suspicion is that the
> > > > TPM_LONG duration might be a bit short for this chip (A nuvoton
> > > > 6xx in a dell XPS-13).
> > > 
> > > Please join the thread [1], where I reported the same problem for
> > > the Dell XPS 13 9360. Unfortunately, no solution was found,
> > > especially, as I did not use the TPM. Other owners of that system
> > > unfortunately didn't have time to report back if it work for them,
> > > so the "conclusion" kind of was, that my TPM was broken, and had to
> > > be tested.
> > 
> > OK, I'll try to find a fix.  It's clearly a marginal problem since
> > I've booted most -rc kernels without issue, so there's some slight
> > timing change in 4.15 that triggered it.  It could also be a shutdown
> > issue.  Any NV ram stuff deferred to start up would take a variable
> > amount of time.
> > 
> > You'd almost think it's some sort of TPM self protest: the more stuff
> > I use it for the more problems it seems to create.  I'm definitely
> > motivated to fix it because without a TPM I can't actually do much
> > with my laptop.
> 
> OK, I investigated but now my TPM has returned to normal (as in it
> passes the selftest immediately).  There's clearly something that makes
> it return TPM_RC_TESTING to every self test probe for seconds at a
> time, but I don't know what it is.  Sending a different command seems
> to cause the problem to clear (Managed to reproduce once with the patch
> to verify), so this is my proposed fix.  It's clearly nonsensical to
> detach the driver because the self test still returns TPM_RC_TESTING,
> so convert that return to a TPM_RC_SUCCESS on timeout.  It prints a
> warning message so we'll see it in the logs if it causes problems.
>  Given that this seems to be some type of internal TPM issue, I don't
> believe changing the timings would work.

I don't think this is a sane rationale for a fix if the driver has
worked just fine on 4.14. It would be better to first identify the
commit that causes the regression and plan after that how to fix it.

/Jarkko
