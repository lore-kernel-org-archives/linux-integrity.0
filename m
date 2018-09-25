Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:64113 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbeIYUgE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Sep 2018 16:36:04 -0400
Message-ID: <54bbc3719576bf3365aea5992fe49cbc6b02e3b6.camel@linux.intel.com>
Subject: Re: [PATCH v4 20/21] tpm1: reimplement tpm1_continue_selftest()
 using tpm_buf
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Sep 2018 17:28:13 +0300
In-Reply-To: <ca7221f592cfcdc312fe1ec72623f118dfa21788.camel@linux.intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
         <20180921135820.20549-21-tomas.winkler@intel.com>
         <5f142a3b-15b8-368b-19e5-5926b20addfd@linux.vnet.ibm.com>
         <ca7221f592cfcdc312fe1ec72623f118dfa21788.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-09-25 at 17:25 +0300, Jarkko Sakkinen wrote:
> On Tue, 2018-09-25 at 15:53 +0530, Nayna Jain wrote:
> > > +
> > > +	rc = tpm_transmit_cmd(chip, NULL, &buf.data, PAGE_SIZE,
> > 
> > I think this needs to buf.data instead of &buf.data
> > 
> > Thanks & Regards,
> >       - Nayna
> 
> You are absolutely right. Thank you.

Had to backtrack what I was doing wrong last time because the commit
has my tested-by and noticed that I did not have this one applied. I
tested this now by doing the change that you suggested and seems to
work.

/Jarkko
