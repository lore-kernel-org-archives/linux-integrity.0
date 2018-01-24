Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61362 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932537AbeAXV3X (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jan 2018 16:29:23 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] tpm: add longer timeouts for creation commands.
Date: Wed, 24 Jan 2018 21:29:19 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94203937@hasmsx108.ger.corp.intel.com>
References: <20180123112731.3687-1-tomas.winkler@intel.com>
 <20180123112731.3687-3-tomas.winkler@intel.com>
 <20180123131203.bdhlqdqabhtwnipi@linux.intel.com>
In-Reply-To: <20180123131203.bdhlqdqabhtwnipi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Tuesday, January 23, 2018 15:12
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>; Usyskin,
> Alexander <alexander.usyskin@intel.com>; tpmdd-
> devel@lists.sourceforge.net; linux-integrity@vger.kernel.org; linux-security-
> module@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3] tpm: add longer timeouts for creation commands.
> 
> On Tue, Jan 23, 2018 at 01:27:31PM +0200, Tomas Winkler wrote:
> > TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve
> > generation of crypto keys which can be a computationally intensive task.
> > The timeout is set to 3min.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> From where are these numbers are derived from?

An Intel SW architect.
 
> 
> Can you send 1/3 and 2/3 as a separate patch set with a cover letter (with
> explanation) and this as a separate patch? This is unrelated to first two
> changes albeit might make sense.

Will do, though the patches were born to  address the initialization issues we've encountered.
Thanks
Tomas
