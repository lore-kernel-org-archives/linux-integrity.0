Return-Path: <SRS0=6sc8=R7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A00C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Mar 2019 17:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEC32173C
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Mar 2019 17:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfC1R2C (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:28:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:39834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbfC1R2C (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Mar 2019 13:28:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67422AAC3;
        Thu, 28 Mar 2019 17:28:00 +0000 (UTC)
Subject: Re: [PATCH 3/3] ima: Add overlay test
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Fabian Vogt <FVogt@suse.com>, Weihua Du <WHDu@suse.com>,
        linux-integrity@vger.kernel.org
References: <20190327161638.7407-1-pvorel@suse.cz>
 <20190327161638.7407-4-pvorel@suse.cz>
From:   Ignaz Forster <iforster@suse.de>
Message-ID: <854e62ce-5e5c-7ea7-0291-0d3eaadf3fca@suse.de>
Date:   Thu, 28 Mar 2019 18:27:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327161638.7407-4-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

thanks a lot for the LTP integration!

Am 27.03.19 um 17:16 Uhr schrieb Petr Vorel:
> Based on reproducer made by Ignaz Forster <iforster@suse.de>
> used for his not upstreamed patchset [1] and previous report [2].

Just for clarification, as the test is only referring to IMA: With IMA 
everything should be working already, the problem during copy_up 
operations was fixed by Mimi and Goldwyn in 
https://patchwork.kernel.org/patch/10776231/.
As expected the test passes on my IMA-only setup.

My outstanding patchset is only necessary when combining IMA with EVM - 
in this case the test will still fail. I hope I'll be able to resume my 
work in the next few weeks.

The test itself is looking good and working as expected.

> NOTE: backup variables are needed because ima_setup.sh calling
> tst_mount as well when TMPDIR is on tmpfs device.
> 
> [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
> [2] https://www.spinics.net/lists/linux-integrity/msg03593.html
> 
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Ignaz Forster <iforster@suse.de>
> Cc: Fabian Vogt <FVogt@suse.com>
> Cc: Weihua Du <WHDu@suse.com>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Tested-by: Ignaz Forster <iforster@suse.de>

> ---
>   runtest/ima                                   |  1 +
>   .../integrity/ima/tests/ima_overlay.sh        | 65 +++++++++++++++++++
>   .../security/integrity/ima/tests/ima_setup.sh |  4 +-
>   3 files changed, 68 insertions(+), 2 deletions(-)
>   create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_overlay.sh
> 
> diff --git a/runtest/ima b/runtest/ima
> index bcae16bb7..f96711a7d 100644
> --- a/runtest/ima
> +++ b/runtest/ima
> @@ -3,3 +3,4 @@ ima_measurements ima_measurements.sh
>   ima_policy ima_policy.sh
>   ima_tpm ima_tpm.sh
>   ima_violations ima_violations.sh
> +ima_overlay ima_overlay.sh
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_overlay.sh b/testcases/kernel/security/integrity/ima/tests/ima_overlay.sh
> new file mode 100755
> index 000000000..eedcd3753
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_overlay.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
> +# Based on reproducer made by Ignaz Forster <iforster@suse.de>
> +
> +TST_SETUP="setup"
> +TST_CLEANUP="cleanup"
> +. ima_setup.sh
> +TST_TESTFUNC="do_test"
> +
> +setup()
> +{
> +	lower="$TST_MNTPOINT/lower"
> +	upper="$TST_MNTPOINT/upper"
> +	work="$TST_MNTPOINT/work"
> +	merged="$TST_MNTPOINT/merged"
> +	mkdir -p $lower $upper $work $merged
> +
> +	device_backup="$TST_DEVICE"
> +	TST_DEVICE="overlay"
> +
> +	fs_type_backup="$TST_FS_TYPE"
> +	TST_FS_TYPE="overlay"
> +
> +	mntpoint_backup="$TST_MNTPOINT"
> +	TST_MNTPOINT="$merged"
> +
> +	params_backup="$TST_MNT_PARAMS"
> +	TST_MNT_PARAMS="-o lowerdir=$lower,upperdir=$upper,workdir=$work"
> +
> +	grep -q ima_appraise_tcb /proc/cmdline || \
> +		tst_brk TCONF "Test requires ima_appraise_tcb kernel parameter"
> +}
> +
> +do_test()
> +{
> +	local file="foo.txt"
> +	local f
> +
> +	tst_mount
> +	mounted=1
> +
> +	ROD echo lower \> $lower/$file
> +	if ! echo overlay > $merged/$file 2>/dev/null; then
> +		tst_res TFAIL "Cannot write to merged layer"
> +		return
> +	fi

I can think of two additional tests here:
1. Appending to a file (>> instead of >)
2. Creating a new file in the overlay

These cases are using different code paths and may fail independently, 
so separate tests would be handy.

Ignaz

> +	for f in $(find $TST_MNTPOINT -type f); do
> +		EXPECT_PASS cat $f \> /dev/null 2\> /dev/null
> +	done
> +}
> +
> +cleanup()
> +{
> +	[ -n "$mounted" ] || return 0
> +
> +	tst_umount $TST_DEVICE
> +
> +	TST_DEVICE="$device_backup"
> +	TST_FS_TYPE="$fs_type_backup"
> +	TST_MNTPOINT="$mntpoint_backup"
> +	TST_MNT_PARAMS="$params_backup"
> +}
> +
> +tst_run
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index da49eb1b2..08aa5300a 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -64,14 +64,14 @@ print_ima_config()
>   	local config="/boot/config-$(uname -r)"
>   	local i
>   
> -	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
> -
>   	if [ -r "$config" ]; then
>   		tst_res TINFO "IMA kernel config:"
>   		for i in $(grep ^CONFIG_IMA $config); do
>   			tst_res TINFO "$i"
>   		done
>   	fi
> +
> +	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
>   }
>   
>   ima_setup()
> 
