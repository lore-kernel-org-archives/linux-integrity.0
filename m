Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23762 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbdJYS6W (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 14:58:22 -0400
Date: Wed, 25 Oct 2017 20:58:17 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Matt Mackall <mpm@selenic.com>,
        David Safford <safford@us.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] tpm: Move Linux RNG connection to hwrng
Message-ID: <20171025185817.hoalqzud3646yuy7@linux.intel.com>
References: <20171024184235.GC1806@obsidianresearch.com>
 <CANc+2y5q78g1Ow1JQ7kO0SkPrgNtbRV=COkB4YLHbSraTQH7aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANc+2y5q78g1Ow1JQ7kO0SkPrgNtbRV=COkB4YLHbSraTQH7aQ@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 25, 2017 at 08:15:09PM +0530, PrasannaKumar Muralidharan wrote:
> > +       if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> > +               return 0;
> 
> Can #ifndef CONFIG_HW_RANDOM_TPM be used instead? That way an if
> condition can be avoided.

Nope. There is no reason to avoid the if-condition. Compiler will take
care of it. IS_ENABLED() macro is available just for the purpose Jason
is using it.

> > +       char tpm_hwrng_name[64];
> > +       struct hwrng tpm_hwrng;
> > +
> 
> Can this also be put inside the #ifdef?

Yes. It should be inside #ifdef.

/Jarkko
