Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:11329 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeJCSuY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Oct 2018 14:50:24 -0400
Date: Wed, 3 Oct 2018 15:02:15 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/21] tpm: move tpm1_pcr_extend to tpm1-cmd.c
Message-ID: <20181003120215.GB7969@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-7-tomas.winkler@intel.com>
 <20181002004248.GC23753@linux.intel.com>
 <7e42b9c4-2299-a62d-ac79-0e147cb60573@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7e42b9c4-2299-a62d-ac79-0e147cb60573@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 02, 2018 at 02:58:00PM +0530, Nayna Jain wrote:
> 
> 
> On 10/02/2018 06:12 AM, Jarkko Sakkinen wrote:
> > On Sat, Sep 29, 2018 at 01:30:20AM +0300, Tomas Winkler wrote:
> > > Move tpm1_pcr_extend to tpm1-cmd.c and remove
> > > unused pcrextend_header structure and
> > > EXTEND_PCR_RESULT_SIZE and EXTEND_PCR_RESULT_BODY_SIZE
> > > defines.
> > > 
> > > Fixes warning:
> > > drivers/char/tpm/tpm-interface.c:609:38: warning: 'pcrextend_header' defined but not used [-Wunused-const-variable=]
> > >   static const struct tpm_input_header pcrextend_header = {
> > >                                        ^~~~~~~~~~~~~~~~
> > > 
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Would need help with this from someone with a working IMA setup
> > on testing.
> 
> 
> My test system is down for now.. I think it will be up later in this week. I
> can test it then.

Thank you.

/Jarkko
