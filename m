Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031249AbeCSUFT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 16:05:19 -0400
Date: Mon, 19 Mar 2018 21:05:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: James Morris <jmorris@namei.org>, linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH] ima: Avoid using not initialized IMA
Message-ID: <20180319200516.5kgloj4vdigxb52y@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180316232827.3791-1-pvorel@suse.cz>
 <1521336476.3503.74.camel@linux.vnet.ibm.com>
 <alpine.LRH.2.21.1803191542410.5791@namei.org>
 <1521457159.3503.93.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1521457159.3503.93.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,

> On Mon, 2018-03-19 at 15:43 +1100, James Morris wrote:
> > On Sat, 17 Mar 2018, Mimi Zohar wrote:

> > > On Sat, 2018-03-17 at 00:28 +0100, Petr Vorel wrote:
> > > > IMA requires have it's hash algorithm to be compiled-in due it's early
> > > > use. Default IMA algorithm is protected by Kconfig to be compiled-in.

> > > > ima_hash kernel parameter allows to choose hash algorithm. When
> > > > specified algorithm not available or available as module, IMA
> > > > initialization fails, but mknodat syscall expect it and calls
> > > > ima_post_path_mknod(). This leads to to kernel oops:

> > > > $ grep CONFIG_CRYPTO_MD4 .config
> > > > CONFIG_CRYPTO_MD4=m

> > > > [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.12.14-2.3-default root=UUID=74ae8202-9ca7-4e39-813b-22287ec52f7a video=1024x768-16 plymouth.ignore-serial-consoles console=ttyS0 console=tty resume=/dev/disk/by-path/pci-0000:00:07.0-part3 splash=silent showopts ima_hash=md4
> > > > ...
> > > > [    1.545190] ima: Can not allocate md4 (reason: -2)

> > > The hash algorithm specified on the boot command line needs to be
> > > builtin.  For whatever reason it isn't builtin, rather than skipping
> > > measurements, a better solution I think would be to fallback to the
> > > builtin hash algorithm.

> > What if this falls back to a hash which is not secure enough?

> It should fallback to the Kconfig selected hash algorithm as defined
> in CONFIG_IMA_DEFAULT_HASH.

OK, I have v2 which use CONFIG_IMA_DEFAULT_HASH, I'll post it tomorrow.
But I'd also keep this patch as well, this check doesn't harm and IMHO you can never be
sure it does not fail.

> Mimi

Kind regards,
Petr
