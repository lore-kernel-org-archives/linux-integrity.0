Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37868 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757938AbdKOSVI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 13:21:08 -0500
Received: by mail-wm0-f54.google.com with SMTP id v186so4778035wma.2
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2017 10:21:08 -0800 (PST)
Message-ID: <1510770065.5979.21.camel@intel.com>
Subject: Re: IMA appraisal master plan? (was: Re: [PATCH V6] EVM: Add
 support for portable signature format)
From: Patrick Ohly <patrick.ohly@intel.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Wed, 15 Nov 2017 19:21:05 +0100
In-Reply-To: <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
References: <20171107151742.25122-1-mjg59@google.com>
         <1510766803.5979.17.camel@intel.com>
         <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-11-15 at 09:58 -0800, Matthew Garrett wrote:
> On Wed, Nov 15, 2017 at 9:26 AM, Patrick Ohly <patrick.ohly@intel.com
> > wrote:
> > What hasn't become obvious to me yet is how portable signatures
> > help
> > fit into the overall system. What kind of IMA policy is it meant to
> > use? Is the entire partition considered read-only except when
> > installing system software or does it also contain data files from
> > untrusted apps? Which MAC, if any, and does that matter? Are there
> > known holes that need to be plugged before this system is
> > considered
> > secure, and is there a "master plan" for getting there?
> 
> Our approach is to combine appraisal with LSM in order to allow a
> more fine-grained policy (we're using Apparmor, but this applies
> equally well to SELinux or SMACK).

I have some experience with SMACK, but not with Apparmor. At least with
SMACK the problem is that the LSM depends on integrity protection of
the xattrs, but the integrity protection itself depends on the LSM, so
there's a cycle. An attacker can much too easily make offline changes
which then defeat whatever IMA policy the system might be using.

>  Execution that attempts to transition intoa more privileged Apparmor
> context will be subject to appraisal,execution that transitions into
> an unprivileged context won't be.

Is that something that already works with the upstream kernel plus your
 portable signatures, or do you have additional kernel patches?

If it already works, can you share the IMA policy and/or be a bit more
specific about how to set up such a system? I'd love to reproduce it.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
