Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:38243 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeJKT2w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 15:28:52 -0400
Date: Thu, 11 Oct 2018 15:01:40 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Message-ID: <20181011120140.GA15767@linux.intel.com>
References: <20181010133817.GA11485@embeddedor.com>
 <20181010140638.GA3894@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181010140638.GA3894@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 10, 2018 at 08:06:38AM -0600, Jason Gunthorpe wrote:
> On Wed, Oct 10, 2018 at 03:38:17PM +0200, Gustavo A. R. Silva wrote:
> > Currently, there are some values assigned to variable *rc*, which
> > are never actually used in any computation, because such variable
> > is updated at line 550, before they can be used:
> > 
> > 549out:
> > 550        rc = tpm_go_idle(chip, flags);
> > 551        if (rc)
> > 552                goto out;
> > 
> > Fix this by removing such assignments. 
> 
> Should this be done by not quashing rc during the error unwind rather
> than dropping the errors?

Yeah.`

Wondering if tpm_go_idle() should simply be a void-function i.e. issue
just a warning inside (disclaimer: did not revisit its code when writing
this).

> Jason

/Jarkko
