Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751625AbeFXWbh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Jun 2018 18:31:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5OMTJ8a007125
        for <linux-integrity@vger.kernel.org>; Sun, 24 Jun 2018 18:31:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jt3ebhja3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 24 Jun 2018 18:31:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 24 Jun 2018 23:31:35 +0100
Subject: Re: IMA: Deadlock in ima_appraise_measurement when /bin/kmod
 carries a digsig in security.evm
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthias Gerstner <mgerstner@suse.de>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Sun, 24 Jun 2018 18:31:30 -0400
In-Reply-To: <1529696928.3418.16.camel@linux.vnet.ibm.com>
References: <20180618145628.GD8123@f195.suse.de>
         <1529446875.3269.6.camel@linux.vnet.ibm.com>
         <20180620105351.GA8033@f195.suse.de>
         <1529696928.3418.16.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1529879490.3343.4.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-06-22 at 15:48 -0400, Mimi Zohar wrote:
> On Wed, 2018-06-20 at 12:53 +0200, Matthias Gerstner wrote:
> > Hello Mimi,
> > 
> > > Somehow I missed it.  A more generic patch is currently queued, which
> > > should resolve this problem as well.  Please try commit fdc33c29b022
> > > ("evm: Don't deadlock if a crypto algorithm is unavailable") in the
> > > next-integrity-queued branch.
> > 
> > thank you for helping me out. I tried that patch but it does no fix the
> > issue completely. It still ends up in a deadlock. As you can see from
> > the backtrace attached below the call to public_key_verify_signature()
> > still causes a deadlock, since there is the following call in it:
> > 
> >     tfm = crypto_alloc_akcipher(alg_name, 0, 0);
> > 
> > Passing CRYPTO_NOLOAD here does fix the deadlock for me, but I fear that
> > won't be an option and the interface needs to be extended to pass flags?
> 
> I'm having a hard time reproducing this bug.  Too many different
> permutations of EVM/IMA keys, signatures, and kernel modules.  Is the
> problem loading the crypto algorithm, itself, built as a kernel module
> (eg. insmod/modprobe - If so, which syscall is being used?)  Or is the
> problem accessing a file signed by an algorithm built as a kernel
> module.

I'm now able to reproduce the bug.

> Mikhail, I'm really sorry for not seeing the patch.  I must have been
> dropped from the sf mailing list and didn't notice.  I was only seeing
> posts when Cc'ed on them.
> 
> Matthias, does Mikhail's patch fix this problem?

Mikhail's patch does resolve it.

Mimi
