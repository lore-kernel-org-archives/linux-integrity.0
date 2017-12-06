Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751463AbdLFMrr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Dec 2017 07:47:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB6ClPue092818
        for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2017 07:47:47 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2epfj0n4xn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2017 07:47:46 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 6 Dec 2017 12:47:44 -0000
Subject: ima:  temporary "next-queued-testing" branch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Bruno E. O. Meneguele" <brdeoliv@redhat.com>,
        Joe Perches <joe@perches.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        James Morris <jmorris@namei.org>
Date: Wed, 06 Dec 2017 07:47:38 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512564458.4698.33.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi -

Before upstreaming "ima: re-introduce own integrity cache lock", I've
pushed the following patches to the next-queued-testing branch for
testing.  We'll resync with the linux-security tree based on -rc3,
hopefully next week.

d79d361c25d7 ima: re-introduce own integrity cache lock
4e94bcf160f2 ima: support new "hash" and "dont_hash" policy actions
bd1fa1e14733 ima: Fix line continuation format
cf46932b9a02 ima: pass filename to ima_rdwr_violation_check()
4aad0b3845e4 ima: log message to module appraisal error

thanks,

Mimi
