Return-Path: <SRS0=2aJh=RY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BC4C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Mar 2019 11:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9B3218E2
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Mar 2019 11:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfCULWR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:22:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727867AbfCULWR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Mar 2019 07:22:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LB5oMb136715
        for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2019 07:22:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rc6v6qunh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2019 07:22:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 21 Mar 2019 11:22:06 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Mar 2019 11:22:03 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2LBM9R559768878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 11:22:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55298AE04D;
        Thu, 21 Mar 2019 11:22:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB6B2AE045;
        Thu, 21 Mar 2019 11:22:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.235])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Mar 2019 11:22:08 +0000 (GMT)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Date:   Thu, 21 Mar 2019 07:21:58 -0400
In-Reply-To: <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
         <1552945715.8658.299.camel@linux.ibm.com>
         <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
         <1552994559.4899.26.camel@linux.ibm.com>
         <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
         <1553015134.4899.82.camel@linux.ibm.com>
         <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
         <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032111-4275-0000-0000-0000031DA09A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032111-4276-0000-0000-0000382C2814
Message-Id: <1553167318.4899.382.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903210082
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Jann Horn, who brought this topic up last year.]

On Wed, 2019-03-20 at 10:23 -0700, Matthew Garrett wrote:
> On Wed, Mar 20, 2019 at 1:11 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:

<snip>

> > My point was about better protecting of shared libraries making life harder
> > for exploits that are downloading extra code from external servers.
> 
> Like you said, they can implement this by copying the code from
> read-only pages to separate executable pages. It does make it harder,
> but not to a huge degree - anything that's mprotect()ing file-backed
> pages to PROT_EXEC later is presumably doing so to avoid IMA, and
> making this change will just encourage them to add further
> workarounds. Since this is a fight we literally can't win, what's the
> benefit?

Really, Matthew?  Such gloomy thoughts coming from someone advocating
the "lockdown" patch set and extending IMA/EVM.  Part of our job
description as Linux kernel security/integrity developers is exactly
that - to make it more difficult for attackers, by hardening the
system and closing one measurement/appraisal gap at a time.

Igor, as for shared libraries:

1. Extend ima_file_mmap() to permit, based on policy, verifying file
signatures for files being mmap'ed read and preventing validly signed
files from being mmap'ed write.

2. Define an IMA mprotect hook that permits, based on policy,
preventing memory having validly signed backing storage from setting
the memory region to write, but allow execute.

(This will require access to the IMA mmap signature verification
status cached in the "iint".)

Mimi

