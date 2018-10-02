Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40244 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeJBLlm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Oct 2018 07:41:42 -0400
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
Date: Tue, 2 Oct 2018 04:58:25 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
In-Reply-To: <20181002005208.GH23753@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> 
> On Sat, Sep 29, 2018 at 01:30:26AM +0300, Tomas Winkler wrote:
> > Add tpm2_pcr_extend() function to tpm2-cmd.c with signature required
> > by tpm-interface.c. It wraps the original open code implementation.
> > The original original tpm2_pcr_extend() function is renamed to
> > __tpm2_pcr_extend() and made static, it is called only from new
> > tpm2_pcr_extend().
> >
> > Fix warnings in __tpm2_pcr_extend()
> > tpm2-cmd.c:251:16: warning: comparison between signed and unsigned
> > integer expressions [-Wsign-compare]
> > tpm2-cmd.c:252:17: warning: comparison between signed and unsigned
> > integer expressions [-Wsign-compare]
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> We do not want the signature change, especially because as we are working
> on getting Roberto's changes in and also because it has absolutely a zero
> gain. Who cares if those functions take different parameters? I don't.

Yes, we do care this series tries to have a clean cut between 1.x  and 2.x specs. Please, let's finish one transformation and then move to another.
I understand that Roberto will have to rebase anyhow, if this series goes in first, if this is hard I can do it myself, it's trivial.

Tomas
