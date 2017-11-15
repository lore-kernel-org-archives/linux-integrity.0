Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:44718 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933489AbdKOS2o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 13:28:44 -0500
Received: by mail-io0-f169.google.com with SMTP id w127so2528726iow.11
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2017 10:28:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510770065.5979.21.camel@intel.com>
References: <20171107151742.25122-1-mjg59@google.com> <1510766803.5979.17.camel@intel.com>
 <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com> <1510770065.5979.21.camel@intel.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 15 Nov 2017 10:28:41 -0800
Message-ID: <CACdnJusLJkdn34s+j+xLA9T0DFaYJ6iocPL=HB3jvRsryGfZkA@mail.gmail.com>
Subject: Re: IMA appraisal master plan? (was: Re: [PATCH V6] EVM: Add support
 for portable signature format)
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 15, 2017 at 10:21 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> I have some experience with SMACK, but not with Apparmor. At least with
> SMACK the problem is that the LSM depends on integrity protection of
> the xattrs, but the integrity protection itself depends on the LSM, so
> there's a cycle. An attacker can much too easily make offline changes
> which then defeat whatever IMA policy the system might be using.

We load the core policy from the initramfs, which is part of our
signed payload that's enforced by the firmware.

>>  Execution that attempts to transition intoa more privileged Apparmor
>> context will be subject to appraisal,execution that transitions into
>> an unprivileged context won't be.
>
> Is that something that already works with the upstream kernel plus your
>  portable signatures, or do you have additional kernel patches?

It doesn't quite work as is - see
https://www.mail-archive.com/selinux@tycho.nsa.gov/msg05830.html and
the 2/2 patch in the series. Then it's just a matter of something
like:

appraise func=CREDS_CHECK subj_user=privileged_t

and anything that's being executed as privileged_t will be appraised
before execution.
