Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:54615 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbeHXJ6I (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Aug 2018 05:58:08 -0400
Date: Fri, 24 Aug 2018 09:24:34 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Howells <dhowells@redhat.com>, denkenz@gmail.com,
        jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/23] TPM: Add new TPMs to the tail of the list to
 prevent inadvertent change of dev
Message-ID: <20180824062434.GB3584@linux.intel.com>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
 <20180821183004.GB25543@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180821183004.GB25543@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Aug 21, 2018 at 12:30:04PM -0600, Jason Gunthorpe wrote:
> On Tue, Aug 21, 2018 at 04:56:56PM +0100, David Howells wrote:
> > Add newly registered TPMs to the tail of the list, not the beginning, so that
> > things that are specifying TPM_ANY_NUM don't find that the device they're
> > using has inadvertently changed.  Adding a second device would break IMA, for
> > instance.
> > 
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> > cc: stable@vger.kernel.org
> > ---
> 
> We really should apply this patch...
> 
> Jason

This is the first time I remember seeing it.

/Jarkko
