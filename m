Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E327BC169C4
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 03:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BCC2175B
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 03:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfA3DMN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:12:13 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:59866 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfA3DMN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jan 2019 22:12:13 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A30BE72CC6D;
        Wed, 30 Jan 2019 06:12:09 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 6E12D4A4A16;
        Wed, 30 Jan 2019 06:12:09 +0300 (MSK)
Date:   Wed, 30 Jan 2019 06:12:08 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH] ima-evm-utils: convert sign v2 from RSA to EVP_PKEY
 API
Message-ID: <20190130031208.2e7fxzvekenmwzil@altlinux.org>
References: <20190128171154.24073-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190128171154.24073-1-vt@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 28, 2019 at 08:11:53PM +0300, Vitaly Chikunov wrote:
> Convert sign_v2 and related to using EVP_PKEY API instead of RSA API.
> This enables more signatures to work out of the box.
> 
> Only in single instance GOST NIDs are checked to produce correct keyid.
> Other than that code is quite generic.

There is was to generalize it a bit more.

> Remove RSA_ASN1_templates[] as it does not needed anymore. OpenSSL sign
> is doing proper PKCS1 padding automatically (tested to be compatible
> with previous version, except for MD4). This also fixes bug with MD4
> which produced wrong signature because of absence of the appropriate
> RSA_ASN1_template.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  src/evmctl.c    |  25 +++---
>  src/imaevm.h    |   4 +-
>  src/libimaevm.c | 271 +++++++++++++++++++++++++++-----------------------------
>  3 files changed, 146 insertions(+), 154 deletions(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index d9ffa13..bd99c60 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -776,16 +724,32 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
>  		log_info("keyid-v1: %s\n", str);
>  }
>  
> -void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
> +void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *key)
>  {
> +	X509_PUBKEY *pk = NULL;
>  	uint8_t sha1[SHA_DIGEST_LENGTH];
> -	unsigned char *pkey = NULL;
> +	const unsigned char *pkey = NULL;
> +	unsigned char *pp = NULL;
>  	int len;
>  
> -	len = i2d_RSAPublicKey(key, &pkey);
> -
> -	SHA1(pkey, len, sha1);
> +	switch (EVP_PKEY_id(key)) {
> +	case NID_id_GostR3410_2012_256:
> +	case NID_id_GostR3410_2012_512:
> +		X509_PUBKEY_set(&pk, key);
> +		X509_PUBKEY_get0_param(NULL, &pkey, &len, NULL, pk);
> +		break;
> +	default:
> +		len = i2d_PublicKey(key, &pp);

Because two calls to X509_PUBKEY_set and X509_PUBKEY_get0_param can
handle more keys (including RSA), call to i2d_PublicKey could be
avoided, so switch with Gost NIDs could be removed too. Tested.

> +		pkey = pp;
> +	}
>  
> +	if (len <= 0) {
> +		ERR_print_errors_fp(stderr);
> +		/* Produce invalid key in case of error. */
> +		len = SHA_DIGEST_LENGTH;
> +		memset(sha1, 0, len);
> +	} else
> +		SHA1(pkey, len, sha1);
>  	/* sha1[12 - 19] is exactly keyid from gpg file */
>  	memcpy(keyid, sha1 + 16, 4);
>  	log_debug("keyid: ");
