Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:11398 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbeJDSik (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Oct 2018 14:38:40 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>
Subject: RE: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Date: Thu, 4 Oct 2018 11:45:30 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9E6D00@hasmsx109.ger.corp.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
 <20181003120141.GA7969@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E5343@hasmsx109.ger.corp.intel.com>
 <20181004113502.GA12498@linux.intel.com>
In-Reply-To: <20181004113502.GA12498@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Thursday, October 04, 2018 14:35
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; Nayna Jain
> <nayna@linux.vnet.ibm.com>; Usyskin, Alexander
> <alexander.usyskin@intel.com>; Struk, Tadeusz <tadeusz.struk@intel.com>;
> linux-integrity@vger.kernel.org; linux-security-module@vger.kernel.org;
> linux-kernel@vger.kernel.org; roberto.sassu@huawei.com
> Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
> 
> On Wed, Oct 03, 2018 at 10:24:09PM +0000, Winkler, Tomas wrote:
> >
> >
> > > -----Original Message-----
> > > From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> > > Sent: Wednesday, October 03, 2018 15:02
> > > To: Winkler, Tomas <tomas.winkler@intel.com>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>; Nayna Jain
> > > <nayna@linux.vnet.ibm.com>; Usyskin, Alexander
> > > <alexander.usyskin@intel.com>; Struk, Tadeusz
> > > <tadeusz.struk@intel.com>; linux-integrity@vger.kernel.org;
> > > linux-security-module@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; roberto.sassu@huawei.com
> > > Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to
> > > tpm2-cmd.c
> > >
> > > On Tue, Oct 02, 2018 at 04:58:25AM +0000, Winkler, Tomas wrote:
> > > >
> > > >
> > > > >
> > > > > On Sat, Sep 29, 2018 at 01:30:26AM +0300, Tomas Winkler wrote:
> > > > > > Add tpm2_pcr_extend() function to tpm2-cmd.c with signature
> > > > > > required by tpm-interface.c. It wraps the original open code
> > > implementation.
> > > > > > The original original tpm2_pcr_extend() function is renamed to
> > > > > > __tpm2_pcr_extend() and made static, it is called only from
> > > > > > new tpm2_pcr_extend().
> > > > > >
> > > > > > Fix warnings in __tpm2_pcr_extend()
> > > > > > tpm2-cmd.c:251:16: warning: comparison between signed and
> > > > > > unsigned integer expressions [-Wsign-compare]
> > > > > > tpm2-cmd.c:252:17: warning: comparison between signed and
> > > > > > unsigned integer expressions [-Wsign-compare]
> > > > > >
> > > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > >
> > > > > We do not want the signature change, especially because as we
> > > > > are working on getting Roberto's changes in and also because it
> > > > > has absolutely a zero gain. Who cares if those functions take
> > > > > different
> > > parameters? I don't.
> > > >
> > > > Yes, we do care this series tries to have a clean cut between 1.x
> > > > and 2.x
> > > specs. Please, let's finish one transformation and then move to another.
> > > > I understand that Roberto will have to rebase anyhow, if this
> > > > series goes in
> > > first, if this is hard I can do it myself, it's trivial.
> > > >
> > > > Tomas
> > >
> > > I'm happy to tune this minor stuff.
> > What minor stuff?  This patch is just okay, let's change the API in next
> round.
> 
> The patch is not okay because it does a completely unnecessary API change.
 
There is no API change, in that sense.
The exported API is in tpm-interface.c int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)  
that is used is outside of the tpm reminds the same, only the open coded implementation of tpm2_pcr_extned has moved to
tpm2-cmd.c, This code is not called out of tpm module.
Please review the code again.

Thanks
Tomas
