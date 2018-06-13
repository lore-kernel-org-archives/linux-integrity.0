Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36101 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754493AbeFMQTP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jun 2018 12:19:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id u4-v6so4862483lff.3
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jun 2018 09:19:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com> <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
 <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
 <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com> <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Jun 2018 12:19:12 -0400
Message-ID: <CAHC9VhRXBx_Q2eM48FFqX9PbPz0k8R74gfFFoRhwV91n2_BPsQ@mail.gmail.com>
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
To: Joe Perches <joe@perches.com>
Cc: James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 13, 2018 at 12:04 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-06-13 at 11:49 -0400, Paul Moore wrote:
>> On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
>> > On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
>> > > Joe, in general I really appreciate the fixes you send, but these
>> > > patches that cross a lot of subsystem boundaries (this isn't the first
>> > > one that does this) causes unnecessary conflicts in -next and during
>> > > the merge window.  Could you split your patches up from now on please?
>> >
>> > Sorry. No.  Merge conflicts are inherent in this system.
>>
>> Yes, merge conflicts are inherent in this system when one makes a
>> single change which impacts multiple subsystems, e.g. changing a core
>> kernel function which is called by multiple subsystems.  However, that
>> isn't what this patch does, it makes a number of self-contained
>> changes across multiple subsystems; there are no cross-subsystem
>> dependencies in this patch.  You are increasing the likelihood of
>> conflicts for no good reason; that is why I'm asking you to split this
>> patch and others like it.
>
> No.  History shows with high certainty that splitting
> patches like this across multiple subsystems of a primary
> subsystem means that the entire patchset is not completely
> applied.

I think that is due more to a lack of effort on the part of the patch
author to keep pushing the individual patches.

> It's _much_ simpler and provides a generic mechanism to
> get the entire patch applied to send a single patch to the
> top level subsystem maintainer.

I understand it is simpler for you, but it is more difficult for everyone else.

Further, where the LSMs are concerned, there is no "top level
subsystem maintainer" anymore.  SELinux and AppArmor send pull
requests directly to Linus.

-- 
paul moore
www.paul-moore.com
