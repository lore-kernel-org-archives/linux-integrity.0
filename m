Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751028AbeC0TMk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Mar 2018 15:12:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2RJA9f8105857
        for <linux-integrity@vger.kernel.org>; Tue, 27 Mar 2018 15:12:40 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gyt9u4y86-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Mar 2018 15:12:40 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 27 Mar 2018 20:12:35 +0100
Subject: Re: [RFC PATCH v2 1/4] security/ima: Rewrite tests into new API +
 fixes
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Tue, 27 Mar 2018 15:12:31 -0400
In-Reply-To: <20180314155731.5943-2-pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
         <20180314155731.5943-2-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1522177951.3541.180.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-03-14 at 16:57 +0100, Petr Vorel wrote:
> * simplify code, remove duplicity
> 
> * ima_measurements.sh:
>   - add support for "ima-ng" and "ima-sig" IMA measurement templates
>   - add support for most of hash algorithms is defined in
>     include/uapi/linux/hash_info.h (kernel headers); algorithms are
>     detected from last occurance of tested file in
>     /sys/kernel/security/ima/ascii_runtime_measurements
>   - check i_version mount option only for ext[2-4] filesystems (other
>     filesystems don't report it), TCONF when not mounted with it
>   - XFS has iversion support from >= V5, TCONF when older version

Needing the filesystem to be mounted with i_version is changing in
Linux 4.16.  With commit ac0bf025d2c0 ("ima: Use i_version only when
filesystem supports it"), files on filesystems, which do not support
i_version, will now *always* be re-measured (based on policy), making
i_version a performance improvement.

[...]

>  load_policy()
>  {
> +	local ret
> +
>  	exec 2>/dev/null 4>$IMA_POLICY
> -	if [ $? -ne 0 ]; then
> -		exit 1
> -	fi
> +	[ $? -eq 0 ] || exit 1
> 
>  	cat $1 |
> -	while read line ; do
> -	{
> -		if [ "${line#\#}" = "${line}" ] ; then
> -			echo $line >&4 2> /dev/null
> +	while read line; do
> +		if [ "${line#\#}" = "${line}" ]; then
> +			echo "$line" >&4 2> /dev/null
>  			if [ $? -ne 0 ]; then
>  				exec 4>&-
>  				return 1
>  			fi
>  		fi
> -	}

Originally writing the policy was done one rule at a time, but hasn't
been required for a long time.  dracut and systemd 'cat' the policy
directly to the pseudo file.

Mimi
