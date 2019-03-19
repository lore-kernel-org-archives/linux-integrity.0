Return-Path: <SRS0=sVEj=RW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09A7C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 11:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8932320828
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 11:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCSLW5 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:22:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbfCSLW5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Mar 2019 07:22:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JBGA3e085010
        for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2019 07:22:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ravks7n0h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2019 07:22:55 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 19 Mar 2019 11:22:49 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 11:22:47 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JBMoIg20840536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 11:22:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B759AE045;
        Tue, 19 Mar 2019 11:22:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0FCAAE055;
        Tue, 19 Mar 2019 11:22:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.3])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 11:22:49 +0000 (GMT)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        linux-integrity@vger.kernel.org
Date:   Tue, 19 Mar 2019 07:22:39 -0400
In-Reply-To: <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
         <1552945715.8658.299.camel@linux.ibm.com>
         <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031911-4275-0000-0000-0000031CCBCF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031911-4276-0000-0000-0000382B4BC5
Message-Id: <1552994559.4899.26.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=845 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190084
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-03-19 at 10:50 +0300, Igor Zhbanov wrote:
> Hi Mimi,
> 
> I guess similar to SELinux function:
[snip]

Remember IMA relies on LSMs for mandatory access control(MAC).  IMA
measures, audits, and enforces file integrity.

> 
> The structure vm_area_struct has a pointer vm_file pointing to mapped file
> so it could be used what file's xattrs to check.

That's fine for when there is a file descriptor, but the file
descriptor could have been closed.  (Refer to the mmap manpage.)

Mimi

