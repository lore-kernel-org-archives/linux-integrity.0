Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:49650 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeEMIrA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 May 2018 04:47:00 -0400
Date: Sun, 13 May 2018 11:46:55 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "David R. Bild" <david.bild@xaptum.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        philip.b.tricca@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Message-ID: <20180513084655.GA19023@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
 <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com>
 <CAAi9uDtt=U_7uSVrxBkC_-ZLobU9WiA4UxuN0pJk18b0Rhv+Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAi9uDtt=U_7uSVrxBkC_-ZLobU9WiA4UxuN0pJk18b0Rhv+Lg@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 10, 2018 at 09:41:53AM -0500, David R. Bild wrote:
> 2) Make more of the TPM driver API public (internally public) so that
> the driver can reuse that code instead of reimplementing.  Not ideal,
> as this could require major restructuring of the TPM code.

Can you open this up a bit? It depends what this means in practice.

/Jarkko
