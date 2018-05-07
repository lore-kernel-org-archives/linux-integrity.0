Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeEGKFY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 May 2018 06:05:24 -0400
Message-ID: <1525687128.24345.3.camel@suse.com>
Subject: Re: [PATCH v3 1/2] usb: misc: xapea00x: add driver for Xaptum ENF
 Access Card
From: Oliver Neukum <oneukum@suse.com>
To: "David R. Bild" <david.bild@xaptum.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-integrity@vger.kernel.org, linux-usb@vger.kernel.org
Date: Mon, 07 May 2018 11:58:48 +0200
In-Reply-To: <20180504130022.5231-2-david.bild@xaptum.com>
References: <20180504130022.5231-1-david.bild@xaptum.com>
         <20180504130022.5231-2-david.bild@xaptum.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Am Freitag, den 04.05.2018, 08:00 -0500 schrieb  David R. Bild :
> 
> +config USB_XAPEA00X
> +	tristate "Xaptum ENF Access card support (XAP-EA-00x)"
> +	depends on USB_SUPPORT && SPI && TCG_TPM

You'd have to know how the device internally works. It would be better
to select SPI.

> +static int xapea00x_br_bulk_write(struct xapea00x_device *dev,
> +				  struct xapea00x_br_bulk_command *header,
> +				  const void *data, int len)
> +{
> +	u8 *buf;
> +	unsigned int pipe;
> +	int buf_len, actual_len, retval;
> +
> +	buf_len = sizeof(struct xapea00x_br_bulk_command) + len;
> +	buf = kzalloc(buf_len, GFP_KERNEL);
> +	if (!buf) {
> +		retval = -ENOMEM;
> +		goto out;
> +	}
> +
> +	memcpy(buf, header, sizeof(struct xapea00x_br_bulk_command));
> +	memcpy(buf + sizeof(struct xapea00x_br_bulk_command), data, len);
> +
> +	pipe = usb_sndbulkpipe(dev->udev, dev->bulk_out->bEndpointAddress);
> +	retval = usb_bulk_msg(dev->udev, pipe, buf, buf_len, &actual_len,
> +			      XAPEA00X_BR_USB_TIMEOUT);
> +	if (retval)
> +		goto free_buf;

WTF?

> +free_buf:
> +	kzfree(buf);
> +
> +out:
> +	return retval;
> +}
> +

[..]
> +static int xapea00x_spi_setup(struct spi_device *spi)
> +{
> +	struct xapea00x_device *dev;
> +	int retval;
> +
> +	dev = spi_master_get_devdata(spi->master);
> +
> +	mutex_lock(&dev->usb_mutex);
> +	if (!dev->interface) {
> +		retval = -ENODEV;
> +		goto out;
> +	}
> +
> +	/* Verify that this is the TPM device */
> +	if (spi->chip_select != 0) {
> +		retval = -EINVAL;
> +		goto err;
> +	}
> +
> +	/*
> +	 * Disable auto chip select for the TPM channel.
> +	 * Must be done after setting the SPI parameters.
> +	 */
> +	retval = xapea00x_br_disable_cs(dev, 0);
> +	if (retval)
> +		goto err;
> +
> +	/* De-assert chip select for the TPM channel. */
> +	retval = xapea00x_br_deassert_cs(dev, 0);
> +	if (retval)
> +		goto err;
> +
> +	goto out;
> +
> +err:
> +	dev_err(&dev->interface->dev,
> +		"configuring SPI channel failed with %d\n", retval);

That could be a simple 'if' statement.
> +
> +out:
> +	mutex_unlock(&dev->usb_mutex);
> +	return retval;
> +}
> +
> 

[..]
> +/**
> + * xapea00x_spi_probe - Register and configure the SPI master.
> + * @dev: the device whose SPI master to register
> + *
> + * Return: If successful, 0. Otherwise a negative error number.
> + */
> +static int xapea00x_spi_probe(struct xapea00x_device *dev)
> +{
> +	struct spi_master *spi_master;
> +	int retval;
> +
> +	spi_master = spi_alloc_master(&dev->interface->dev, sizeof(void *));
> +	if (!spi_master) {
> +		retval = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	spi_master_set_devdata(spi_master, dev);
> +
> +	spi_master->min_speed_hz = 93 * 1000 + 800; /* 93.9kHz */
> +	spi_master->max_speed_hz = 12 * 1000 * 1000; /* 12 MHz */
> +
> +	spi_master->bus_num = -1; /* dynamically assigned */
> +	spi_master->num_chipselect = 1;
> +	spi_master->mode_bits = SPI_MODE_0;
> +
> +	spi_master->flags = 0;
> +	spi_master->setup = xapea00x_spi_setup;
> +	spi_master->transfer_one_message = xapea00x_spi_transfer_one_message;
> +
> +	retval = spi_register_master(spi_master);
> +
> +	if (retval)
> +		goto free_spi;
> +
> +	dev->spi_master = spi_master;

Race condition.

> +
> +	return 0;
> +
> +free_spi:
> +	spi_master_put(spi_master);
> +	dev->spi_master = NULL;
> +
> +err_out:
> +	return retval;
> +}
> +
> +struct xapea00x_async_probe {
> +	struct work_struct work;
> +	struct xapea00x_device *dev;
> +};
> +
> +#define work_to_probe(w) container_of(w, struct xapea00x_async_probe, work)
> +
> +/**
> + * xapea00x_init_async_probe - initialize an async probe with the
> + * specified values.
> + * @probe: pointer to the async_probe to initialize
> + * @dev: pointer to the device to probe
> + * @f: pointer to the probe function
> + */
> +static void xapea00x_init_async_probe(struct xapea00x_async_probe *probe,
> +				      struct xapea00x_device *dev,
> +				      void (*f)(struct work_struct *work))
> +{
> +	INIT_WORK(&probe->work, f);
> +	probe->dev = dev;
> +
> +	kref_get(&dev->kref);
> +	spi_master_get(dev->spi_master);
> +}
> +
> +/**
> + * xapea00x_cleanup_async_probe - clean up the internals of the async
> + * probe. Call this method after the probe has completed.
> + *
> + * The caller is responsible for freeing the probe itself, if
> + * dynamically allocated.
> + *
> + * @probe: pointer to the async_probe to clean up
> + */
> +static void xapea00x_cleanup_async_probe(struct xapea00x_async_probe *probe)
> +{
> +	spi_master_put(probe->dev->spi_master);
> +	kref_put(&probe->dev->kref, xapea00x_delete);
> +}
> +
> +static struct spi_board_info tpm_board_info = {
> +	.modalias	= XAPEA00X_TPM_MODALIAS,
> +	.max_speed_hz	= 43 * 1000 * 1000, // Hz

Are you hardcoding HZ ?

> +	.chip_select	= 0,
> +	.mode		= SPI_MODE_0
> +};

	Regards
		Oliver
