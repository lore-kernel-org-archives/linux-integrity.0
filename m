Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:40148 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932543AbeCFN4N (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 08:56:13 -0500
Date: Tue, 6 Mar 2018 15:56:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] tmp: factor out tpm1_get_random into tpm1-cmd.c
Message-ID: <20180306135607.GB5700@linux.intel.com>
References: <20180306093041.11996-1-tomas.winkler@intel.com>
 <20180306093041.11996-4-tomas.winkler@intel.com>
 <1520335881.7549.9.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422F24F@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9422F24F@hasmsx108.ger.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Mar 06, 2018 at 11:34:50AM +0000, Winkler, Tomas wrote:
> 
> > 
> > On Tue, 2018-03-06 at 11:30 +0200, Tomas Winkler wrote:
> > > Factor out get random implementation from tpm-interface.c into
> > > tpm1_get_random function in tpm1-cmd.c.
> > > No functional changes.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > 
> > While you are doing this, please make it use tpm_buf so tha we get stuff out
> > of that nasty union. Using "helper" structs is still fine, just move it right
> > before the function implementation out of tpm.h (there are examples of this
> > tpm2-cmd.c).
> 
> Sure, but not while moving code, this is dangerous. Should be done after code is moved.

Makes sense have use two steps here.

/Jarkko
