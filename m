Return-Path: <SRS0=36rA=4W=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C040FC3F2D2
	for <linux-integrity@archiver.kernel.org>; Thu,  5 Mar 2020 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9251120848
	for <linux-integrity@archiver.kernel.org>; Thu,  5 Mar 2020 20:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRLEAu1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgCEUce (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:32:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50407 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEUce (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 15:32:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so15797wmb.0;
        Thu, 05 Mar 2020 12:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RQ/OfgFACJ0HisdDvqug2qr4vfTuZ/pxuVKJCyxS9zw=;
        b=sRLEAu1aPYmaaq/kcEvKo4cbSXgVvYRa8fd2ovdQfBJiaEl4FnME2hUIOicSkOJj98
         4byYuz7lfI4m9G9pQ3AlVupw9gP8rTKSa3081CpFJkVRflxBWzCdZJbAm7bTk0ZXYGxP
         va4W1C9la/XQo2P9wK3pHfMtAIWuGdDd1stIxlMUQ83KGl8EUfB1ec6+2xVmCr6831G5
         Bev9rhSlGDHDHIfMa6HL+RW+Fx++iFuIr7xgYqCXQ4PtZXCUogdihUBF6mmpVrQS1+v6
         cJ4s8PyG7jVQ4dG9C1/8MKlsBSCuGVg2ZtAM9K/CNXHIB1tQVD8zCu5Xc7waKhx5ZClQ
         wbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RQ/OfgFACJ0HisdDvqug2qr4vfTuZ/pxuVKJCyxS9zw=;
        b=fq33/SPseRrQQvzhKPCADK+YbYGSxB0dNjsel39JXfmIDHnq7vL4idZJtLcuBVOeeK
         RtaQgAsaKP+Dp+hEPFWb2k00fRhmodVwePUzEPpdYQ09rMuKITB6dbQYyJh7e7WX+BxR
         Wg3j+3oOvSsN8ezUfEf8f+2hIl7NsS3y1BUQFEwn2CCzDaKLKy3YOCxOHQxvRChiLs1D
         Ome38960R5NRhaRWVbbdtaNXVMzvieHdwqSnvNGgHawGosz4j8Fj+2rv42Zej8DYD7s8
         Gsej+yq/6sdNp91H1FLJYVoT0fvPZR8LnROVH7wFCcw6pFL4D32yR2a1g3UIGKg+RyLz
         ORUg==
X-Gm-Message-State: ANhLgQ1rMOUaGKI2A0SzbeVLigHLS5+kIYwWeOKXMa6P7HhOcFQjjfm3
        ttBJZBI+pLp5zwSPcccmgO4=
X-Google-Smtp-Source: ADFU+vvtBKJIt5WQ+US9N8veekkY03ax/HnHcOLwkT58OQwfs769GgQxQQjfgI8smdp+C9TedJJ27A==
X-Received: by 2002:a1c:ed0c:: with SMTP id l12mr540568wmh.151.1583440351248;
        Thu, 05 Mar 2020 12:32:31 -0800 (PST)
Received: from felia ([2001:16b8:2d7c:7000:ec58:d834:7ed:456a])
        by smtp.gmail.com with ESMTPSA id b12sm18439987wro.66.2020.03.05.12.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:32:30 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Thu, 5 Mar 2020 21:32:23 +0100 (CET)
X-X-Sender: lukas@felia
To:     Sumit Garg <sumit.garg@linaro.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MAINTAINERS: adjust to trusted keys subsystem
 creation
In-Reply-To: <CAFA6WYOfLONAM8qAhpiikrGkmDkLq0qcw_eGUTzG1AdgP0TB+w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2003052130520.5431@felia>
References: <20200304211254.5127-1-lukas.bulwahn@gmail.com> <CAFA6WYOfLONAM8qAhpiikrGkmDkLq0qcw_eGUTzG1AdgP0TB+w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On Thu, 5 Mar 2020, Sumit Garg wrote:

> On Thu, 5 Mar 2020 at 02:43, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
> > renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
> > to trusted-keys/trusted_tpm1.c in security/keys/.
> >
> > Since then, ./scripts/get_maintainer.pl --self-test complains:
> >
> >   warning: no file matches F: security/keys/trusted.c
> >   warning: no file matches F: include/keys/trusted.h
> >
> > Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
> > files in security/keys/ are identified as part of KEYS-TRUSTED.
> >
> 
> I guess you meant here security/keys/trusted-keys/ instead of security/keys/.
>

Yes, that is what I meant. I rushed the patch v2 last night.

Here is hopefully now a PATCH v3 you can ack:

https://lore.kernel.org/linux-integrity/20200305203013.6189-1-lukas.bulwahn@gmail.com/T/#u

Lukas
