Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751181AbdKTO7o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 09:59:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKEwmfw081293
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 09:59:44 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ebx32n8mu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 09:59:43 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 20 Nov 2017 14:59:41 -0000
Subject: Re: IMA appraisal master plan?
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Patrick Ohly <patrick.ohly@intel.com>,
        James Morris <james.l.morris@oracle.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc: Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Silviu Vlasceanu <silviu.vlasceanu@huawei.com>
Date: Mon, 20 Nov 2017 09:59:36 -0500
In-Reply-To: <1511173252.5979.45.camel@intel.com>
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
         <1511173252.5979.45.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511189976.4729.110.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-11-20 at 11:20 +0100, Patrick Ohly wrote:
> On Mon, 2017-11-20 at 07:47 +1100, James Morris wrote:
> > On Fri, 17 Nov 2017, Roberto Sassu wrote:
> > 
> > > LSMs are responsible to enforce a security policy at run-time,
> > > while IMA/EVM protect data and metadata against offline attacks.
> > 
> > In my view, IMA can also protect against making an online attack 
> > persistent across boots, and that would be the most compelling use of
> > it for many general purpose applications.
> 
> I do not quite buy that interpretation. If the online attack succeeds
> in bypassing the run-time checks, for example with a full root exploit,
> then he has pretty much the same capabilities to make persistent file
> changes as during an offline attack.

In the face of a full root exploit, there is not much that one can do,
"other" than to detect it.  This is why remote attestation is so
important.

> When allowing local hashing, it's actually worse: during an offline
> attack, the attacker might not have access to the TPM and thus cannot
> easily update the EVM HMAC. During an online attack, the kernel will
> happily update that and the IMA hash for the attacker, resulting in a
> file that passes appraisal after a reboot.

The assumption is that most files in the TCB are not changing and are
signed.  Custom policies should require file signatures for these
files.

Assuming that the private keys that are used to sign these files, as
well as the private key used for signing other keys added to the IMA
keyring, are stored off line, new files can not be signed.

The number of mutable files in the TCB should be very limited,
probably < 20 files.  Their usage can be constrained by MAC.

That said, IMA/IMA-appraisal is work in progress.  There are still
measurement/appraisal gaps that need to be closed.  One such example
are files read by interpreters and interpreted files.  There have been
some initial proposals in this area.

Mimi
