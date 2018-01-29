Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53614 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbeA2Ioq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jan 2018 03:44:46 -0500
Date: Mon, 29 Jan 2018 10:44:41 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "tpmdd-devel@lists.sourceforge.net"
        <tpmdd-devel@lists.sourceforge.net>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: cmd_ready command can be issued only after
 granting locality
Message-ID: <20180129084441.6oc4m4jgbqzsfq3v@linux.intel.com>
References: <20180123112731.3687-1-tomas.winkler@intel.com>
 <20180123125426.t6xjgrqcfbkmvkdl@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94203771@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B94203771@hasmsx108.ger.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jan 24, 2018 at 06:33:53PM +0000, Winkler, Tomas wrote:
> > > -	pm_runtime_put(dev);
> > > +	pm_runtime_put_sync(dev);
> > 
> > Change to put_sync is needed so that the idle handshake gets completed?
> 
> Right.

Since we seem to agree that your change to get rid of the use of PM
runtime should that be actually the first change in the patch set?

Or are you looking forward to get these backported to stable kernels?

/Jarkko
