Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732114AbeIVAcy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Sep 2018 20:32:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LIYEeL054103
        for <linux-integrity@vger.kernel.org>; Fri, 21 Sep 2018 14:42:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn3jt69yb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Sep 2018 14:42:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Sep 2018 19:42:41 +0100
Subject: Re: [PATCH] security/integrity: remove unnecessary 'init_keyring'
 variable
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>,
        linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Fri, 21 Sep 2018 14:42:38 -0400
In-Reply-To: <20180907202515.217716-1-ebiggers@kernel.org>
References: <20180907202515.217716-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1537555358.3830.345.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-09-07 at 13:25 -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The 'init_keyring' variable actually just gave the value of
> CONFIG_INTEGRITY_TRUSTED_KEYRING.  We should check the config option
> directly instead.  No change in behavior; this just simplifies the code.

We try to minimize as much as possible "ifdefs" in C code.  This
change is moving in the wrong direction.

Mimi

> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  security/integrity/digsig.c    | 11 ++---------
>  security/integrity/integrity.h |  9 +++++----
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 879396fa3be0..9e6adbd1ad42 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -37,12 +37,6 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
>  	"_module",
>  };
> 
> -#ifdef CONFIG_INTEGRITY_TRUSTED_KEYRING
> -static bool init_keyring __initdata = true;
> -#else
> -static bool init_keyring __initdata;
> -#endif
> -
>  #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
>  #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
>  #else
> @@ -79,15 +73,13 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
>  	return -EOPNOTSUPP;
>  }
> 
> +#ifdef CONFIG_INTEGRITY_TRUSTED_KEYRING
>  int __init integrity_init_keyring(const unsigned int id)
>  {
>  	const struct cred *cred = current_cred();
>  	struct key_restriction *restriction;
>  	int err = 0;
> 
> -	if (!init_keyring)
> -		return 0;
> -
>  	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
>  	if (!restriction)
>  		return -ENOMEM;
> @@ -109,6 +101,7 @@ int __init integrity_init_keyring(const unsigned int id)
>  	}
>  	return err;
>  }
> +#endif /* CONFIG_INTEGRITY_TRUSTED_KEYRING */
> 
>  int __init integrity_load_x509(const unsigned int id, const char *path)
>  {
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index e60473b13a8d..37ab908cfb6e 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -147,26 +147,27 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  extern struct dentry *integrity_dir;
> 
>  #ifdef CONFIG_INTEGRITY_SIGNATURE
> -
>  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
>  			    const char *digest, int digestlen);
> 
> -int __init integrity_init_keyring(const unsigned int id);
>  int __init integrity_load_x509(const unsigned int id, const char *path);
>  #else
> -
>  static inline int integrity_digsig_verify(const unsigned int id,
>  					  const char *sig, int siglen,
>  					  const char *digest, int digestlen)
>  {
>  	return -EOPNOTSUPP;
>  }
> +#endif /* CONFIG_INTEGRITY_SIGNATURE */
> 
> +#ifdef CONFIG_INTEGRITY_TRUSTED_KEYRING
> +int __init integrity_init_keyring(const unsigned int id);
> +#else
>  static inline int integrity_init_keyring(const unsigned int id)
>  {
>  	return 0;
>  }
> -#endif /* CONFIG_INTEGRITY_SIGNATURE */
> +#endif
> 
>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
>  int asymmetric_verify(struct key *keyring, const char *sig,
