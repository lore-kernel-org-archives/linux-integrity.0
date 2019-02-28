Return-Path: <SRS0=BEGI=RD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C3C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 01:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2B6218A2
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 01:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfB1BkA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:40:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730234AbfB1BkA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 20:40:00 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S1dKmx049101
        for <linux-integrity@vger.kernel.org>; Wed, 27 Feb 2019 20:39:52 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qx4ue315d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 27 Feb 2019 20:39:51 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 28 Feb 2019 01:39:51 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 01:39:49 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1S1dm2W27983946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 01:39:48 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E5E1BE054;
        Thu, 28 Feb 2019 01:39:48 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF792BE04F;
        Thu, 28 Feb 2019 01:39:46 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.80.198.150])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Feb 2019 01:39:46 +0000 (GMT)
References: <MWHPR21MB075192F589A7AA4E8B89F8B9F0740@MWHPR21MB0751.namprd21.prod.outlook.com> <1551307229.10911.100.camel@linux.ibm.com> <MWHPR21MB07518C72F310CC9F8ECB683CF0750@MWHPR21MB0751.namprd21.prod.outlook.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Jordan Hand <Jordan.Hand@microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity\@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [DISCUSSION] IMA Signature Measurements
In-reply-to: <MWHPR21MB07518C72F310CC9F8ECB683CF0750@MWHPR21MB0751.namprd21.prod.outlook.com>
Date:   Wed, 27 Feb 2019 22:39:42 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19022801-0004-0000-0000-000014E7F8EC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010677; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167359; UDB=6.00609846; IPR=6.00947970;
 MB=3.00025772; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-28 01:39:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022801-0005-0000-0000-00008ABE19BC
Message-Id: <87k1hkk7xd.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280008
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hello Jordan,

Jordan Hand <Jordan.Hand@microsoft.com> writes:

>>On Wed, 2019-02-27 at 22:02 +0000, Jordan Hand wrote:
>>> Hello,
>>>
>>> I have been looking into how IMA policies work for
>>> measuring/appraising in specific scenarios such as kexec. IMA has
>>> specific policies for these scenarios (i.e. setting func to
>>> KEXEC_KERNEL_CHECK). While these policies do exist, in practice it
>>> seems that IMA treats these files the same way it treats any other
>>> file; it will validate and measure (in the case of ima-sig) based on
>>> the IMA signature in the file's inode.
>>
>>or security.ima could contain a file hash, while security.evm contains a signature.
>>
>>>
>>> It seems that this policy is mostly a placeholder in case there is a
>>> desire later to do some different behavior based on the file type
>>> (correct me if I'm wrong and there's another reason for having the
>>> KEXEC_KERNEL_CHECK function).
>>
>>Policies are defined in terms of hooks, LSM labels, and other file metadata. True
>>the FILE_CHECK hook could be defined to measure, appraise, audit the kexec
>>kernel image, but it might not require a signature. Defining a policy containing
>>KEXEC_KERNEL_CHECK allows specifying the kexec'ed kernel module be signed
>>without requiring all files to be signed.
>>
>>>
>>> I wanted to get feedback on the possibility of IMA measuring a
>>> different signature type during kexec. In general kernal images are
>>> signed as PE files, with the signature embedded in the file image.
>>> Normal kexec (not the IMA path) validates this type of signature. I
>>> would like to use IMA to both appraise and measure based on this
>>> signature instead of the IMA signature (this could have a Kconfig
>>> flag).
>>
>>The ima-sig template contains a file hash and an IMA signature field.
>>The file hash needs to remain the file hash of the entire file.
>>Thiago is currently adding support for a kexec kernel image appended
>>signature. He's defining two new template fields named d-modsig and modsig
>>and a new policy "appraise_type" named "modsig".
>>
>>You could do something similarly.
>
> Ah, I missed that patch set. That seems to be very close to what I
> wanted. I'll take a deeper look.

I am preparing a new version of the patch set. I'm hoping to post it by
the end of the week if all goes well.

> As an aside, is there any mechanism for measuring things other than
> files in the kernel (IMA or otherwise)? As an example, I was looking
> into measuring the kernel command line string being used during kexec.
> I suppose at that point its getting away from the purpose of IMA to
> measure files being loaded/executed on the system.

Well, there's at least one example of IMA measuring something that's not
a file: the boot_aggregate (see ima_add_boot_aggregate()) which measures
some PCR registers.

--
Thiago Jung Bauermann
IBM Linux Technology Center

