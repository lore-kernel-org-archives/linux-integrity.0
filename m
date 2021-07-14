Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35450C1B08C
	for <linux-integrity@archiver.kernel.org>; Wed, 14 Jul 2021 20:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A784613C0
	for <linux-integrity@archiver.kernel.org>; Wed, 14 Jul 2021 20:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhGNUWz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:22:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44030 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhGNUWy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 16:22:54 -0400
Received: from [10.106.164.77] (unknown [131.107.8.205])
        by linux.microsoft.com (Postfix) with ESMTPSA id C1E9B20B6C50;
        Wed, 14 Jul 2021 13:20:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1E9B20B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626294002;
        bh=CI2oVvUcJHhMJovBZUzCe28YfUdYQ0mCKIALYAE50Gg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Iiz42R2oHhkUkarSS4dE205fLbBzvBElAzKaHupirGeJw2r8hQLDTRIbOR8uvYJhL
         4saJXFw0p9jUGahlMVeSb0Q9TmkRRhClnxl81EnMXn8bpkyra3o9dSXvU8Ebj3eSLE
         LGC2I54TTMiGFXHBWXuYnsNTJIruwHQ73XHjHK/U=
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using
 IMA
To:     Thore Sommer <public@thson.de>
Cc:     agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        snitzer@redhat.com, zohar@linux.ibm.com
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
 <20210714113241.28580-1-public@thson.de>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <c833339e-c4bf-6e78-5719-cd902fa8426f@linux.microsoft.com>
Date:   Wed, 14 Jul 2021 13:20:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714113241.28580-1-public@thson.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Thore,
On 7/14/21 4:32 AM, Thore Sommer wrote:
> Thank you for bringing IMA support to device mapper. The addition of dm-verity
> to IMA is very useful for the project I'm working on where we boot
> our distribution from removable USB media.
Thank you for the positive ack. Appreciate it.
> One of our goals is to detect tampering of the root file system remotely.
> Therefore we enabled dm-verity support but implementing remote attestation for
> dm-verity from userland is not ideal which was our initial plan.
Yes, remote attestation from userland is not ideal.
> This patch set enables us to leverage to already implemented IMA attestation
> infrastructure by the remote attestation service that we are using (Keylime)
> without trying to roll a custom solution.
I am glad that DM-IMA functionality is useful for your scenario.
> We tested the initial RFC patch set and will continue testing with 
> this one to see if it fully works in our environment and with our use 
> case. 
Thank you for testing the RFC patch set.
Please let me know if you discover any bugs in this one, or have any 
other feedback.

Thanks again.

Regards,
Tushar
> Thore Sommer 

