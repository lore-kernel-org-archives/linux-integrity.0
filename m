Return-Path: <SRS0=us8B=RK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C788DC43381
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 14:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A34920835
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 14:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfCGOUF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:20:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726207AbfCGOUF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Mar 2019 09:20:05 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27EF14o109756
        for <linux-integrity@vger.kernel.org>; Thu, 7 Mar 2019 09:20:04 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r34d427s8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 07 Mar 2019 09:20:03 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 7 Mar 2019 14:20:02 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Mar 2019 14:19:59 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x27EJwPR23920640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Mar 2019 14:19:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D06C0B2065;
        Thu,  7 Mar 2019 14:19:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3A68B2070;
        Thu,  7 Mar 2019 14:19:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Mar 2019 14:19:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6712D16C6593; Thu,  7 Mar 2019 06:19:57 -0800 (PST)
Date:   Thu, 7 Mar 2019 06:19:57 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix typo in Mimi Zohar's address
Reply-To: paulmck@linux.ibm.com
References: <e186bbae367ceb7a2a71e2dea216838ac19dee8f.1545889849.git.baruch@tkos.co.il>
 <20181227165304.GA4170@linux.ibm.com>
 <87r2bj2ql4.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2bj2ql4.fsf@tarshish>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19030714-0040-0000-0000-000004CE00AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010721; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01170932; UDB=6.00606765; IPR=6.00951576;
 MB=3.00025875; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-07 14:20:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030714-0041-0000-0000-000008D90E5E
Message-Id: <20190307141957.GO13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903070101
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 07, 2019 at 07:36:39AM +0200, Baruch Siach wrote:
> Hi Paul,
> 
> On Thu, Dec 27 2018, Paul E. McKenney wrote:
> 
> > On Thu, Dec 27, 2018 at 07:50:49AM +0200, Baruch Siach wrote:
> >> Fixes: ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >
> > Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
> >
> > And where is a brown paper bag when you need one?  :-/
> 
> This has missed v5.0.

And v5.1 unless someone is pushing it into this merge window.

> Which tree is this patch supposed to go through, anyway?

I was expecting you to push it somewhere, hence my Reviewed-by.  But I
can take it, and if I do it will be v5.2.

Or you could try sending it directly to Linus, which would very likely
get it into v5.1.

							Thanx, Paul

> baruch
> 
> >> ---
> >>  MAINTAINERS | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 705555d9b3af..0b8b0d60833a 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -8339,7 +8339,7 @@ F:	security/keys/encrypted-keys/
> >>  KEYS-TRUSTED
> >>  M:	James Bottomley <jejb@linux.ibm.com>
> >>  M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> -M:	Mimi Zohar <zohar@linuxibm.com>
> >> +M:	Mimi Zohar <zohar@linux.ibm.com>
> >>  L:	linux-integrity@vger.kernel.org
> >>  L:	keyrings@vger.kernel.org
> >>  S:	Supported
> 
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
> 

