Return-Path: <SRS0=Ndpk=OK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7688C04EB9
	for <linux-integrity@archiver.kernel.org>; Sat,  1 Dec 2018 03:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881E220868
	for <linux-integrity@archiver.kernel.org>; Sat,  1 Dec 2018 03:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881E220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeLAOxR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:53:17 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:48712 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLAOxR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 09:53:17 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8C3D672CA65;
        Sat,  1 Dec 2018 06:41:44 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7A7BB4A4A29;
        Sat,  1 Dec 2018 06:41:44 +0300 (MSK)
Date:   Sat, 1 Dec 2018 06:41:44 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2.1 6/7] ima-evm-utils: Extract digest algorithms from
 hash_info.h
Message-ID: <20181201034144.kcyxjmotj7mjfb5n@sole.flsd.net>
References: <20181129122759.16813-1-vt@altlinux.org>
 <1543605748.4216.74.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543605748.4216.74.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 30, 2018 at 02:22:28PM -0500, Mimi Zohar wrote:
> On Thu, 2018-11-29 at 15:27 +0300, Vitaly Chikunov wrote:
> > If configured with "--with-kernel-headers=PATH" try to extract hash
> > algorithms from "hash_info.h" from the kernel source tree or
> > kernel-headers package located in the specified path. (Otherwise, it
> > will be tried to get from the installed kernel.)
> > 
> > This also introduces two algorithm lists, one is built-in and another is
> > from the kernel source. (They should never contain conflicting algorithm
> > IDs by their append-only nature.) If the digest is not found in the
> > built-in list it will be searched in the list from kernel's
> > "hash_info.h".
> > 
> > This patch will allow evmctl to be just recompiled to work with digest
> > algorithms introduced in the newer kernels.
> > 
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> > Changes since v1:
> > - New patch.
> > Changes since v2:
> > - Mark PATH portion of "--with-kernel-headers=PATH" non-optional and
> >   change description to reflect correct behavior.
> 
> Defaulting to the currently running kernel build tree would have been
> nice.

It already does. As description states "(Otherwise, it will be tried to get
from the installed kernel.)" Also:

> > +AC_ARG_WITH(kernel_headers, [AS_HELP_STRING([--with-kernel-headers=PATH],
> > +	    [specifies the Linux kernel-headers package location or kernel root directory you want to use])],
> > +	    [KERNEL_HEADERS="$withval"],
> > +	    [KERNEL_HEADERS=/lib/modules/$(uname -r)/source])

if "--with-kernel-headers" is not specified it will default to
`/lib/modules/$(uname -r)/source` which points to the kernel-headers or
kernel source tree root.

> Then you could extract "hash_algo_name[]" from crypto/hash_info.c
> directly.

I could add this, BUT this will mean that developer with kernel tree
(very small amount of users) will have slightly different algos list
than a common person with a kernel-headers package. And I don't know a
single distro which packs full kernel source (with crypto/hash_info.c)
as easy to install package, and which would link appropriately into
/lib/modules/. So this is highly doubtful that user will be inclined to
install kernel source via usually complicated procedure just to compile
evmctl.

I already tried to address this possible difference issue by algocmp()
which would not compare `_` and `-` chars, which is the only difference
from hash_algo_name in the kernel and in ima-evm-utils and OpenSSL. So,
even without this feature (of parsing crypto/hash_info.c) added, user
already can specify any algo from crypto/hash_info.c and it will just
work.


> > +echo "enum hash_algo {"
> > +grep HASH_ALGO_.*, $HASH_INFO
> > +printf "\tHASH_ALGO__LAST\n"
> > +echo "};"
> > +
> > +echo "const char *const hash_algo_name[HASH_ALGO__LAST] = {"
> > +sed -n 's/HASH_ALGO_\(.*\),/[HASH_ALGO_\1] = "\L\1\E",/p' $HASH_INFO
> > +echo "};"
> 
> Almost perfectly matches crypto/hash_crypto.c! šWaiting to see if/how
> the next patch addresses the differences...

Could you elaborate again on what I should do with this suggestion?
I guessed crypto/hash_crypto.c is crypto/hash_info.c, but what
differences you expecting?


> > +	/* first iterate over builtin algorithms */
> >  	for (i = 0; i < PKEY_HASH__LAST; i++)
> >  		if (pkey_hash_algo[i] &&
> >  		    !strcmp(algo, pkey_hash_algo[i]))
> >  			return i;
> > 
> > +	/* iterate over algorithms provided by kernel-headers */
> > +	for (i = 0; i < HASH_ALGO__LAST; i++) {
> > +		if (hash_algo_name[i] &&
> > +		    !algocmp(algo, hash_algo_name[i]))
> > +			return i;
> > +	}
> 
> Assuming the two lists are in sync, which they should be, "i" could be
> set to PKEY_HASH__LAST.

Can not do that, since pkey_hash_algo is currently sparse array and could
skip entries which are present in hash_algo_name.

Note, that since "[PATCH v2 7/7] ima-evm-utils: Try to load digest by
its alias" lists will have different semantics: the pkey_hash_algo list is
compared algo names with strmatch which supports algo aliases, and the
hash_algo_name list is compared using algocmp which does not compare
non-alphanumeric chars such as `_` and `-`, so streebog-512, streebog_512
or just streebog512 all would work (to match algo id).

Concluding, if you would not insist on parsing crypto/hash_info.c, I
don't need fixing anything in this patch.

Thanks,

