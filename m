Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:37479 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbeENXMp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 19:12:45 -0400
Received: by mail-it0-f45.google.com with SMTP id 70-v6so15381205ity.2
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 16:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180511231236.5501-1-mjg59@google.com> <20180511231236.5501-3-mjg59@google.com>
 <1526229700.3898.26.camel@linux.vnet.ibm.com> <CACdnJuuve3OrJPvBYeRoTfaan022hi9p0dDbDbZJuKHCU4t3xA@mail.gmail.com>
 <1526318354.3898.159.camel@linux.vnet.ibm.com> <1526319342.3368.2.camel@linux.vnet.ibm.com>
 <CACdnJusuhYBsOY_tg681hcE2fnHAfTvmEyFnE-ALO_BNBCKAzA@mail.gmail.com>
 <CACdnJuvffE30wET24+KJ3KnBfM_mf88=DKU96wHmV+2BL+A2Hg@mail.gmail.com> <1526331734.3937.3.camel@linux.vnet.ibm.com>
In-Reply-To: <1526331734.3937.3.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 14 May 2018 16:12:32 -0700
Message-ID: <CACdnJuswbX44aPB9GCJSmmqh1-EJa7+6risJfCsYXHXf5tVWeA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] EVM: Allow runtime modification of the set of
 verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, May 14, 2018 at 2:02 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> The call to notify_change() calls security_inode_setattr(), which is
> failing, because there is no security.evm xattr.  It's failing with
> -EPERM.

Ah! Ok yes that would explain it. Let me figure out how to do this
reasonably...
