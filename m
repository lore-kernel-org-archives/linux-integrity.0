Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1AC433EF
	for <linux-integrity@archiver.kernel.org>; Thu,  9 Sep 2021 20:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB3C61179
	for <linux-integrity@archiver.kernel.org>; Thu,  9 Sep 2021 20:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbhIIUWi (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:22:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53056 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhIIUWh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 16:22:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42813223D3;
        Thu,  9 Sep 2021 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631218885;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fuYouy3hEzLqGWJfS9AOiV8MYNHcOhi/rAyzUcI9JbM=;
        b=3YZOh/qepCpnjm6uX+nM7KV2XQYUPpL8L+2R8mkaCOvRScZfCQuv19C5ScmQbWnTUhsgO1
        oPw2IlfR0WQ7mJTR9SOROjmbp3VPqeYe1PPntboNomz83nClsRoqWW+V8gRbv92DWBedyH
        ct3flpQ062oPAR9bx5lZi1JTvgcXqxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631218885;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fuYouy3hEzLqGWJfS9AOiV8MYNHcOhi/rAyzUcI9JbM=;
        b=+THbq2XpAILrnshImNeJD7K+Z2CYnamlfxoBs3OY2tHGWOeWRgl+t7wnQ3MMF8l0qw7aQN
        sycEf/WWGeq0x/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE4C913B29;
        Thu,  9 Sep 2021 20:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ji+xL8RsOmGBUAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 09 Sep 2021 20:21:24 +0000
Date:   Thu, 9 Sep 2021 22:21:22 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, alexhenrie24@gmail.com
Subject: Re: [PATCH ltp] IMA: Add tests for uid, gid, fowner, and fgroup
 options
Message-ID: <YTpswsqlDS5tI7NC@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210909165111.51038-1-alexh@vpitech.com>
 <20210909165111.51038-2-alexh@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909165111.51038-2-alexh@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex,

> Requires "ima: add gid support".
I haven't test the patch yet, but LTP supports (unlike kselftest) various kernel
versions. Thus there should be some check to prevent old kernels failing.
You could certainly wrap new things with if tst_kvcmp. If there is a chance new
functionality can be detected, we prefer it because various features are
sometimes backported to enterprise distros' kernels.

Also, adding new test ima_measurements02.sh with TST_MIN_KVER would also work,
although for IMA tests I usually kept everything in a single file.

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> @@ -8,6 +8,7 @@

>  TST_NEEDS_CMDS="awk cut sed"
You should add sudo:

TST_NEEDS_CMDS="awk cut sed sudo"
>  TST_SETUP="setup"
> +TST_CLEANUP="cleanup"
>  TST_CNT=3
>  TST_NEEDS_DEVICE=1

> @@ -20,6 +21,13 @@ setup()
>  	TEST_FILE="$PWD/test.txt"
>  	POLICY="$IMA_DIR/policy"
>  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
> +
> +	cat $IMA_POLICY > policy-original
This might not work if CONFIG_IMA_READ_POLICY is not set. There is
check_policy_readable() helper in ima_setup.sh. Is it really needed anyway?

> +}
> +
> +cleanup()
> +{
> +	cat policy-original > $IMA_POLICY
Again, this will not work if CONFIG_IMA_WRITE_POLICY not set.
And this is very likely not to be set.

...

Kind regards,
Petr
