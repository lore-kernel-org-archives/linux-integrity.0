Return-Path: <SRS0=MPPW=S3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9CDC10F03
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C17218AD
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 11:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDYL7H (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:59:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbfDYL7H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Apr 2019 07:59:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PBpY1c041049
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 07:59:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3bxt1feb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 07:59:06 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 25 Apr 2019 12:59:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 12:59:01 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PBx01344367980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 11:59:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77D794203F;
        Thu, 25 Apr 2019 11:59:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC8D142049;
        Thu, 25 Apr 2019 11:58:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.60])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Apr 2019 11:58:59 +0000 (GMT)
Subject: Re: Can we enforce "IMA Policy" based on file type
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kavitha Sivagnanam <kavi@juniper.net>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Thu, 25 Apr 2019 07:58:49 -0400
In-Reply-To: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
References: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042511-0012-0000-0000-00000314845B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042511-0013-0000-0000-0000214CDE2F
Message-Id: <1556193529.3894.94.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250076
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-04-19 at 21:52 +0000, Kavitha Sivagnanam wrote:
> Hi
> 
> I am wondering, in the current implementation of IMA policy, if
> there is a way to enforce appraisal on a file based on the file
> type.  The file type that I am interested in enforcing the policy is
> for SquashFS files.
> 
> We want to check the signature on the SquashFS file itself before
> mounting it and mark the partition as read-only. This would allow us
> to have the flexibility of not signing every immutable file we are
> installing. Also the installation process will be faster as setting
> extended attribute on every file is extremely time consuming
> process.  The signatures are generated at build time & we are using
> seftattr to set the security.ima attribute. 
> 
> Is it possible to achieve this with existing policy (or) we need
> enhancement to the current IMA code? If we need to enhance the
> kernel to support this feature, where would we start?

As Matthew indicated, you could define LSM labels on the squashfs file
images.  Another option would be to extend IMA by implementing the LSM
security_sb_mount hook.  The IMA policy rule would probably look
something like:

appraise func=MOUNT_CHECK fsname=squashfs appraise_type=imasig

Mimi

