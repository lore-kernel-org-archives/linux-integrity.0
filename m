Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933999AbeFLVgL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jun 2018 17:36:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5CLTP1W010227
        for <linux-integrity@vger.kernel.org>; Tue, 12 Jun 2018 17:36:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jjje2s0tr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Jun 2018 17:36:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 12 Jun 2018 22:36:08 +0100
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>, Joe Perches <joe@perches.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Tue, 12 Jun 2018 17:36:01 -0400
In-Reply-To: <9ae2397b-ad11-d437-d0f4-4e4f0dff4ce9@canonical.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
         <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
         <alpine.LRH.2.21.1806130631400.13763@namei.org>
         <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
         <9ae2397b-ad11-d437-d0f4-4e4f0dff4ce9@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1528839361.3874.10.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-12 at 14:29 -0700, John Johansen wrote:
> On 06/12/2018 02:12 PM, Paul Moore wrote:
> > On Tue, Jun 12, 2018 at 4:32 PM, James Morris <jmorris@namei.org> wrote:
> >> On Mon, 11 Jun 2018, Casey Schaufler wrote:
> >>
> >>> If you want to break this up by security module I would take
> >>> the Smack part as soon as James does the tree update. If James
> >>> wants to take the whole thing at once you can add my:
> >>>
> >>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>
> >>> for the Smack changes.
> >>
> >> It's probably simplest for me to take them as one patch.
> > 
> > I would prefer if the SELinux changes were split into a separate
> > patch.  I'm guessing John would probably want the same for the
> > AppArmor patches, but take his work for it, not mine.
> 
> yes that would be preferred

Agreed
> 
> > 
> > Joe, in general I really appreciate the fixes you send, but these
> > patches that cross a lot of subsystem boundaries (this isn't the first
> > one that does this) causes unnecessary conflicts in -next and during
> > the merge window.  Could you split your patches up from now on please?
> > 
> 
> yeah splitting patches at subsystem boundaries is highly recommended.

Agreed
