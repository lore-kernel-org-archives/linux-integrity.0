Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30163 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbdJXSX7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Oct 2017 14:23:59 -0400
Date: Tue, 24 Oct 2017 20:22:35 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:INTEGRITY MEASUREMENT ARCHITECTURE IMA"
        <linux-ima-user@lists.sourceforge.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "moderated list:TPM DEVICE DRIVER"
        <tpmdd-devel@lists.sourceforge.net>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Matt Mackall <mpm@selenic.com>,
        "open list:INTEGRITY MEASUREMENT ARCHITECTURE IMA"
        <linux-ima-devel@lists.sourceforge.net>,
        David Safford <safford@us.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
 in-kernel API
Message-ID: <20171024182235.d7b3oajc5zcjs57v@linux.intel.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
 <cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
 <20171023163139.GA17394@obsidianresearch.com>
 <20171024154440.3jeupmus43jcgbbz@linux.intel.com>
 <CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
 <20171024162359.tf5xulhlhokmuxh5@linux.intel.com>
 <CANc+2y4vtr+kbhC_7Rv=rHA2LgEVBHLFEu+DYYK1UmpU63PCgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANc+2y4vtr+kbhC_7Rv=rHA2LgEVBHLFEu+DYYK1UmpU63PCgQ@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 24, 2017 at 10:05:20PM +0530, PrasannaKumar Muralidharan wrote:
> > 1. Every user in the kernel is using TPM_ANY_NUM, which means there are
> >    no other users.
> 
> Completely agree that there is no in kernel users yet.

And should never be. It's a bogus parameter that makes no sense.

> > 2. Moving struct tpm_rng to the TPM client is architecturally
> >    uacceptable.
> 
> As there was no response to the patch there is no way to know whether
> it is acceptable or not.

I like the idea of removing the tpm rng driver as discussed in other
emails in this thread.

> > 3. Using zero deos not give you any better guarantees on anything than
> >    just using TPM_ANY_NUM.
> 
> Chip id is used, not zero.

Sorry I misread the patch first time. Anyway it's not any kind of ID to
be trusted.

> > Why this patch is not CC'd to linux-integrity? It modifies the TPM
> > driver. And in the worst way.
> 
> TPM list is moderated and the moderator has not approved it yet.
> get_maintainer script did not say about linux-integrity mailing list.
> 
> It could be doing things in worst way but it is not known until some
> one says. If no one tells it is the case I don't think it is possible
> to fix. Which is what happened.

Understood. We've moved to linux-integrity@vger.kernel.org. MAINTAINERS
update is in the queue for the next kernel release.

> > Implementing the ideas that Jason explained is the senseful way to
> > get stable access. modules.dep makes sure that the modules are loaded
> > in the correct order.
> 
> If that is sensible then it is the way to go.
> 
> There must be a reason to believe what is sensible and what is not.
> Looks like this RFC has helped in judging that.
> 
> Regards,
> PrasannaKumar

Would you be interested to work on patch set that would remove the
existing tpm rng driver and make the TPM driver the customer? It's not
that far away from the work you've been doing already.

/Jarkko
