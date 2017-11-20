Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42479 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbdKTSEO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 13:04:14 -0500
Received: by mail-wm0-f67.google.com with SMTP id 5so19471187wmk.1
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 10:04:14 -0800 (PST)
Date: Mon, 20 Nov 2017 11:04:09 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: "Roberts, William C" <william.c.roberts@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171120180409.GB29075@ziepe.ca>
References: <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
 <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
 <20171117181734.GM4276@ziepe.ca>
 <53b319e3-d46c-dfc7-7024-88a448be7d72@redhat.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BEC48@ORSMSX115.amr.corp.intel.com>
 <20171117235526.GX4276@ziepe.ca>
 <f77f3fa3-94ed-40fe-228b-b24dd5539754@redhat.com>
 <20171119152721.GY4276@ziepe.ca>
 <36e9ad69-225b-ca2b-7047-d188a50b1438@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36e9ad69-225b-ca2b-7047-d188a50b1438@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 20, 2017 at 10:26:01AM +0100, Javier Martinez Canillas wrote:

> I thought the TPM spaces was about exposing a virtualized TPM that didn't
> have the limitation of only allowing to store a small set of transient
> objects (so user-space didn't have to deal with the handles flushing and
> context save/load), rather than relaxing the access control to the TPM.

Somehow it became about both ..

The kernel defaults the tpmrm to root only, so the distro can decide
how to set it up. Some people are giving access to unpriv users.

> Having said that, I'm happy to implement the synthesized response when
> the command is not supported, if that's the correct way to resolve this.

It seems like it, from what I can see, but only if the command is not
supported..

You should double check with James of course.

Jason
