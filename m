Return-Path: <SRS0=eEpa=QH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B23C169C4
	for <linux-integrity@archiver.kernel.org>; Thu, 31 Jan 2019 09:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C310820B1F
	for <linux-integrity@archiver.kernel.org>; Thu, 31 Jan 2019 09:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfAaJWF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:22:05 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:38762 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfAaJWE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Jan 2019 04:22:04 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C22A272CC6D;
        Thu, 31 Jan 2019 12:22:01 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id A80DE4A4A2A;
        Thu, 31 Jan 2019 12:22:01 +0300 (MSK)
Date:   Thu, 31 Jan 2019 12:22:01 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: remove redundant call to
 OpenSSL_add_all_algorithms
Message-ID: <20190131092201.grymls3ocm3mmrmd@altlinux.org>
References: <20190127023916.2425-1-vt@altlinux.org>
 <1548851697.20210.91.camel@linux.ibm.com>
 <20190130132521.edhtrv54labxlbyc@altlinux.org>
 <1548862549.3037.18.camel@HansenPartnership.com>
 <20190130161208.vpbk3v74l7cf5a4t@altlinux.org>
 <1548866665.3037.27.camel@HansenPartnership.com>
 <20190130175419.hiqbpptl7fej6m4j@altlinux.org>
 <1548873360.3037.45.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1548873360.3037.45.camel@HansenPartnership.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 30, 2019 at 10:36:00AM -0800, James Bottomley wrote:
> On Wed, 2019-01-30 at 20:54 +0300, Vitaly Chikunov wrote:
> > On Wed, Jan 30, 2019 at 08:44:25AM -0800, James Bottomley wrote:
> > > On Wed, 2019-01-30 at 19:12 +0300, Vitaly Chikunov wrote:
> [...]
> > > > There is preferred "easy" method of [system wide] loading of
> > > > gost-engine "by default" just by changing openssl.cnf like this:
> > > > 
> > > >   https://github.com/gost-engine/engine/blob/master/example.conf
> > > > 
> > > > After that change all openssl (and linked) tools understand GOST
> > > > algorithms without needing options like `-engine gost`.
> > > 
> > > This means that you turn the gost engine on by default in the file
> > 
> > This is how most gost users are suggested to use it.
> 
> Well, no, this is how Russian Government people use it because gost
> implements the mandatory aspects of their encryption standard.  If you
> work for them you want gost all the time for everything.  So it's the
> suggested way for that class of users.

Well, no, this is not "how Russian Government people use it", but is how
normal people use it, and gost-engine does not make GOST everything,
everywhere, always, but just enables GOST algorithms to use when they
need. They may need to access gov portals, APIs, tax and communal
systems, banks, etc.

The root of the problem is GOST algorithms was split from mainstream OpenSSL
project into separate subproject gost-engine. Unlike, for example, to
SM2 or whatever you can use natively just by linking with openssl.
Linking openssl does not make you work for Chinese Government and use SM
algorithms all the time for everything.

Just to make GOST algorithms "automatically" accessible by software
which is linked to openssl, openssl.cnf trick is used. From the user point
of view these algorithms just become "inside" of openssl. And there is
no other way of extending openssl besides engines. And there are no other
ways of loading engine except by 1) making software and their users
aware of openssl engines, 2) config trick.

> However, that's not how a casual non-Russian user would want it. 
> They'd only want gost if they specified the streebog hash.  And if we
> advertise the hash (as we do because you added it to the help) they
> should have a reasonable expectation of its working easily.

It will. I support both methods of use. For occasional user there is
option --engine and for the frequent user there is config trick.

> > > > This works unless tool is compiled without OPENSSL_LOAD_CONF and
> > > > it calls OpenSSL_add_all_algorithms() instead of
> > > > OPENSSL_add_all_algorithms_conf(). Which is frequently the
> > > > default, (because there is too much methods of openssl
> > > > initialization and people may not understand all intrications for
> > > > all options.) In that case we try to persuade tool author to
> > > > change the way openssl is initialized.
> > > 
> > > What I'm saying is that modifying config files is really difficult
> > > for most users.  So, if you want ima-evm-utils to work out of the
> > > box with the Streebog hash it needs to have no dependent
> > > requirement on config files, which means you need to add the call
> > > to ENGINE_set_default()
> > 
> > I implemented two methods of loading engine for evmctl (via config
> > and via --engine option).  There is no problem with --engine option
> > for Streebog, AFAIK.
> 
> Can you try it with a vanilla (non gost modified) openssl.cnf file to
> verify?  I think you require the ENGINE_set_default() call but it may
> be that a non-standard hash name will cause a search of the engine
> added hashes.  OpenSSL has badly documented defaults, so I usually
> chase that through the code, but in this case a simple experiment will
> tell us.

Of course, I tried and tested that both ways are working independently.
Just for Streebog ENGINE_set_default is not required, but to support
GOST signatures (patch is RFCed) it will be required.

> >   We are talking about config method, which would be
> > default for the most users.
> > 
> > (Your suggestion is still good for my next patch what implements PKEY
> > instead of RSA, for EC-RDSA signatures. Thanks! I will add it.)
> > 
> > > This isn't about how you usually do it, it's about making these
> > > additions usable for average users.
> > 
> > Config method of loading gost engine is not how I usually do it, but
> > how most gost users use it (and suggested to use it). This isn't some
> > marginal use case. They just modify `openssl.cnf` once (manually of
> > via script) and all relevant ssl tools "magically" start to
> > understand gost algorithms without any additional options. This would
> > be very not user friendly if for every network tool that supports ssl
> > they should specify `--someoption gost`.
> 
> Right, I'm not saying disallow that.  The Russian crypto case is
> certainly a valid class of user.  What I'm saying is *don't* require
> this config setup for other non-Russian crypto users because they won't
> be familiar with it.

Config method is not required as there are two ways of use. But engine
does not load properly without a call to OPENSSL_add_all_algorithms_conf.
So, I am curious why to disallow it.

Also, calling OPENSSL_add_all_algorithms_conf will not cause any engine
load if a user does not edit config on her system.

Thanks,

> > `--engine` option is just supplementary for advanced or occasional
> > users. It continues to work (for Streebog) if
> > OpenSSL_add_all_algorithms call is removed, but breaks if
> > OPENSSL_add_all_algorithms_conf is removed, probably, need to call
> > ENGINE_load_builtin_engines in that case.
> > 
> > All this make initialization more complicated instead of single call
> > to OPENSSL_add_all_algorithms_conf().
> 
> Yes, but it's acceptable to make our life more complex if it makes life
> simpler for the end user.
> 
> > > That doesn't stop you from adding further mods via the config
> > > files, but it does mean that if a random user installs evmctl and
> > > types
> > > 
> > > evmctl -e gost -a streebog256 ...
> > > 
> > > it will just work instead of failing with an obscure error because
> > > the default config file is wrong.  I actually think for usability
> > > you should tie the hash and the engine together so a user can just
> > > type
> > > 
> > > evmctl -a streebog256 ...
> > > 
> > > And the tool will automatically try to load the gost engine and
> > > tell you if it's missing.
> > 
> > This is interesting idea. (But this probably will fail for GOST
> > keys/certificates.)
> 
> Gost certs should identify the streebog hash, so in theory we can
> examine the OIDs and see we need the gost engine to process them.  I'm
> certainly not saying do this, I'm just giving it as an example of how
> to make life easier for users.
> 
> James
