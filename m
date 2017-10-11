Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30744 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751910AbdJKLs3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2017 07:48:29 -0400
Date: Wed, 11 Oct 2017 14:48:26 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: =?iso-8859-1?B?Suly6W15?= Lefaure <jeremy.lefaure@lse.epita.fr>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/18] tpm: use ARRAY_SIZE
Message-ID: <20171011114826.kvzfweerdavsa6tf@linux.intel.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001193101.8898-14-jeremy.lefaure@lse.epita.fr>
 <20171004121449.kywykfgyxtkmu2ar@linux.intel.com>
 <20171010163011.2df093d1@blatinox-laptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171010163011.2df093d1@blatinox-laptop.localdomain>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 10, 2017 at 04:30:11PM -0400, Jeremy Lefaure wrote:
> On Wed, 4 Oct 2017 15:14:49 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > On Sun, Oct 01, 2017 at 03:30:51PM -0400, Jeremy Lefaure wrote:
> > > Using the ARRAY_SIZE macro improves the readability of the code.
> > > 
> > > Found with Coccinelle with the following semantic patch:
> > > @r depends on (org || report)@
> > > type T;
> > > T[] E;
> > > position p;
> > > @@
> > > (
> > >  (sizeof(E)@p /sizeof(*E))
> > > |
> > >  (sizeof(E)@p /sizeof(E[...]))
> > > |
> > >  (sizeof(E)@p /sizeof(T))
> > > )
> > > 
> > > Signed-off-by: Jeremy Lefaure <jeremy.lefaure@lse.epita.fr>  
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> Hi Jarkko,
> This patch is an individual patch, it's not really part of a series
> (my fault, sorry).
> 
> Could you apply this patch to your tree ?
> 
> Thank you,
> Jeremy

It is already applied :-)

I'll take it as part of my next pull request. Thank you.

/JarkkO
