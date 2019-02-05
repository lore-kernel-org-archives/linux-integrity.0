Return-Path: <SRS0=fuDz=QM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395A7C3E8A4
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 16:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095142175B
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 16:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhL5MUT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfBEQBa (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:01:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34891 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfBEQBa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Feb 2019 11:01:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id l142so3076130lfe.2
        for <linux-integrity@vger.kernel.org>; Tue, 05 Feb 2019 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hO6+63tQm3aHSgnBHEGAUVT+FpxAShSxA8UJEbukKCw=;
        b=mhL5MUT6wwBH0Ip7sWIE/VgCwNKpRQGC2z+DjfH6jqPpyub+AqD+daB9BXOZgNnuO1
         QoHTVC8eDiE3+5KhdmRsLaE6bggD31AFtxyDKbNdg5h6GoaA2430KX84FsapqccqAzj7
         qbNcyqzbdWIMNlRsg0WN9OkK4rO7LNAiFgcijRDjckOMQoZ3Qh+PafXUPa9ii79v1ahi
         GAH03hDQYi9sAUEjWCvnZTwl6sMO0Y/pRaa57RNsBR7zC6KvFhW9HNPhCGYbTg4Rv7wK
         dpa3M7NMetreJYGl83vOMjfJZDbyEyituNY0cXsyflq16diOa05pljpPqUg0HbkQKRWk
         qOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hO6+63tQm3aHSgnBHEGAUVT+FpxAShSxA8UJEbukKCw=;
        b=Zix3E2bK5Zg1zO8awAXCz1htKMsxWiI7nor/mpnnA7E0IWo7EBkD7oKOiskItUXFEK
         h2JpGPJPu4moxauXPdogGN1bbk5m/nosD+sykvDk3zqKytzsRl3Ydxs9NiuezX+yXUHO
         /3GEnAofBxqHj7VFAEs6sKTb+v/r6aB0MLdKNJsLZPWeSlOC1RCKi5s2bFuvOKio2CNW
         s4bv4DS9yUqiCMQHdeQLJws74t8Upo8g72gLi42tiOMoM9y5547n7/632zPx1HMyrSee
         jOTx0/V/33gwbRC0g7bSB7J7MnNWbZ1Rw73gqiSyII47ws1rMXbTNxZGYPDFae6gCTZE
         5I+w==
X-Gm-Message-State: AHQUAuaSmaFLtI1gULjIYePMkE4SadencoTtbixzX8gwp6LuzUddvPjy
        RyLfncqJ/kXW6cd4W1JDXfurXt9MsnKrMYOeo1U=
X-Google-Smtp-Source: AHgI3IYzYVBZsGywq4JRrzNnHZmP5SMBd1vKwRkYkYiwOvOP8ZPF05xUjJs9Nr9+xZ04wKySmXjn2eWsls3hHkmQ5cg=
X-Received: by 2002:ac2:53b1:: with SMTP id j17mr3405354lfh.167.1549382487869;
 Tue, 05 Feb 2019 08:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20190128171154.24073-1-vt@altlinux.org> <20190130031208.2e7fxzvekenmwzil@altlinux.org>
 <CACE9dm9zN4GF35oC0P0sd3CcmhLr2ZJPxmh9fxNA-ahbYRg=wQ@mail.gmail.com>
In-Reply-To: <CACE9dm9zN4GF35oC0P0sd3CcmhLr2ZJPxmh9fxNA-ahbYRg=wQ@mail.gmail.com>
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Tue, 5 Feb 2019 18:05:09 +0200
Message-ID: <CACE9dm9Suhu_mP4=wJidsMiXzq9-UYdmiR9kpjF5LrxzLPN-LQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ima-evm-utils: convert sign v2 from RSA to EVP_PKEY API
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 5, 2019 at 5:38 PM Dmitry Kasatkin
<dmitry.kasatkin@gmail.com> wrote:
>
> On Wed, Jan 30, 2019 at 5:12 AM Vitaly Chikunov <vt@altlinux.org> wrote:
> >
> > On Mon, Jan 28, 2019 at 08:11:53PM +0300, Vitaly Chikunov wrote:
> > > Convert sign_v2 and related to using EVP_PKEY API instead of RSA API.
> > > This enables more signatures to work out of the box.
> > >
> > > Only in single instance GOST NIDs are checked to produce correct keyid.
> > > Other than that code is quite generic.
> >
> > There is was to generalize it a bit more.
> >
> > > Remove RSA_ASN1_templates[] as it does not needed anymore. OpenSSL sign
> > > is doing proper PKCS1 padding automatically (tested to be compatible
> > > with previous version, except for MD4). This also fixes bug with MD4
> > > which produced wrong signature because of absence of the appropriate
> > > RSA_ASN1_template.
> > >
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > >  src/evmctl.c    |  25 +++---
> > >  src/imaevm.h    |   4 +-
> > >  src/libimaevm.c | 271 +++++++++++++++++++++++++++-----------------------------
> > >  3 files changed, 146 insertions(+), 154 deletions(-)
> > >
> > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > index d9ffa13..bd99c60 100644
> > > --- a/src/libimaevm.c
> > > +++ b/src/libimaevm.c
> > > @@ -776,16 +724,32 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
> > >               log_info("keyid-v1: %s\n", str);
> > >  }
> > >
> > > -void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
> > > +void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *key)
> > >  {
> > > +     X509_PUBKEY *pk = NULL;
> > >       uint8_t sha1[SHA_DIGEST_LENGTH];
> > > -     unsigned char *pkey = NULL;
> > > +     const unsigned char *pkey = NULL;
> > > +     unsigned char *pp = NULL;
> > >       int len;
> > >
> > > -     len = i2d_RSAPublicKey(key, &pkey);
> > > -
> > > -     SHA1(pkey, len, sha1);
> > > +     switch (EVP_PKEY_id(key)) {
> > > +     case NID_id_GostR3410_2012_256:
> > > +     case NID_id_GostR3410_2012_512:
> > > +             X509_PUBKEY_set(&pk, key);
> > > +             X509_PUBKEY_get0_param(NULL, &pkey, &len, NULL, pk);
> > > +             break;
> > > +     default:
> > > +             len = i2d_PublicKey(key, &pp);
> >
> > Because two calls to X509_PUBKEY_set and X509_PUBKEY_get0_param can
> > handle more keys (including RSA), call to i2d_PublicKey could be
> > avoided, so switch with Gost NIDs could be removed too. Tested.
> >
> > > +             pkey = pp;
> > > +     }
> > >
> > > +     if (len <= 0) {
> > > +             ERR_print_errors_fp(stderr);
> > > +             /* Produce invalid key in case of error. */
> > > +             len = SHA_DIGEST_LENGTH;
> > > +             memset(sha1, 0, len);
> > > +     } else
> > > +             SHA1(pkey, len, sha1);
> > >       /* sha1[12 - 19] is exactly keyid from gpg file */
> > >       memcpy(keyid, sha1 + 16, 4);
> > >       log_debug("keyid: ");
>
>
> I have tested EVM and IMA signature verification with new patch and it
> seems to be OK.
>
> But when I try to sign with new patch, then signing fails...
>
> $ sudo ./src/evmctl -k keys/privkey_ima.pem ima_sign car
> 139794956297792:error:0608C09B:digital envelope
> routines:EVP_PKEY_sign:buffer too small:../crypto/evp/pmeth_fn.c:65:
> evmctl: evmctl.c:601: sign_ima: Assertion `len < sizeof(sig)' failed.
> Aborted
>
> sign_hash() returns -1
>
> any ideas why?
>
> Dmitry
>

I actually found out...

int EVP_PKEY_sign(EVP_PKEY_CTX *ctx,
                   unsigned char *sig, size_t *siglen,
                   const unsigned char *tbs, size_t tbslen);

siglen must contain maxim size of the buffer.
In the patch, the value is uninitialized...

So please fix it.

Thanks,
Dmitry
