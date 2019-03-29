Return-Path: <SRS0=7fxW=SA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70AEC43381
	for <linux-integrity@archiver.kernel.org>; Fri, 29 Mar 2019 10:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA062082F
	for <linux-integrity@archiver.kernel.org>; Fri, 29 Mar 2019 10:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="k5zU/V7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfC2KAM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:00:12 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:41134 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfC2KAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Mar 2019 06:00:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 9EA2EEE21B9;
        Fri, 29 Mar 2019 13:00:10 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w_m3Awaj9sbX; Fri, 29 Mar 2019 13:00:09 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id C627BEE21B3;
        Fri, 29 Mar 2019 13:00:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru C627BEE21B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1553853609;
        bh=O0yXa9rukg9PNBhNPTTLhOcA4LrYW01c/NzhmrypqT4=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=k5zU/V7flDRZdV821HeT1+W1ASwF9YnX6n1JWyhWUbTJ8ZOt7KjhHd8x+b3JOuM9R
         +bNOUXk37Kxx2XEbXwAdB0b7S0SsO8JAxIURM7kCNu63Vx+RspORecMURTU9Nst5kd
         DOqtPOTIKy36sbfqNphy5kaa4rOr5RCCIBhqVyRMj0/JNHx6nGJZZWwfGrK27NLA0z
         kHp97xFYJsrH+4j4BBYY/Q4nlPE97J+VY+U32gAzQgc+dx8Gvlzku9y6IWeZy4UGRg
         9254uma75UuLXt5IMZ7GIwDBDVqwVv5nn7kwghkIoB9pMUUTYsi2Jm+Vc7vE+86h/S
         9kD8TBOPe/jqA==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QtEwGTZvT9K9; Fri, 29 Mar 2019 13:00:09 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id 9CA2AEE21B2;
        Fri, 29 Mar 2019 13:00:09 +0300 (MSK)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com>
 <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com>
 <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com>
 <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com>
 <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
 <1553793463.8711.26.camel@linux.ibm.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <92718382-8669-748f-10d8-02fa21225210@omprussia.ru>
Date:   Fri, 29 Mar 2019 13:00:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1553793463.8711.26.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

Interesting article. It is almost exactly of what I wanted to be implemented.

If this minor LSM would be stackable to allow combining with e.g. SELinux
then why not.

On 28.03.2019 20:17, Mimi Zohar wrote:
> I just came across the grsecurity article on mprotect.[1]
>  Has anyone looked at it? Would it make sense to make it a minor LSM?
> 
> [1]https://pax.grsecurity.net/docs/mprotect.txt
