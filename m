Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:37682 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdKOR6p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 12:58:45 -0500
Received: by mail-io0-f174.google.com with SMTP id v21so2447234ioi.4
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2017 09:58:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510766803.5979.17.camel@intel.com>
References: <20171107151742.25122-1-mjg59@google.com> <1510766803.5979.17.camel@intel.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 15 Nov 2017 09:58:43 -0800
Message-ID: <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
Subject: Re: IMA appraisal master plan? (was: Re: [PATCH V6] EVM: Add support
 for portable signature format)
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 15, 2017 at 9:26 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> What hasn't become obvious to me yet is how portable signatures help
> fit into the overall system. What kind of IMA policy is it meant to
> use? Is the entire partition considered read-only except when
> installing system software or does it also contain data files from
> untrusted apps? Which MAC, if any, and does that matter? Are there
> known holes that need to be plugged before this system is considered
> secure, and is there a "master plan" for getting there?

Our approach is to combine appraisal with LSM in order to allow a more
fine-grained policy (we're using Apparmor, but this applies equally
well to SELinux or SMACK). Execution that attempts to transition into
a more privileged Apparmor context will be subject to appraisal,
execution that transitions into an unprivileged context won't be. Long
term, this also allows for writing policy that ensures that (eg) all
files read by systemd are appraised without having to impose the same
requirement on root in general.
