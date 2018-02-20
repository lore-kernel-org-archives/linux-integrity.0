Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34588 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751422AbeBTXJy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 18:09:54 -0500
Message-ID: <1519168191.4446.31.camel@HansenPartnership.com>
Subject: Re: [PATCH v3] tpm: fix intermittent failure with self tests
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org
Date: Tue, 20 Feb 2018 18:09:51 -0500
In-Reply-To: <20180220212847.il76cysi3t4ibhhi@linux.intel.com>
References: <1519043040.4721.5.camel@HansenPartnership.com>
         <1519148635.6941.5.camel@linux.intel.com>
         <1519149111.4446.11.camel@HansenPartnership.com>
         <20180220192600.gvlfgs5bw6ve563l@linux.intel.com>
         <20180220212725.gwqi3w6lua527yu5@linux.intel.com>
         <20180220212847.il76cysi3t4ibhhi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-02-20 at 23:28 +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 20, 2018 at 11:27:25PM +0200, Jarkko Sakkinen wrote:
> > 
> > On Tue, Feb 20, 2018 at 09:26:00PM +0200, Jarkko Sakkinen wrote:
> > > 
> > > On Tue, Feb 20, 2018 at 12:51:51PM -0500, James Bottomley wrote:
> > > > 
> > > > On Tue, 2018-02-20 at 19:43 +0200, Jarkko Sakkinen wrote:
> > > > > 
> > > > > I get merge conflicts in my tree but I'll review this.
> > > > 
> > > > You told me to rebase it on that patch that wasn't in your
> > > > tree:
> > > > 
> > > > https://patchwork.kernel.org/patch/10208965/
> > > > 
> > > > If you put it in your tree, I can just rebase on top of
> > > > everything.
> > > > 
> > > > James
> > > 
> > > Aah. Sorry, my bad I'll move forward on testing :-)
> > > 
> > > /Jarkko
> > 
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > /Jarkko
> 
> These must be taken away:
> 
> [    2.843641] tpm tpm0: TPM: running incremental selftest
> [    2.854087] tpm tpm0: TPM: selftest succeeded

I'm not wedded to having the messages, but it helps give context when
something like this happens:

[    1.550099] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[    1.550108] tpm tpm0: TPM: running incremental selftest
[    1.602294] tpm tpm0: A TPM error (323) occurred incremental selftest
[    1.602320] tpm tpm0: TPM: incremental selftest failed
[    1.602322] tpm tpm0: TPM: running full selftest
[    2.523689] tpm tpm0: TPM: selftest succeeded

It also helps explain why I lost a second in the boot sequence to the
TPM having to run a full self test.

Without the chatty messages, what you see is 

[    1.550099] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[
    1.602294] tpm tpm0: A TPM error (323) occurred incremental selftest

Which is a bit harder to interpret.

James
