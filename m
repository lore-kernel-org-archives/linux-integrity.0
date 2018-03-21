Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754032AbeCUXS5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Mar 2018 19:18:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LNEci9097931
        for <linux-integrity@vger.kernel.org>; Wed, 21 Mar 2018 19:18:57 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guybwk8ce-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 21 Mar 2018 19:18:56 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 23:18:54 -0000
Subject: Re: [PATCH v6 07/12] integrity: Select CONFIG_KEYS instead of
 depending on it
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date: Wed, 21 Mar 2018 19:18:47 -0400
In-Reply-To: <20180316203837.10174-8-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
         <20180316203837.10174-8-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521674327.3848.221.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-03-16 at 17:38 -0300, Thiago Jung Bauermann wrote:
> This avoids a dependency cycle in CONFIG_IMA_APPRAISE_MODSIG (introduced by
> a later patch in this series): it will select CONFIG_MODULE_SIG_FORMAT
> which in turn selects CONFIG_KEYS. Kconfig then complains that
> CONFIG_INTEGRITY_SIGNATURE depends on CONFIG_KEYS.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
>  security/integrity/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index da9565891738..0d642e0317c7 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -17,8 +17,8 @@ if INTEGRITY
> 
>  config INTEGRITY_SIGNATURE
>  	bool "Digital signature verification using multiple keyrings"
> -	depends on KEYS
>  	default n
> +	select KEYS
>  	select SIGNATURE
>  	help
>  	  This option enables digital signature verification support
> 
