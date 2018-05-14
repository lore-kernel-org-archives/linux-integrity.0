Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:54071 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbeENSu1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 14:50:27 -0400
Received: by mail-it0-f68.google.com with SMTP id n64-v6so12844063itb.3
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 11:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180511231236.5501-1-mjg59@google.com> <20180511231236.5501-3-mjg59@google.com>
 <1526229700.3898.26.camel@linux.vnet.ibm.com> <CACdnJuuve3OrJPvBYeRoTfaan022hi9p0dDbDbZJuKHCU4t3xA@mail.gmail.com>
 <1526318354.3898.159.camel@linux.vnet.ibm.com> <1526319342.3368.2.camel@linux.vnet.ibm.com>
 <CACdnJusuhYBsOY_tg681hcE2fnHAfTvmEyFnE-ALO_BNBCKAzA@mail.gmail.com>
In-Reply-To: <CACdnJusuhYBsOY_tg681hcE2fnHAfTvmEyFnE-ALO_BNBCKAzA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 14 May 2018 11:50:15 -0700
Message-ID: <CACdnJuvffE30wET24+KJ3KnBfM_mf88=DKU96wHmV+2BL+A2Hg@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] EVM: Allow runtime modification of the set of
 verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, May 14, 2018 at 10:36 AM Matthew Garrett <mjg59@google.com> wrote:

> On Mon, May 14, 2018 at 10:35 AM Mimi Zohar <zohar@linux.vnet.ibm.com>
> wrote:
> > > # echo . > /sys/kernel/security/integrity/evm/evm_xattrs
> > > bash: echo: write error: Operation not permitted

> > I'm still seeing this message.

> Looking into it.

I can't reproduce this - the only way you should be getting EPERM is if the
list is already locked or if you don't have CAP_SYS_ADMIN.
