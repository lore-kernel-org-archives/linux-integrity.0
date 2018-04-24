Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:46228 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeDXUEI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Apr 2018 16:04:08 -0400
Received: by mail-io0-f179.google.com with SMTP id f3-v6so24166805iob.13
        for <linux-integrity@vger.kernel.org>; Tue, 24 Apr 2018 13:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180413225220.20130-1-mjg59@google.com> <1523801140.3272.187.camel@linux.vnet.ibm.com>
 <CACdnJutNLdkqaz0UfveSq_vYBZ37Qx8DkfGWKR3_=bcLpj5MwA@mail.gmail.com>
 <1523909802.3272.238.camel@linux.vnet.ibm.com> <CACdnJusXUkwmxsJiwysMniYj4AvmJjBjH0XXzMiTXwsR9+T+Fw@mail.gmail.com>
In-Reply-To: <CACdnJusXUkwmxsJiwysMniYj4AvmJjBjH0XXzMiTXwsR9+T+Fw@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 24 Apr 2018 20:03:56 +0000
Message-ID: <CACdnJusixeW6LUhFzTEdLgQwRfxf9SXup3CwCAL+gXfA0PPO8g@mail.gmail.com>
Subject: Re: [PATCH] EVM: Allow runtime modification of the set of verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Apr 16, 2018 at 1:22 PM Matthew Garrett <mjg59@google.com> wrote:
> I could go either way on this - I think that doing it on the command line
> would satisfy all my use cases.

Thinking about this some more - I think being able to do this at runtime is
actually important. If we add an additional xattr to the signatures then we
want to be able to update machine policy without forcing a reboot first,
otherwise we have a chicken and egg problem where we have to gate any new
package update against having a machine rebooted with an updated command
line (otherwise the signature validation will fail for packages that
contain new signatures)
