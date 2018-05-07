Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37564 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeEGNbw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 May 2018 09:31:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id l1-v6so15468724wmb.2
        for <linux-integrity@vger.kernel.org>; Mon, 07 May 2018 06:31:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525687128.24345.3.camel@suse.com>
References: <20180504130022.5231-1-david.bild@xaptum.com> <20180504130022.5231-2-david.bild@xaptum.com>
 <1525687128.24345.3.camel@suse.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Mon, 7 May 2018 08:31:50 -0500
Message-ID: <CAAi9uDuhR+X37aedWjmrPssr4RjgzuJoJ4vL7md1fMsHq5ASJQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] usb: misc: xapea00x: add driver for Xaptum ENF
 Access Card
To: Oliver Neukum <oneukum@suse.com>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, May 7, 2018 at 4:58 AM, Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Freitag, den 04.05.2018, 08:00 -0500 schrieb  David R. Bild :
> >
> > +config USB_XAPEA00X
> > +     tristate "Xaptum ENF Access card support (XAP-EA-00x)"
> > +     depends on USB_SUPPORT && SPI && TCG_TPM
>
> You'd have to know how the device internally works. It would be better
> to select SPI.


That was my logic to Greg too. I'll change the SPI back to select.

> [..]
> > +/**
> > + * xapea00x_spi_probe - Register and configure the SPI master.
> > + * @dev: the device whose SPI master to register
> > + *
> > + * Return: If successful, 0. Otherwise a negative error number.
> > + */
> > +static int xapea00x_spi_probe(struct xapea00x_device *dev)
> > +{
> > +     struct spi_master *spi_master;
> > +     int retval;
> > +
> > +     spi_master = spi_alloc_master(&dev->interface->dev, sizeof(void *));
> > +     if (!spi_master) {
> > +             retval = -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     spi_master_set_devdata(spi_master, dev);
> > +
> > +     spi_master->min_speed_hz = 93 * 1000 + 800; /* 93.9kHz */
> > +     spi_master->max_speed_hz = 12 * 1000 * 1000; /* 12 MHz */
> > +
> > +     spi_master->bus_num = -1; /* dynamically assigned */
> > +     spi_master->num_chipselect = 1;
> > +     spi_master->mode_bits = SPI_MODE_0;
> > +
> > +     spi_master->flags = 0;
> > +     spi_master->setup = xapea00x_spi_setup;
> > +     spi_master->transfer_one_message = xapea00x_spi_transfer_one_message;
> > +
> > +     retval = spi_register_master(spi_master);
> > +
> > +     if (retval)
> > +             goto free_spi;
> > +
> > +     dev->spi_master = spi_master;
>
> Race condition.
>

What race condition do you see?  (I appreciate the review, but need
some more specific help here.)

>
> > +
> > +     return 0;
> > +
> > +free_spi:
> > +     spi_master_put(spi_master);
> > +     dev->spi_master = NULL;
> > +
> > +err_out:
> > +     return retval;
> > +}
> > +
>
> > +
> > +static struct spi_board_info tpm_board_info = {
> > +     .modalias       = XAPEA00X_TPM_MODALIAS,
> > +     .max_speed_hz   = 43 * 1000 * 1000, // Hz
>
> Are you hardcoding HZ ?


Yes. But it's the max speed of the SPI clock which is actually
specified in real HZ. It's not kernel "HZ".

Thanks for the other comments too; I'll incorporate into the next version.

Best,
David
