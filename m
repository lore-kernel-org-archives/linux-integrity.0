Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030777AbeCSUUI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 16:20:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2JKJGEN095903
        for <linux-integrity@vger.kernel.org>; Mon, 19 Mar 2018 16:20:07 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gtgssrc0g-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Mar 2018 16:20:07 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 19 Mar 2018 20:20:05 -0000
Subject: Re: [PATCH] ima: Avoid using not initialized IMA
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: James Morris <jmorris@namei.org>, linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Mon, 19 Mar 2018 16:20:00 -0400
In-Reply-To: <20180319200516.5kgloj4vdigxb52y@dell5510>
References: <20180316232827.3791-1-pvorel@suse.cz>
         <1521336476.3503.74.camel@linux.vnet.ibm.com>
         <alpine.LRH.2.21.1803191542410.5791@namei.org>
         <1521457159.3503.93.camel@linux.vnet.ibm.com>
         <20180319200516.5kgloj4vdigxb52y@dell5510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521490800.3503.202.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-19 at 21:05 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > On Mon, 2018-03-19 at 15:43 +1100, James Morris wrote:
> > > On Sat, 17 Mar 2018, Mimi Zohar wrote:
> 
> > > > On Sat, 2018-03-17 at 00:28 +0100, Petr Vorel wrote:
> > > > > IMA requires have it's hash algorithm to be compiled-in due it's early
> > > > > use. Default IMA algorithm is protected by Kconfig to be compiled-in.
> 
> > > > > ima_hash kernel parameter allows to choose hash algorithm. When
> > > > > specified algorithm not available or available as module, IMA
> > > > > initialization fails, but mknodat syscall expect it and calls
> > > > > ima_post_path_mknod(). This leads to to kernel oops:
> 
> > > > > $ grep CONFIG_CRYPTO_MD4 .config
> > > > > CONFIG_CRYPTO_MD4=m
> 
> > > > > [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.12.14-2.3-default root=UUID=74ae8202-9ca7-4e39-813b-22287ec52f7a video=1024x768-16 plymouth.ignore-serial-consoles console=ttyS0 console=tty resume=/dev/disk/by-path/pci-0000:00:07.0-part3 splash=silent showopts ima_hash=md4
> > > > > ...
> > > > > [    1.545190] ima: Can not allocate md4 (reason: -2)
> 
> > > > The hash algorithm specified on the boot command line needs to be
> > > > builtin.  For whatever reason it isn't builtin, rather than skipping
> > > > measurements, a better solution I think would be to fallback to the
> > > > builtin hash algorithm.
> 
> > > What if this falls back to a hash which is not secure enough?
> 
> > It should fallback to the Kconfig selected hash algorithm as defined
> > in CONFIG_IMA_DEFAULT_HASH.
> 
> OK, I have v2 which use CONFIG_IMA_DEFAULT_HASH, I'll post it tomorrow.
> But I'd also keep this patch as well, this check doesn't harm and IMHO you can never be
> sure it does not fail.

Adding a new measurement gap is not an acceptable solution.  Either an
ima_init() failure causes the kernel to panic, or we force IMA to use
the default builtin Kconfig hash algorithm.

Mimi
