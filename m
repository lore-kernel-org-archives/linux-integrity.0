Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:44772 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965189AbeEIWHC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 18:07:02 -0400
Received: by mail-io0-f173.google.com with SMTP id d11-v6so738237iof.11
        for <linux-integrity@vger.kernel.org>; Wed, 09 May 2018 15:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180420203408.50769-1-mjg59@google.com>
In-Reply-To: <20180420203408.50769-1-mjg59@google.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 09 May 2018 22:06:50 +0000
Message-ID: <CACdnJutL4SJRP1F6GUiLMZZvzdZMqts8M6gdCNTUprSeAyzWoA@mail.gmail.com>
Subject: Re: [PATCH] evm: Allow non-SHA1 digital signatures
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Apr 20, 2018 at 1:34 PM Matthew Garrett <mjg59@google.com> wrote:

> SHA1 is reasonable in HMAC constructs, but it's desirable to be able to
> use stronger hashes in digital signatures. Modify the EVM crypto code so
> the hash type is imported from the digital signature and passed down to
> the hash calculation code, and return the digest size to higher layers
> for validation.

Hi! Any feedback on this?
