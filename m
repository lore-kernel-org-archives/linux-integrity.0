Return-Path: <SRS0=UEBU=VC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070F8C46499
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Jul 2019 21:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D043F20989
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Jul 2019 21:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3v1W8Kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfGEVXI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:23:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36920 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGEVXI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 17:23:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so10907382wme.2
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jul 2019 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rS6kOX5YyvVCvcrdk2FYfqpnPfqSkXdm+H0ez5O7NNs=;
        b=N3v1W8Knv+Y19uuxI1+k4lRIC/sN+YM+FRBpZov/V2y6s+Y3CNUtoclt3okG5/yhRH
         +9K7LI4QWQV/OaUvycftmZI6gpOjR1dSYLsr/5rF4YJ6K7UhnX05eXigV7n4EPaIn6Nb
         EBkFKhV4ZYuU2hNx3Evx9cJWPGivCyHzmBfHYlcWCsZFQU8LQsnCb1G7tK0PweZcwnUC
         OySlMjQsP4XsixZfBQ+gZ3MDR4z4O/xGw5JHptTkVcMDMEIp0Eta4PRmXq9uRu4s1BJi
         FUpvtWZAun1jchq5RfM16Po8PD5cvpRD6Q7B9Qjx/6PsGkiLyhAx0QacDLBuJ3uVBHoS
         E1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rS6kOX5YyvVCvcrdk2FYfqpnPfqSkXdm+H0ez5O7NNs=;
        b=NuIG7j9uqEm7sAe2yLRjJo5QwoRrl/M3tQcrdQhJQAmdKyinhA2lr4qQgSa5MUdjXm
         xVdo8ON36+r9JviTgmVdUaKLdB+UOBjdmwy/8GKRchd/4rn+lv192uL34Nn32i0HOif7
         HyZj5nBfOfsE3v2PyxYCicbE4XCaIXnVzg90pSa7amfmPR9Qt8zLGkLpo+L8NoVF9RVa
         +Bzt51CBxDEtMheX6QTQMv5NP+EUOS6JK0TGcUZk7MRXdSFau9yoDPLqG4bYpxHhaxaN
         Yk/yg1IFGpBnU8kQhP6iQDB4tCv1ooB4Qj/GnfDDA+BdBi4N8av9n9nqj3jnT/elXgOC
         iLMg==
X-Gm-Message-State: APjAAAVl0xzcbrMUYuZTkhxIODKcnOnt/4yrYChulVHY8EOb99hSBuZm
        eseJ10KjqhY0YpZ86mc8Bso=
X-Google-Smtp-Source: APXvYqwP4OZORY670FxPFdOGUNNUMBGfxlp3rKSxCvYWQ6vtCOtdAOzpw2GClxJh7/Z949tctQhk/g==
X-Received: by 2002:a05:600c:2199:: with SMTP id e25mr4489884wme.72.1562361786612;
        Fri, 05 Jul 2019 14:23:06 -0700 (PDT)
Received: from [192.168.8.100] (37-48-34-161.nat.epc.tmcz.cz. [37.48.34.161])
        by smtp.gmail.com with ESMTPSA id z2sm8048935wrt.41.2019.07.05.14.23.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 14:23:05 -0700 (PDT)
Subject: Re: [PATCH] tpm: Fix null pointer dereference on chip register error
 path
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>
References: <20190612084210.13562-1-gmazyland@gmail.com>
 <9df0a432-eb9c-914e-5ddc-2680a6fecebd@gmail.com>
 <a8fc7162019168ab3b9b662fb629855205a6b1ca.camel@linux.intel.com>
 <20190703230125.aynx4ianvqqjt5d7@linux.intel.com>
 <1821f2adb0910e76f039949e96ed78325025a4bd.camel@linux.intel.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <1324e0d6-74c4-f8a7-ea9f-0a603bf15e93@gmail.com>
Date:   Fri, 5 Jul 2019 23:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1821f2adb0910e76f039949e96ed78325025a4bd.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 05/07/2019 19:52, Jarkko Sakkinen wrote:
> 
> So how should we work this one out? Do you want to create v2 or do I
> create a new patch and put reported-by tag. Both work for me. I just
> need to know this.

Please fix you mail filters, the patch was sent more than day ago.

https://lore.kernel.org/linux-integrity/20190704072615.31143-1-gmazyland@gmail.com/T/#u

Milan
