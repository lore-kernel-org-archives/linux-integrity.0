Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:45882 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdKSP1Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Nov 2017 10:27:24 -0500
Received: by mail-io0-f180.google.com with SMTP id z74so13299901iof.12
        for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2017 07:27:24 -0800 (PST)
Date: Sun, 19 Nov 2017 08:27:21 -0700
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
Message-ID: <20171119152721.GY4276@ziepe.ca>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f77f3fa3-94ed-40fe-228b-b24dd5539754@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Nov 18, 2017 at 01:53:49AM +0100, Javier Martinez Canillas wrote:

> What I fail to understand is why that's not a problem when the TPM spaces
> infrastructure isn't used, tpm_validate_command() function just returns
> true if space is NULL. So when sending command to /dev/tpm0 directly, a
> rogue user-space program can send any arbitrary data to the TPM.

tpm spaces was designed to allow unprivileged user space access to
the TPM so it has additional protection designed to keep the TPM
secure.

Allowing unprivileged user space to send send garbage to the TPM seems
like a good way to trigger a TPM bug in parsing.

When spaces are not used /dev/tpm0 is root only and has full
unrestricted access.

Jason
