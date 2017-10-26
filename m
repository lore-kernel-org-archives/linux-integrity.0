Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11667 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932141AbdJZKyj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2017 06:54:39 -0400
Date: Thu, 26 Oct 2017 12:54:30 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Huewe <peterhuewe@gmx.de>,
        Marcel Selhorst <tpmdd@selhorst.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <james.l.morris@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Safford <safford@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:TPM DEVICE DRIVER"
        <tpmdd-devel@lists.sourceforge.net>,
        "open list:INTEGRITY MEASUREMENT ARCHITECTURE (IMA)"
        <linux-ima-devel@lists.sourceforge.net>,
        "open list:INTEGRITY MEASUREMENT ARCHITECTURE (IMA)"
        <linux-ima-user@lists.sourceforge.net>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: use struct tpm_chip for tpm_chip_find_get()
Message-ID: <20171026105430.t6khk6cekk3cyfrs@linux.intel.com>
References: <20171025115508.5682-1-jarkko.sakkinen@linux.intel.com>
 <CANc+2y46q85+G1=9cXKW0R8FpGBqCuzkLnJzvSYFQ1S=ztKGew@mail.gmail.com>
 <20171025193452.d4qa4dhacfgqejk7@linux.intel.com>
 <20171025194633.GB998@obsidianresearch.com>
 <20171025200746.svsraubdotjyzt2i@linux.intel.com>
 <20171025201744.GB2815@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171025201744.GB2815@obsidianresearch.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 25, 2017 at 02:17:44PM -0600, Jason Gunthorpe wrote:
> On Wed, Oct 25, 2017 at 10:07:46PM +0200, Jarkko Sakkinen wrote:
> 
> > The id has a nice feature that it is unique for one boot cycle you can
> > even try to get a chip that has been deleted. It has the most stable
> > properties in the long run.
> 
> It isn't unique, we can re-use ids them via idr_alloc(). We should
> never use index inside the kernel.
> 
> > Address is a reusable identifier in one boot cycle.
> 
> It is invalid to pass in a chip for which the caller does not hold a
> kref, so address is the safest argument.
> 
> Jason

I'll buy this too (sending update today).

/Jarkko
