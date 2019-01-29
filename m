Return-Path: <SRS0=yJTw=QF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71140C169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D04721473
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfA2Tuf (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:50:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43043 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfA2Tue (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jan 2019 14:50:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so23640597qtj.10
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jan 2019 11:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sD9hVaTuLm2GppK3UYbAJCsL7ItFFDSTfKIl1UfHWnU=;
        b=setB4pq4VNb5y0enVw8zNWvHDst4rthfdgQr0plFAiKpdWpeEXx4gW7bF+nTn4ftd5
         jVAKawuoyZZiCnJ6w+eHTsi7nQ44YpWAgel5LYok+vhQHPnyDiE1mr66uL+CIPw+zjGe
         kbMAy0zsbxWYIPa6dDmxcn3x0tPL8DqNfelGadG+1THPAnRU/P5JGfZiDQDvFGunaYPi
         vENkn9OYAg2dYvofQPhX0GtEAft/pYoXdCZ1Xb0qowIqJRWKkdI2O3dGUCTBsc6jx7Pa
         Q9xY6astlnXQg717GO0F59BpG2+HlS7/PiMbMoHG2h3QLHIN7n0gl9kQjgYjnh9DxlkN
         Wkbw==
X-Gm-Message-State: AJcUukcgxhaUxktoK+crYf8jlVUllJpEaGuAWZIWv3uZT2Thu6T874p+
        TRLlWcDA0IzhX6lj+QjO/exlofAYlqc=
X-Google-Smtp-Source: ALg8bN5k8GVuGESzvo+WTzT0uGH0tlSUsJzpZepawBZv0iG5fOkxcOpR7zn/ST5TVeJjRSMK3jyZLA==
X-Received: by 2002:a0c:9144:: with SMTP id q62mr25571554qvq.87.1548791433726;
        Tue, 29 Jan 2019 11:50:33 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id m68sm72094610qte.49.2019.01.29.11.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 11:50:33 -0800 (PST)
Date:   Tue, 29 Jan 2019 12:50:31 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] tpm: don't return bool from update_timeouts
Message-ID: <20190129195031.7lxlj4ahbxl3d46a@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190129174145.1482-1-jsnitsel@redhat.com>
 <20190129174145.1482-2-jsnitsel@redhat.com>
 <20190129192205.GA14305@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190129192205.GA14305@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Jan 29 19, Jarkko Sakkinen wrote:
>On Tue, Jan 29, 2019 at 10:41:45AM -0700, Jerry Snitselaar wrote:
>> Set tpm_chip->timeouts_adjusted directly in the update_timeouts
>> code instead of returning bool. Return rc of tpm read instead,
>> which can be return an error in the case of the spi driver.
>>
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>Couple of remarks:
>
>1. Shouldn't it then be just void?

Yes I think if we don't really care about the tpm read failing
it can just be void, and print out a warning when the read fail
occurs.

>2. Why do we even need timeout_adjusted in struct tpm_chip [1]?

It gets used by timeouts_show in tpm-sysfs.c as well.

>
>[1] Only used locally in tpm1_get_timeouts().
>
>/Jarkko
