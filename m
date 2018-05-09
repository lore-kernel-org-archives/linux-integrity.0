Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:43050 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935304AbeEIRlE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 13:41:04 -0400
Received: by mail-io0-f175.google.com with SMTP id t23-v6so43605443ioc.10
        for <linux-integrity@vger.kernel.org>; Wed, 09 May 2018 10:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180501175124.192587-1-mjg59@google.com> <20180501175124.192587-2-mjg59@google.com>
 <1525317430.3238.58.camel@linux.vnet.ibm.com> <CACdnJuvUze0GSmQcnyFi_3vGEPoEgavrF9WhFoDpmHSni3FwEA@mail.gmail.com>
 <1525815782.3551.86.camel@linux.vnet.ibm.com> <CACdnJusHQvBk3rO1DqOr=XyeKZkmFqq+HM9HUO7whvUVG9yxYw@mail.gmail.com>
 <1525878005.3551.223.camel@linux.vnet.ibm.com>
In-Reply-To: <1525878005.3551.223.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 09 May 2018 17:40:53 +0000
Message-ID: <CACdnJuuFO1e0T9oQwD7R6dC8Kod3k8mWipZ4xZQKC4U=oea3Aw@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 9, 2018 at 8:30 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Adding support for additional xattr names is fine.  Making it a
> Kconfig option is required.  Being able to lock adding additional
>   xattr names should also be required.

Ok! I'll add that.
