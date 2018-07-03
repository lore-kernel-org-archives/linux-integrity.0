Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:31614 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGCQcN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jul 2018 12:32:13 -0400
Message-ID: <1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
Subject: Re: [PATCH] ima: Use tpm_default_chip() and call TPM functions with
 a tpm_chip
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Tue, 03 Jul 2018 19:32:07 +0300
In-Reply-To: <1530550839.3709.46.camel@linux.vnet.ibm.com>
References: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
         <1530550839.3709.46.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-07-02 at 13:00 -0400, Mimi Zohar wrote:
> On Mon, 2018-07-02 at 11:24 -0400, Stefan Berger wrote:
> > Rather than accessing the TPM functions by passing a NULL pointer for
> > the tpm_chip, which causes a lookup for a suitable chip every time, get a
> > hold of a tpm_chip and access the TPM functions using it. Also get rid of
> > the ima_used_chip variable and use the new ima_tpm_chip variable instead
> > for determining whether to call TPM functions.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Jarkko, would you mind staging this patch with the rest of the patch
> set?

Yes, sure, I can do that. Any additional tag?

/Jarkko
