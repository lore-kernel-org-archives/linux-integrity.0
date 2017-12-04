Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752658AbdLDTSc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Dec 2017 14:18:32 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB4JElRi144797
        for <linux-integrity@vger.kernel.org>; Mon, 4 Dec 2017 14:18:32 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2enbw0s9kq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 04 Dec 2017 14:18:31 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 4 Dec 2017 19:18:30 -0000
Subject: Re: IMA-EVM-Utils OpenSSL1.1 interface update
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org
Date: Mon, 04 Dec 2017 14:18:26 -0500
In-Reply-To: <20171204171435.GA6190@glitch>
References: <20171201181522.GB3056@glitch>
         <1512392157.3977.36.camel@linux.vnet.ibm.com>
         <20171204171435.GA6190@glitch>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512415106.3977.53.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-12-04 at 15:14 -0200, Bruno E. O. Meneguele wrote:
> On 04-12, Mimi Zohar wrote:
> > On Fri, 2017-12-01 at 16:15 -0200, Bruno E. O. Meneguele wrote:
> > > Hi folks,
> > > 
> > > I don't really know what are your best interest in update ima-evm-utils
> > > 1.0 package to support OpenSSL 1.1 new interface considering lots of
> > > distros are chaging to it as the default one. Some are maintaining
> > > compatibility packages to OpenSSL 1.0, but usually it remains available
> > > in the official repos for something like 1 or 2 releases and then
> > > removed completely.
> > > 
> > > Actually I have a simple/small port of it to OpenSSL 1.1 that I plan to
> > > maintain for Fedora's Rawhide (next release, f28) package. Do you guys
> > > have interest on it? I could post it as a patch.
> > > 
> > > Thanks!
> > 
> > Yes, I'd really appreciate it.  We need to release the new EVM
> > portable signature support as well.
> > 
> 
> Perfect! should I post with some different subject prefix or something
> like that to let things clear that is a patch for the userspace app?

In general, now that we have a shared mailing list with TPM, the
subject line should be prefixed with the kernel subystem (eg. "ima:",
"evm:", "tpm:").

Similarly we could do the equivalent for userspace applications (eg.
"ima-evm-utils:").

Jarkko, is that ok?

Mimi
