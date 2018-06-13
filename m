Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934508AbeFMNl7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jun 2018 09:41:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DDUeIm104502
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jun 2018 09:41:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jk353kuaf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jun 2018 09:41:58 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 14:41:56 +0100
Subject: Re: [USER] [PATCH 1/2] Remove hardcoding of SHA1 in EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Wed, 13 Jun 2018 09:41:42 -0400
In-Reply-To: <20180417225601.6965-1-mjg59@google.com>
References: <20180417225601.6965-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1528897302.3880.1.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-04-17 at 15:56 -0700, Matthew Garrett wrote:

> @@ -1033,7 +1041,13 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>  		goto out;
>  	}
> 
> -	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), EVP_sha1(), NULL);
> +	md = EVP_get_digestbyname(params.hash_algo);

HMAC is still limited to sha1.

> +	if (!md) {
> +		log_err("EVP_get_digestbyname() failed\n");
> +		goto out;
> +	}
> +
> +	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), md, NULL);
>  	if (err) {
>  		log_err("HMAC_Init() failed\n");
>  		goto out;
