Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51006 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752346AbdJPLrF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Oct 2017 07:47:05 -0400
Date: Mon, 16 Oct 2017 14:47:02 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Boshi Wang <wangboshi@huawei.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys, trusted: fix missing support for TPM 2.0 in
 trusted_update()
Message-ID: <20171016114702.axfsnfxdrleofibu@linux.intel.com>
References: <683216c3-d61a-1b24-c38c-b3f4348ce876@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <683216c3-d61a-1b24-c38c-b3f4348ce876@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 16, 2017 at 10:53:13AM +0800, Boshi Wang wrote:
> Call tpm_seal_trusted() in trusted_update() for TPM 2.0 chips.
> 
> Signed-off-by: Boshi Wang <wangboshi@huawei.com>
> ---
>  security/keys/trusted.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index ddfaebf..563fe5f 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -1065,6 +1065,11 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
>      size_t datalen = prep->datalen;
>      char *datablob;
>      int ret = 0;
> +    int tpm2;
> +
> +    tpm2 = tpm_is_tpm2(TPM_ANY_NUM);
> +    if (tpm2 < 0)
> +        return tpm2;
> 
>      if (test_bit(KEY_FLAG_NEGATIVE, &key->flags))
>          return -ENOKEY;
> @@ -1110,7 +1115,10 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
>      dump_payload(p);
>      dump_payload(new_p);
> 
> -    ret = key_seal(new_p, new_o);
> +    if (tpm2)
> +        ret = tpm_seal_trusted(TPM_ANY_NUM, new_p, new_o);
> +    else
> +        ret = key_seal(new_p, new_o);
>      if (ret < 0) {
>          pr_info("trusted_key: key_seal failed (%d)\n", ret);
>          kzfree(new_p);
> -- 
> 2.10.1
> 
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

The sealing code for TPM 1.2 should be moved to driver/char/tpm (has
been in my backlog for couple of years now).

/Jarkko
