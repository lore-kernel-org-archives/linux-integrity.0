Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:31972 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbeCPODo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 10:03:44 -0400
Date: Fri, 16 Mar 2018 16:03:39 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] tpm: factor out tpm1 code into tpm1-cmd.c
Message-ID: <20180316140339.GB9616@linux.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
 <ee4a88f87158e8cb38f90b955af85d68b9105a97.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94237DDA@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B94237DDA@hasmsx108.ger.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:25:48PM +0000, Winkler, Tomas wrote:
> > On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > > Move TPM1 implementation from tpm-interface.c to tpm1-cmd.c similarly
> > > to tpm2-cmd.c, as well as move TPM2 open code flows into new functions
> > > to tpm2-cmd.c The functions in tpm-interface.c should now be in form:
> > 
> > In which patch tpm1-cmd.c is created?
> 
> tpm: factor out tpm 1.2 duration calculation to tpm1-cmd.c
> 
> https://patchwork.kernel.org/patch/10259691/

Please include it to the series.

/Jarkko
