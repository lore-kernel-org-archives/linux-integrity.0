Return-Path: <SRS0=2lTb=SF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BECFC4360F
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 21:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4B8206DF
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 21:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDCV5O (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:57:14 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33216 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCV5O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Apr 2019 17:57:14 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1A6DC72CC8C;
        Thu,  4 Apr 2019 00:57:12 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 02B2D4A4A14;
        Thu,  4 Apr 2019 00:57:12 +0300 (MSK)
Date:   Thu, 4 Apr 2019 00:57:11 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ima-evm-utils: try to load digest by its alias
Message-ID: <20190403215711.7dypkbiinjzt2t5i@altlinux.org>
References: <20190323014152.14701-1-vt@altlinux.org>
 <20190323014152.14701-3-vt@altlinux.org>
 <1554324064.3839.20.camel@linux.ibm.com>
 <20190403210435.duptffqlwp6vo66m@altlinux.org>
 <1554325820.3839.27.camel@linux.ibm.com>
 <20190403213739.afjtakg5nujke477@altlinux.org>
 <1554327643.3839.29.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554327643.3839.29.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 03, 2019 at 05:40:43PM -0400, Mimi Zohar wrote:
> On Thu, 2019-04-04 at 00:37 +0300, Vitaly Chikunov wrote:
> > On Wed, Apr 03, 2019 at 05:10:20PM -0400, Mimi Zohar wrote:
> > > On Thu, 2019-04-04 at 00:04 +0300, Vitaly Chikunov wrote:
> > > > Mimi,
> > > > 
> > > > On Wed, Apr 03, 2019 at 04:41:04PM -0400, Mimi Zohar wrote:
> > > > > On Sat, 2019-03-23 at 04:41 +0300, Vitaly Chikunov wrote:
> > > > > > Primary names of the algorithms are different for OpenSSL and Kernel.
> > > > > > Allow to use both of them.
> > > > > 
> > > > > Can we add a line here explaining the two names? šPerhaps something
> > > > > like, "GOST R 34.11-2012 is the Russian national standard based on the
> > > > > Streebog set of hash functions."š
> > > > 
> > > > Ok. But, "GOST R 34.11-2012" is not mentioned, and there is other
> > > > standards with Streebog, such as RFC 6986, ISO/IEC 10118-3:2018, GOST
> > > > 34.11-2018.
> > > > 
> > > > Point of this patch is that Kernel calls this hash function by it's
> > > > proper name "StreebogX", but older version of OpenSSL reference it by
> > > > acronym "md_gost12_X". (While newer should support Streebog name too.)
> > > > And we try to be user friendly and allow to use both names.
> > > 
> > > If "Streebog" will be supported by OpenSSL, then why make md_gost12_x
> > > the primary name, and the kernel name the alias? šShouldn't it be the
> > > reverse (eg. "pkey_hash_algo_alias")?
> > 
> > Because ima-evm-utils is using OpenSSL and not Kernel's Crypto API,
> > OpenSSL names are "primary" for ima-evm-utils. It's happened that most
> > names are the same for both APIs.
> > 
> > "md_gost12_X" is supported for years by more versions of OpenSSL. While
> > "StreebogX" name is just committed a few months ago to gost-engine. Thus,
> > 
> >   1) "md_gost12_x" name could be used on conservative distros. Users
> >    will not need to wait [possible] a few years when new name reach
> >    their distro.
> > 
> >   2) PKEY_HASH_STREEBOG_X is resolved to "md_gost12_X" names (to the
> >   names that are present in OpenSSL with much more probability).
> > 
> > `pkey_hash_algo_kern` only contains names that are different between
> > the Kernel and OpenSSL.
> > 
> > I used "primary" for the both arrays so that no names are offended by
> > being not-primary.
> 
> Could you provide me with a single line or two, with an explanation
> for the two names. šI'll add it to the commit patch description,
> before pushing out these patches.

Maybe this:

  "Streebog" is a name of the hash algorithm in the Kernel Crypto API.
  "md_gost12_X" is the name used by the most versions of OpenSSL, it's
  placed in pkey_hash_algo[] so that algo IDs are resolved to them.

> 
> Thanks!
> 
> Mimi
