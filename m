Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35816 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeFDUJc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jun 2018 16:09:32 -0400
Received: by mail-it0-f67.google.com with SMTP id a3-v6so554820itd.0
        for <linux-integrity@vger.kernel.org>; Mon, 04 Jun 2018 13:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180601230244.138560-1-mjg59@google.com> <20180602155418.nsumhiicugt26747@gondor.apana.org.au>
In-Reply-To: <20180602155418.nsumhiicugt26747@gondor.apana.org.au>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 4 Jun 2018 13:09:19 -0700
Message-ID: <CACdnJuu1i-hNzEoLhL5gGSadd+=Crcg14X_NAaVRj1Vt_PnJpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] evm: Don't deadlock if a crypto algorithm is unavailable
To: herbert@gondor.apana.org.au
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-crypto@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Jun 2, 2018 at 8:54 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Jun 01, 2018 at 04:02:43PM -0700, Matthew Garrett wrote:
> > Trying to instantiate a non-existent crypto algorithm will cause the
> > kernel to trigger a module load. If EVM appraisal is enabled, this will
> > in turn trigger appraisal of the module, which will fail because the
> > crypto algorithm isn't available. Add a CRYPTO_NOLOAD flag and skip
> > module loading if it's set, and add that flag in the EVM case.
> >
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
>
> I don't get it.  Without your patch it will fail because the
> EVM appraisal fails.  With your patch it will fail because there
> is no algorithm registered.  So what's the difference?

Without my patch it will deadlock as it recursively calls back into
EVM to perform the module appraisal. Sorry, the description was
unclear on that point.
