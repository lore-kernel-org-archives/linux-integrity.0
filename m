Return-Path: <SRS0=nfu5=RC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE703C43381
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7DD2133D
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 22:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfB0WuM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:50:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729412AbfB0WuM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 17:50:12 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RMo0pT016985
        for <linux-integrity@vger.kernel.org>; Wed, 27 Feb 2019 17:50:06 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qx1knn0bf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 27 Feb 2019 17:50:05 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 27 Feb 2019 22:50:04 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 22:50:02 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1RMo1Aa29556798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 22:50:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29B6152F71;
        Wed, 27 Feb 2019 22:50:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.105])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9F8E452F72;
        Wed, 27 Feb 2019 22:50:00 +0000 (GMT)
Subject: Re: [DISCUSSION] IMA Signature Measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jordan Hand <Jordan.Hand@microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Wed, 27 Feb 2019 17:49:50 -0500
In-Reply-To: <1551306168.3105.22.camel@HansenPartnership.com>
References: <MWHPR21MB075192F589A7AA4E8B89F8B9F0740@MWHPR21MB0751.namprd21.prod.outlook.com>
         <1551306168.3105.22.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022722-0020-0000-0000-0000031C1691
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022722-0021-0000-0000-0000216D854E
Message-Id: <1551307790.10911.106.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=886 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-02-27 at 14:22 -0800, James Bottomley wrote:
> On Wed, 2019-02-27 at 22:02 +0000, Jordan Hand wrote:

> Um, this is already upstream.  The slight problem is that kernel
> bzImages are arch specific, so the file you're looking for is 
> 
>   arch/x86/kernel/kexec-bzimage64.c
> 
> You'll find the signature verifier for x86 bzImages is the PE one.  The
> current problem is more that the kernel keyring doesn't trust the
> secure boot keys, so the issue isn't with the signature format its with
> keyring trust.

With CONFIG_INTEGRITY_PLATFORM_KEYRING enabled, the pre-boot keys are
loaded onto the new "platform" keyring.  Queued for v5.1 are two
patches which allow verifying the PE signed kernel image based on keys
in the platform keyring.

Mimi

