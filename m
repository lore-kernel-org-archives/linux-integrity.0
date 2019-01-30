Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4AAC282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 18:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5211820869
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 18:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="sfgxYG7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbfA3SgI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:36:08 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60352 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733011AbfA3SgH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 13:36:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DED5C8EE2FF;
        Wed, 30 Jan 2019 10:36:06 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KSsRDNoWQGPQ; Wed, 30 Jan 2019 10:36:06 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E1E478EE0E9;
        Wed, 30 Jan 2019 10:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1548873366;
        bh=hlceGRC/4rbIrSEQijAkVssH/gvZhcEirF7Qf+o6ulk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sfgxYG7QZzxvGlpZHtMxsCIw0mjlNOrqKc/LomMigi1bWN2Lag0Mbuf9uFn0Suntq
         yJjhruHhWEnL3xL2ibCf/ZPccSWwJcupZWBR9496saVv0mlNaokIzf8qAdHjhYwCvg
         o4WdUEGdoIO1+bb+4A2l6uc8em2WKqTdbnE7eIYM=
Message-ID: <1548873360.3037.45.camel@HansenPartnership.com>
Subject: Re: [PATCH] ima-evm-utils: remove redundant call to
 OpenSSL_add_all_algorithms
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 30 Jan 2019 10:36:00 -0800
In-Reply-To: <20190130175419.hiqbpptl7fej6m4j@altlinux.org>
References: <20190127023916.2425-1-vt@altlinux.org>
         <1548851697.20210.91.camel@linux.ibm.com>
         <20190130132521.edhtrv54labxlbyc@altlinux.org>
         <1548862549.3037.18.camel@HansenPartnership.com>
         <20190130161208.vpbk3v74l7cf5a4t@altlinux.org>
         <1548866665.3037.27.camel@HansenPartnership.com>
         <20190130175419.hiqbpptl7fej6m4j@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-01-30 at 20:54 +0300, Vitaly Chikunov wrote:
> On Wed, Jan 30, 2019 at 08:44:25AM -0800, James Bottomley wrote:
> > On Wed, 2019-01-30 at 19:12 +0300, Vitaly Chikunov wrote:
[...]
> > > There is preferred "easy" method of [system wide] loading of
> > > gost-engine "by default" just by changing openssl.cnf like this:
> > > 
> > >   https://github.com/gost-engine/engine/blob/master/example.conf
> > > 
> > > After that change all openssl (and linked) tools understand GOST
> > > algorithms without needing options like `-engine gost`.
> > 
> > This means that you turn the gost engine on by default in the file
> 
> This is how most gost users are suggested to use it.

Well, no, this is how Russian Government people use it because gost
implements the mandatory aspects of their encryption standard.  If you
work for them you want gost all the time for everything.  So it's the
suggested way for that class of users.

However, that's not how a casual non-Russian user would want it. 
They'd only want gost if they specified the streebog hash.  And if we
advertise the hash (as we do because you added it to the help) they
should have a reasonable expectation of its working easily.

> > > This works unless tool is compiled without OPENSSL_LOAD_CONF and
> > > it calls OpenSSL_add_all_algorithms() instead of
> > > OPENSSL_add_all_algorithms_conf(). Which is frequently the
> > > default, (because there is too much methods of openssl
> > > initialization and people may not understand all intrications for
> > > all options.) In that case we try to persuade tool author to
> > > change the way openssl is initialized.
> > 
> > What I'm saying is that modifying config files is really difficult
> > for most users.  So, if you want ima-evm-utils to work out of the
> > box with the Streebog hash it needs to have no dependent
> > requirement on config files, which means you need to add the call
> > to ENGINE_set_default()
> 
> I implemented two methods of loading engine for evmctl (via config
> and via --engine option).  There is no problem with --engine option
> for Streebog, AFAIK.

Can you try it with a vanilla (non gost modified) openssl.cnf file to
verify?  I think you require the ENGINE_set_default() call but it may
be that a non-standard hash name will cause a search of the engine
added hashes.  OpenSSL has badly documented defaults, so I usually
chase that through the code, but in this case a simple experiment will
tell us.

>   We are talking about config method, which would be
> default for the most users.
> 
> (Your suggestion is still good for my next patch what implements PKEY
> instead of RSA, for EC-RDSA signatures. Thanks! I will add it.)
> 
> > This isn't about how you usually do it, it's about making these
> > additions usable for average users.
> 
> Config method of loading gost engine is not how I usually do it, but
> how most gost users use it (and suggested to use it). This isn't some
> marginal use case. They just modify `openssl.cnf` once (manually of
> via script) and all relevant ssl tools "magically" start to
> understand gost algorithms without any additional options. This would
> be very not user friendly if for every network tool that supports ssl
> they should specify `--someoption gost`.

Right, I'm not saying disallow that.  The Russian crypto case is
certainly a valid class of user.  What I'm saying is *don't* require
this config setup for other non-Russian crypto users because they won't
be familiar with it.

> `--engine` option is just supplementary for advanced or occasional
> users. It continues to work (for Streebog) if
> OpenSSL_add_all_algorithms call is removed, but breaks if
> OPENSSL_add_all_algorithms_conf is removed, probably, need to call
> ENGINE_load_builtin_engines in that case.
> 
> All this make initialization more complicated instead of single call
> to OPENSSL_add_all_algorithms_conf().

Yes, but it's acceptable to make our life more complex if it makes life
simpler for the end user.

> > That doesn't stop you from adding further mods via the config
> > files, but it does mean that if a random user installs evmctl and
> > types
> > 
> > evmctl -e gost -a streebog256 ...
> > 
> > it will just work instead of failing with an obscure error because
> > the default config file is wrong.  I actually think for usability
> > you should tie the hash and the engine together so a user can just
> > type
> > 
> > evmctl -a streebog256 ...
> > 
> > And the tool will automatically try to load the gost engine and
> > tell you if it's missing.
> 
> This is interesting idea. (But this probably will fail for GOST
> keys/certificates.)

Gost certs should identify the streebog hash, so in theory we can
examine the OIDs and see we need the gost engine to process them.  I'm
certainly not saying do this, I'm just giving it as an example of how
to make life easier for users.

James

