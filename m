Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A1C433DB
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Feb 2021 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F5764F91
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Feb 2021 17:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhBCRrX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:47:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53666 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhBCRrW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 12:47:22 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8B01220B7192;
        Wed,  3 Feb 2021 09:46:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B01220B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612374401;
        bh=3RICIW6ifzknABr+efjv9dnif1PvuEM7vXwzp3I9uVk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VnGV5Ki16nGyG3QUZJWQdHCAoC9+Yhc9TlgiDzQpGOKycF5QkederFZHOZYJJ8slr
         woSSRz8xuZhkVFjEzfi+5M9o3WEZIGtPWrDXd08IPVQVi4b+IUxQrpFIeNwXFDZT3x
         kQOB8ZbFSbPOREgVwvK77c8ZRNoycRwlegERH3RE=
Subject: Re: [PATCH 2/2] ima: Free IMA measurement buffer after kexec syscall
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, gregkh@linuxfoundation.org,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210121173003.18324-1-nramas@linux.microsoft.com>
 <20210121173003.18324-2-nramas@linux.microsoft.com>
 <87bldg1u3s.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <15fb8c53-2aa0-dc5e-123d-87fee78aacb5@linux.microsoft.com>
Date:   Wed, 3 Feb 2021 09:46:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87bldg1u3s.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/22/21 2:31 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> IMA allocates kernel virtual memory to carry forward the measurement
>> list, from the current kernel to the next kernel on kexec system call,
>> in ima_add_kexec_buffer() function.  This buffer is not freed before
>> completing the kexec system call resulting in memory leak.
>>
>> Add ima_buffer field in "struct kimage" to store the virtual address
>> of the buffer allocated for the IMA measurement list.
>> Free the memory allocated for the IMA measurement list in
>> kimage_file_post_load_cleanup() function.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
> 
> Good catch.
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 

Thanks Thiago.

  -lakshmi

