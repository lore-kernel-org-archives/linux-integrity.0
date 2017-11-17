Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932236AbdKQMVf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 07:21:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAHCLJKD134812
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 07:21:34 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e9tr65b2d-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 07:21:34 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 17 Nov 2017 12:21:31 -0000
Subject: Re: [PATCH v2 00/15] ima: digest list feature
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        Kees Cook <keescook@chromium.org>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        silviu.vlasceanu@huawei.com
Date: Fri, 17 Nov 2017 07:21:26 -0500
In-Reply-To: <ddad05d7-1e74-e7b4-d59c-f2e217aa92b5@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
         <1510061855.3425.113.camel@linux.vnet.ibm.com>
         <aec4e72a-7f74-43e7-c226-f51077e7c619@huawei.com>
         <CAGXu5jKjXqn-1j881vYc1F0POPhPJOPZB1w=W_zfgdXTsiyX6A@mail.gmail.com>
         <ddad05d7-1e74-e7b4-d59c-f2e217aa92b5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510921286.5920.41.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-11-17 at 09:55 +0100, Roberto Sassu wrote:
> On 11/17/2017 2:08 AM, Kees Cook wrote:
> > On Tue, Nov 7, 2017 at 8:45 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> >> On 11/7/2017 2:37 PM, Mimi Zohar wrote:
> >>> Normally, the protection of kernel memory is out of scope for IMA.
> >>> This patch set introduces an in kernel white list, which would be a
> >>> prime target for attackers looking for ways of by-passing IMA-
> >>> measurement, IMA-appraisal and IMA-audit.  Others might disagree, but
> >>> from my perspective, this risk is too high.
> > 
> > BTW, which part of the series does the whitelist? I'd agree generally,
> > though: we don't want to make things writable if they're normally
> > read-only.

The white list is a proposed new feature.

> Patch 5/15 introduces the hash table ima_digests_htable and the
> functions to add/search file digests
> 
> Patches 6-7-8/15 add file digests to ima_digests_htable
> 
> Patch 10/15 searches file digests in ima_digests_htable
> 
> 
> Original files containing digest lists are discarded after being parsed.
> 
> 
> >> It would be much easier for an attacker to just set ima_policy_flag to
> >> zero.
> > 
> > That's a fair point. I wonder if ima_policy_flag could be marked
> > __ro_after_init? Most of the writes are from __init sections, but I
> > haven't looked closely at when ima_update_policy() gets called.
> 
> Unfortunately not. New policies can be loaded by writing to a file in
> the securityfs filesystem. They could enable different actions
> (measurement/appraisal/audit).

The ima_policy_flag is an optimization indicating which actions -
MEASURE, APPRAISE, AUDIT - the policy contains.  The IMA policy,
itself, can be replaced with a signed custom policy just once.  This
is normally done in the initramfs, after the LSM policies have been
loaded, in order to define policy rules in terms of LSM labels.  Once
the new policy is loaded, the ima_policy_flag is set.

A Kconfig option allows additional signed rules to be added to the IMA
policy.  After adding these new rules, additional actions can be added
to the policy flag, but not cleared.

The system admin/owner knows, prior to loading the custom policy,
which actions will be defined.  Instead of waiting for the policy to
be written, the ima_policy_flag could be set at init.  (We could
extend the existing "ima_policy=" boot command line option.)  If not
the ima_policy_flag, itself, then a shadow of the ima_policy_flag,
which is OR'ed with the ima_policy_flag.

Mimi
