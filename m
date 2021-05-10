Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F79C433ED
	for <linux-integrity@archiver.kernel.org>; Mon, 10 May 2021 14:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E20613DE
	for <linux-integrity@archiver.kernel.org>; Mon, 10 May 2021 14:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhEJOuB (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 May 2021 10:50:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44844 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhEJOs1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 10:48:27 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5316620B7178;
        Mon, 10 May 2021 07:47:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5316620B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1620658032;
        bh=+MR2sJfy4yb7RLdpuJHh0zxQZPNiqB72G1vqsOMUJtk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jeKp3e6t2M3S7ygHNO9IVKXlUm65R0qawMba3S3p6wmG+PGstklwboisIbj+eaOvs
         dtzEjOxOoAADhonSaII7coRseJJWt+O83bVkbSgWisjGhHHg07vaOw+JUTYLuu2nov
         Kz+oZXKUDzN05GJ7Wro3mAP2VWkpXV6bVs+ifKFg=
Subject: Re: [PATCH v4 1/3] ima_keys.sh: Check policy only once
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
References: <20210507191414.14795-1-pvorel@suse.cz>
 <20210507191414.14795-2-pvorel@suse.cz>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f22e507d-1983-b7a0-b5e0-15e1519ca038@linux.microsoft.com>
Date:   Mon, 10 May 2021 07:47:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210507191414.14795-2-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/7/21 12:14 PM, Petr Vorel wrote:
> Not needed to check the same policy twice.
> Rename to contain 'require' as we use tst_brk.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> new in v4
> 
>   .../security/integrity/ima/tests/ima_keys.sh       | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index 9951ab999..3476b8007 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -1,7 +1,7 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   # Copyright (c) 2020 Microsoft Corporation
> -# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
>   # Author: Lachlan Sneff <t-josne@linux.microsoft.com>
>   #
>   # Verify that keys are measured correctly based on policy.
> @@ -20,6 +20,7 @@ REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
>   setup()
>   {
>   	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
> +	require_valid_policy_template
>   }
>   
>   cleanup()
> @@ -27,15 +28,14 @@ cleanup()
>   	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
>   }
>   
> -check_policy_template()
> +
> +require_valid_policy_template()
>   {
>   	while read line; do
>   	if echo $line | grep -q 'template=' && ! echo $line | grep -q 'template=ima-buf'; then
> -		tst_res TCONF "only template=ima-buf can be specified for KEY_CHECK"
> -		return 1
> +		tst_brk TCONF "only template=ima-buf can be specified for KEY_CHECK"
>   	fi
>   	done < $TST_TMPDIR/policy.txt
> -	return 0
>   }
>   
>   check_keys_policy()
> @@ -59,8 +59,6 @@ test1()
>   
>   	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
>   
> -	check_policy_template || return
> -
>   	check_keys_policy "$pattern" > $tmp_file || return
>   	keycheck_lines=$(cat $tmp_file)
>   	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
> @@ -115,8 +113,6 @@ test2()
>   
>   	tst_res TINFO "verify measurement of certificate imported into a keyring"
>   
> -	check_policy_template || return
> -
>   	check_keys_policy "$pattern" >/dev/null || return
>   
>   	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
> 

