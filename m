Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44066 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbdKQR6k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 12:58:40 -0500
Received: by mail-wr0-f195.google.com with SMTP id l22so2787937wrc.11
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 09:58:39 -0800 (PST)
Date: Fri, 17 Nov 2017 10:58:34 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171117175834.GK4276@ziepe.ca>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
 <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Nov 17, 2017 at 06:56:09PM +0100, Javier Martinez Canillas wrote:

> Yes, the problem with that is user-space not having enough information about
> what went wrong. Right now the TCTI layer just reports TSS2_BASE_RC_IO_ERROR
> in this case and can't be blamed.

Well, if you care about the differnce between a transport failure and
a kernel rejection due to validation, then it needs to report a
different code :)

> > Regarding your specific issue, can you make the command you want to
> > use validate? Would that make sense?
> 
> Sorry, I'm not sure to understand what you meant. Could you please elaborate?

Make it so tpm_validate will accept the command being sent.

Jason
