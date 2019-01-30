Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29747C282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 17:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD522087F
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 17:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfA3RyZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:54:25 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:51152 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbfA3RyX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 12:54:23 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9116F72CC6D;
        Wed, 30 Jan 2019 20:54:20 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id EBFDB4A4A16;
        Wed, 30 Jan 2019 20:54:19 +0300 (MSK)
Date:   Wed, 30 Jan 2019 20:54:19 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: remove redundant call to
 OpenSSL_add_all_algorithms
Message-ID: <20190130175419.hiqbpptl7fej6m4j@altlinux.org>
References: <20190127023916.2425-1-vt@altlinux.org>
 <1548851697.20210.91.camel@linux.ibm.com>
 <20190130132521.edhtrv54labxlbyc@altlinux.org>
 <1548862549.3037.18.camel@HansenPartnership.com>
 <20190130161208.vpbk3v74l7cf5a4t@altlinux.org>
 <1548866665.3037.27.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1548866665.3037.27.camel@HansenPartnership.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 30, 2019 at 08:44:25AM -0800, James Bottomley wrote:
> On Wed, 2019-01-30 at 19:12 +0300, Vitaly Chikunov wrote:
> > On Wed, Jan 30, 2019 at 07:35:49AM -0800, James Bottomley wrote:
> > > On Wed, 2019-01-30 at 16:25 +0300, Vitaly Chikunov wrote:
> > > > On Wed, Jan 30, 2019 at 07:34:57AM -0500, Mimi Zohar wrote:
> > > > > On Sun, 2019-01-27 at 05:39 +0300, Vitaly Chikunov wrote:
> > > > > > Because of call to OPENSSL_add_all_algorithms_conf() calling
> > > > > > OpenSSL_add_all_algorithms() is not needed. There was not be
> > > > > > any
> > > > > > problems though because double initialization is permitted.
> > > > > > ---
> > > > > >  src/libimaevm.c | 1 -
> > > > > >  1 file changed, 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > > > > index 7501303..b038d0c 100644
> > > > > > --- a/src/libimaevm.c
> > > > > > +++ b/src/libimaevm.c
> > > > > > @@ -995,7 +995,6 @@ int sign_hash(const char *hashalgo, const
> > > > > > unsigned char *hash, int size, const c
> > > > > > 
> > > > > >  static void libinit()
> > > > > >  {
> > > > > > -	OpenSSL_add_all_algorithms();
> > > > > >  	OPENSSL_add_all_algorithms_conf();
> > > > > >  	ERR_load_crypto_strings();
> > > > > >  }
> > > > > 
> > > > > The only difference between the two calls seems to be reading
> > > > > the
> > > > > system openssl.cnf file.  In the original call that is
> > > > > dependent on
> > > > > OPENSSL_LOAD_CONF being defined.  Calling
> > > > > OPENSSL_add_all_algorithms_conf(), forces reading the system
> > > > > openssl.cnf.
> > > > 
> > > > Yes. OPENSSL_LOAD_CONF is per application define, which is by
> > > > default
> > > > undefined. And instead of defining it, we could just call
> > > > OPENSSL_add_all_algorithms_conf(), which is required for GOST
> > > > support.
> > > > Otherwise enabling Streebog via OPENSSL_CONF will not work.
> > > 
> > > It will if you call
> > 
> > There is preferred "easy" method of [system wide] loading of gost-
> > engine
> > "by default" just by changing openssl.cnf like this:
> > 
> >   https://github.com/gost-engine/engine/blob/master/example.conf
> > 
> > After that change all openssl (and linked) tools understand GOST
> > algorithms without needing options like `-engine gost`.
> 
> This means that you turn the gost engine on by default in the file

This is how most gost users are suggested to use it.

> > This works unless tool is compiled without OPENSSL_LOAD_CONF and it
> > calls OpenSSL_add_all_algorithms() instead of
> > OPENSSL_add_all_algorithms_conf(). Which is frequently the default,
> > (because there is too much methods of openssl initialization and
> > people may not understand all intrications for all options.) In that
> > case we try to persuade tool author to change the way openssl is
> > initialized.
> 
> What I'm saying is that modifying config files is really difficult for
> most users.  So, if you want ima-evm-utils to work out of the box with
> the Streebog hash it needs to have no dependent requirement on config
> files, which means you need to add the call to ENGINE_set_default()

I implemented two methods of loading engine for evmctl (via config and
via --engine option).  There is no problem with --engine option for
Streebog, AFAIK.  We are talking about config method, which would be
default for the most users.

(Your suggestion is still good for my next patch what implements PKEY
instead of RSA, for EC-RDSA signatures. Thanks! I will add it.)

> This isn't about how you usually do it, it's about making these
> additions usable for average users.

Config method of loading gost engine is not how I usually do it, but how
most gost users use it (and suggested to use it). This isn't some marginal
use case. They just modify `openssl.cnf` once (manually of via script)
and all relevant ssl tools "magically" start to understand gost
algorithms without any additional options. This would be very not user
friendly if for every network tool that supports ssl they should specify
`--someoption gost`.

`--engine` option is just supplementary for advanced or occasional
users. It continues to work (for Streebog) if OpenSSL_add_all_algorithms
call is removed, but breaks if OPENSSL_add_all_algorithms_conf is
removed, probably, need to call ENGINE_load_builtin_engines in that case.

All this make initialization more complicated instead of single call to
OPENSSL_add_all_algorithms_conf().

> That doesn't stop you from adding further mods via the config files,
> but it does mean that if a random user installs evmctl and types
> 
> evmctl -e gost -a streebog256 ...
> 
> it will just work instead of failing with an obscure error because the
> default config file is wrong.  I actually think for usability you
> should tie the hash and the engine together so a user can just type
> 
> evmctl -a streebog256 ...
> 
> And the tool will automatically try to load the gost engine and tell
> you if it's missing.

This is interesting idea. (But this probably will fail for GOST
keys/certificates.)

> 
> James
> 
> 
