Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56559 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeBTV13 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 16:27:29 -0500
Date: Tue, 20 Feb 2018 23:27:25 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: fix intermittent failure with self tests
Message-ID: <20180220212725.gwqi3w6lua527yu5@linux.intel.com>
References: <1519043040.4721.5.camel@HansenPartnership.com>
 <1519148635.6941.5.camel@linux.intel.com>
 <1519149111.4446.11.camel@HansenPartnership.com>
 <20180220192600.gvlfgs5bw6ve563l@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180220192600.gvlfgs5bw6ve563l@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Feb 20, 2018 at 09:26:00PM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 20, 2018 at 12:51:51PM -0500, James Bottomley wrote:
> > On Tue, 2018-02-20 at 19:43 +0200, Jarkko Sakkinen wrote:
> > > I get merge conflicts in my tree but I'll review this.
> > 
> > You told me to rebase it on that patch that wasn't in your tree:
> > 
> > https://patchwork.kernel.org/patch/10208965/
> > 
> > If you put it in your tree, I can just rebase on top of everything.
> > 
> > James
> 
> Aah. Sorry, my bad I'll move forward on testing :-)
> 
> /Jarkko

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
