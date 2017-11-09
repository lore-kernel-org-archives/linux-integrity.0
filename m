Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753609AbdKIQR1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Nov 2017 11:17:27 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA9GGGdb076816
        for <linux-integrity@vger.kernel.org>; Thu, 9 Nov 2017 11:17:26 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e4snwtq4g-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 09 Nov 2017 11:17:25 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 9 Nov 2017 16:17:23 -0000
Subject: Re: [PATCH v2 00/15] ima: digest list feature
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date: Thu, 09 Nov 2017 11:17:16 -0500
In-Reply-To: <CACdnJusj5aHHEJ2zY6UonK-XG_=P4Z09EPMZVKoXYUMZoUdHQQ@mail.gmail.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
         <CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
         <899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
         <CACdnJut-FzG=6DW-Pisx+_Ot5+=62_MabP1SU_RR2d9n-RJvyw@mail.gmail.com>
         <e879759b-d866-e3e3-b070-3025baf3454d@huawei.com>
         <CACdnJut0-4k97m0TM-Zd4jLPTraBe6_JoE-eznFYKwbPEmNS0Q@mail.gmail.com>
         <210975fe-527c-df2f-5a8a-9aca31e9246a@huawei.com>
         <CACdnJusj5aHHEJ2zY6UonK-XG_=P4Z09EPMZVKoXYUMZoUdHQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510244236.4484.172.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-09 at 09:47 -0500, Matthew Garrett wrote:

> This seems very over-complicated, and it's unclear why the kernel
> needs to open the file itself. You *know* that all of userland is
> trustworthy at this point even in the absence of signatures.

Assuming the initramfs is signed, then yes the rootfs files would be
trusted.  rootfs can still access files from real root, which is where
policies are normally stored.

> It seems
> reasonable to provide a interface that allows userland to pass a
> digest list to the kernel, in the same way that userland can pass an
> IMA policy to the kernel. You can then restrict access to that
> interface via an LSM.

IMA can and should be configured to require signed policies.

Mimi
