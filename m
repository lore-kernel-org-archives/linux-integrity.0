Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8916BC282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 22:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324732084C
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 22:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feC5JQ7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbfA3W5t (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:57:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46066 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfA3W5r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 17:57:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so779664qka.12
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jan 2019 14:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gaj/PlwU64C0uTMIloPc24RP+u024A3Rkglx9j/Jceg=;
        b=feC5JQ7vz4YIgbYzpKeyXIepWsjRCvWxyTSJcfc0+eZ6yDYO+zOBUWeGwqhJE9M7ul
         sM1Pv237P31fWqynncXCydPu9GzUQpES4cZl7Zyj36AD++hwrgOMULCM3cmIBFMUR8Jj
         cwxTkehisG8L6nzg1A0ZRW7dqlQborXxvQVnwUTPIQicGxCnbt7rbqy6W+HOMM6u9bO6
         LDBHjEE7G9Lq6v6WfVaJ986NvZV+YBymwZ8CZ3jNAOf4dNqQ0825hEmlPiR62XztbxJW
         YlBfxMdDHiiNHzFKpNruI4Imyn1B3Jd2m5GUO4Tk+v4spZ9KZRg2h8661Y/CZD8xY9DK
         qAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gaj/PlwU64C0uTMIloPc24RP+u024A3Rkglx9j/Jceg=;
        b=LWNOubJUQA+C/PO44JazsBCiyB7xi74hqFlk/OHFnXQFedyevJVM3zonE3jrj1I4hl
         q6rF84kPdgAzq5VdQ5WGK9gjpIoqpdSKqMP6STRmd1M2tJzBcvJrKLmRW+C+g7BdzQBh
         3kOqZHoexGgSeDJUuL1uBau/2roBtxAdA77nm2w6bohxagZgPvMbfhtBC6qX7s+2xUwn
         ++ARc0Mg0nVOWlfN39UGOzhZFpsJeuQ4PxwgtjqcVDat3HYpypoZDYh7I3O4EqpKqwrq
         vrii6+ORp6sxzabYHf8TFDVYNSmnGqW/LecEOAnRlcLqf06dZlbNGyfqtJh3uist7lgz
         mgAg==
X-Gm-Message-State: AJcUukdArTz4SkRlyPe8MFtRrQYx2TvCfuvIBlihewMAY8ohJObinkdn
        eyEiDdYrJqp1ALIa7/wZzuN1iew0cLuMBqXADjI=
X-Google-Smtp-Source: ALg8bN7Q+WMkAa7zeV7AEgsuUEfufkaGW7XgTe3yqC3uyECbHViYHCJHJoSCkReNd/ciq01oDJlqMeIxpPPREM6P1nU=
X-Received: by 2002:a37:4bc7:: with SMTP id y190mr29063701qka.134.1548887694303;
 Wed, 30 Jan 2019 14:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20190128171154.24073-1-vt@altlinux.org> <20190130031208.2e7fxzvekenmwzil@altlinux.org>
In-Reply-To: <20190130031208.2e7fxzvekenmwzil@altlinux.org>
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Thu, 31 Jan 2019 00:34:43 +0200
Message-ID: <CACE9dm8BnRv5Hg0-BK_h+jYPxuZKYjeLxXjwFji32jnmy7-NMA@mail.gmail.com>
Subject: Re: [RFC PATCH] ima-evm-utils: convert sign v2 from RSA to EVP_PKEY API
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I had problems with home computer I did not want to fix :)

What is original message?

Dmiry

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



-- 
Thanks,
Dmitry
