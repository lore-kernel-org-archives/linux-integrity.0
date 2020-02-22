Return-Path: <SRS0=oVO0=4K=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE9C35641
	for <linux-integrity@archiver.kernel.org>; Sat, 22 Feb 2020 00:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B1A2071E
	for <linux-integrity@archiver.kernel.org>; Sat, 22 Feb 2020 00:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d/cg413N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgBVALY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:11:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40948 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgBVALY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 19:11:24 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5CF27201ECA4;
        Fri, 21 Feb 2020 16:11:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CF27201ECA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582330283;
        bh=Z8vXPUIrEwc0K3Pta5YCMzVom/gyQcUg0xR+YE3BH8E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d/cg413Nxcgg467tOHmxhX/EpMdFVS1P8AenvZtoC/dal1cmgX5dVbQb8o+7vCrEz
         oleVnroX02awTBr4UVm/mbiJt8NZQcLZ9HW0BUGczTlpJxQEomjxkXendXdTE+aNvf
         DhGOlhywaSjVbjWoZVEzpGSA1KxWAEG6EZJXMa5w=
Subject: Re: [RFC PATCH 0/8] ima-evm-utils: calculate per TPM bank template
 digest
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ed6849bf-0988-3807-1b8f-151871f702d1@linux.microsoft.com>
Date:   Fri, 21 Feb 2020 16:11:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> IMA currently extends the different TPM banks by padding/truncating the
> SHA1 template digest.  Although the IMA measurement list only includes
> the SHA1 template digest, the template digest could be re-calculated
> properly for each bank.  Roberto Sassu's proposed "ima: support stronger
> algorithms for attestation" kernel patch set makes this change.
> 
> In order to test the proposed kernel change, this patch set walks the
> IMA measurement list, re-calculating the per TPM bank template digest
> and extending the TPM bank PCR with the bank specific digest.  The last
> step, after walking the measurement list, is comparing the the resulting
> TPM per bank PCR values with the actual TPM per bank PCR values.

I have built the kernel with Roberto's patch set and also built evmctl 
with your patch set.

Could you please include an example for how evmctl can be used to test 
Roberto's change?

thanks,
  -lakshmi
