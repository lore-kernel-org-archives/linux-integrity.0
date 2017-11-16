Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934876AbdKPNGp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 08:06:45 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAGD6jqU130366
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 08:06:45 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e997j697q-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 08:06:44 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 16 Nov 2017 13:06:41 -0000
Subject: Re: IMA appraisal master plan?
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <james.l.morris@oracle.com>
Cc: Patrick Ohly <patrick.ohly@intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 16 Nov 2017 08:06:35 -0500
In-Reply-To: <8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
References: <20171107151742.25122-1-mjg59@google.com>
         <1510766803.5979.17.camel@intel.com>
         <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
         <1510770065.5979.21.camel@intel.com>
         <alpine.LFD.2.20.1711161101360.27132@localhost>
         <CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
         <1510798382.3711.389.camel@linux.vnet.ibm.com>
         <8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510837595.3711.420.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-16 at 10:23 +0100, Roberto Sassu wrote:
> On 11/16/2017 3:13 AM, Mimi Zohar wrote:
> > On Wed, 2017-11-15 at 16:05 -0800, Matthew Garrett wrote:
> >> On Wed, Nov 15, 2017 at 4:02 PM, James Morris <james.l.morris@oracle.com> wrote:
> >>> On Wed, 15 Nov 2017, Patrick Ohly wrote:
> >>>
> >>>> I have some experience with SMACK, but not with Apparmor. At least with
> >>>> SMACK the problem is that the LSM depends on integrity protection of
> >>>> the xattrs, but the integrity protection itself depends on the LSM, so
> >>>> there's a cycle. An attacker can much too easily make offline changes
> >>>> which then defeat whatever IMA policy the system might be using.
> >>>
> >>> Isn't this what EVM is supposed to mitigate?
> 
> With the default appraisal policy, it can't. IMA determines if a file
> must be appraised depending on metadata whose integrity has not been
> verified yet. A root process is able to load appraised files with
> i_uid = 0 and files with missing/invalid HMAC and i_uid != 0, at the
> same time.

The LSMs are responsible for protecting their own labels.  They have
the opportunity to verify and deny access to files based on LSM
labels, BEFORE IMA-appraisal is called to verify the file's integrity.

Look at security/security.c and see that IMA is called AFTER the
LSMs.  The same is true for the other IMA hooks, that are not co-
located with LSM hooks.  For example, the security_file_open hook is
called before the ima_file_check() hook.

Mimi
