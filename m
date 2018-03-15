Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:58546 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbeCOXZx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 19:25:53 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] tpm: factor out tpm1 code into tpm1-cmd.c
Date: Thu, 15 Mar 2018 23:25:48 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94237DDA@hasmsx108.ger.corp.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
 <ee4a88f87158e8cb38f90b955af85d68b9105a97.camel@linux.intel.com>
In-Reply-To: <ee4a88f87158e8cb38f90b955af85d68b9105a97.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > Move TPM1 implementation from tpm-interface.c to tpm1-cmd.c similarly
> > to tpm2-cmd.c, as well as move TPM2 open code flows into new functions
> > to tpm2-cmd.c The functions in tpm-interface.c should now be in form:
> 
> In which patch tpm1-cmd.c is created?

tpm: factor out tpm 1.2 duration calculation to tpm1-cmd.c

https://patchwork.kernel.org/patch/10259691/

> 
> /Jarkko
