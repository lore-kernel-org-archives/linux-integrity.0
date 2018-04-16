Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:56311 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeDPUWj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Apr 2018 16:22:39 -0400
Received: by mail-it0-f42.google.com with SMTP id 145-v6so7137314itf.5
        for <linux-integrity@vger.kernel.org>; Mon, 16 Apr 2018 13:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180413225220.20130-1-mjg59@google.com> <1523801140.3272.187.camel@linux.vnet.ibm.com>
 <CACdnJutNLdkqaz0UfveSq_vYBZ37Qx8DkfGWKR3_=bcLpj5MwA@mail.gmail.com> <1523909802.3272.238.camel@linux.vnet.ibm.com>
In-Reply-To: <1523909802.3272.238.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 16 Apr 2018 20:22:27 +0000
Message-ID: <CACdnJusXUkwmxsJiwysMniYj4AvmJjBjH0XXzMiTXwsR9+T+Fw@mail.gmail.com>
Subject: Re: [PATCH] EVM: Allow runtime modification of the set of verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Apr 16, 2018 at 1:16 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Mon, 2018-04-16 at 18:32 +0000, Matthew Garrett wrote:
> > Runtime. I'll look into the post-init stuff, but given that this doesn't
> > change the current security position do you think it's a blocker?

> I would probably make the existing evm_config_xattrnames a const and
> create a link list.  As new xattrs are defined, append them to the
> tail.

Ok, that's definitely an option. But thinking about it some more - if an
attacker has arbitrary memory overwrite of writable pages, wouldn't it be
easier for them to just overwrite the policy and disable appraisal?

> Is there a reason for adding one additional xattrs one at a time, as
> opposed to parsing a string?

Mostly to avoid introducing more string parsing into the kernel.

> Is it better to define a securityfs file, rather than a boot command
> line argument?  With a boot command line argument, the list of xattrs
> could be defined as __ro_after_init.

I could go either way on this - I think that doing it on the command line
would satisfy all my use cases.
