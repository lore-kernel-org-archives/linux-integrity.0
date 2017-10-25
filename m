Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:42495 "EHLO quartz.orcorp.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932162AbdJYUR7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 16:17:59 -0400
Date: Wed, 25 Oct 2017 14:17:44 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
Message-ID: <20171025201744.GB2815@obsidianresearch.com>
References: <20171025115508.5682-1-jarkko.sakkinen@linux.intel.com>
 <CANc+2y46q85+G1=9cXKW0R8FpGBqCuzkLnJzvSYFQ1S=ztKGew@mail.gmail.com>
 <20171025193452.d4qa4dhacfgqejk7@linux.intel.com>
 <20171025194633.GB998@obsidianresearch.com>
 <20171025200746.svsraubdotjyzt2i@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171025200746.svsraubdotjyzt2i@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 25, 2017 at 10:07:46PM +0200, Jarkko Sakkinen wrote:

> The id has a nice feature that it is unique for one boot cycle you can
> even try to get a chip that has been deleted. It has the most stable
> properties in the long run.

It isn't unique, we can re-use ids them via idr_alloc(). We should
never use index inside the kernel.

> Address is a reusable identifier in one boot cycle.

It is invalid to pass in a chip for which the caller does not hold a
kref, so address is the safest argument.

Jason
