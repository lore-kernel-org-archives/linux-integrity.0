Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF72C282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 16:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FB62086C
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 16:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rVzzl6Bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfA3Qo2 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:44:28 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58870 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730688AbfA3Qo2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 11:44:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 73CAF8EE241;
        Wed, 30 Jan 2019 08:44:27 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ieqhMeQGw2uH; Wed, 30 Jan 2019 08:44:27 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DB08A8EE0E9;
        Wed, 30 Jan 2019 08:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1548866667;
        bh=ikmNjZckMw52TJ5G4hJQOcHW/hs1Pu9V5APGdF8VU6c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rVzzl6BjD6JX5KzCbyXfVO2kRw/QBM/BOAZ3XUDV9XkBK+j+ErOkGYEwlkpJZrl50
         +cD+87UCW3TLiCMh4gC/243oZmnI3a06+KMxXJM1R7RyYiwu+ZlqBLNExq3Dmbrl0v
         bDdZV2QChXz++WoI3j4JMMgBnbIWlEezQtpS2CMc=
Message-ID: <1548866665.3037.27.camel@HansenPartnership.com>
Subject: Re: [PATCH] ima-evm-utils: remove redundant call to
 OpenSSL_add_all_algorithms
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 30 Jan 2019 08:44:25 -0800
In-Reply-To: <20190130161208.vpbk3v74l7cf5a4t@altlinux.org>
References: <20190127023916.2425-1-vt@altlinux.org>
         <1548851697.20210.91.camel@linux.ibm.com>
         <20190130132521.edhtrv54labxlbyc@altlinux.org>
         <1548862549.3037.18.camel@HansenPartnership.com>
         <20190130161208.vpbk3v74l7cf5a4t@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-01-30 at 19:12 +0300, Vitaly Chikunov wrote:
> On Wed, Jan 30, 2019 at 07:35:49AM -0800, James Bottomley wrote:
> > On Wed, 2019-01-30 at 16:25 +0300, Vitaly Chikunov wrote:
> > > On Wed, Jan 30, 2019 at 07:34:57AM -0500, Mimi Zohar wrote:
> > > > On Sun, 2019-01-27 at 05:39 +0300, Vitaly Chikunov wrote:
> > > > > Because of call to OPENSSL_add_all_algorithms_conf() calling
> > > > > OpenSSL_add_all_algorithms() is not needed. There was not be
> > > > > any
> > > > > problems though because double initialization is permitted.
> > > > > ---
> > > > >  src/libimaevm.c | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > > 
> > > > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > > > index 7501303..b038d0c 100644
> > > > > --- a/src/libimaevm.c
> > > > > +++ b/src/libimaevm.c
> > > > > @@ -995,7 +995,6 @@ int sign_hash(const char *hashalgo, const
> > > > > unsigned char *hash, int size, const c
> > > > > 
> > > > >  static void libinit()
> > > > >  {
> > > > > -	OpenSSL_add_all_algorithms();
> > > > >  	OPENSSL_add_all_algorithms_conf();
> > > > >  	ERR_load_crypto_strings();
> > > > >  }
> > > > 
> > > > The only difference between the two calls seems to be reading
> > > > the
> > > > system openssl.cnf file.  In the original call that is
> > > > dependent on
> > > > OPENSSL_LOAD_CONF being defined.  Calling
> > > > OPENSSL_add_all_algorithms_conf(), forces reading the system
> > > > openssl.cnf.
> > > 
> > > Yes. OPENSSL_LOAD_CONF is per application define, which is by
> > > default
> > > undefined. And instead of defining it, we could just call
> > > OPENSSL_add_all_algorithms_conf(), which is required for GOST
> > > support.
> > > Otherwise enabling Streebog via OPENSSL_CONF will not work.
> > 
> > It will if you call
> 
> There is preferred "easy" method of [system wide] loading of gost-
> engine
> "by default" just by changing openssl.cnf like this:
> 
>   https://github.com/gost-engine/engine/blob/master/example.conf
> 
> After that change all openssl (and linked) tools understand GOST
> algorithms without needing options like `-engine gost`.

This means that you turn the gost engine on by default in the file

> This works unless tool is compiled without OPENSSL_LOAD_CONF and it
> calls OpenSSL_add_all_algorithms() instead of
> OPENSSL_add_all_algorithms_conf(). Which is frequently the default,
> (because there is too much methods of openssl initialization and
> people may not understand all intrications for all options.) In that
> case we try to persuade tool author to change the way openssl is
> initialized.

What I'm saying is that modifying config files is really difficult for
most users.  So, if you want ima-evm-utils to work out of the box with
the Streebog hash it needs to have no dependent requirement on config
files, which means you need to add the call to ENGINE_set_default()

This isn't about how you usually do it, it's about making these
additions usable for average users.

That doesn't stop you from adding further mods via the config files,
but it does mean that if a random user installs evmctl and types

evmctl -e gost -a streebog256 ...

it will just work instead of failing with an obscure error because the
default config file is wrong.  I actually think for usability you
should tie the hash and the engine together so a user can just type

evmctl -a streebog256 ...

And the tool will automatically try to load the gost engine and tell
you if it's missing.

James



