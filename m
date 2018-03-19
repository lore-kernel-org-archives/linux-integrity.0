Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:53448 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754511AbeCSEnz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 00:43:55 -0400
Date: Mon, 19 Mar 2018 15:43:48 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH] ima: Avoid using not initialized IMA
In-Reply-To: <1521336476.3503.74.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1803191542410.5791@namei.org>
References: <20180316232827.3791-1-pvorel@suse.cz> <1521336476.3503.74.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1899361713-1521434628=:5791"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 17 Mar 2018, Mimi Zohar wrote:

> On Sat, 2018-03-17 at 00:28 +0100, Petr Vorel wrote:
> > IMA requires have it's hash algorithm to be compiled-in due it's early
> > use. Default IMA algorithm is protected by Kconfig to be compiled-in.
> > 
> > ima_hash kernel parameter allows to choose hash algorithm. When
> > specified algorithm not available or available as module, IMA
> > initialization fails, but mknodat syscall expect it and calls
> > ima_post_path_mknod(). This leads to to kernel oops:
> > 
> > $ grep CONFIG_CRYPTO_MD4 .config
> > CONFIG_CRYPTO_MD4=m
> > 
> > [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.12.14-2.3-default root=UUID=74ae8202-9ca7-4e39-813b-22287ec52f7a video=1024x768-16 plymouth.ignore-serial-consoles console=ttyS0 console=tty resume=/dev/disk/by-path/pci-0000:00:07.0-part3 splash=silent showopts ima_hash=md4
> > ...
> > [    1.545190] ima: Can not allocate md4 (reason: -2)
> 
> The hash algorithm specified on the boot command line needs to be
> builtin.  For whatever reason it isn't builtin, rather than skipping
> measurements, a better solution I think would be to fallback to the
> builtin hash algorithm.

What if this falls back to a hash which is not secure enough?


-- 
James Morris
<jmorris@namei.org>
