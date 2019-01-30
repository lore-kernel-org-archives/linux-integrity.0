Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572DAC282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 15:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7EE207E0
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 15:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfA3P7U (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:59:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:51814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730826AbfA3P7U (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 10:59:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84018AFBB;
        Wed, 30 Jan 2019 15:59:19 +0000 (UTC)
Date:   Wed, 30 Jan 2019 16:59:17 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Jonathan Davies <jonathan.davies@canonical.com>,
        Marcus Meissner <meissner@suse.com>
Subject: Re: [PATCH] ima-evm-utils: remove redundant call to
 OpenSSL_add_all_algorithms
Message-ID: <20190130155917.GA10021@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190127023916.2425-1-vt@altlinux.org>
 <1548851697.20210.91.camel@linux.ibm.com>
 <20190130132521.edhtrv54labxlbyc@altlinux.org>
 <1548855673.20210.102.camel@linux.ibm.com>
 <20190130135342.wx7vcq7hyvxqtqxd@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130135342.wx7vcq7hyvxqtqxd@altlinux.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

[ Cc Marcus and Jonathan ]
> On Wed, Jan 30, 2019 at 08:41:13AM -0500, Mimi Zohar wrote:
> > [Cc'ing Bruno, Petr]

> > On Wed, 2019-01-30 at 16:25 +0300, Vitaly Chikunov wrote:
> > > On Wed, Jan 30, 2019 at 07:34:57AM -0500, Mimi Zohar wrote:
> > > > On Sun, 2019-01-27 at 05:39 +0300, Vitaly Chikunov wrote:
> > > > > Because of call to OPENSSL_add_all_algorithms_conf() calling
> > > > > OpenSSL_add_all_algorithms() is not needed. There was not be any
> > > > > problems though because double initialization is permitted.
> > > > > ---
> > > > >  src/libimaevm.c | 1 -
> > > > >  1 file changed, 1 deletion(-)

> > > > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > > > index 7501303..b038d0c 100644
> > > > > --- a/src/libimaevm.c
> > > > > +++ b/src/libimaevm.c
> > > > > @@ -995,7 +995,6 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c

> > > > >  static void libinit()
> > > > >  {
> > > > > -	OpenSSL_add_all_algorithms();
> > > > >  	OPENSSL_add_all_algorithms_conf();
> > > > >  	ERR_load_crypto_strings();
> > > > >  }

> > > > The only difference between the two calls seems to be reading the
> > > > system openssl.cnf file.  In the original call that is dependent on
> > > > OPENSSL_LOAD_CONF being defined.  Calling
> > > > OPENSSL_add_all_algorithms_conf(), forces reading the system
> > > > openssl.cnf.

> > > Yes. OPENSSL_LOAD_CONF is per application define, which is by default
> > > undefined. And instead of defining it, we could just call
> > > OPENSSL_add_all_algorithms_conf(), which is required for GOST support.
> > > Otherwise enabling Streebog via OPENSSL_CONF will not work.

> > I think this is basically a packaging question.  Instead of hard
> > coding this change, it could be an autoconf option (eg.
> > enable/disable-gost).

> User already have control to load or not engines by editing or not the
> config. But, if OpenSSL_add_all_algorithms() is used without defining
> OPENSSL_LOAD_CONF (default) user will lose such option.

> I think loading config is quite normal operation which is also default
> for the openssl binary.


> > Bruno, Petr, any preference?
Not sure (I Cc more experienced packagers), but allowing distros to control it
via autoconf certainly does not harm.

BTW OpenSSL_add_all_algorithms() is deprecated since OpenSSL 1.1.0.


Kind regards,
Petr
