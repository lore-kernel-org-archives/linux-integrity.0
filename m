Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:32894 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFAUwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 16:52:19 -0400
Received: by mail-it0-f65.google.com with SMTP id k17-v6so6103624ita.0
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jun 2018 13:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
 <20180530202804.148245-1-mjg59@google.com> <15252CF8C1B4384C8CE16D7D55C66479011414E83B@BC-MAIL-M04.internal.baidu.com>
 <CACdnJutzAbjwieaxH1N5Z-Vt9Q=Gwf5WamPURkO1epVZEUy_8g@mail.gmail.com>
 <1527796502.3427.46.camel@linux.vnet.ibm.com> <CACdnJutU3fcYK3TVicBXUvCDo_9DaWuqTRDcz_GGGZOLegg3Ww@mail.gmail.com>
 <1527798728.3427.58.camel@linux.vnet.ibm.com> <CACdnJuvRoZ=McstC_f9uaqZ+zWWDu9L=yQCBXDF6xQMtmTsfcQ@mail.gmail.com>
 <1527852067.3427.81.camel@linux.vnet.ibm.com>
In-Reply-To: <1527852067.3427.81.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 1 Jun 2018 13:52:07 -0700
Message-ID: <CACdnJutAGYyB2FW9W-0v2yVDHdAwcm0KQY7pUao8hsjf8ifw6A@mail.gmail.com>
Subject: Re: [PATCH] evm: Don't deadlock if a crypto algorithm is unavailable
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: wangjunwen@baidu.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 1, 2018 at 4:21 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Thu, 2018-05-31 at 14:06 -0700, Matthew Garrett wrote:
> > EVM looks like it SELECTs CONFIG_SHA1, so I /think/ it should be ok
> > before that patch?
>
> According to Junwen, with CONFIG_TRUSTED_KEYS enabled the HMAC and
> SHA1 are allocated at __init.  The locking problem occurs when
> CONFIG_TRUSTED_KEYS is not enabled.  His solution would have been to
> move the crypto_alloc_shash() in EVM to an __init function.

Ok - I think just allowing it to be deferred is preferable, since
otherwise we'd have to build in every hash algorithm that could be
used for the signatures (which wasn't a problem before the non-sha1
patch). How would you prefer me to send these two? The non-sha1 patch
isn't in -next, so I can't add a fixes: for it at this point.
