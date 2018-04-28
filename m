Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48305 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757912AbeD1PJP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 28 Apr 2018 11:09:15 -0400
Date: Sat, 28 Apr 2018 17:09:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v3 01/10] security/ima: Rewrite tests into new API +
 fixes
Message-ID: <20180428150913.6gf6kkpdf5r7kcm6@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-2-pvorel@suse.cz>
 <1524838395.3416.65.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1524838395.3416.65.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,

> > +ima_check()
...
> > +	[ "$DIGEST_INDEX" ] && digest="$(echo "$line" | awk '{print $(NF-'$DIGEST_INDEX')}' | cut -d ':' -f 1)"
> > +	hash="$(echo "$line" | awk '{print $(NF-1)}' | cut -d ':' -f 2)"

> With the "ima-sig" template, with a measurement that does not contain
> the signature, this works fine.  There's a problem with lines
> containing the signature.

> Sample ima-sig template measurements with/without the signature:
> line="10 ee788468d1b416a394feb9f4e5650302d9cd5574 ima-sig sha256:866c2542efd5c7528591eb3bb2861a1994a655da47732ccf28f7f4b1ce42d564 /usr/lib64/libpam.so.0.84.1"

> line="10 d3afb4df5fe42485b99677f4b68a04692977b4bc ima-sig sha256:7b85508c9181670fe169935310b8c95d7c2573f0318a70cecd12868569aab891 /etc/profile.d/less.sh 0302046e6c104601008bd533707b34a9e896d3d530a88e9af517fb7e8cf79e9e55064a577fcbcdb81236ede6fec0638d357e4c2ed9b261320f8789378d1e58af8e1c6f40ebdf080759be2c633b27bc8aed85af0620fa27700c68fdf31d33b2f9e36432a1e7d7eb8dbf20b9474d332deb9697767ee13e13c116544a843b54fce842d24ea485bb41f6f7b1e9fa3faed0c591f5243cee008b9499e48064141662d3c4d002b07448ae54dc8d8674437143d73c4e34f5b416300ba890dc391eae9e5b1e89190790d0ea77d1dc57e07dae9ca003294a36fda09c31f8afa347701bfcf5aed0fda9cf7a37f734ba80fc10f2d60409f0beba532f3e5cc15ae995128e466b20fdadef789e285519"

Sorry, I haven't setup machine with IMA signature support yet. So booting with
ima_template_fmt=d-ng|n-ng|sig (or kernel with CONFIG_IMA_DEFAULT_TEMPLATE="ima-sig")
without any keys generated with evmctl obviously doesn't bring any signatures.

It could be a solution to detect presence of signature for 'ima-sig' with simple counting
parameters (5: no signature, 6: signature when ima_template_fmt is not used).  And good
thing is that line without signature is different: signature part isn't left, but there is
and space (' ') for it.

The detection of both indexes (the hash itself and the digest) needs to be bit smarter
anyway as imagine someone crazy using ima_template_fmt=d-ng|n-ng|sig|d-ng|n-ng|sig
parameter.

Kind regards,
Petr
