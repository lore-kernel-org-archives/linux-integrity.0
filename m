Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42016 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeEVUH3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 May 2018 16:07:29 -0400
Received: by mail-wr0-f194.google.com with SMTP id t16-v6so19183559wrm.9
        for <linux-integrity@vger.kernel.org>; Tue, 22 May 2018 13:07:29 -0700 (PDT)
Date: Tue, 22 May 2018 14:07:24 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
Message-ID: <20180522200723.GE3311@ziepe.ca>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 22, 2018 at 10:32:46AM -0700, Tadeusz Struk wrote:
> There is a race condition in tpm_common_write function allowing two
> threads on the same /dev/tpm<N>, or two different applications on
> the same /dev/tpmrm<N> to overwrite eachother requests/responses.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

I didn't see any reasn for data_pending to be an atomic, ever use case
is near the buffer_mutex, can you respin this patch to just drop that
completely and only manipulate it within the lock?

Jason
