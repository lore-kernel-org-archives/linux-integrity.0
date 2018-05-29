Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:53214 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965658AbeE2S0c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 14:26:32 -0400
Received: by mail-it0-f66.google.com with SMTP id y189-v6so19631611itb.2
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 11:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <1526508736.3306.6.camel@linux.vnet.ibm.com> <20180517220938.102953-1-mjg59@google.com>
 <1526659412.3404.32.camel@linux.vnet.ibm.com>
In-Reply-To: <1526659412.3404.32.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 29 May 2018 11:26:20 -0700
Message-ID: <CACdnJuvd8Y9N1Bds474BXiikc5R8c41gaHGpJEUO2z_vkXG-XQ@mail.gmail.com>
Subject: Re: [PATCH V4] evm: Allow non-SHA1 digital signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        wangjunwen@baidu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, May 18, 2018 at 9:03 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Thu, 2018-05-17 at 15:09 -0700, Matthew Garrett wrote:
> > Oh bother - I think I see what's wrong. Does this version work better?
> > I'm afraid I only tested against signatures rather than HMACs, and I was
> > generating a raw SHA1 rather than an HMAC :(

> That's a lot better!

> FYI, Wang Junwen reported a problem with enabling EVM with just the
> immutable and portable keys.  Without trusted keys enabled, SHA1 isn't
> being built into the kernel.  Loading the SHA1 kernel module fails.
>   Without knowing apriori which hash algorithms need to be builtin is a
> problem.

It looks like Kconfig is selecting CRYPTO_SHA1 when EVM is enabled, and
since that's a bool it should be forcing it to be built-in? I can't see a
good way of extending that generally, unfortunately. Is the problem with
loading the module that you're enforcing an IMA policy before loading it?
