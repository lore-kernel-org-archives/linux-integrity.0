Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54591 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeBUHZW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Feb 2018 02:25:22 -0500
Date: Wed, 21 Feb 2018 09:25:18 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: fix intermittent failure with self tests
Message-ID: <20180221072518.emmos62oegedw7rz@linux.intel.com>
References: <1519043040.4721.5.camel@HansenPartnership.com>
 <1519148635.6941.5.camel@linux.intel.com>
 <1519149111.4446.11.camel@HansenPartnership.com>
 <20180220192600.gvlfgs5bw6ve563l@linux.intel.com>
 <20180220212725.gwqi3w6lua527yu5@linux.intel.com>
 <20180220212847.il76cysi3t4ibhhi@linux.intel.com>
 <1519168191.4446.31.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1519168191.4446.31.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Feb 20, 2018 at 06:09:51PM -0500, James Bottomley wrote:
> On Tue, 2018-02-20 at 23:28 +0200, Jarkko Sakkinen wrote:
> > On Tue, Feb 20, 2018 at 11:27:25PM +0200, Jarkko Sakkinen wrote:
> > > 
> > > On Tue, Feb 20, 2018 at 09:26:00PM +0200, Jarkko Sakkinen wrote:
> > > > 
> > > > On Tue, Feb 20, 2018 at 12:51:51PM -0500, James Bottomley wrote:
> > > > > 
> > > > > On Tue, 2018-02-20 at 19:43 +0200, Jarkko Sakkinen wrote:
> > > > > > 
> > > > > > I get merge conflicts in my tree but I'll review this.
> > > > > 
> > > > > You told me to rebase it on that patch that wasn't in your
> > > > > tree:
> > > > > 
> > > > > https://patchwork.kernel.org/patch/10208965/
> > > > > 
> > > > > If you put it in your tree, I can just rebase on top of
> > > > > everything.
> > > > > 
> > > > > James
> > > > 
> > > > Aah. Sorry, my bad I'll move forward on testing :-)
> > > > 
> > > > /Jarkko
> > > 
> > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > /Jarkko
> > 
> > These must be taken away:
> > 
> > [    2.843641] tpm tpm0: TPM: running incremental selftest
> > [    2.854087] tpm tpm0: TPM: selftest succeeded
> 
> I'm not wedded to having the messages, but it helps give context when
> something like this happens:
> 
> [    1.550099] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [    1.550108] tpm tpm0: TPM: running incremental selftest
> [    1.602294] tpm tpm0: A TPM error (323) occurred incremental selftest
> [    1.602320] tpm tpm0: TPM: incremental selftest failed
> [    1.602322] tpm tpm0: TPM: running full selftest
> [    2.523689] tpm tpm0: TPM: selftest succeeded
> 
> It also helps explain why I lost a second in the boot sequence to the
> TPM having to run a full self test.
> 
> Without the chatty messages, what you see is 
> 
> [    1.550099] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [
>     1.602294] tpm tpm0: A TPM error (323) occurred incremental selftest
> 
> Which is a bit harder to interpret.
> 
> James

Way too much bloat to klog. Telling whether the full or incremental test
failed makes sense. Otherwise, not so much.

I updated the patch (v4) with things cleaned up that add bloat to the
driver code and squashed tpm_buf patch to it.

/Jarkko
