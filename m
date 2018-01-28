Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55022 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751288AbeA1Qhw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jan 2018 11:37:52 -0500
Message-ID: <1517157470.3082.14.camel@HansenPartnership.com>
Subject: Re: [PATCH] ima-evm-utils: migrate to the new openssl 1.1 api
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Bruno E. O. Meneguele" <brdeoliv@redhat.com>,
        dmitry.kasatkin@gmail.com, jarkko.sakkinen@linux.intel.com
Cc: linux-integrity@vger.kernel.org
Date: Sun, 28 Jan 2018 08:37:50 -0800
In-Reply-To: <1517116029.29187.214.camel@linux.vnet.ibm.com>
References: <20171207190508.28292-1-brdeoliv@redhat.com>
         <1517034216.3034.50.camel@HansenPartnership.com>
         <1517116029.29187.214.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2018-01-28 at 00:07 -0500, Mimi Zohar wrote:
> On Fri, 2018-01-26 at 22:23 -0800, James Bottomley wrote:
> > 
> > On Thu, 2017-12-07 at 17:05 -0200, Bruno E. O. Meneguele wrote:
> > > 
> > > This patch adds and changes the points needed to support the new
> > > OpenSSL 1.1 API, considering the older one, OpenSSL 1.0.z, will
> > > be dropped by the major distros in following releases.
> > 
> > This would break compilation on every 1.0 distro:
> > 
> > gcc -DHAVE_CONFIG_H -I. -I.. -I.. -include config.h    -g -O2 -g
> > -O1
> > -Wall -Wstrict-prototypes -pipe -MT evmctl-evmctl.o -MD -MP -MF
> > .deps/evmctl-evmctl.Tpo -c -o evmctl-evmctl.o `test -f 'evmctl.c'
> > ||
> > echo './'`evmctl.c
> > evmctl.c: In function 'calc_evm_hash':
> > evmctl.c:369:2: warning: implicit declaration of function
> > 'EVP_MD_CTX_new' [-Wimplicit-function-declaration]
> >   ctx = EVP_MD_CTX_new();
> > ...
> > 
> > Unfortunately you have to ifdef the compilations if you want it to
> > work on both 1.0 and 1.1.
> > 
> > How about this?
> 
> Thanks, James.  It compiles and works with both libraries now.

Great, thanks for testing (I only compile tested).  I'll send this as a
formal patch with your tested by.

James
