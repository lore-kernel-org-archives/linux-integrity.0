Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46137 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbeCNQcn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 12:32:43 -0400
Date: Wed, 14 Mar 2018 17:32:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] security/ima: Rewrite tests into new API +
 fixes
Message-ID: <20180314163241.2d5ekhz4mfsqgxjn@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <20180314155731.5943-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314155731.5943-2-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

> -# Function:     test02
> -# Description	- Verify ima calculated aggregate PCR values matches
> -#		  actual PCR value.
> -test02()
> +test2()
>  {
> +	tst_res TINFO "verify PCR values"

> -	# Would be nice to know where the PCRs are located.  Is this safe?
> -	PCRS_PATH=$(find /$SYSFS/devices/ | grep pcrs)
> +	# Would be nice to know where the PCRs are located. Is this safe?
> +	local pcrs_path="$(find $SYSFS/devices/ | grep pcrs)"
>  	if [ $? -eq 0 ]; then
> -		validate_pcr $PCRS_PATH
> +		validate_pcr $pcrs_path
>  		if [ $? -eq 0 ]; then
> -			tst_resm TPASS "aggregate PCR value matches real PCR value."
> +			tst_res TPASS "aggregate PCR value matches real PCR value"
>  		else
> -			tst_resm TFAIL "aggregate PCR value does not match real PCR value."
> +			tst_res TFAIL "aggregate PCR value does not match real PCR value"
>  		fi
>  	else
> -		tst_resm TFAIL "TPM not enabled, no PCR value to validate"
> +		tst_res TFAIL "TPM not enabled, no PCR value to validate"
Wrong, This must be TCONF:
		tst_res TCONF "TPM not enabled, no PCR value to validate"

>  	fi
>  }


Kind regards,
Petr
