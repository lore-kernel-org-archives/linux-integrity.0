Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932087AbeCIRJ1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Mar 2018 12:09:27 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w29H7klJ040569
        for <linux-integrity@vger.kernel.org>; Fri, 9 Mar 2018 12:09:27 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gku4f969g-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Mar 2018 12:09:24 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 9 Mar 2018 17:09:22 -0000
Subject: Re: [PATCH v2 3/3] ima: support platform keyring for kernel
 appraisal
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>, dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Date: Fri, 09 Mar 2018 12:09:18 -0500
In-Reply-To: <20180309153803.25859-3-nayna@linux.vnet.ibm.com>
References: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
         <20180309153803.25859-3-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520615358.3911.1.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-03-09 at 21:08 +0530, Nayna Jain wrote:
> Distros may sign the kernel images and, possibly, the initramfs with
> platform trusted keys. On secure boot enabled systems or embedded devices,
> these signatures are to be validated using keys on the platform keyring.
> 
> This patch enables IMA-appraisal to access the platform keyring, based on a
> new Kconfig option "IMA_USE_PLATFORM_KEYRING".
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>

Thanks, Nayna!

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>


> ---
> Changelog:
> 
> v2:
> * Rename integrity_load_keyring() to integrity_find_keyring()
> * Fix the patch description per line length as suggested by Mimi
> 
>  security/integrity/digsig.c           | 15 +++++++++++++++
>  security/integrity/ima/Kconfig        | 10 ++++++++++
>  security/integrity/ima/ima_appraise.c | 22 +++++++++++++++++-----
>  security/integrity/ima/ima_init.c     |  4 ++++
>  security/integrity/integrity.h        | 17 ++++++++++++++++-
>  5 files changed, 62 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 6f9e4ce568cd..cfeb977bced9 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -34,6 +34,8 @@ static const char *keyring_name[INTEGRITY_KEYRING_MAX] = {
>  	".ima",
>  #endif
>  	"_module",
> +	".platform_keys",
> +
>  };
> 
>  #ifdef CONFIG_INTEGRITY_TRUSTED_KEYRING
> @@ -78,6 +80,19 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
>  	return -EOPNOTSUPP;
>  }
> 
> +#ifdef CONFIG_IMA_USE_PLATFORM_KEYRING
> +int __init integrity_find_keyring(const unsigned int id)
> +{
> +
> +	keyring[id] = find_keyring_by_name(keyring_name[id], 0);
> +	if (IS_ERR(keyring[id]))
> +		if (PTR_ERR(keyring[id]) != -ENOKEY)
> +			return PTR_ERR(keyring[id]);
> +	return 0;
> +
> +}
> +#endif
> +
>  int __init integrity_init_keyring(const unsigned int id)
>  {
>  	const struct cred *cred = current_cred();
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 35ef69312811..2e89d4f8a364 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -227,3 +227,13 @@ config IMA_APPRAISE_SIGNED_INIT
>  	default n
>  	help
>  	   This option requires user-space init to be signed.
> +
> +config IMA_USE_PLATFORM_KEYRING
> +       bool "IMA uses keys from Platform Keyring for verification"
> +       depends on PLATFORM_KEYRING
> +       depends on IMA_APPRAISE
> +       depends on INTEGRITY_ASYMMETRIC_KEYS
> +       default n
> +       help
> +	  This option enables IMA appraisal to look for the platform
> +	  trusted keys in .platform_keys keyring.
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index f2803a40ff82..5fec29f40595 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -276,13 +276,25 @@ int ima_appraise_measurement(enum ima_hooks func,
>  					     (const char *)xattr_value, rc,
>  					     iint->ima_hash->digest,
>  					     iint->ima_hash->length);
> -		if (rc == -EOPNOTSUPP) {
> -			status = INTEGRITY_UNKNOWN;
> -		} else if (rc) {
> +		if (rc) {
> +			if (rc == -EOPNOTSUPP) {
> +				status = INTEGRITY_UNKNOWN;
> +				break;
> +			}
> +			if (func == KEXEC_KERNEL_CHECK) {
> +				rc = integrity_digsig_verify(
> +						INTEGRITY_KEYRING_PLATFORM,
> +						(const char *)xattr_value,
> +						xattr_len,
> +						iint->ima_hash->digest,
> +						iint->ima_hash->length);
> +				if (!rc) {
> +					status = INTEGRITY_PASS;
> +					break;
> +				}
> +			}
>  			cause = "invalid-signature";
>  			status = INTEGRITY_FAIL;
> -		} else {
> -			status = INTEGRITY_PASS;
>  		}
>  		break;
>  	default:
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 29b72cd2502e..5778647c6bc4 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -122,6 +122,10 @@ int __init ima_init(void)
>  	if (rc)
>  		return rc;
> 
> +	rc = integrity_find_keyring(INTEGRITY_KEYRING_PLATFORM);
> +	if (rc)
> +		pr_info("Platform keyring is not found. (rc=%d)\n", rc);
> +
>  	rc = ima_init_crypto();
>  	if (rc)
>  		return rc;
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 50a8e3365df7..3d3b7171ead2 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -136,13 +136,23 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  #define INTEGRITY_KEYRING_EVM		0
>  #define INTEGRITY_KEYRING_IMA		1
>  #define INTEGRITY_KEYRING_MODULE	2
> -#define INTEGRITY_KEYRING_MAX		3
> +#define INTEGRITY_KEYRING_PLATFORM	3
> +#define INTEGRITY_KEYRING_MAX		4
> 
>  #ifdef CONFIG_INTEGRITY_SIGNATURE
> 
>  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
>  			    const char *digest, int digestlen);
> 
> +#ifdef CONFIG_IMA_USE_PLATFORM_KEYRING
> +int __init integrity_find_keyring(const unsigned int id);
> +#else
> +static inline int __init integrity_find_keyring(const unsigned int id)
> +{
> +	return 0;
> +}
> +#endif
> +
>  int __init integrity_init_keyring(const unsigned int id);
>  int __init integrity_load_x509(const unsigned int id, const char *path);
>  #else
> @@ -154,6 +164,11 @@ static inline int integrity_digsig_verify(const unsigned int id,
>  	return -EOPNOTSUPP;
>  }
> 
> +static inline int __init integrity_find_keyring(const unsigned int id)
> +{
> +	return 0;
> +}
> +
>  static inline int integrity_init_keyring(const unsigned int id)
>  {
>  	return 0;
