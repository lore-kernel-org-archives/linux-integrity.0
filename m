Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52609 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932226AbeFUR4H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 13:56:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so6544814wmb.2
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jun 2018 10:56:06 -0700 (PDT)
Date: Thu, 21 Jun 2018 11:56:01 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180621175601.GC19270@ziepe.ca>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180621171518.GI11859@linux.intel.com>
 <95b2970f-b71b-4cfc-c188-7ae7e8cb94c5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95b2970f-b71b-4cfc-c188-7ae7e8cb94c5@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Jun 21, 2018 at 01:45:03PM -0400, Stefan Berger wrote:
> On 06/21/2018 01:15 PM, Jarkko Sakkinen wrote:
> >On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> >>Implement tpm_chip_find() for other subsystems to find a TPM chip and
> >>get a reference to that chip. Once done with using the chip, the reference
> >>is released using tpm_chip_put().
> >>
> >>Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >You should sort this out in a way that we don't end up with duplicate
> >functions.
> 
> Do you want me to create a function *like* tpm_chip_find_get() that takes an
> additional parameter whether to get the ops semaphore and have that function
> called by the existing tpm_chip_find_get() and the new tpm_chip_find(). The
> latter would then not get the ops semphore. I didn't want to do this since
> one time the function returns with a lock held and the other time not.

Another option, and I haven't looked, is to revise the callers of
tpm_chip_find_get to not require it to hold the ops semaphore for
them.

Either by giving them an API to do it, or revising the TPM entry
points to do it.

I didn't look, but how did the ops semaphore get grabbed in your
revised patches? They do grab it, right?

Jason
