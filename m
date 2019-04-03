Return-Path: <SRS0=2lTb=SF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF84C4360F
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 21:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BC92082C
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 21:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfDCVEl (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:04:41 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43428 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCVEj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Apr 2019 17:04:39 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3176C72CC8C;
        Thu,  4 Apr 2019 00:04:36 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 2058A4A4A14;
        Thu,  4 Apr 2019 00:04:36 +0300 (MSK)
Date:   Thu, 4 Apr 2019 00:04:35 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ima-evm-utils: try to load digest by its alias
Message-ID: <20190403210435.duptffqlwp6vo66m@altlinux.org>
References: <20190323014152.14701-1-vt@altlinux.org>
 <20190323014152.14701-3-vt@altlinux.org>
 <1554324064.3839.20.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554324064.3839.20.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Apr 03, 2019 at 04:41:04PM -0400, Mimi Zohar wrote:
> On Sat, 2019-03-23 at 04:41 +0300, Vitaly Chikunov wrote:
> > Primary names of the algorithms are different for OpenSSL and Kernel.
> > Allow to use both of them.
> 
> Can we add a line here explaining the two names? šPerhaps something
> like, "GOST R 34.11-2012 is the Russian national standard based on the
> Streebog set of hash functions."š

Ok. But, "GOST R 34.11-2012" is not mentioned, and there is other
standards with Streebog, such as RFC 6986, ISO/IEC 10118-3:2018, GOST
34.11-2018.

Point of this patch is that Kernel calls this hash function by it's
proper name "StreebogX", but older version of OpenSSL reference it by
acronym "md_gost12_X". (While newer should support Streebog name too.)
And we try to be user friendly and allow to use both names.

> 
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> 
> Reviewed-by: šMimi Zohar <zohar@linux.ibm.com>
> 
> > ---
> >  src/libimaevm.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index bc7be1e..6783110 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -61,6 +61,7 @@
> >  #include "imaevm.h"
> >  #include "hash_info.h"
> > 
> > +/* Names that are primary for OpenSSL. */
> >  const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> >  	[PKEY_HASH_MD4]		= "md4",
> >  	[PKEY_HASH_MD5]		= "md5",
> > @@ -70,6 +71,12 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> >  	[PKEY_HASH_SHA384]	= "sha384",
> >  	[PKEY_HASH_SHA512]	= "sha512",
> >  	[PKEY_HASH_SHA224]	= "sha224",
> > +	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
> > +	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
> > +};
> > +
> > +/* Names that are primary for the kernel. */
> > +const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
> >  	[PKEY_HASH_STREEBOG_256] = "streebog256",
> >  	[PKEY_HASH_STREEBOG_512] = "streebog512",
> >  };
> > @@ -551,6 +558,11 @@ int get_hash_algo(const char *algo)
> >  		    !strcmp(algo, pkey_hash_algo[i]))
> >  			return i;
> > 
> > +	for (i = 0; i < PKEY_HASH__LAST; i++)
> > +		if (pkey_hash_algo_kern[i] &&
> > +		    !strcmp(algo, pkey_hash_algo_kern[i]))
> > +			return i;
> > +
> >  	/* iterate over algorithms provided by kernel-headers */
> >  	for (i = 0; i < HASH_ALGO__LAST; i++)
> >  		if (hash_algo_name[i] &&
