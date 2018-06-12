Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:46449 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933850AbeFLRn3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jun 2018 13:43:29 -0400
Received: by mail-io0-f193.google.com with SMTP id d22-v6so329949iof.13
        for <linux-integrity@vger.kernel.org>; Tue, 12 Jun 2018 10:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180608215743.224253-1-mjg59@google.com> <20180608215743.224253-2-mjg59@google.com>
In-Reply-To: <20180608215743.224253-2-mjg59@google.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 12 Jun 2018 10:43:16 -0700
Message-ID: <CACdnJuuop-rosGXBqkLZrMszuxhy-JeQGKrj7aFJNSe4NWBNog@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] evm: Don't deadlock if a crypto algorithm is unavailable
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 8, 2018 at 2:57 PM Matthew Garrett <mjg59@google.com> wrote:
>
> When EVM attempts to appraise a file signed with a crypto algorithm the
> kernel doesn't have support for, it will cause the kernel to trigger a
> module load. If the EVM policy includes appraisal of kernel modules this
> will in turn call back into EVM - since EVM is holding a lock until the
> crypto initialisation is complete, this triggers a deadlock. Add a
> CRYPTO_NOLOAD flag and skip module loading if it's set, and add that flag
> in the EVM case in order to fail gracefully with an error message
> instead of deadlocking.

Hi Herbert,

Does this explain the problem sufficiently?
