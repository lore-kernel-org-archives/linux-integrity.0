Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50980 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENTcE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 15:32:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id t11-v6so15498195wmt.0
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 12:32:03 -0700 (PDT)
Date: Mon, 14 May 2018 13:31:57 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David R. Bild" <david.bild@xaptum.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        philip.b.tricca@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Message-ID: <20180514193157.GA21531@ziepe.ca>
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

> 3) Allow the driver to register the TPM with TPM driver, but not yet
> expose the TPM to userspace.  Let the driver do some additional work
> (like set the platform hierarchy password) and then explicitly inform
> the TPM driver that it is safe to expose the TPM to userspace.  This
> would be my preferred approach.

We already have this. The driver can setup enough to use the TPM
framework to send commands before completing registration. We use it
in startup timeouts and other flows today.

Jason
