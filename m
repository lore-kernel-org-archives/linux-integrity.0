Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:43710 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdKTKU5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 05:20:57 -0500
Received: by mail-wr0-f169.google.com with SMTP id u40so7565243wrf.10
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 02:20:57 -0800 (PST)
Message-ID: <1511173252.5979.45.camel@intel.com>
Subject: Re: IMA appraisal master plan?
From: Patrick Ohly <patrick.ohly@intel.com>
To: James Morris <james.l.morris@oracle.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Silviu Vlasceanu <silviu.vlasceanu@huawei.com>
Date: Mon, 20 Nov 2017 11:20:52 +0100
In-Reply-To: <alpine.LFD.2.20.1711200746120.25470@localhost>
References: <20171107151742.25122-1-mjg59@google.com>
         <1510766803.5979.17.camel@intel.com>
         <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
         <1510770065.5979.21.camel@intel.com>
         <alpine.LFD.2.20.1711161101360.27132@localhost>
         <CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
         <1510798382.3711.389.camel@linux.vnet.ibm.com>
         <8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
         <1510837595.3711.420.camel@linux.vnet.ibm.com>
         <a88aff89-1e75-9019-4394-640f5fb318da@huawei.com>
         <alpine.LFD.2.20.1711200746120.25470@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-11-20 at 07:47 +1100, James Morris wrote:
> On Fri, 17 Nov 2017, Roberto Sassu wrote:
> 
> > LSMs are responsible to enforce a security policy at run-time,
> > while IMA/EVM protect data and metadata against offline attacks.
> 
> In my view, IMA can also protect against making an online attack 
> persistent across boots, and that would be the most compelling use of
> it for many general purpose applications.

I do not quite buy that interpretation. If the online attack succeeds
in bypassing the run-time checks, for example with a full root exploit,
then he has pretty much the same capabilities to make persistent file
changes as during an offline attack.

When allowing local hashing, it's actually worse: during an offline
attack, the attacker might not have access to the TPM and thus cannot
easily update the EVM HMAC. During an online attack, the kernel will
happily update that and the IMA hash for the attacker, resulting in a
file that passes appraisal after a reboot.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
