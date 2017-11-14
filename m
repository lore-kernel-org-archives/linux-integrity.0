Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:22525 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754612AbdKNO1K (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Nov 2017 09:27:10 -0500
Date: Tue, 14 Nov 2017 16:27:06 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Update MAINTAINERS for Jason Gunthorpe
Message-ID: <20171114142706.nqin45kx7rhbbkfb@linux.intel.com>
References: <20171031202357.GA1030@ziepe.ca>
 <20171103142841.2nphkjojzamrdezm@linux.intel.com>
 <0812DDC3-187D-4F29-BFB5-9A4F509CA376@gmx.de>
 <20171107150356.uln3lks64zt5oxjv@linux.intel.com>
 <20171108063640.kxwag6fzguetpjnf@linux.intel.com>
 <E803B459-CB11-4E23-B3BC-4DEF2A0C40B6@gmx.de>
 <20171108222434.GF7063@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171108222434.GF7063@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 08, 2017 at 03:24:34PM -0700, Jason Gunthorpe wrote:
> On Wed, Nov 08, 2017 at 10:27:37AM +0100, Peter Huewe wrote:
> 
> > >Updating that file goes out of my territory other than acking the
> > >updates. 
> 
> > Imho not really, since there is no MAINTAINERS maintainer.  If you
> > feel uncomfortable with adding the changes to MAINTAINERS via your
> > tree, please ask James to pull them up - just as Mimi did for her
> > linux-integrity update.
> 
> Agreed, if you are submitting pull requests then the MAINTAINERS
> update for TPM related things should go into your pull request. That
> is appropriate..
> 
> It isn't necessary for everything to be cc'd everywhere, ultimately it
> is your responsibility as the TPM maintainer to accept/reject this
> change.
> 
> If it was a larger change, like adding/removing a maintainer then a
> large audiance would be appropriate, but this is just changing
> spelling and the patch was PGP signed ..
> 
> Jason

Agreed. I'll apply this after my previous change is available.

/Jarkko
