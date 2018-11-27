Return-Path: <SRS0=wgLp=OG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA04C43441
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 13:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B87920989
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 13:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B87920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeK1AGG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:06:06 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:46730 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeK1AGG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Nov 2018 19:06:06 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7046172CC59;
        Tue, 27 Nov 2018 16:08:12 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 60E134A4A29;
        Tue, 27 Nov 2018 16:08:12 +0300 (MSK)
Date:   Tue, 27 Nov 2018 16:08:12 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 3/3] ima-evm-utils: Allow to use Streebog hash function
Message-ID: <20181127130812.ad3t3uflxkagttuf@sole.flsd.net>
References: <20181126043953.1126-1-vt@altlinux.org>
 <20181126043953.1126-3-vt@altlinux.org>
 <1543319811.3902.134.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543319811.3902.134.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Nov 27, 2018 at 06:56:51AM -0500, Mimi Zohar wrote:
> On Mon, 2018-11-26 at 07:39 +0300, Vitaly Chikunov wrote:
> <snip>
> > diff --git a/src/imaevm.h b/src/imaevm.h
> > index 1bafaad..1a5ebbe 100644
> > --- a/src/imaevm.h
> > +++ b/src/imaevm.h
> > @@ -149,6 +149,7 @@ struct signature_hdr {
> >  	char mpi[0];
> >  } __packed;
> > 
> > +/* reflect enum hash_algo from include/uapi/linux/hash_info.h */
> >  enum pkey_hash_algo {
> >  	PKEY_HASH_MD4,
> >  	PKEY_HASH_MD5,
> > @@ -158,6 +159,18 @@ enum pkey_hash_algo {
> >  	PKEY_HASH_SHA384,
> >  	PKEY_HASH_SHA512,
> >  	PKEY_HASH_SHA224,
> > +	PKEY_HASH_RIPE_MD_128,
> > +	PKEY_HASH_RIPE_MD_256,
> > +	PKEY_HASH_RIPE_MD_320,
> > +	PKEY_HASH_WP_256,
> > +	PKEY_HASH_WP_384,
> > +	PKEY_HASH_WP_512,
> > +	PKEY_HASH_TGR_128,
> > +	PKEY_HASH_TGR_160,
> > +	PKEY_HASH_TGR_192,
> > +	PKEY_HASH_SM3_256,
> > +	PKEY_HASH_STREEBOG_256,
> > +	PKEY_HASH_STREEBOG_512,
> >  	PKEY_HASH__LAST
> >  };
> > 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index 714f1ac..8f74660 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -50,6 +50,7 @@
> >  #include <string.h>
> >  #include <stdio.h>
> > 
> > +#include <openssl/crypto.h>
> >  #include <openssl/pem.h>
> >  #include <openssl/evp.h>
> >  #include <openssl/x509.h>
> > @@ -66,6 +67,8 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> >  	[PKEY_HASH_SHA384]	= "sha384",
> >  	[PKEY_HASH_SHA512]	= "sha512",
> >  	[PKEY_HASH_SHA224]	= "sha224",
> > +	[PKEY_HASH_STREEBOG_256] = "streebog256",
> > +	[PKEY_HASH_STREEBOG_512] = "streebog512",
> >  };
> 
> hash_info.h is now included in kernel-headers package.

I think, first it should not be coincided with the new algo adding and
being follow-up patch (if any).

> Anyone using the hash_algo enumeration defined in hash_info.h, will
> probably also want to use an associated algorithm name. šIt would make
> more sense to keep the hash_algo enumeration, hash_algo_name[], and
> perhaps the hash_digest_size[] together. šMaybe using macros to keep
> them in sync (eg. kernel_read_file_id/kernel_read_file_str).

On the first sight this sounds good, but...

It sounds like it will require patching kernel's hash_info.h, so it will
be not possible to transfer smoothly on the new scheme without breaking
some compatibility (of the newer ima-evm-utils with older kernels). Also,
it is possible that ima-evm-utils is used on the older stable box (where some
reliable and stable build system run) which does not have such modification
and/or new algorithms in the kernel but willing to generate signatures.

So, I think code duplication between projects is good in this case.

Some hash algorithms may be wished to be compatible with rsa pkcs1
signature scheme, which is also defined in kernel in
crypto/rsa-pkcs1pad.c and in ima-evm-utils in src/libimaevm.c so code
duplication and adding algorithms in both sources will happen anyway.

Thanks,


> As new algorithms are added to hash_info.h, nothing would need to be
> done here in ima-evm-utils, other than updating the maximum digest
> size.
> 
> What do you think?
> 
> Mimi
