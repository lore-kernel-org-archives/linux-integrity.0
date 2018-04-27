Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753079AbeD0L1A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Apr 2018 07:27:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3RBOcDi096935
        for <linux-integrity@vger.kernel.org>; Fri, 27 Apr 2018 07:27:00 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hm1n2kpxn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 27 Apr 2018 07:26:59 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 27 Apr 2018 12:26:57 +0100
Subject: Re: [LTP] [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Fri, 27 Apr 2018 07:26:52 -0400
In-Reply-To: <20180427095140.y6nngyv4ldjvitc6@dell5510>
References: <20180419195503.7194-1-pvorel@suse.cz>
         <20180427095140.y6nngyv4ldjvitc6@dell5510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1524828412.3416.31.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-04-27 at 11:51 +0200, Petr Vorel wrote:
[...]
>  ima_cleanup()
> diff --git testcases/kernel/security/integrity/ima/tests/ima_tpm.sh testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index 0124c338f..0ffc3c022 100755
> --- testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -69,7 +69,7 @@ validate_pcr()
>  		grep 'HW PCR-10:' | awk '{print $3}')"
>  	if [ -z "$aggregate_pcr" ]; then
>  		tst_res TFAIL "failed to get PCR-10"
> -		return
> +		return 1
>  	fi
> 
>  	while read line; do
> 

        aggregate_pcr="$(evmctl -v ima_measurement
$BINARY_MEASUREMENTS 2>&1 | \
                grep 'HW PCR-10:' | awk '{print $3}')"

This works properly with the "ima-ng" template and even the "ima-sig"
template, without any signatures or keys.  With the "ima-sig" there
will be some informational/warning messages.  Even with the warnings,
we can still validate the measurement list PCR value.

The last two records will contain the calculated aggregate PCR value
and the real HW PCR value. 

example 1: evmctl without any keys
[...]
Failed to open keyfile: /etc/keys/x509_evm.der
PCRAgg 10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b
HW PCR-10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b

example 2: evmctl missing some keys
key 1: 6e6c1046 /etc/keys/ima/<additional key>
[...]
/usr/lib64/evolution/plugins/liborg-gnome-email-custom-header.so: RSA_public_decrypt() failed: -1
/usr/lib64/evolution/plugins/liborg-gnome-external-editor.so: RSA_public_decrypt() failed: -1
PCRAgg 10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b
HW PCR-10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b

example 3: evmctl with all keys ("-k" option) 
key 1: 6e6c1046 /etc/keys/ima/<distro key>
key 2: c4e2426e /etc/keys/ima/<additional key>
PCRAgg 10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b
HW PCR-10: 2d1f635489a5b82fafde1ed48cfe67eabf6cba7b

Mimi
