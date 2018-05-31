Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:37527 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754067AbeEaTar (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 15:30:47 -0400
Received: by mail-it0-f68.google.com with SMTP id l6-v6so16097234iti.2
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 12:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
 <20180530202804.148245-1-mjg59@google.com> <15252CF8C1B4384C8CE16D7D55C66479011414E83B@BC-MAIL-M04.internal.baidu.com>
In-Reply-To: <15252CF8C1B4384C8CE16D7D55C66479011414E83B@BC-MAIL-M04.internal.baidu.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 31 May 2018 12:30:34 -0700
Message-ID: <CACdnJutzAbjwieaxH1N5Z-Vt9Q=Gwf5WamPURkO1epVZEUy_8g@mail.gmail.com>
Subject: Re: [PATCH] evm: Don't deadlock if a crypto algorithm is unavailable
To: wangjunwen@baidu.com
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Cool. Mimi, does this satisfy your concerns with the non-SHA1 patch?
If so I'll resend with a s-o-b
On Wed, May 30, 2018 at 8:14 PM Wang,Junwen <wangjunwen@baidu.com> wrote:
>
> this pretty good, now ima_appraise & evm working well on my machine
> thank you, Matthew :)
> ________________________________________
> ???: Matthew Garrett [mjg59@google.com]
> ????: 2018?5?31? 4:28
> ???: linux-integrity@vger.kernel.org
> ??: zohar@linux.vnet.ibm.com; Matthew Garrett; Wang,Junwen
> ??: [PATCH] evm: Don't deadlock if a crypto algorithm is unavailable
>
> Does this help?
>
> Trying to instantiate a non-existent crypto algorithm will cause the
> kernel to trigger a module load. If EVM appraisal is enabled, this will
> in turn trigger appraisal of the module, which will fail because the
> crypto algorithm isn't available. Add a CRYPTO_NOLOAD flag and skip
> module loading if it's set, and add that flag in the EVM case.
> ---
>  crypto/api.c                        | 2 +-
>  include/linux/crypto.h              | 5 +++++
>  security/integrity/evm/evm_crypto.c | 3 ++-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/crypto/api.c b/crypto/api.c
> index 0ee632bba064..7aca9f86c5f3 100644
> --- a/crypto/api.c
> +++ b/crypto/api.c
> @@ -229,7 +229,7 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
>         mask &= ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
>
>         alg = crypto_alg_lookup(name, type, mask);
> -       if (!alg) {
> +       if (!alg && !(mask & CRYPTO_NOLOAD)) {
>                 request_module("crypto-%s", name);
>
>                 if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 6eb06101089f..e8839d3a7559 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -112,6 +112,11 @@
>   */
>  #define CRYPTO_ALG_OPTIONAL_KEY                0x00004000
>
> +/*
> + * Don't trigger module loading
> + */
> +#define CRYPTO_NOLOAD                  0x00008000
> +
>  /*
>   * Transform masks and values (for crt_flags).
>   */
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index eb87d40c62a5..ff8687232a1a 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -97,7 +97,8 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
>                 mutex_lock(&mutex);
>                 if (*tfm)
>                         goto out;
> -               *tfm = crypto_alloc_shash(algo, 0, CRYPTO_ALG_ASYNC);
> +               *tfm = crypto_alloc_shash(algo, 0,
> +                                         CRYPTO_ALG_ASYNC | CRYPTO_NOLOAD);
>                 if (IS_ERR(*tfm)) {
>                         rc = PTR_ERR(*tfm);
>                         pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
> --
> 2.17.1.1185.g55be947832-goog
>
