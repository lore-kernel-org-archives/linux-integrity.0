Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935331AbeD0ONX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Apr 2018 10:13:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3REBjtA049103
        for <linux-integrity@vger.kernel.org>; Fri, 27 Apr 2018 10:13:22 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hm3r9w2p8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 27 Apr 2018 10:13:21 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 27 Apr 2018 15:13:20 +0100
Subject: Re: [RFC PATCH v3 01/10] security/ima: Rewrite tests into new API +
 fixes
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Fri, 27 Apr 2018 10:13:15 -0400
In-Reply-To: <20180419195503.7194-2-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
         <20180419195503.7194-2-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1524838395.3416.65.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-04-19 at 21:54 +0200, Petr Vorel wrote:

> -# Function:     test02
> -# Description	- Verify modifying, then reading, a file causes a new
> -# 		  measurement to be added to the IMA measurement list.
> -test02()
> +ima_check()
>  {
> -	# Modify test.txt
> -	echo $(date) - file modified >> test.txt
> +	local digest="$DEFAULT_DIGEST_OLD_FORMAT"
> +	local hash expected_hash line
> +
> +	# need to read file to get updated $ASCII_MEASUREMENTS
> +	cat $TEST_FILE > /dev/null
> +
> +	line="$(grep $TEST_FILE $ASCII_MEASUREMENTS | tail -1)"
> +	[ -n "$line" ] || tst_res TFAIL "cannot find measurement for '$TEST_FILE'"
> 
> -	# Calculating the sha1sum of test.txt should add
> -	# the new measurement to the measurement list
> -	hash=$(sha1sum test.txt | sed 's/  -//')
> +	[ "$DIGEST_INDEX" ] && digest="$(echo "$line" | awk '{print $(NF-'$DIGEST_INDEX')}' | cut -d ':' -f 1)"
> +	hash="$(echo "$line" | awk '{print $(NF-1)}' | cut -d ':' -f 2)"

With the "ima-sig" template, with a measurement that does not contain
the signature, this works fine.  There's a problem with lines
containing the signature.

Sample ima-sig template measurements with/without the signature:
line="10 ee788468d1b416a394feb9f4e5650302d9cd5574 ima-sig sha256:866c2542efd5c7528591eb3bb2861a1994a655da47732ccf28f7f4b1ce42d564 /usr/lib64/libpam.so.0.84.1"

line="10 d3afb4df5fe42485b99677f4b68a04692977b4bc ima-sig sha256:7b85508c9181670fe169935310b8c95d7c2573f0318a70cecd12868569aab891 /etc/profile.d/less.sh 0302046e6c104601008bd533707b34a9e896d3d530a88e9af517fb7e8cf79e9e55064a577fcbcdb81236ede6fec0638d357e4c2ed9b261320f8789378d1e58af8e1c6f40ebdf080759be2c633b27bc8aed85af0620fa27700c68fdf31d33b2f9e36432a1e7d7eb8dbf20b9474d332deb9697767ee13e13c116544a843b54fce842d24ea485bb41f6f7b1e9fa3faed0c591f5243cee008b9499e48064141662d3c4d002b07448ae54dc8d8674437143d73c4e34f5b416300ba890dc391eae9e5b1e89190790d0ea77d1dc57e07dae9ca003294a36fda09c31f8afa347701bfcf5aed0fda9cf7a37f734ba80fc10f2d60409f0beba532f3e5cc15ae995128e466b20fdadef789e285519"

> 
> -	# Check if the new measurement exists
> -	cat /sys/kernel/security/ima/ascii_runtime_measurements > measurements
> -	$(grep $hash measurements > /dev/null)
> +	tst_res TINFO "computing hash for $digest digest"
> +	expected_hash="$(compute_hash $digest $TEST_FILE)" || \
> +		{ tst_res TCONF "cannot compute hash for '$digest' digest"; return; }
> 
> -	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "Modified file not measured"
> -		tst_resm TINFO "iversion not supported; or not mounted with iversion"
> +	if [ "$hash" = "$expected_hash" ]; then
> +		tst_res TPASS "correct hash found"
>  	else
> -		tst_resm TPASS "Modified file measured"
> +		tst_res TFAIL "hash not found"
>  	fi
>  }
> 
