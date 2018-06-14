Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:54923 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755072AbeFNTmk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jun 2018 15:42:40 -0400
Received: by mail-it0-f66.google.com with SMTP id 76-v6so9827499itx.4
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jun 2018 12:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180417225601.6965-1-mjg59@google.com> <1528897302.3880.1.camel@linux.vnet.ibm.com>
In-Reply-To: <1528897302.3880.1.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 14 Jun 2018 12:42:27 -0700
Message-ID: <CACdnJuvkE48YbO51OLpbkWRX2N6aHVZ5gxrY3FRPb9grNFVzHw@mail.gmail.com>
Subject: Re: [USER] [PATCH 1/2] Remove hardcoding of SHA1 in EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 13, 2018 at 6:42 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>
> On Tue, 2018-04-17 at 15:56 -0700, Matthew Garrett wrote:
> > -     err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), EVP_sha1(), NULL);
> > +     md = EVP_get_digestbyname(params.hash_algo);
>
> HMAC is still limited to sha1.

Yes, let me revert that hunk and I'll resend.
