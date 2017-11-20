Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1867 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbdKTQOp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 11:14:45 -0500
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
Date: Mon, 20 Nov 2017 16:14:41 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC563F4BF41F@ORSMSX115.amr.corp.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
 <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
 <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
 <20171117181734.GM4276@ziepe.ca>
 <53b319e3-d46c-dfc7-7024-88a448be7d72@redhat.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BEC48@ORSMSX115.amr.corp.intel.com>
 <20171117235526.GX4276@ziepe.ca>
 <f77f3fa3-94ed-40fe-228b-b24dd5539754@redhat.com>
 <20171119152721.GY4276@ziepe.ca>
 <36e9ad69-225b-ca2b-7047-d188a50b1438@redhat.com>
In-Reply-To: <36e9ad69-225b-ca2b-7047-d188a50b1438@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Javier Martinez Canillas [mailto:javierm@redhat.com]
> Sent: Monday, November 20, 2017 1:26 AM
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Roberts, William C <william.c.roberts@intel.com>; linux-
> kernel@vger.kernel.org; Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>;
> Peter Huewe <peterhuewe@gmx.de>; Tricca, Philip B
> <philip.b.tricca@intel.com>; linux-integrity@vger.kernel.org
> Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
> fails
> 
> On 11/19/2017 04:27 PM, Jason Gunthorpe wrote:
> > On Sat, Nov 18, 2017 at 01:53:49AM +0100, Javier Martinez Canillas wrote:
> >
> >> What I fail to understand is why that's not a problem when the TPM
> >> spaces infrastructure isn't used, tpm_validate_command() function
> >> just returns true if space is NULL. So when sending command to
> >> /dev/tpm0 directly, a rogue user-space program can send any arbitrary data to
> the TPM.
> >
> > tpm spaces was designed to allow unprivileged user space access to

Shouldn't it depend on the mode of the device file?

> 
> Ah, I didn't know about that design decision. This isn't documented anywhere
> AFAICT, it would be nice to add some notes to Documentation/security/tpm/ so
> people are aware of this.
> 
> > the TPM so it has additional protection designed to keep the TPM
> > secure.

The TPM manages its own security over objects, can you give me an example of where
this matters? I see below you mention a bug in parsing the data sent by the tpm.
If I want to allow untrusted access through the kernel RM one should allow it. It should be based
on file system permissions, not arbitrary checks in the driver. Also, the more code you write
the more the argument that the parsing error could be in the Linux kernel. Maybe they
just want to use the TPM driver to gain access to kernel mode and not the TPM.

> >
> > Allowing unprivileged user space to send send garbage to the TPM seems
> > like a good way to trigger a TPM bug in parsing.
> >
> 
> Well, I don't think that unprivileged user-space should have any access to the
> TPM. Since a rogue user-space can abuse the TPM anyway even when using a
> well constructed command (which is the only validation that's done IIUC).
> 
> In other words, only trusted software should have access to the TPM device.

That's policy, and shouldn't be hardcoded in the kernel. Let the DAC permission model
And LSMs sort that out.

> 
> I thought the TPM spaces was about exposing a virtualized TPM that didn't have
> the limitation of only allowing to store a small set of transient objects (so user-
> space didn't have to deal with the handles flushing and context save/load), rather
> than relaxing the access control to the TPM.
> 
> > When spaces are not used /dev/tpm0 is root only and has full
> > unrestricted access.

Wouldn't this be based on the changeable mode of /dev/tpm0?

> >
> 
> The Linux motto is that it should provide mechanisms and not policy, so I wonder
> if is up to user-space to decide who should access the devices.
> 
> For example on my Fedora machine, the /dev/tpm* char devices are owned by
> the "tss" user and group. That's because the tpm2-abrmd package installs an
> udev rule to change the permissions, since the resource manager is run as the
> unprivileged tss user.
> 
> The /dev/tpmrm* on the other hand are owned by root. So on this distro at least,
> is the opposite of what you described.
> 
> Having said that, I'm happy to implement the synthesized response when the
> command is not supported, if that's the correct way to resolve this.
> 
> > Jason
> >
> 
> Best regards,
> --
> Javier Martinez Canillas
> Software Engineer - Desktop Hardware Enablement Red Hat
