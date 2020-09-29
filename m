Return-Path: <SRS0=nt+s=DG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55908C47425
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Sep 2020 12:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054582075F
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Sep 2020 12:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgI2MSH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:18:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:46538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731218AbgI2MRi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 08:17:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27112ACC6;
        Tue, 29 Sep 2020 12:17:37 +0000 (UTC)
Date:   Tue, 29 Sep 2020 14:17:35 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ima_tpm.sh: Fix calculating boot aggregate
Message-ID: <20200929121735.GA11889@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200925185034.24155-1-pvorel@suse.cz>
 <20200925185034.24155-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925185034.24155-4-pvorel@suse.cz>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

>  test1()
>  {
>  	tst_res TINFO "verify boot aggregate"

> -	local zero="0000000000000000000000000000000000000000"
>  	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
> -	local ima_measurements="$ASCII_MEASUREMENTS"
> -	local boot_aggregate boot_hash line
> +	local cmd="evmctl ima_boot_aggregate"
> +	local boot_aggregate cmd zero

> -	# IMA boot aggregate
> -	read line < $ima_measurements
> -	boot_hash=$(echo $line | awk '{print $(NF-1)}' | cut -d':' -f2)
> +	if [ "$MISSING_EVMCTL" = 1 ]; then
> +		if [ -f "$tpm_bios" ]; then
I leaved this error during rebase:
if [ ! -f "$tpm_bios" ]; then

I'm still investigating corner case issue when
/sys/kernel/security/tpm0/binary_bios_measurements
is not presented (mostly when no TPM device, thus IMA "TPM-bypass" code being
used, but sometimes also for TPM 2.0 which does not export event log).

I'll send shortly v3.

Kind regards,
Petr

> +			tst_res TCONF "missing $tpm_bios, $ERRMSG_EVMCTL"
> +			return
> +		fi
> +		tst_check_cmds ima_boot_aggregate || return
> +		cmd="ima_boot_aggregate -f $tpm_bios"
> +	fi
> +	tst_res TINFO "using command: $cmd"
