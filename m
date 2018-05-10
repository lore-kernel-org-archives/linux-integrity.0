Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:5172 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756379AbeEJBjb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 21:39:31 -0400
Date: Thu, 10 May 2018 04:39:25 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Thiebaud Weksteen <tweek@google.com>, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ltp <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH v2 2/4] tpm: Move eventlog files to a subdirectory
Message-ID: <20180510013925.GJ6190@linux.intel.com>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-3-tweek@google.com>
 <20180420053926.GB15364@linux.intel.com>
 <1525725397.3551.10.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1525725397.3551.10.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, May 07, 2018 at 04:36:37PM -0400, Mimi Zohar wrote:
> [Cc'ing Petr Vorel and the ltp mailing list]
> 
> Hi Jarrko,
> 
> On Fri, 2018-04-20 at 08:39 +0300, Jarkko Sakkinen wrote:
> > On Thu, Apr 12, 2018 at 12:13:48PM +0200, Thiebaud Weksteen wrote:
> > > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> I just noticed this is queued in your next branch.
> 
> Petr Vorel has been updating the IMA LTP tests.  One of those IMA LTP
> tests includes walking the TPM binary_runtime_measurements in order to
> calculate the IMA boot-aggregate.  The IMA boot-aggregate is the first
> measurement in the IMA measurement list.
> 
> Mimi

Sorry, not following how these connect directly?

/Jarkko
