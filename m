Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19317 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933443AbdKQTO3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 14:14:29 -0500
From: "Roberts, William C" <william.c.roberts@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Date: Fri, 17 Nov 2017 19:14:21 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC563F4BEC48@ORSMSX115.amr.corp.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
 <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
 <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
 <20171117181734.GM4276@ziepe.ca>
 <53b319e3-d46c-dfc7-7024-88a448be7d72@redhat.com>
In-Reply-To: <53b319e3-d46c-dfc7-7024-88a448be7d72@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Javier Martinez Canillas [mailto:javierm@redhat.com]
> Sent: Friday, November 17, 2017 10:35 AM
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-kernel@vger.kernel.org; Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com>; Peter Huewe <peterhuewe@gmx.de>;
> Tricca, Philip B <philip.b.tricca@intel.com>; linux-integrity@vger.kernel.org;
> Roberts, William C <william.c.roberts@intel.com>
> Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
> fails
> 
> On 11/17/2017 07:17 PM, Jason Gunthorpe wrote:
> > On Fri, Nov 17, 2017 at 07:10:09PM +0100, Javier Martinez Canillas wrote:
> >
> >> Right, that's what I understood indeed but wanted to be sure. The
> >> problem with that approach is that would not scale.
> >>
> >> Since this particular TPM2 doesn't have support for the
> >> TPM2_EncryptDecrypt2 command, but some chips may not support others
> commands.
> >
> > No, tpm_validate is not supposed to be sensitive to what commands the
> > TPM supports. It is only supposed to check if the command passed is
> > fully understood by the kernel and is properly formed.
> >
> > This is to prevent rouge user space from sending garbage or privileged
> > commands to the TPM.
> >
> > If it is refusing TPM2_EncryptDecrypt2, and that command is safe to
> > use in the spaces system, then tpm_validate must learn how to handle
> > it, or userspace can never use it.
> >
> 
> I see, misunderstood what the check was about then. If that's the case, then
> Making tpm_validate to learn how to check that command makes sense indeed
> and so does the -EINVAL error code.
> 
> Since it doesn't mean that the TPM doesn't support the command but just that
> the TPM spaces doesn't know how to handle it.

Yeah it looks like it would fail in tpm2_find_cc

I don't know why spaces would filter by command code. But it does seem to be loaded
By getting the command codes from the tpm in  tpm2_get_tpm_pt(). So even if someone
Is using spaces and the tpm is some development model with crazy commands, they
Should get loaded into the command list.

We could implement similar logic in the userspace tools where the issue is occurring.
I don't think that it's the right fix. I don't think the in-kernel RM should be filtering,
but please enlighten my ignorance. Phillip did the userspace RM and understand the
RM issues way better than I.

I just don't like the fact that it issues a different return code, the userspace RM
doesn't do this. If a command isn't supported it should issue a TPM response
saying so, it's virtualizing a tpm.

> 
> Need to look at the code in more detail, thanks a lot for the clarification.
> 
> > Jason
> >
> 
> Best regards,
> --
> Javier Martinez Canillas
> Software Engineer - Desktop Hardware Enablement Red Hat
