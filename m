Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19387C282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E205921473
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 13:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfA3Nxq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:53:46 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53636 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3Nxq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 08:53:46 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1D04572CC6D;
        Wed, 30 Jan 2019 16:53:43 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 067FB4A4A16;
        Wed, 30 Jan 2019 16:53:43 +0300 (MSK)
Date:   Wed, 30 Jan 2019 16:53:42 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] ima-evm-utils: remove redundant call to
 OpenSSL_add_all_algorithms
Message-ID: <20190130135342.wx7vcq7hyvxqtqxd@altlinux.org>
References: <20190127023916.2425-1-vt@altlinux.org>
 <1548851697.20210.91.camel@linux.ibm.com>
 <20190130132521.edhtrv54labxlbyc@altlinux.org>
 <1548855673.20210.102.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548855673.20210.102.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 30, 2019 at 08:41:13AM -0500, Mimi Zohar wrote:
> [Cc'ing Bruno, Petr]
> 
> On Wed, 2019-01-30 at 16:25 +0300, Vitaly Chikunov wrote:
> > On Wed, Jan 30, 2019 at 07:34:57AM -0500, Mimi Zohar wrote:
> > > On Sun, 2019-01-27 at 05:39 +0300, Vitaly Chikunov wrote:
> > > > Because of call to OPENSSL_add_all_algorithms_conf() calling
> > > > OpenSSL_add_all_algorithms() is not needed. There was not be any
> > > > problems though because double initialization is permitted.
> > > > ---
> > > >  src/libimaevm.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > > index 7501303..b038d0c 100644
> > > > --- a/src/libimaevm.c
> > > > +++ b/src/libimaevm.c
> > > > @@ -995,7 +995,6 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
> > > > 
> > > >  static void libinit()
> > > >  {
> > > > -	OpenSSL_add_all_algorithms();
> > > >  	OPENSSL_add_all_algorithms_conf();
> > > >  	ERR_load_crypto_strings();
> > > >  }
> > > 
> > > The only difference between the two calls seems to be reading the
> > > system openssl.cnf file. šIn the original call that is dependent on
> > > OPENSSL_LOAD_CONF being defined. šCalling
> > > OPENSSL_add_all_algorithms_conf(), forces reading the system
> > > openssl.cnf.
> > 
> > Yes. OPENSSL_LOAD_CONF is per application define, which is by default
> > undefined. And instead of defining it, we could just call
> > OPENSSL_add_all_algorithms_conf(), which is required for GOST support.
> > Otherwise enabling Streebog via OPENSSL_CONF will not work.
> 
> I think this is basically a packaging question. šInstead of hard
> coding this change, it could be an autoconf option (eg.
> enable/disable-gost).

User already have control to load or not engines by editing or not the
config. But, if OpenSSL_add_all_algorithms() is used without defining
OPENSSL_LOAD_CONF (default) user will lose such option.

I think loading config is quite normal operation which is also default
for the openssl binary.

> 
> Bruno, Petr, any preference?
> 
> Thanks,
> 
> Mimi
