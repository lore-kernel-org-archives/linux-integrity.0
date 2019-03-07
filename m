Return-Path: <SRS0=us8B=RK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45C4C43381
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 14:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765C920675
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 14:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfCGO1O (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:27:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726120AbfCGO1N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Mar 2019 09:27:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27EEhAY142549
        for <linux-integrity@vger.kernel.org>; Thu, 7 Mar 2019 09:27:12 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r34c5ttxp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 07 Mar 2019 09:27:12 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 7 Mar 2019 14:27:10 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Mar 2019 14:27:08 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x27ER85o57606340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Mar 2019 14:27:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1841A4053;
        Thu,  7 Mar 2019 14:27:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F3C2A4059;
        Thu,  7 Mar 2019 14:27:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.211])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Mar 2019 14:27:07 +0000 (GMT)
Subject: Re: [PATCH] MAINTAINERS: fix typo in Mimi Zohar's address
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     paulmck@linux.ibm.com, Baruch Siach <baruch@tkos.co.il>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Date:   Thu, 07 Mar 2019 09:26:56 -0500
In-Reply-To: <20190307141957.GO13351@linux.ibm.com>
References: <e186bbae367ceb7a2a71e2dea216838ac19dee8f.1545889849.git.baruch@tkos.co.il>
         <20181227165304.GA4170@linux.ibm.com> <87r2bj2ql4.fsf@tarshish>
         <20190307141957.GO13351@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030714-0008-0000-0000-000002C9D4E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030714-0009-0000-0000-00002235E357
Message-Id: <1551968816.31706.336.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903070101
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-03-07 at 06:19 -0800, Paul E. McKenney wrote:
> On Thu, Mar 07, 2019 at 07:36:39AM +0200, Baruch Siach wrote:
> > Hi Paul,
> > 
> > On Thu, Dec 27 2018, Paul E. McKenney wrote:
> > 
> > > On Thu, Dec 27, 2018 at 07:50:49AM +0200, Baruch Siach wrote:
> > >> Fixes: ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
> > >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > >
> > > Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > >
> > > And where is a brown paper bag when you need one?  :-/
> > 
> > This has missed v5.0.
> 
> And v5.1 unless someone is pushing it into this merge window.
> 
> > Which tree is this patch supposed to go through, anyway?
> 
> I was expecting you to push it somewhere, hence my Reviewed-by.  But I
> can take it, and if I do it will be v5.2.

I'm really sorry I missed that.
> 
> Or you could try sending it directly to Linus, which would very likely
> get it into v5.1.

If you decide not to send it, I'll include it for v5.2.

Mimi

