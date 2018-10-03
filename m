Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:43142 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeJCSuL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Oct 2018 14:50:11 -0400
Date: Wed, 3 Oct 2018 15:01:41 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Message-ID: <20181003120141.GA7969@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 02, 2018 at 04:58:25AM +0000, Winkler, Tomas wrote:
> 
> 
> > 
> > On Sat, Sep 29, 2018 at 01:30:26AM +0300, Tomas Winkler wrote:
> > > Add tpm2_pcr_extend() function to tpm2-cmd.c with signature required
> > > by tpm-interface.c. It wraps the original open code implementation.
> > > The original original tpm2_pcr_extend() function is renamed to
> > > __tpm2_pcr_extend() and made static, it is called only from new
> > > tpm2_pcr_extend().
> > >
> > > Fix warnings in __tpm2_pcr_extend()
> > > tpm2-cmd.c:251:16: warning: comparison between signed and unsigned
> > > integer expressions [-Wsign-compare]
> > > tpm2-cmd.c:252:17: warning: comparison between signed and unsigned
> > > integer expressions [-Wsign-compare]
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > 
> > We do not want the signature change, especially because as we are working
> > on getting Roberto's changes in and also because it has absolutely a zero
> > gain. Who cares if those functions take different parameters? I don't.
> 
> Yes, we do care this series tries to have a clean cut between 1.x  and 2.x specs. Please, let's finish one transformation and then move to another.
> I understand that Roberto will have to rebase anyhow, if this series goes in first, if this is hard I can do it myself, it's trivial.
> 
> Tomas

I'm happy to tune this minor stuff. I'll wait for Nayna to test
the one patch and make those adjustments :-) Would not make sense
to roll another series for these changes.

/Jarkko
