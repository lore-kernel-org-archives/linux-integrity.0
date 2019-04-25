Return-Path: <SRS0=MPPW=S3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43D1C10F03
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 12:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFA2218AD
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 12:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfDYMOZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:14:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727452AbfDYMOZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Apr 2019 08:14:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PC0SQG057573
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 08:14:23 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s3c9m1d12-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 08:14:23 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 25 Apr 2019 13:14:21 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 13:14:19 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PCEIvM56623276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 12:14:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5487EA4073;
        Thu, 25 Apr 2019 12:14:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E91E8A405F;
        Thu, 25 Apr 2019 12:14:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Apr 2019 12:14:17 +0000 (GMT)
Subject: Re: [PATCH] integrity: make 'sync' update the inode integrity state
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Thu, 25 Apr 2019 08:14:07 -0400
In-Reply-To: <CAE=NcraD_VD=ZmNTiCb4AWzwiaOYp5S0cE4uC64b0kHLQ=7PEA@mail.gmail.com>
References: <20190410145659.26347-1-janne.karhunen@gmail.com>
         <1554987784.7843.40.camel@linux.ibm.com>
         <CAE=NcrYDK1de25XeJcYOpW41O3_RbqYJamkz=SE745Krfa=t8Q@mail.gmail.com>
         <CAE=NcraD_VD=ZmNTiCb4AWzwiaOYp5S0cE4uC64b0kHLQ=7PEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042512-0012-0000-0000-000003148CE2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042512-0013-0000-0000-0000214CE6C5
Message-Id: <1556194447.3894.105.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250077
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-25 at 13:05 +0300, Janne Karhunen wrote:
> Hi,

> Finally. Now I think I'm almost happy with the overall construction
> and my gut feeling is telling me I can make the hashes reflect the
> filesystem state pretty well, maybe even over 99.9% of the time given
> the workload stock android is generating.
> 
> The pieces that we did:
> - initialize hashes correctly on open()
> - hook 'sync'
> - hook 'msync'
> - hook 'truncate'
> - introduce a per-cpu workqueue that gets work items from write and
> dirty page flush. Long-running write is allowed to go as is (no
> performance penalty from re-measurements), but once the the write goes
> silent workqueue item is flushed and the file is hashed.

What type of workqueue (eg. fifo)?  Are all of the writes needed, as
they might be re-written later.

> 
> Before I uplift this construction against the mainline, any thoughts
> about this? All I can say so far is that it runs and it seems to keep
> the system relatively crash tolerant. 'Don't let the perfect be the
> enemy of the better' I guess...

As long as the iint cache info isn't affected by these changes, the
change is limited to writing out the xattr more frequently.  If the
iint cache info is affected, then you need to be careful that multiple
readers/writers continue to work.

Mimi

