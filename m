Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:53600 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbdJPR6E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Oct 2017 13:58:04 -0400
Received: by mail-it0-f48.google.com with SMTP id n195so2147242itg.2
        for <linux-integrity@vger.kernel.org>; Mon, 16 Oct 2017 10:58:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508077661.3426.143.camel@linux.vnet.ibm.com>
References: <20171011191014.4426-1-mjg59@google.com> <1508077661.3426.143.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 16 Oct 2017 10:58:03 -0700
Message-ID: <CACdnJutVsX3-U8P=uWPqi+XQ6zUx8Ys9W78C62K+rnfmaZb1=g@mail.gmail.com>
Subject: Re: [PATCH V2] EVM: Allow userspace to signal an RSA key has been loaded
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 15, 2017 at 7:27 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Wed, 2017-10-11 at 12:10 -0700, Matthew Garrett wrote:
>> EVM will only perform validation once a key has been loaded. This key
>> may either be a symmetric trusted key (for HMAC validation and creation)
>> or the public half of an asymmetric key (for digital signature
>> validation). The /sys/kernel/security/evm interface allows userland to
>> signal that a symmetric key has been loaded, but does not allow userland
>> to signal that an asymmetric public key has been loaded.
>>
>> This patch extends the interface to permit userspace to pass a bitmask
>> of loaded key types. It also allows userspace to block loading of an
>> asymmetric key in order to avoid a compromised system from being able to
>> load an additional key type later.
>
> I assume you mean "block loading of a symmetric key".  Other than this
> and a trailing blank line, the patch looks good.  If you don't have
> objections, I'll fix these two things.

Sorry, yes. That works for me - thank you!
