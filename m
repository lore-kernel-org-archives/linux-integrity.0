Return-Path: <SRS0=eq0w=PE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B685C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 27 Dec 2018 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB52214C6
	for <linux-integrity@archiver.kernel.org>; Thu, 27 Dec 2018 16:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbeL0QxD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 27 Dec 2018 11:53:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731164AbeL0QxD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Dec 2018 11:53:03 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBRGmqnc013352
        for <linux-integrity@vger.kernel.org>; Thu, 27 Dec 2018 11:52:57 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pn137mt0m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Dec 2018 11:52:57 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Dec 2018 16:52:56 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Dec 2018 16:52:53 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBRGqqkx14745612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Dec 2018 16:52:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E153AB2067;
        Thu, 27 Dec 2018 16:52:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C82D5B205F;
        Thu, 27 Dec 2018 16:52:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Dec 2018 16:52:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6651F16C3373; Thu, 27 Dec 2018 08:53:04 -0800 (PST)
Date:   Thu, 27 Dec 2018 08:53:04 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix typo in Mimi Zohar's address
Reply-To: paulmck@linux.ibm.com
References: <e186bbae367ceb7a2a71e2dea216838ac19dee8f.1545889849.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e186bbae367ceb7a2a71e2dea216838ac19dee8f.1545889849.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18122716-0052-0000-0000-0000036DABBB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010297; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01137899; UDB=6.00591911; IPR=6.00918077;
 MB=3.00024866; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-27 16:52:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122716-0053-0000-0000-00005F3FF6FF
Message-Id: <20181227165304.GA4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812270149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 27, 2018 at 07:50:49AM +0200, Baruch Siach wrote:
> Fixes: ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

And where is a brown paper bag when you need one?  :-/

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 705555d9b3af..0b8b0d60833a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8339,7 +8339,7 @@ F:	security/keys/encrypted-keys/
>  KEYS-TRUSTED
>  M:	James Bottomley <jejb@linux.ibm.com>
>  M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> -M:	Mimi Zohar <zohar@linuxibm.com>
> +M:	Mimi Zohar <zohar@linux.ibm.com>
>  L:	linux-integrity@vger.kernel.org
>  L:	keyrings@vger.kernel.org
>  S:	Supported
> -- 
> 2.19.2
> 

