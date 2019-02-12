Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9EAC282C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A81222C1
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 17:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfBLRXu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:23:50 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:42156 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfBLRXu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Feb 2019 12:23:50 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0019772CC64;
        Tue, 12 Feb 2019 20:23:46 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id C3C534A4A2A;
        Tue, 12 Feb 2019 20:23:46 +0300 (MSK)
Date:   Tue, 12 Feb 2019 20:23:46 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: simplify digest alias handling
Message-ID: <20190212172346.e42pm6xsw5ee3b3q@altlinux.org>
References: <20190212001400.11107-1-vt@altlinux.org>
 <1549988620.12743.272.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549988620.12743.272.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Feb 12, 2019 at 11:23:40AM -0500, Mimi Zohar wrote:
> Definitely a lot better.
> 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index d9ffa13..ed77211 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -63,7 +63,7 @@
> >  #include "imaevm.h"
> >  #include "hash_info.h"
> > 
> > -const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> > +const char *pkey_hash_algo[PKEY_HASH__LAST] = {
> 
> Dropping the "const"?

I will undo this change.

> >  	[PKEY_HASH_MD4]		= "md4",
> >  	[PKEY_HASH_MD5]		= "md5",
> >  	[PKEY_HASH_SHA1]	= "sha1",
> > @@ -72,8 +72,13 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> >  	[PKEY_HASH_SHA384]	= "sha384",
> >  	[PKEY_HASH_SHA512]	= "sha512",
> >  	[PKEY_HASH_SHA224]	= "sha224",
> > -	[PKEY_HASH_STREEBOG_256] = "md_gost12_256,streebog256",
> > -	[PKEY_HASH_STREEBOG_512] = "md_gost12_512,streebog512",
> > +	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
> > +	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
> > +};
> > +
> > +const char *pkey_hash_algo_alias[PKEY_HASH__LAST] = {
> > +	[PKEY_HASH_STREEBOG_256] = "streebog256",
> > +	[PKEY_HASH_STREEBOG_512] = "streebog512",
> >  };
> > 
> 
> If the upstream kernel name is defined as "streebog", the alias would
> be "gost".

To me it seems that meaning of what here is alias is really not
important.  There is two names in OpenSSL md_gost12_X and streebogX,
where streebogX is newer and less accessible, and md_gost12_X is
more accessible in older version. While in the kernel name is streebogX.

Probably it's better to distinguish as openssl and kernel names, and not
the name and alias.

Since libimaevm primarily works with OpenSSL API, I keep backward compatible
names md_gost12_X in pkey_hash_algo, so when algo id is resolved to the name
it resolved to the name which is present in the older OpenSSLs, thus we don't
need to request EVP_get_digestbyname another time if user specified name is
not found in OpenSSL.

> > @@ -615,15 +553,14 @@ int get_hash_algo(const char *algo)
> >  	/* first iterate over builtin algorithms */
> >  	for (i = 0; i < PKEY_HASH__LAST; i++)
> >  		if (pkey_hash_algo[i] &&
> > -		    !strmatch(algo, pkey_hash_algo[i]))
> > +		    !strcmp(algo, pkey_hash_algo[i]))
> >  			return i;
> > 
> >  	/* iterate over algorithms provided by kernel-headers */
> > -	for (i = 0; i < HASH_ALGO__LAST; i++) {
> > -		if (hash_algo_name[i] &&
> > -		    !algocmp(algo, hash_algo_name[i]))
> > +	for (i = 0; i < PKEY_HASH__LAST; i++)
> > +		if (pkey_hash_algo_alias[i] &&
> > +		    !strcmp(algo, pkey_hash_algo_alias[i]))
> >  			return i;
> > -	}
> > 
> 
> This doesn't look right. šThe comments don't reflect the code.
> Shouldn't there be 3 loops -špkey_hash_algo,špkey_hash_algo_alias, and
> then the kernel header?

My mistake. I forgot about this feature.

Thanks!

> 
> Mimi
