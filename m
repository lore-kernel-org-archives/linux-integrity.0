Return-Path: <SRS0=2lTb=SF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE9EC4360F
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 20:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA982084B
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 20:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDCUmo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:42:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbfDCUmo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Apr 2019 16:42:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33KSlki089279
        for <linux-integrity@vger.kernel.org>; Wed, 3 Apr 2019 16:42:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rn1xywqun-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2019 16:42:42 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 3 Apr 2019 21:42:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 21:42:38 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33KgbKN61931652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 20:42:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18B1FAE04D;
        Wed,  3 Apr 2019 20:42:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EBC4AE051;
        Wed,  3 Apr 2019 20:42:36 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 20:42:36 +0000 (GMT)
Subject: Re: [PATCH v3] ima-evm-utils: Rework openssl init
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 03 Apr 2019 16:42:35 -0400
In-Reply-To: <20190323021609.20600-1-vt@altlinux.org>
References: <20190323021609.20600-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040320-0020-0000-0000-0000032BF605
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040320-0021-0000-0000-0000217E02BE
Message-Id: <1554324155.3839.22.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-03-23 at 05:16 +0300, Vitaly Chikunov wrote:
> Remove deprecated call to OpenSSL_add_all_algorithms().
> Allow to disable openssl config loading by evmctl via configure
> `--disable-openssl-conf' option. Show status of that in configure.
> Move config loading from libimaevm to evmctl.
> Finish engine initialization properly by calling ENGINE_set_default(),
> as suggested by James Bottomley.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

