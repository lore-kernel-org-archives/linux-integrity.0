Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751714AbeCMS0w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Mar 2018 14:26:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2DIF7Rk186320
        for <linux-integrity@vger.kernel.org>; Tue, 13 Mar 2018 14:26:52 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gpkfks5xn-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Mar 2018 14:26:51 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 13 Mar 2018 18:16:48 -0000
Subject: Re: [RFC PATCH linux-next] evm: evm_hmac can be static
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: kbuild test robot <fengguang.wu@intel.com>,
        =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: kbuild-all@01.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 14:16:42 -0400
In-Reply-To: <20180313174224.GA28779@intel17>
References: <201803140150.bfjQDiL5%fengguang.wu@intel.com>
         <20180313174224.GA28779@intel17>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520965002.3547.342.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-03-14 at 01:42 +0800, kbuild test robot wrote:
> Fixes: c49fc264be98 ("evm: Move evm_hmac and evm_hash from evm_main.c to evm_crypto.c")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Thanks!

> ---
>  evm_crypto.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index fdde9cb..a46fba3 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -37,8 +37,8 @@ static DEFINE_MUTEX(mutex);
> 
>  static unsigned long evm_set_key_flags;
> 
> -char * const evm_hmac = "hmac(sha1)";
> -char * const evm_hash = "sha1";
> +static char * const evm_hmac = "hmac(sha1)";
> +static char * const evm_hash = "sha1";
> 
>  /**
>   * evm_set_key() - set EVM HMAC key from the kernel
