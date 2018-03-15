Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:28910 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbeCOXY2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 19:24:28 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/8] tpm: factor out tpm1_get_random into tpm1-cmd.c
Date: Thu, 15 Mar 2018 23:24:23 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94237DCA@hasmsx108.ger.corp.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-4-tomas.winkler@intel.com>
 <9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
In-Reply-To: <9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> 
> On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > +		rlength = be32_to_cpu(tpm_cmd.header.out.length);
> > +		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> > +			      recd) {
> > +			total = -EFAULT;
> > +			break;
> > +		}
> > +		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data,
> recd);
> 
> This rlength stuff can be handled with tpm_buf_length() as I do in my
> pendig-for-review patch set:
> 
> https://patchwork.kernel.org/patch/10259331/

Right, as I wrote before not sure it's good to move and change the code more than necessary at the same time. 
I would leave the tpm_buf_ changes after this series. 

Thanks
Tomas
