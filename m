Return-Path: <SRS0=Znl9=PS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C712C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 16:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CDB20685
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 16:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfAJQS1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:18:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727953AbfAJQS0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jan 2019 11:18:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AGEHQU070671
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jan 2019 11:18:25 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2px763qhgw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jan 2019 11:18:25 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 10 Jan 2019 16:18:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 16:18:21 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0AGIKGG11731144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 16:18:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD2BC42041;
        Thu, 10 Jan 2019 16:18:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 332F142052;
        Thu, 10 Jan 2019 16:18:20 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 16:18:20 +0000 (GMT)
Subject: Re: OTA does not work with IMA due to xattr not supported by zip
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     rishi gupta <gupt21@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Thu, 10 Jan 2019 11:18:19 -0500
In-Reply-To: <CALUj-gvmo8pTGeHB=L+sZaP9a1QPTE2AXNc=vzzfZ+4GtVac3A@mail.gmail.com>
References: <CALUj-gsiY+_K_PM2kAXvVFU+wntq6tQaqUk+BVzwA3o-7nhCPw@mail.gmail.com>
         <1546981121.19931.130.camel@linux.ibm.com>
         <CALUj-gvmo8pTGeHB=L+sZaP9a1QPTE2AXNc=vzzfZ+4GtVac3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011016-4275-0000-0000-000002FD2CB9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011016-4276-0000-0000-0000380B3F0A
Message-Id: <1547137099.19931.336.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=576 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100128
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-01-10 at 12:16 +0530, rishi gupta wrote:
> Thanks Mimi. Any plan for zip archive format support.

Are you offering?

> Also when using EVM, the files has to be signed on target. So after
> new files has been flashed on device during OTA, does private key also
> needs to be present on system.

Perhaps someone with Android experience could respond.  Dmitry?

