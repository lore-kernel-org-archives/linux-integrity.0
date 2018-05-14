Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46213 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeENT7h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 15:59:37 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so13579410wrn.13
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 12:59:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514193157.GA21531@ziepe.ca>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca> <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com> <CAAi9uDtt=U_7uSVrxBkC_-ZLobU9WiA4UxuN0pJk18b0Rhv+Lg@mail.gmail.com>
 <20180514193157.GA21531@ziepe.ca>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Mon, 14 May 2018 14:59:36 -0500
Message-ID: <CAAi9uDvwqFT_nrq1FLM7QiMhUXXLTE4fx7+3HpMXbgp1nW7gOg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        philip.b.tricca@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, May 14, 2018 at 2:31 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, May 10, 2018 at 09:41:53AM -0500, David R. Bild wrote:
>
> > 3) Allow the driver to register the TPM with TPM driver, but not yet
> > expose the TPM to userspace.  Let the driver do some additional work
> > (like set the platform hierarchy password) and then explicitly inform
> > the TPM driver that it is safe to expose the TPM to userspace.  This
> > would be my preferred approach.
>
> We already have this. The driver can setup enough to use the TPM
> framework to send commands before completing registration. We use it
> in startup timeouts and other flows today.


That sounds perfect.  Can you point me to some usages in the code (or
relevant functions)?

This driver registers with the TPM subsystem using the "tpm_tis_spi"
driver like this:

"
  static struct spi_board_info tpm_board_info = {
      .modalias           = "tpm_tis_spi",
      .max_speed_hz = 43 * 1000 * 1000, // Hz
      .chip_select       = 0,
      .mode                = SPI_MODE_0
  };

  struct spi_device *tpm = spi_new_device(spi_master, &tpm_board_info);
"

I don't see how sending of commands before completing registration.
At the very least, the "tpm_tis_spi" driver probably has to be
changed?

Best,
David
