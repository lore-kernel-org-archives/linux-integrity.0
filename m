Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:41488 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162054AbdKQXzb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 18:55:31 -0500
Received: by mail-wm0-f53.google.com with SMTP id b189so9384160wmd.0
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 15:55:31 -0800 (PST)
Date: Fri, 17 Nov 2017 16:55:26 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171117235526.GX4276@ziepe.ca>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
 <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
 <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
 <20171117181734.GM4276@ziepe.ca>
 <53b319e3-d46c-dfc7-7024-88a448be7d72@redhat.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BEC48@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC563F4BEC48@ORSMSX115.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Nov 17, 2017 at 07:14:21PM +0000, Roberts, William C wrote:

> I don't know why spaces would filter by command code. But it does
> seem to be loaded By getting the command codes from the tpm in
> tpm2_get_tpm_pt().

Ah, I forgot. So my remark is not quite right :\

> I don't think that it's the right fix. I don't think the in-kernel
> RM should be filtering, but please enlighten my ignorance. Phillip
> did the userspace RM and understand the RM issues way better than I.

It needs to prevent unauthorized stuff from being sent to the TPM, so
if the kernel does not know how to parse the command it shouldn't send
it. It is a matter of security..

I can't remember if we synthezied responses for anything else, it
could make sense to return the usual not supported command response
for this specific thing. But the length error should remain EINVAL I
think..

Jason
