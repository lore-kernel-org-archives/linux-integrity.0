Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5303 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbeHNS4C (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Aug 2018 14:56:02 -0400
Date: Tue, 14 Aug 2018 19:07:57 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] tpm: add ptr to the tpm_space struct to file_priv
Message-ID: <20180814160757.GA14500@linux.intel.com>
References: <153419236870.8189.15489652816512817246.stgit@tstruk-mobl1.jf.intel.com>
 <153419237378.8189.17192381683473461307.stgit@tstruk-mobl1.jf.intel.com>
 <20180814160605.GC13648@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180814160605.GC13648@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Aug 14, 2018 at 07:06:05PM +0300, Jarkko Sakkinen wrote:
> On Mon, Aug 13, 2018 at 01:32:53PM -0700, Tadeusz Struk wrote:
> > Add a ptr to struct tpm_space to the file_priv to have an easy
> > access to it in the async job without the need to allocate memory.
> > This also allows to consolidate of the write operations for
> > the two interfaces.
> > 
> > Tested-by: Philip Tricca <philip.b.tricca@intel.com>
> > Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> 
> NAK
> 
> A rule thumb: do not add "links" between commits unless it is you cannot
> find any other way. The cover letter is made for describing feature or
> features that are defined a the set of commits.
                            ~~~~~
			    by a

/Jarkko
