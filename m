Return-Path: <SRS0=yJTw=QF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D57EC169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 18:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AC22080F
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 18:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfA2SiM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:38:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726852AbfA2SiM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jan 2019 13:38:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TIY17M055908
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jan 2019 13:38:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qat3f710k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jan 2019 13:38:11 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 29 Jan 2019 18:38:09 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 18:38:07 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TIc6Dj58982610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 18:38:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21FB44C04A;
        Tue, 29 Jan 2019 18:38:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA4DD4C044;
        Tue, 29 Jan 2019 18:38:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.219])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jan 2019 18:38:05 +0000 (GMT)
Subject: Re: Understanding fsuuid policy rule for appraisal and exclusion
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     rishi gupta <gupt21@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Tue, 29 Jan 2019 13:37:54 -0500
In-Reply-To: <CALUj-gsgpbcXD8xpG-XTZ3QCs_1CoN_9w6sOUSPVYHJ7OrnwQA@mail.gmail.com>
References: <CALUj-gsgpbcXD8xpG-XTZ3QCs_1CoN_9w6sOUSPVYHJ7OrnwQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012918-4275-0000-0000-0000030771BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012918-4276-0000-0000-000038157540
Message-Id: <1548787074.20210.27.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290135
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-01-29 at 14:21 +0530, rishi gupta wrote:
> Hi Team,
> 
> I set the policy for IMA as follows. (1) Files in partition B will be
> appraised or not if its UUID is not yyyy-yy-yy-yy. (2) Do files in
> partition C only will be appraised irrespective of whatever rule is
> written for other partitions.
> 
> My goal is to include a partition and exclude all other partitions.
> 
> # Exclude partition A
> dont_measure fsuuid=xxxx-xx-xx-xx
> dont_appraise fsuuid=xxxx-xx-xx-xx
> 
> # Exclude partition B (Problem here)
> dont_measure fsuuid=yyyy-yy-yy-yy
> dont_appraise fsuuid=yyyy-yy-yy-yy
> 
> # Appraise partition C
> appraise fsuuid=zzzz-zz-zz-zz appraise_type=imasig

Are you having problems with these policy rules?  Policy rules are
handled sequentially.  Just make sure these rules are before any of
the other "appraise" rules.

Mimi

