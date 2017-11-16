Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33282 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbdKPAF0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 19:05:26 -0500
Received: by mail-io0-f195.google.com with SMTP id 134so3451544ioo.0
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2017 16:05:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1711161101360.27132@localhost>
References: <20171107151742.25122-1-mjg59@google.com> <1510766803.5979.17.camel@intel.com>
 <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
 <1510770065.5979.21.camel@intel.com> <alpine.LFD.2.20.1711161101360.27132@localhost>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 15 Nov 2017 16:05:24 -0800
Message-ID: <CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
Subject: Re: IMA appraisal master plan? (was: Re: [PATCH V6] EVM: Add support
 for portable signature format)
To: James Morris <james.l.morris@oracle.com>
Cc: Patrick Ohly <patrick.ohly@intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 15, 2017 at 4:02 PM, James Morris <james.l.morris@oracle.com> wrote:
> On Wed, 15 Nov 2017, Patrick Ohly wrote:
>
>> I have some experience with SMACK, but not with Apparmor. At least with
>> SMACK the problem is that the LSM depends on integrity protection of
>> the xattrs, but the integrity protection itself depends on the LSM, so
>> there's a cycle. An attacker can much too easily make offline changes
>> which then defeat whatever IMA policy the system might be using.
>
> Isn't this what EVM is supposed to mitigate?

If the path to the loading of the LSM policy isn't fully appraised,
then it can be modified offline in order to permit modification of the
EVM xattrs at runtime, at which point the kernel will happily generate
a new HMAC.
