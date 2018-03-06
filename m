Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35300 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFLVJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 06:21:09 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/6] tpm: factor out tpm 1.2 duration calculation to
 tpm1-cmd.c
Date: Tue, 6 Mar 2018 11:21:04 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F21B@hasmsx108.ger.corp.intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
         <20180305202017.24008-3-tomas.winkler@intel.com>
 <1520335194.7549.7.camel@linux.intel.com>
In-Reply-To: <1520335194.7549.7.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> 
> On Mon, 2018-03-05 at 22:20 +0200, Tomas Winkler wrote:
> > Factor out tpm1.2 commands calculation into tpm1-cmd.c file.
> > and change the prefix from tpm_ to tpm1_.
> > No functional change is done here.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> This a good idea but can you go on and move all TPM 1.x stuff to this new
> file while you are doing it?

Yes, see the next patch series.
Tomas
