Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:34277 "EHLO quartz.orcorp.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbdJXVfC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Oct 2017 17:35:02 -0400
Date: Tue, 24 Oct 2017 15:34:49 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
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
Message-ID: <20171024213449.GA21662@obsidianresearch.com>
References: <20171024184235.GC1806@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171024184235.GC1806@obsidianresearch.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 24, 2017 at 12:42:35PM -0600, Jason Gunthorpe wrote:

> This is compile tested only.

0day says the kconfig has a problem when randomized, here is the fix I
will roll into a v2 in a few days:

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index a95725fa77789e..ca89da3e4b2ae9 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -27,16 +27,13 @@ menuconfig TCG_TPM
 if TCG_TPM
 
 config HW_RANDOM_TPM
-       tristate "TPM HW Random Number Generator support"
-       depends on TCG_TPM && HW_RANDOM
-       default HW_RANDOM
+       bool "TPM HW Random Number Generator support"
+       depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
+       default y
        ---help---
          This driver provides kernel-side support for the Random Number
          Generator in the Trusted Platform Module
 
-         To compile this driver as a module, choose M here: the
-         module will be called tpm-rng.
-
          If unsure, say Y.
 
 config TCG_TIS_CORE
