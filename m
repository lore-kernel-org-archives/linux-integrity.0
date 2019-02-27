Return-Path: <SRS0=nfu5=RC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AADC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 22:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEA62083D
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 22:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfB0Wk4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:40:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729412AbfB0Wk4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 17:40:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RMdiGJ024452
        for <linux-integrity@vger.kernel.org>; Wed, 27 Feb 2019 17:40:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qx17swumr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 27 Feb 2019 17:40:45 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 27 Feb 2019 22:40:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 22:40:41 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1RMeePJ39977012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 22:40:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 547BE11C08B;
        Wed, 27 Feb 2019 22:40:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D726411C08C;
        Wed, 27 Feb 2019 22:40:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.105])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 22:40:39 +0000 (GMT)
Subject: Re: [DISCUSSION] IMA Signature Measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jordan Hand <Jordan.Hand@microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Wed, 27 Feb 2019 17:40:29 -0500
In-Reply-To: <MWHPR21MB075192F589A7AA4E8B89F8B9F0740@MWHPR21MB0751.namprd21.prod.outlook.com>
References: <MWHPR21MB075192F589A7AA4E8B89F8B9F0740@MWHPR21MB0751.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022722-0028-0000-0000-0000034DDB45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022722-0029-0000-0000-0000240C345F
Message-Id: <1551307229.10911.100.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-02-27 at 22:02 +0000, Jordan Hand wrote:
> Hello,
> 
> I have been looking into how IMA policies work for
> measuring/appraising in specific scenarios such as kexec. IMA has
> specific policies for these scenarios (i.e. setting func to
> KEXEC_KERNEL_CHECK). While these policies do exist, in practice it
> seems that IMA treats these files the same way it treats any other
> file; it will validate and measure (in the case of ima-sig) based on
> the IMA signature in the file's inode.

or security.ima could contain a file hash, while security.evm contains
a signature.

> 
> It seems that this policy is mostly a placeholder in case there is a
> desire later to do some different behavior based on the file type
> (correct me if I'm wrong and there's another reason for having the
> KEXEC_KERNEL_CHECK function).

Policies are defined in terms of hooks, LSM labels, and other file
metadata.  True the FILE_CHECK hook could be defined to measure,
appraise, audit the kexec kernel image, but it might not require a
signature.  Defining a policy containing KEXEC_KERNEL_CHECK allows
specifying the kexec'ed kernel module be signed without requiring all
files to be signed. 

> 
> I wanted to get feedback on the possibility of IMA measuring a
> different signature type during kexec. In general kernal images are
> signed as PE files, with the signature embedded in the file image.
> Normal kexec (not the IMA path) validates this type of signature. I
> would like to use IMA to both appraise and measure based on this
> signature instead of the IMA signature (this could have a Kconfig
> flag).

The ima-sig template contains a file hash and an IMA signature field.
 The file hash needs to remain the file hash of the entire file.
 Thiago is currently adding support for a kexec kernel image appended
signature.  He's defining two new template fields named d-modsig and
modsig and a new policy "appraise_type" named "modsig".

You could do something similarly.

> Alternatively it could look for both. I think this makes sense
> because it means folks can make use of IMA's measurement
> capabilities while still signing the kernel image in the same way
> they have always signed it for kexec. This also makes the
> signing/packaging/installing story simpler for kernels wishing to
> make use of IMA as they don't have to ship with IMA/EVM signatures.

For systems which support PE signatures, distros don't need to provide
 both PE and IMA signatures.  Please refer to the IMA x86 architecture
specific policy being upstreamed and the IMA kselftest patches that I
posted yesterday.

Mimi

> 
> I know that currently IMA only handles IMA/EVM signatures (makes
> sense) so this would deviate a decent amount from how IMA currently
> works. I want to get general thoughts on this proposal before I
> start work on this to ensure this is something the
> community/maintainers are supportive of.

