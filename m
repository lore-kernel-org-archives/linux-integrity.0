Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A75C282C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 19:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A3A2190B
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 19:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfBLTbH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:31:07 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:33970 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfBLTbH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Feb 2019 14:31:07 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6FEE072CC64;
        Tue, 12 Feb 2019 22:31:03 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5414D4A4A2A;
        Tue, 12 Feb 2019 22:31:03 +0300 (MSK)
Date:   Tue, 12 Feb 2019 22:31:03 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: simplify digest alias handling
Message-ID: <20190212193102.ic2uykah45ygasqj@altlinux.org>
References: <20190212001400.11107-1-vt@altlinux.org>
 <1549988620.12743.272.camel@linux.ibm.com>
 <20190212172346.e42pm6xsw5ee3b3q@altlinux.org>
 <1549999039.12743.277.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1549999039.12743.277.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Feb 12, 2019 at 02:17:19PM -0500, Mimi Zohar wrote:
> On Tue, 2019-02-12 at 20:23 +0300, Vitaly Chikunov wrote:
> > On Tue, Feb 12, 2019 at 11:23:40AM -0500, Mimi Zohar wrote:
> > > Definitely a lot better.
> > > 
> > > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > > index d9ffa13..ed77211 100644
> > > > --- a/src/libimaevm.c
> > > > +++ b/src/libimaevm.c
> > > > @@ -63,7 +63,7 @@
> > > >  #include "imaevm.h"
> > > >  #include "hash_info.h"
> > > > 
> > > > -const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> > > > +const char *pkey_hash_algo[PKEY_HASH__LAST] = {
> > > 
> > > Dropping the "const"?
> > 
> > I will undo this change.
> > 
> > > >  	[PKEY_HASH_MD4]		= "md4",
> > > >  	[PKEY_HASH_MD5]		= "md5",
> > > >  	[PKEY_HASH_SHA1]	= "sha1",
> > > > @@ -72,8 +72,13 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> > > >  	[PKEY_HASH_SHA384]	= "sha384",
> > > >  	[PKEY_HASH_SHA512]	= "sha512",
> > > >  	[PKEY_HASH_SHA224]	= "sha224",
> > > > -	[PKEY_HASH_STREEBOG_256] = "md_gost12_256,streebog256",
> > > > -	[PKEY_HASH_STREEBOG_512] = "md_gost12_512,streebog512",
> > > > +	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
> > > > +	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
> > > > +};
> > > > +
> > > > +const char *pkey_hash_algo_alias[PKEY_HASH__LAST] = {
> > > > +	[PKEY_HASH_STREEBOG_256] = "streebog256",
> > > > +	[PKEY_HASH_STREEBOG_512] = "streebog512",
> > > >  };
> > > > 
> > > 
> > > If the upstream kernel name is defined as "streebog", the alias would
> > > be "gost".
> > 
> > To me it seems that meaning of what here is alias is really not
> > important.  There is two names in OpenSSL md_gost12_X and streebogX,
> > where streebogX is newer and less accessible, and md_gost12_X is
> > more accessible in older version. While in the kernel name is streebogX.
> > 
> > Probably it's better to distinguish as openssl and kernel names, and not
> > the name and alias.
> 
> The original design matched the kernel haah_info.h.

But for libimaevm we have openssl as crypto library not the kernel. That
pkey_hash_algo/hash_algo_name lists names does not need to reflect kernel
names at all for things to work, since only openssl is interfaced. It is
question of user interface and compatibility with older libs.


