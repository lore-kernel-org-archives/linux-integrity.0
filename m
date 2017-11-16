Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757467AbdKPCNJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 21:13:09 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAG29AKR103849
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2017 21:13:08 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e913ksdqs-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2017 21:13:08 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 16 Nov 2017 02:13:06 -0000
Subject: Re: IMA appraisal master plan? (was: Re: [PATCH V6] EVM: Add
 support for portable signature format)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>,
        James Morris <james.l.morris@oracle.com>
Cc: Patrick Ohly <patrick.ohly@intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Wed, 15 Nov 2017 21:13:02 -0500
In-Reply-To: <CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
References: <20171107151742.25122-1-mjg59@google.com>
         <1510766803.5979.17.camel@intel.com>
         <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
         <1510770065.5979.21.camel@intel.com>
         <alpine.LFD.2.20.1711161101360.27132@localhost>
         <CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510798382.3711.389.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-11-15 at 16:05 -0800, Matthew Garrett wrote:
> On Wed, Nov 15, 2017 at 4:02 PM, James Morris <james.l.morris@oracle.com> wrote:
> > On Wed, 15 Nov 2017, Patrick Ohly wrote:
> >
> >> I have some experience with SMACK, but not with Apparmor. At least with
> >> SMACK the problem is that the LSM depends on integrity protection of
> >> the xattrs, but the integrity protection itself depends on the LSM, so
> >> there's a cycle. An attacker can much too easily make offline changes
> >> which then defeat whatever IMA policy the system might be using.
> >
> > Isn't this what EVM is supposed to mitigate?
> 
> If the path to the loading of the LSM policy isn't fully appraised,
> then it can be modified offline in order to permit modification of the
> EVM xattrs at runtime, at which point the kernel will happily generate
> a new HMAC.

Matthew, your explanation is a valid problem, but different than what
Patrick was describing.  Your description is of protecting the LSM
policy itself.  Patrick, correct me if I'm wrong, was describing the
situation where the LSM labels are modified, causing the file being
appraised not to be in the IMA policy.

To solve Matthew's problem requires modifying the LSMs so that instead
of userspace reading the policy, processing it and loading it into the
kernel, the LSMs read the policy file directly.

Mimi
