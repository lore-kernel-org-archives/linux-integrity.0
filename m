Return-Path: <SRS0=2lTb=SF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8469C4360F
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 21:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D603206DF
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 21:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDCV7k (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:59:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfDCV7k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Apr 2019 17:59:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33LxFcG108993
        for <linux-integrity@vger.kernel.org>; Wed, 3 Apr 2019 17:59:39 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rn40ek6h6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2019 17:59:38 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 3 Apr 2019 22:59:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 22:59:32 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33LxVnQ61669448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 21:59:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 894915204E;
        Wed,  3 Apr 2019 21:59:31 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DDAD552051;
        Wed,  3 Apr 2019 21:59:30 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima-evm-utils: try to load digest by its alias
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 03 Apr 2019 17:59:30 -0400
In-Reply-To: <20190403215711.7dypkbiinjzt2t5i@altlinux.org>
References: <20190323014152.14701-1-vt@altlinux.org>
         <20190323014152.14701-3-vt@altlinux.org>
         <1554324064.3839.20.camel@linux.ibm.com>
         <20190403210435.duptffqlwp6vo66m@altlinux.org>
         <1554325820.3839.27.camel@linux.ibm.com>
         <20190403213739.afjtakg5nujke477@altlinux.org>
         <1554327643.3839.29.camel@linux.ibm.com>
         <20190403215711.7dypkbiinjzt2t5i@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040321-0008-0000-0000-000002D5FB2B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040321-0009-0000-0000-0000224205E1
Message-Id: <1554328770.3839.31.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=873 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-04 at 00:57 +0300, Vitaly Chikunov wrote:

> Maybe this:
> 
>   "Streebog" is a name of the hash algorithm in the Kernel Crypto API.
>   "md_gost12_X" is the name used by the most versions of OpenSSL, it's
>   placed in pkey_hash_algo[] so that algo IDs are resolved to them.

Thank you!

