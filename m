Return-Path: <SRS0=fuDz=QM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D2C282CB
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692552083B
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 15:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNJoGTbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfBEPez (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:34:55 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44847 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfBEPey (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Feb 2019 10:34:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so2937932lfe.11
        for <linux-integrity@vger.kernel.org>; Tue, 05 Feb 2019 07:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxNphzw0seBtwayPZCUYo3QxegqmW+4uXkkwT8IH+cE=;
        b=fNJoGTbizzUWt8yKwKlA7UDhoS0riKHdzA0MzejwqTgOqbcQWyxKZ1XDDyTtvrnyCQ
         X9xJnItx0d21ZnrUujDimoD3XVwDmYlpARfKYh6AYKlj7pBvp337+anNCUadeC2Bi1Sh
         GrhiEWnGUIqJTDXGW84Z2RTFTEV4XpBFjiKlZCqGiLkL7dc3VnLXZKxQ+nHeT5FVMG6r
         zHBbw3rk1P74JxKrma3O4PBV7feTsNr3LUxZf6zweftP2QLmfK/asznjt1CKcDX9CPfz
         z3B3ZyzKK8ONfTgqQteA3PuxMqfP1UOwHGX/Yuk7en8tX5SuX2+uMKbxAiybqhVy0KGM
         IYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxNphzw0seBtwayPZCUYo3QxegqmW+4uXkkwT8IH+cE=;
        b=HLGXtNoKNrJvZXjxrW0xCVOmWxIR44/wWotrjq6aWgn94AC5rRyXrv7+vOA0RFFaAa
         1D4LLVm2PVKqzNF+eSzHdBhvXvzZEbWWuTxDXALOR4YOQlSgQLJ5k/uLP2Emd4trnmgW
         nsl4Lu8UkhG9BE4CRagNQCZE+IFQri1NcPCianibr8LlUtBrqV1g1/y3jwQNBK5w4APt
         BvBLibHpPokHqVt2DdvHl/ulBzhu3Ss/x0yzn2MvKF/mSt/MKKaHLA2/3U9oJPU+DDrc
         b1GpO3ko62Z1zq1dlTCCdEvxnweasX/NnB4KDKh4SsoOQp/ZH2JZINhcQ67pNp11D2od
         aw3A==
X-Gm-Message-State: AHQUAua9z5pbvpAxZBZIFBI0Yq6gO0Y+vi9PwlpykCl1FuUXqoACkiP+
        88G5QnZoTLDgzfAgCs5Nj1yesClPl/gyNz7FDB0=
X-Google-Smtp-Source: AHgI3IZfGRIPREhdsBgO9Ug1byjzp0mp5uATxWwebIH/vk0BgbI/EBsB4SyenYhlIJlmkZcaBk0gxMU1WzrlRWceSqs=
X-Received: by 2002:a19:9bc2:: with SMTP id d185mr3475412lfe.21.1549380892280;
 Tue, 05 Feb 2019 07:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20190128171154.24073-1-vt@altlinux.org> <20190130031208.2e7fxzvekenmwzil@altlinux.org>
In-Reply-To: <20190130031208.2e7fxzvekenmwzil@altlinux.org>
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Tue, 5 Feb 2019 17:38:34 +0200
Message-ID: <CACE9dm9zN4GF35oC0P0sd3CcmhLr2ZJPxmh9fxNA-ahbYRg=wQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ima-evm-utils: convert sign v2 from RSA to EVP_PKEY API
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 30, 2019 at 5:12 AM Vitaly Chikunov <vt@altlinux.org> wrote:
>
> On Mon, Jan 28, 2019 at 08:11:53PM +0300, Vitaly Chikunov wrote:
> > Convert sign_v2 and related to using EVP_PKEY API instead of RSA API.
> > This enables more signatures to work out of the box.
> >
> > Only in single instance GOST NIDs are checked to produce correct keyid.
> > Other than that code is quite generic.
>
> There is was to generalize it a bit more.
>
> > Remove RSA_ASN1_templates[] as it does not needed anymore. OpenSSL sign
> > is doing proper PKCS1 padding automatically (tested to be compatible
> > with previous version, except for MD4). This also fixes bug with MD4
> > which produced wrong signature because of absence of the appropriate
> > RSA_ASN1_template.
> >
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >  src/evmctl.c    |  25 +++---
> >  src/imaevm.h    |   4 +-
> >  src/libimaevm.c | 271 +++++++++++++++++++++++++++-----------------------------
> >  3 files changed, 146 insertions(+), 154 deletions(-)
> >
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index d9ffa13..bd99c60 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -776,16 +724,32 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
> >               log_info("keyid-v1: %s\n", str);
> >  }
> >
> > -void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
> > +void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *key)
> >  {
> > +     X509_PUBKEY *pk = NULL;
> >       uint8_t sha1[SHA_DIGEST_LENGTH];
> > -     unsigned char *pkey = NULL;
> > +     const unsigned char *pkey = NULL;
> > +     unsigned char *pp = NULL;
> >       int len;
> >
> > -     len = i2d_RSAPublicKey(key, &pkey);
> > -
> > -     SHA1(pkey, len, sha1);
> > +     switch (EVP_PKEY_id(key)) {
> > +     case NID_id_GostR3410_2012_256:
> > +     case NID_id_GostR3410_2012_512:
> > +             X509_PUBKEY_set(&pk, key);
> > +             X509_PUBKEY_get0_param(NULL, &pkey, &len, NULL, pk);
> > +             break;
> > +     default:
> > +             len = i2d_PublicKey(key, &pp);
>
> Because two calls to X509_PUBKEY_set and X509_PUBKEY_get0_param can
> handle more keys (including RSA), call to i2d_PublicKey could be
> avoided, so switch with Gost NIDs could be removed too. Tested.
>
> > +             pkey = pp;
> > +     }
> >
> > +     if (len <= 0) {
> > +             ERR_print_errors_fp(stderr);
> > +             /* Produce invalid key in case of error. */
> > +             len = SHA_DIGEST_LENGTH;
> > +             memset(sha1, 0, len);
> > +     } else
> > +             SHA1(pkey, len, sha1);
> >       /* sha1[12 - 19] is exactly keyid from gpg file */
> >       memcpy(keyid, sha1 + 16, 4);
> >       log_debug("keyid: ");


I have tested EVM and IMA signature verification with new patch and it
seems to be OK.

But when I try to sign with new patch, then signing fails...

$ sudo ./src/evmctl -k keys/privkey_ima.pem ima_sign car
139794956297792:error:0608C09B:digital envelope
routines:EVP_PKEY_sign:buffer too small:../crypto/evp/pmeth_fn.c:65:
evmctl: evmctl.c:601: sign_ima: Assertion `len < sizeof(sig)' failed.
Aborted

sign_hash() returns -1

any ideas why?

Dmitry

-- 
Thanks,
Dmitry
