Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:44625 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753217AbeABOnK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jan 2018 09:43:10 -0500
Date: Tue, 2 Jan 2018 16:43:05 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Chris Chiu <chiu@endlessm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: TPM driver breaks S3 suspend
Message-ID: <20180102144305.jjjss4nj5yviyiwd@linux.intel.com>
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
 <20171224203335.su56j5qs6rt6wd4v@linux.intel.com>
 <CAB4CAwf+nWQ-dpYA1N2oHvODPj01cefoPzzNT00c2h9daXvSRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB4CAwf+nWQ-dpYA1N2oHvODPj01cefoPzzNT00c2h9daXvSRw@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 25, 2017 at 10:43:40AM +0800, Chris Chiu wrote:
> On Mon, Dec 25, 2017 at 4:33 AM, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Thu, Dec 21, 2017 at 04:04:56PM +0800, Chris Chiu wrote:
> >> Hi,
> >>     We have a desktop which has S3 suspend (to RAM) problem due to
> >> error messages as follows.
> >> [  198.908282] tpm tpm0: Error (38) sending savestate before suspend
> >> [  198.908289] __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x160 returns 38
> >> [  198.908293] dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns 38
> >> [  198.908298] PM: Device 00:0b failed to suspend: error 38
> >>
> >>     However, the first suspend after boot is working although it still
> >> shows an interesting message during resume.
> >> [  155.789945] tpm tpm0: A TPM error (38) occurred continue selftest
> >>
> >>     The error code 38 in definition is TPM_ERR_INVALID_POSTINIT. I
> >> found some explanations which said this error code means that this
> >> command was received in the wrong sequence relative to a TPM_Startup
> >> command. Don't really know what happens here and how should I deal
> >> with this? Any suggestions? Please let me know what else information
> >> should I provide. Thanks
> >>
> >> Chris
> >
> > The sequences for initializing TPM 1.x devices has been fairly static
> > for a long time. Has this occured after a kernel update? Is there a
> > kernel version where it used to work and a version where it doesn't?
> > Thanks.
> >
> > /Jarkko
> Hi Jarkko,
> 
> Actually, it's a new Acer machine which I never tried an older kernel. I only
> tried versions >= 4.13. The output of "lsmod | grep tpm" is none. I think it's
> not built as a module.
> 
> Chris

Can you try it on git://git.infradead.org/users/jjs/linux-tpmdd.git ?

Maybe it is related to the LPC #CLKRUN issues we've had.

/Jarkko
