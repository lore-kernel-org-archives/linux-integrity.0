Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B7C169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 20:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF0B218DE
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 20:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBKUhW (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:37:22 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:36688 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfBKUhW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 15:37:22 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 01FBA72CC64;
        Mon, 11 Feb 2019 23:37:20 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D878B4A4A14;
        Mon, 11 Feb 2019 23:37:19 +0300 (MSK)
Date:   Mon, 11 Feb 2019 23:37:19 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 7/7] ima-evm-utils: Try to load digest by its alias
Message-ID: <20190211203718.gx6iw3d2vhikegdy@altlinux.org>
References: <20181203033525.20431-1-vt@altlinux.org>
 <20181203033525.20431-7-vt@altlinux.org>
 <1549906738.12743.167.camel@linux.ibm.com>
 <20190211175248.22ighzenzvm5tddb@altlinux.org>
 <1549907952.12743.173.camel@linux.ibm.com>
 <20190211181300.cktmpuymd4uqtcov@altlinux.org>
 <20190211182115.gir76jn66e73akc7@altlinux.org>
 <20190211192644.q7ipos4rrmj7vugq@altlinux.org>
 <1549916463.12743.188.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549916463.12743.188.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Feb 11, 2019 at 03:21:03PM -0500, Mimi Zohar wrote:
> On Mon, 2019-02-11 at 22:26 +0300, Vitaly Chikunov wrote:
> > On Mon, Feb 11, 2019 at 09:21:15PM +0300, Vitaly Chikunov wrote:
> > > On Mon, Feb 11, 2019 at 09:13:00PM +0300, Vitaly Chikunov wrote:
> > > > On Mon, Feb 11, 2019 at 12:59:12PM -0500, Mimi Zohar wrote:
> > > > > On Mon, 2019-02-11 at 20:52 +0300, Vitaly Chikunov wrote:
> > > > > > On Mon, Feb 11, 2019 at 12:38:58PM -0500, Mimi Zohar wrote:
> > > > > > > On Mon, 2018-12-03 at 06:35 +0300, Vitaly Chikunov wrote:
> > > > > > > > For compatibility with older OpenSSL try to load digest by its alias if
> > > > > > > > load by its proper name is failed.
> > > > > > > > 
> > > > > > > > This is configured in pkey_hash_algo by mentioning loadable alias first in the
> > > > > > > > comma separated list of algo names.
> > > > > > > 
> > > > > > > After this patch, I can not verify the signature. šIt's failing to
> > > > > > > find the hash algorithm.
> > > > > > 
> > > > > > Yes, it's fixed in "ima-evm-utils: convert sign v2 from RSA to EVP_PKEY
> > > > > > API". I didn't consider it a problem since streebog256 should not work
> > > > > > for sign/verify anyway (since RSA should not support it). That EVP_PKEY
> > > > > > patch which adds ability to sign/verify for Streebog also fixes above
> > > > > > problem.
> > > > > 
> > > > > I've been having second thoughts about this patch in general, as it
> > > > > made the hash algorithm comparison unnecessarily more complex for the
> > > > > simple case. šAs there hasn't been a new ima-evm-utils release with
> > > > > patch, perhaps we should simple remove/revert it?
> > > > 
> > > > It was only for compatibility with older openssl/gost-engine, where
> > > > "streebog256" name is not defined yet. If you don't want to allow that
> > > > users to use Streebog feel free to revert it.
> > 
> > Or you may suggest simpler approach.
> > 
> > Basically, we need to resole both text strings into the same PKEY_HASH_
> > id, allow any of the string pass into EVP_get_digestbyname, and resolve
> > PKEY_HASH_ id back into the correct hash name. Optionally, allow user to
> > specify new hash name on older openssl/gost-engine. This is all
> > implemented by that patch, it was not just overly complicated "hash
> > algorithm comparison".
> > 
> > My wish is we retain support of older openssl/gost-engine.
> 
> The following seems to fix the problem, but instead of adding it in
> strmatch(), as below, I would add it before the strmatch() call. šThen
> strmatch is only called as needed.

IC. I will try to conceptually simplify the code and prepare another
patch. Probably, I will split pkey_hash_algop[] into two arrays, simple
one where strcmp() in the loop is used, and complex one for hash names
with aliases. I will try to replace strmatch() with just simple string 
array loop.

> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index d9ffa13befb0..7901215da655 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -598,6 +598,9 @@ static int strmatch(const char *needle, const char *haystack)
>         const char *p = haystack;
>         const char *t;
>  
> +       if (strcmp(needle, haystack) == 0)
> +               return 0;
> +
>         for (t = strchrnul(p, ','); *p; p = t, t = strchrnul(p, ',')) {
>                 if (t - p == len &&
>                     !strncmp(needle, p, len))
> 
> Mimi
