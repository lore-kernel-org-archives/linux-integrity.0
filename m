Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42185 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934241AbeEWTlV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 May 2018 15:41:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so5754398wrk.9
        for <linux-integrity@vger.kernel.org>; Wed, 23 May 2018 12:41:20 -0700 (PDT)
Date: Wed, 23 May 2018 13:41:15 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
Message-ID: <20180523194115.GC8705@ziepe.ca>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
 <20180523132318.GE363@linux.intel.com>
 <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 23, 2018 at 10:57:07AM -0700, Tadeusz Struk wrote:
> On 05/23/2018 06:23 AM, Jarkko Sakkinen wrote:
> > Ouch o_O Do you have a fixes tag for this one?
> > 
> 
> This one is quite tricky.
> The original bug was introduced by abce9ac292e13 (tpm: Propagate error from tpm_transmit to fix a timeout hang)
> and the code back then was in drivers/char/tpm/tpm-interface.c file

No, it has been wrong since before git history started, so just use

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

All the other commits you listed are just moving the bad code around
to new files.

Jason
