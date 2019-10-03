Return-Path: <SRS0=FObC=X4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3DAC10F14
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Oct 2019 15:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7641A21848
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Oct 2019 15:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Eb9g6OOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfJCPlB (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:41:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43428 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfJCPlA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 11:41:00 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1323820BBF87;
        Thu,  3 Oct 2019 08:41:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1323820BBF87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570117260;
        bh=VXWU+xxOw4oOE5WPfbmuiZOKkgsS8/j6Ootr6dfT9jw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Eb9g6OOrekVAF2ugx2720Yih9o9gt24mEdkqM9V5W8Mq5dznI1Ingh5jzDQaLL8s6
         lle1nTLXwTfxLV+MYdIu7TBYPXT4ORJn5+ZV+ymzukYKXz2sB7IUFIrHXZ4QGbVVTn
         wPwZoa7WpYPZ+nxQGQROZUcKNlD1rmkQMBXC0XyU=
Subject: Re: ima_tpm_chip is queried and saved only at IMA init, but never
 later
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <d9c28fc6-bd5e-95ae-6386-84e87125c41d@linux.microsoft.com>
 <1569364624.5364.23.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <d5aef823-9428-65d4-c045-c23d3466033e@linux.microsoft.com>
Date:   Thu, 3 Oct 2019 08:40:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569364624.5364.23.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/24/19 3:37 PM, James Bottomley wrote:
> On Tue, 2019-09-24 at 15:31 -0700, Lakshmi Ramasubramanian wrote:
> 
> There has been some discussion that we could, for UEFI systems, use the
> UEFI runtime drivers for the TPM until the actual driver is inserted
> but no-one's looked into doing that.
> 
> James

Can IMA take a dependency on TPM and postpone IMA initialization until a 
TPM device shows up?

Has anyone looked into this?

Thanks,
  -lakshmi


