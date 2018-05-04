Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:43585 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeEDNBp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 May 2018 09:01:45 -0400
Received: by mail-io0-f196.google.com with SMTP id t23-v6so25494510ioc.10
        for <linux-integrity@vger.kernel.org>; Fri, 04 May 2018 06:01:45 -0700 (PDT)
From: "David R. Bild" <david.bild@xaptum.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-integrity@vger.kernel.org,
        "David R. Bild" <david.bild@xaptum.com>
Subject: [PATCH v3 1/2] usb: misc: xapea00x: add driver for Xaptum ENF Access Card
Date: Fri,  4 May 2018 08:00:21 -0500
Message-Id: <20180504130022.5231-2-david.bild@xaptum.com>
In-Reply-To: <20180504130022.5231-1-david.bild@xaptum.com>
References: <20180504130022.5231-1-david.bild@xaptum.com>
In-Reply-To: <20180430125418.31344-1-david.bild@xaptum.com>
References: <20180430125418.31344-1-david.bild@xaptum.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This commit adds a driver for the Xaptum ENF Access Card, a TPM2.0
hardware module for authenticating IoT devices and gateways.

The card consists of a SPI TPM 2.0 chip and a USB-SPI bridge. This
driver configures the bridge, registers the bridge as an SPI
controller, and adds the TPM 2.0 as an SPI device.  The in-kernel TPM
2.0 driver is then automatically loaded to configure the TPM and
expose it to userspace.

Signed-off-by: David R. Bild <david.bild@xaptum.com>
---
 MAINTAINERS                                 |   6 +
 drivers/usb/misc/Kconfig                    |   2 +
 drivers/usb/misc/Makefile                   |   1 +
 drivers/usb/misc/xapea00x/Kconfig           |  14 +
 drivers/usb/misc/xapea00x/Makefile          |   7 +
 drivers/usb/misc/xapea00x/xapea00x-bridge.c | 380 ++++++++++++++++++++++++++
 drivers/usb/misc/xapea00x/xapea00x-core.c   | 408 ++++++++++++++++++++++++++++
 drivers/usb/misc/xapea00x/xapea00x-spi.c    | 196 +++++++++++++
 drivers/usb/misc/xapea00x/xapea00x.h        |  75 +++++
 9 files changed, 1089 insertions(+)
 create mode 100644 drivers/usb/misc/xapea00x/Kconfig
 create mode 100644 drivers/usb/misc/xapea00x/Makefile
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x-bridge.c
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x-core.c
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x-spi.c
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b1ccabd0dbc3..77d35444ef1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14796,6 +14796,12 @@ L:	linux-wireless@vger.kernel.org
 S:	Maintained
 F:	drivers/net/wireless/rndis_wlan.c
 
+USB XAPEA00X DRIVER
+M:	David R. Bild <david.bild@xaptum.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/misc/xapea00x/
+
 USB XHCI DRIVER
 M:	Mathias Nyman <mathias.nyman@intel.com>
 L:	linux-usb@vger.kernel.org
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 68d2f2cd17dd..747d7f03fb84 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -275,3 +275,5 @@ config USB_CHAOSKEY
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called chaoskey.
+
+source "drivers/usb/misc/xapea00x/Kconfig"
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 109f54f5b9aa..f3583501547c 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -30,4 +30,5 @@ obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
 obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
+obj-$(CONFIG_USB_XAPEA00X)		+= xapea00x/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
diff --git a/drivers/usb/misc/xapea00x/Kconfig b/drivers/usb/misc/xapea00x/Kconfig
new file mode 100644
index 000000000000..bea57c8cca53
--- /dev/null
+++ b/drivers/usb/misc/xapea00x/Kconfig
@@ -0,0 +1,14 @@
+config USB_XAPEA00X
+	tristate "Xaptum ENF Access card support (XAP-EA-00x)"
+	depends on USB_SUPPORT && SPI && TCG_TPM
+	select TCG_TIS_SPI
+	help
+	  Say Y here if you want to support the Xaptum ENF Access
+	  modules (XAP-EA-00x) in the USB or Mini PCI-e form
+	  factors. The XAP-EA-00x module exposes a TPM 2.0 as
+	  /dev/tpmX to use for authenticating with the Xaptum ENF.
+
+	  To compile this driver as a module, choose M here. The
+	  module will be called xapea00x.
+
+	  If unsure, say M.
diff --git a/drivers/usb/misc/xapea00x/Makefile b/drivers/usb/misc/xapea00x/Makefile
new file mode 100644
index 000000000000..c4bcd7524c31
--- /dev/null
+++ b/drivers/usb/misc/xapea00x/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the xapea00x driver.
+#
+obj-$(CONFIG_USB_XAPEA00X) += xapea00x.o
+
+xapea00x-y += xapea00x-core.o xapea00x-bridge.o
diff --git a/drivers/usb/misc/xapea00x/xapea00x-bridge.c b/drivers/usb/misc/xapea00x/xapea00x-bridge.c
new file mode 100644
index 000000000000..7071431dea96
--- /dev/null
+++ b/drivers/usb/misc/xapea00x/xapea00x-bridge.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Driver for the XAP-EA-00x series of the Xaptum Edge Access Card, a
+ *  TPM 2.0-based hardware module for authenticating IoT devices and
+ *  gateways.
+ *
+ *  Copyright (c) 2017-2018 Xaptum, Inc.
+ */
+
+#include "xapea00x.h"
+
+#define XAPEA00X_BR_CMD_READ			0x00
+#define XAPEA00X_BR_CMD_WRITE			0x01
+#define XAPEA00X_BR_CMD_WRITEREAD		0x02
+
+#define XAPEA00X_BR_BREQTYP_SET		0x40
+
+#define XAPEA00X_BR_BREQ_SET_GPIO_VALUES	0x21
+#define XAPEA00X_BR_BREQ_SET_GPIO_CS		0x25
+#define XAPEA00X_BR_BREQ_SET_SPI_WORD		0x31
+
+#define XAPEA00X_BR_USB_TIMEOUT		1000 // msecs
+
+#define XAPEA00X_BR_CS_DISABLED		0x00
+
+/*******************************************************************************
+ * Bridge USB transfers
+ */
+
+struct xapea00x_br_bulk_command {
+	__u16  reserved1;
+	__u8   command;
+	__u8   reserved2;
+	__le32 length;
+} __attribute__((__packed__));
+
+/**
+ * xapea00x_br_prep_bulk_command - Prepares the bulk command header with
+ * the supplied values.
+ * @hdr: pointer to header to prepare
+ * @command: the command id for the command
+ * @length: length in bytes of the command data
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+static void xapea00x_br_prep_bulk_command(struct xapea00x_br_bulk_command *hdr,
+					  u8 command, int length)
+{
+	hdr->reserved1 = 0;
+	hdr->command   = command;
+	hdr->reserved2 = 0;
+	hdr->length    = __cpu_to_le32(length);
+}
+
+/**
+ * xapea00x_br_bulk_write - Issues a bulk write to the bridge chip.
+ * @dev: pointer to the device to write to
+ * @command: the command started by this write (WRITE, READ, WRITE_READ)
+ * @data: pointer to the data to write. Must be DMA capable (e.g.,
+ *	  kmalloc-ed, not stack).
+ * @len: length in bytes of the data to write
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+static int xapea00x_br_bulk_write(struct xapea00x_device *dev,
+				  struct xapea00x_br_bulk_command *header,
+				  const void *data, int len)
+{
+	u8 *buf;
+	unsigned int pipe;
+	int buf_len, actual_len, retval;
+
+	buf_len = sizeof(struct xapea00x_br_bulk_command) + len;
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(buf, header, sizeof(struct xapea00x_br_bulk_command));
+	memcpy(buf + sizeof(struct xapea00x_br_bulk_command), data, len);
+
+	pipe = usb_sndbulkpipe(dev->udev, dev->bulk_out->bEndpointAddress);
+	retval = usb_bulk_msg(dev->udev, pipe, buf, buf_len, &actual_len,
+			      XAPEA00X_BR_USB_TIMEOUT);
+	if (retval)
+		goto free_buf;
+
+free_buf:
+	kzfree(buf);
+
+out:
+	return retval;
+}
+
+/**
+ * xapea00x_br_bulk_read - Issues a bulk read to the bridge chip.
+ * @dev: pointer to the device to read from
+ * @data: pointer to the data read. Must be DMA capable (e.g.,
+ *	  kmalloc-ed, not stack).
+ * @len: length in bytes of the data to read
+ *
+ * Return: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_br_bulk_read(struct xapea00x_device *dev, void *data,
+				 int len)
+{
+	unsigned int pipe;
+	void *buf;
+	int actual_len, retval;
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	pipe = usb_rcvbulkpipe(dev->udev, dev->bulk_in->bEndpointAddress);
+	retval = usb_bulk_msg(dev->udev, pipe, buf, len, &actual_len,
+			      XAPEA00X_BR_USB_TIMEOUT);
+
+	if (retval)
+		goto free_buf;
+
+	memcpy(data, buf, actual_len);
+
+free_buf:
+	kzfree(buf);
+
+out:
+	return retval;
+}
+
+/**
+ * xapea00x_br_ctrl_write - Issues a send control transfer to the bridge
+ * chip.
+ * @dev: pointer to the device to write to
+ * @bRequest: the command
+ * @wValue: the command value
+ * @wIndex: the command index
+ * @data: pointer to the command data
+ * @len: length in bytes of the command data
+ *
+ * The possible bRequest, wValue, and wIndex values and data format
+ * are specified in the hardware datasheet.
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_br_ctrl_write(struct xapea00x_device *dev, u8 bRequest,
+				  u16 wValue, u16 wIndex, u8 *data, u16 len)
+{
+	unsigned int pipe;
+	void *buf;
+	int retval;
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf) {
+		retval = -ENOMEM;
+		goto out;
+	}
+	memcpy(buf, data, len);
+
+	pipe = usb_sndctrlpipe(dev->udev, 0);
+	retval = usb_control_msg(dev->udev, pipe, bRequest,
+				 XAPEA00X_BR_BREQTYP_SET, wValue, wIndex,
+				 buf, len, XAPEA00X_BR_USB_TIMEOUT);
+	if (retval < 0)
+		goto free_buf;
+
+	retval = 0;
+
+free_buf:
+	kzfree(buf);
+
+out:
+	return retval;
+}
+
+/*******************************************************************************
+ * Bridge configuration commands
+ */
+
+/**
+ * xapea00x_br_set_gpio_value - Sets the value on the specified pin of
+ * the bridge chip.
+ * @dev: pointer to the device containing the bridge whose pin to set
+ * @pin: the number of the pin to set
+ * @value: the value to set the pin to, 0 or 1
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+static int xapea00x_br_set_gpio_value(struct xapea00x_device *dev, u8 pin,
+				      u8 value)
+{
+	u8 data[4] = { 0, 0, 0, 0 };
+
+	switch (pin) {
+	case 10:
+	case  9:
+	case  8:
+	case  7:
+	case  6:
+		data[0] = value << (pin - 4);
+		data[2] = 1 << (pin - 4);
+		break;
+	case  5:
+		data[0] = value;
+		data[2] = 1;
+		break;
+	case  4:
+	case  3:
+	case  2:
+	case  1:
+	case  0:
+		data[1] = value << (pin + 3);
+		data[3] = 1 << (pin + 3);
+		break;
+	}
+	return xapea00x_br_ctrl_write(dev, XAPEA00X_BR_BREQ_SET_GPIO_VALUES,
+				      0, 0, data, 4);
+}
+
+/**
+ * xapea00x_br_set_gpio_cs - Sets the chip select control on the specified
+ * pin of the bridge chip.
+ * @dev: pointer to the device containing the bridge whose cs to set
+ * @pin: the number of the pin to set
+ * @control: the chip select control value for the pin, 0, 1, or 2
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+static int xapea00x_br_set_gpio_cs(struct xapea00x_device *dev, u8 pin,
+				   u8 control)
+{
+	u8 data[2] = { pin, control };
+
+	return xapea00x_br_ctrl_write(dev, XAPEA00X_BR_BREQ_SET_GPIO_CS,
+				      0, 0, data, 2);
+}
+
+/*******************************************************************************
+ * Bridge configuration commands
+ */
+/**
+ * xapea00x_br_disable_cs - disable the built-in chip select
+ * capability of the specified channel. It does not support holding
+ * the CS active between SPI transfers, a feature required for the
+ * TPM. Instead, we manually control the CS pin as a GPIO.
+ * @dev: pointer to the device containing the bridge whose cs to disable
+ * @channel: the SPI channel whose cs to disable
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful 0. Otherwise a negative error number.
+ */
+int xapea00x_br_disable_cs(struct xapea00x_device *dev, u8 channel)
+{
+	return xapea00x_br_set_gpio_cs(dev, channel,
+				       XAPEA00X_BR_CS_DISABLED);
+}
+
+/**
+ * xapea00x_br_assert_cs - assert the chip select pin for the
+ * specified channel.
+ * @dev: pointer to the device containing the bridge who cs to assert
+ * @channel: the SPI channel whose cs to assert
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful 0. Otherwise a negative error number.
+ */
+int xapea00x_br_assert_cs(struct xapea00x_device *dev, u8 channel)
+{
+	return xapea00x_br_set_gpio_value(dev, channel, 0);
+}
+
+/**
+ * xapea00x_br_deassert_cs - deassert the chip select pin for the
+ * specified channel.
+ * @dev: pointer to the device containing the bridge who cs to deassert
+ * @channel: the SPI channel whose cs to deassert
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful 0. Otherwise a negative error number.
+ */
+int xapea00x_br_deassert_cs(struct xapea00x_device *dev, u8 channel)
+{
+	return xapea00x_br_set_gpio_value(dev, channel, 1);
+}
+
+/*******************************************************************************
+ * Bridge SPI reads and writes
+ */
+/**
+ * xeapea00x_spi_read - Performs a read from the active channel
+ * @dev: pointer to the device to perform the read
+ * @rx_buf: pointer to the buffer to read the data into.  Must be
+ *	    DMA-capable (e.g., kmalloc-ed, not stack).
+ * @len: length in bytes of the data to read
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+int xapea00x_br_spi_read(struct xapea00x_device *dev, void *rx_buf, int len)
+{
+	struct xapea00x_br_bulk_command header;
+	int retval;
+
+	xapea00x_br_prep_bulk_command(&header, XAPEA00X_BR_CMD_READ, len);
+	retval = xapea00x_br_bulk_write(dev, &header, NULL, 0);
+	if (retval)
+		goto out;
+
+	retval = xapea00x_br_bulk_read(dev, rx_buf, len);
+
+out:
+	return retval;
+}
+
+/**
+ *xapea00x_br_spi_write - Performs a write to the active channel
+ * @dev: pointer to the device to perform the write
+ * @tx_buf: pointer to the data to write. Must be DMA-capable (e.g.,
+ *	    kmalloc-ed, not stack).
+ * @len: length in bytes of the data to write
+ */
+int xapea00x_br_spi_write(struct xapea00x_device *dev, const void *tx_buf,
+			  int len)
+{
+	struct xapea00x_br_bulk_command header;
+	int retval;
+
+	xapea00x_br_prep_bulk_command(&header, XAPEA00X_BR_CMD_WRITE, len);
+	retval = xapea00x_br_bulk_write(dev, &header, tx_buf, len);
+
+	return retval;
+}
+
+/**
+ * xapea00x_br_spi_write_read - Performs a simultaneous write and read on
+ * the active channel
+ * @dev: pointer to the device to perform the write/read
+ * @tx_buf: pointer to the data to write. Must be DMA-capable (e.g.,
+ *	    kmalloc-ed, not stack).
+ * @rx_buf: pointer to the buffer to read the data into. Must be
+ *	    DMA-capable (e.g., kmalloc-ed, not stack).
+ * @len: length in bytes of the data to write/read
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+int xapea00x_br_spi_write_read(struct xapea00x_device *dev, const void *tx_buf,
+			       void *rx_buf, int len)
+{
+	struct xapea00x_br_bulk_command header;
+	int retval;
+
+	xapea00x_br_prep_bulk_command(&header, XAPEA00X_BR_CMD_WRITEREAD, len);
+	retval = xapea00x_br_bulk_write(dev, &header, tx_buf, len);
+	if (retval)
+		goto out;
+
+	retval = xapea00x_br_bulk_read(dev, rx_buf, len);
+
+out:
+	return retval;
+}
diff --git a/drivers/usb/misc/xapea00x/xapea00x-core.c b/drivers/usb/misc/xapea00x/xapea00x-core.c
new file mode 100644
index 000000000000..885bcda9c01d
--- /dev/null
+++ b/drivers/usb/misc/xapea00x/xapea00x-core.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Driver for the XAP-EA-00x series of the Xaptum Edge Access Card, a
+ *  TPM 2.0-based hardware module for authenticating IoT devices and
+ *  gateways.
+ *
+ *  Copyright (c) 2017-2018 Xaptum, Inc.
+ */
+
+#include "xapea00x.h"
+
+#define XAPEA00X_TPM_MODALIAS	"tpm_tis_spi"
+
+#define kref_to_xapea00x(k) container_of(k, struct xapea00x_device, kref)
+
+static void xapea00x_delete(struct kref *kref)
+{
+	struct xapea00x_device *dev = kref_to_xapea00x(kref);
+
+	usb_put_dev(dev->udev);
+	kfree(dev);
+}
+
+/*******************************************************************************
+ * SPI master functions
+ */
+
+/**
+ * xapea00x_spi_setup - Setup the SPI channel for the TPM.
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+static int xapea00x_spi_setup(struct spi_device *spi)
+{
+	struct xapea00x_device *dev;
+	int retval;
+
+	dev = spi_master_get_devdata(spi->master);
+
+	mutex_lock(&dev->usb_mutex);
+	if (!dev->interface) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	/* Verify that this is the TPM device */
+	if (spi->chip_select != 0) {
+		retval = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * Disable auto chip select for the TPM channel.
+	 * Must be done after setting the SPI parameters.
+	 */
+	retval = xapea00x_br_disable_cs(dev, 0);
+	if (retval)
+		goto err;
+
+	/* De-assert chip select for the TPM channel. */
+	retval = xapea00x_br_deassert_cs(dev, 0);
+	if (retval)
+		goto err;
+
+	goto out;
+
+err:
+	dev_err(&dev->interface->dev,
+		"configuring SPI channel failed with %d\n", retval);
+
+out:
+	mutex_unlock(&dev->usb_mutex);
+	return retval;
+}
+
+/**
+ * xapea00x_spi_transfer - Execute a single SPI transfer.
+ * @dev: pointer to the device to do the transfer on
+ * @tx_buf: pointer to the data to send, if not NULL
+ * @rx_buf: pointer to the buffer to store the received data, if not NULL
+ * @len: length in bytes of the data to send/receive
+ * @cs_hold: If non-zero, the chip select will remain asserted
+ * @delay_usecs: If nonzero, how long to delay after last bit transfer
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+int xapea00x_spi_transfer(struct xapea00x_device *dev,
+			  const void *tx_buf, void *rx_buf, u32 len,
+			  int cs_hold, u16 delay_usecs)
+{
+	int retval;
+
+	/* Assert chip select */
+	retval = xapea00x_br_assert_cs(dev, 0);
+	if (retval)
+		goto out;
+
+	/* empty transfer */
+	if (!tx_buf && !rx_buf)
+		retval = 0;
+	/* read transfer */
+	else if (!tx_buf)
+		retval = xapea00x_br_spi_read(dev, rx_buf, len);
+	/* write transfer */
+	else if (!rx_buf)
+		retval = xapea00x_br_spi_write(dev, tx_buf, len);
+	/* write_read transfer */
+	else
+		retval = xapea00x_br_spi_write_read(dev, tx_buf, rx_buf, len);
+
+	/* Deassert chip select, if requested */
+	if (!cs_hold)
+		retval = xapea00x_br_deassert_cs(dev, 0);
+
+	/* Delay for the requested time */
+	udelay(delay_usecs);
+
+out:
+	return retval;
+}
+
+/**
+ * xapea00x_spi_transfer_one_message - Execute a full SPI message.
+ * @master: The SPI master on which to execute the message.
+ * @msg: The SPI message to execute.
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative erorr number.
+ */
+static int xapea00x_spi_transfer_one_message(struct spi_master *master,
+					     struct spi_message *msg)
+{
+	struct xapea00x_device *dev;
+	struct spi_transfer *xfer;
+	int is_last, retval;
+
+	dev = spi_master_get_devdata(master);
+
+	mutex_lock(&dev->usb_mutex);
+	if (!dev->interface) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	/* perform all transfers */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		is_last = list_is_last(&xfer->transfer_list, &msg->transfers);
+
+		/* Transfer message */
+		retval = xapea00x_spi_transfer(dev, xfer->tx_buf,
+					       xfer->rx_buf, xfer->len,
+					       is_last == xfer->cs_change,
+					       xfer->delay_usecs);
+		if (retval)
+			goto out;
+
+		msg->actual_length += xfer->len;
+	}
+
+	retval = 0;
+
+out:
+	msg->status = retval;
+	spi_finalize_current_message(master);
+
+	mutex_unlock(&dev->usb_mutex);
+	return retval;
+}
+
+/**
+ * xapea00x_spi_probe - Register and configure the SPI master.
+ * @dev: the device whose SPI master to register
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+static int xapea00x_spi_probe(struct xapea00x_device *dev)
+{
+	struct spi_master *spi_master;
+	int retval;
+
+	spi_master = spi_alloc_master(&dev->interface->dev, sizeof(void *));
+	if (!spi_master) {
+		retval = -ENOMEM;
+		goto err_out;
+	}
+
+	spi_master_set_devdata(spi_master, dev);
+
+	spi_master->min_speed_hz = 93 * 1000 + 800; /* 93.9kHz */
+	spi_master->max_speed_hz = 12 * 1000 * 1000; /* 12 MHz */
+
+	spi_master->bus_num = -1; /* dynamically assigned */
+	spi_master->num_chipselect = 1;
+	spi_master->mode_bits = SPI_MODE_0;
+
+	spi_master->flags = 0;
+	spi_master->setup = xapea00x_spi_setup;
+	spi_master->transfer_one_message = xapea00x_spi_transfer_one_message;
+
+	retval = spi_register_master(spi_master);
+
+	if (retval)
+		goto free_spi;
+
+	dev->spi_master = spi_master;
+
+	return 0;
+
+free_spi:
+	spi_master_put(spi_master);
+	dev->spi_master = NULL;
+
+err_out:
+	return retval;
+}
+
+struct xapea00x_async_probe {
+	struct work_struct work;
+	struct xapea00x_device *dev;
+};
+
+#define work_to_probe(w) container_of(w, struct xapea00x_async_probe, work)
+
+/**
+ * xapea00x_init_async_probe - initialize an async probe with the
+ * specified values.
+ * @probe: pointer to the async_probe to initialize
+ * @dev: pointer to the device to probe
+ * @f: pointer to the probe function
+ */
+static void xapea00x_init_async_probe(struct xapea00x_async_probe *probe,
+				      struct xapea00x_device *dev,
+				      void (*f)(struct work_struct *work))
+{
+	INIT_WORK(&probe->work, f);
+	probe->dev = dev;
+
+	kref_get(&dev->kref);
+	spi_master_get(dev->spi_master);
+}
+
+/**
+ * xapea00x_cleanup_async_probe - clean up the internals of the async
+ * probe. Call this method after the probe has completed.
+ *
+ * The caller is responsible for freeing the probe itself, if
+ * dynamically allocated.
+ *
+ * @probe: pointer to the async_probe to clean up
+ */
+static void xapea00x_cleanup_async_probe(struct xapea00x_async_probe *probe)
+{
+	spi_master_put(probe->dev->spi_master);
+	kref_put(&probe->dev->kref, xapea00x_delete);
+}
+
+static struct spi_board_info tpm_board_info = {
+	.modalias	= XAPEA00X_TPM_MODALIAS,
+	.max_speed_hz	= 43 * 1000 * 1000, // Hz
+	.chip_select	= 0,
+	.mode		= SPI_MODE_0
+};
+
+/**
+ * xapea00x_tpm_probe - Register and initialize the TPM device
+ * @work: the work struct contained by the xapea00x device
+ *
+ * Context: !in_interrupt()
+ */
+static void xapea00x_tpm_probe(struct work_struct *work)
+{
+	struct xapea00x_async_probe *probe = work_to_probe(work);
+	struct xapea00x_device *dev = probe->dev;
+	struct spi_master *spi_master = dev->spi_master;
+	struct spi_device *tpm;
+	int retval;
+
+	tpm = spi_new_device(spi_master, &tpm_board_info);
+	mutex_lock(&dev->usb_mutex);
+	if (!dev->interface) {
+		retval = -ENODEV;
+		goto out;
+	}
+	if (!tpm) {
+		retval = -ENODEV;
+		dev_err(&dev->interface->dev,
+			"unable to add spi device for TPM\n");
+		goto err;
+	}
+
+	dev->tpm = tpm;
+	goto out;
+
+err:
+	dev_err(&dev->interface->dev,
+		"TPM initialization failed with %d\n", retval);
+
+out:
+	mutex_unlock(&dev->usb_mutex);
+	xapea00x_cleanup_async_probe(probe);
+	kzfree(probe);
+}
+
+/*******************************************************************************
+ * USB driver structs and functions
+ */
+
+static const struct usb_device_id xapea00x_devices[] = {
+	{ USB_DEVICE(USB_VENDOR_ID_SILABS, USB_PRODUCT_ID_XAPEA001) },
+	{ USB_DEVICE(USB_VENDOR_ID_XAPTUM, USB_PRODUCT_ID_XAPEA002) },
+	{ USB_DEVICE(USB_VENDOR_ID_XAPTUM, USB_PRODUCT_ID_XAPEA003) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, xapea00x_devices);
+
+static int xapea00x_probe(struct usb_interface *interface,
+			  const struct usb_device_id *id)
+{
+	struct xapea00x_device *dev;
+	struct xapea00x_async_probe *probe;
+	int retval;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	kref_init(&dev->kref);
+	mutex_init(&dev->usb_mutex);
+
+	/* ---------------------- USB ------------------------ */
+	dev->interface = interface;
+	dev->udev = usb_get_dev(interface_to_usbdev(interface));
+
+	dev->vid = __le16_to_cpu(dev->udev->descriptor.idVendor);
+	dev->pid = __le16_to_cpu(dev->udev->descriptor.idProduct);
+
+	retval = usb_find_common_endpoints(interface->cur_altsetting,
+					   &dev->bulk_in, &dev->bulk_out,
+					   NULL, NULL);
+	if (retval) {
+		dev_err(&interface->dev,
+			"could not find both bulk-in and bulk-out endpoints\n");
+		goto free_dev;
+	}
+
+	usb_set_intfdata(interface, dev);
+
+	/* ---------------------- SPI Master ------------------------ */
+	retval = xapea00x_spi_probe(dev);
+	if (retval) {
+		dev_err(&interface->dev, "could not initialize SPI master\n");
+		goto free_dev;
+	}
+
+	/* ---------------------- TPM SPI Device ------------------------ */
+	probe = kzalloc(sizeof(*probe), GFP_KERNEL);
+	if (!probe) {
+		retval = -ENOMEM;
+		goto free_spi;
+	}
+	xapea00x_init_async_probe(probe, dev, xapea00x_tpm_probe);
+
+	schedule_work(&probe->work);
+
+	/* ---------------------- Finished ------------------------ */
+	return 0;
+
+free_spi:
+	spi_unregister_master(dev->spi_master);
+
+free_dev:
+	kref_put(&dev->kref, xapea00x_delete);
+
+	dev_err(&interface->dev, "device failed with %d\n", retval);
+	return retval;
+}
+
+static void xapea00x_disconnect(struct usb_interface *interface)
+{
+	struct xapea00x_device *dev = usb_get_intfdata(interface);
+
+	usb_set_intfdata(interface, NULL);
+	spi_unregister_master(dev->spi_master);
+
+	mutex_lock(&dev->usb_mutex);
+	dev->interface = NULL;
+	mutex_unlock(&dev->usb_mutex);
+
+	kref_put(&dev->kref, xapea00x_delete);
+}
+
+static struct usb_driver xapea00x_driver = {
+	.name		= KBUILD_MODNAME,
+	.probe		= xapea00x_probe,
+	.disconnect	= xapea00x_disconnect,
+	.id_table	= xapea00x_devices
+};
+
+module_usb_driver(xapea00x_driver);
+
+MODULE_AUTHOR("David R. Bild <david.bild@xaptum.com>");
+MODULE_DESCRIPTION("Xaptum XAP-EA-00x ENF Access card");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/misc/xapea00x/xapea00x-spi.c b/drivers/usb/misc/xapea00x/xapea00x-spi.c
new file mode 100644
index 000000000000..d71e79029639
--- /dev/null
+++ b/drivers/usb/misc/xapea00x/xapea00x-spi.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Driver for the XAP-EA-00x series of the Xaptum Edge Access Card, a
+ *  TPM 2.0-based hardware module for authenticating IoT devices and
+ *  gateways.
+ *
+ *  Copyright (c) 2017-2018 Xaptum, Inc.
+ */
+
+#include "xapea00x.h"
+
+/*******************************************************************************
+ * SPI master functions
+ */
+
+/**
+ * xapea00x_spi_setup - Setup the SPI channel for the TPM.
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+static int xapea00x_spi_setup(struct spi_device *spi)
+{
+	struct xapea00x_device *dev;
+	int retval;
+
+	dev = spi_master_get_devdata(spi->master);
+
+	/* Verify that this is the TPM device */
+	if (spi->chip_select != 0) {
+		retval = -EINVAL;
+		goto err;
+	}
+
+	/* Set the SPI parameters for the TPM channel. */
+	retval = xapea00x_br_set_spi_word(dev, 0, XAPEA00X_TPM_SPI_WORD);
+	if (retval)
+		goto err;
+
+	/*
+	 * Disable auto chip select for the TPM channel.
+	 * Must be done after setting the SPI parameters.
+	 */
+	retval = xapea00x_br_set_gpio_cs(dev, 0, XAPEA00X_GPIO_CS_DISABLED);
+	if (retval)
+		goto err;
+
+	/* De-assert chip select for the TPM channel. */
+	retval = xapea00x_br_set_gpio_value(dev, 0, 1);
+	if (retval)
+		goto err;
+
+	return 0;
+
+err:
+	dev_err(&dev->interface->dev,
+		"configuring SPI channel failed with %d\n", retval);
+	return retval;
+}
+
+/**
+ * xapea00x_spi_transfer - Execute a single SPI transfer.
+ * @dev: pointer to the device to do the transfer on
+ * @tx_buf: pointer to the data to send, if not NULL
+ * @rx_buf: pointer to the buffer to store the received data, if not NULL
+ * @len: length in bytes of the data to send/receive
+ * @cs_hold: If non-zero, the chip select will remain asserted
+ * @delay_usecs: If nonzero, how long to delay after last bit transfer
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+int xapea00x_spi_transfer(struct xapea00x_device *dev,
+			  const void *tx_buf, void *rx_buf, u32 len,
+			  int cs_hold, u16 delay_usecs)
+{
+	int retval;
+
+	/* Assert chip select */
+	retval = xapea00x_br_set_gpio_value(dev, 0, 0);
+	if (retval)
+		goto out;
+
+	/* empty transfer */
+	if (!tx_buf && !rx_buf)
+		retval = 0;
+	/* read transfer */
+	else if (!tx_buf)
+		retval = xapea00x_br_spi_read(dev, rx_buf, len);
+	/* write transfer */
+	else if (!rx_buf)
+		retval = xapea00x_br_spi_write(dev, tx_buf, len);
+	/* write_read transfer */
+	else
+		retval = xapea00x_br_spi_write_read(dev, tx_buf, rx_buf, len);
+
+	/* Deassert chip select, if requested */
+	if (!cs_hold)
+		retval = xapea00x_br_set_gpio_value(dev, 0, 1);
+
+	/* Delay for the requested time */
+	udelay(delay_usecs);
+
+out:
+	return retval;
+}
+
+/**
+ * xapea00x_spi_transfer_one_message - Execute a full SPI message.
+ * @master: The SPI master on which to execute the message.
+ * @msg: The SPI message to execute.
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative erorr number.
+ */
+static int xapea00x_spi_transfer_one_message(struct spi_master *master,
+					     struct spi_message *msg)
+{
+	struct xapea00x_device *dev;
+	struct spi_transfer *xfer;
+	int is_last, retval;
+
+	dev = spi_master_get_devdata(master);
+
+	/* perform all transfers */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		is_last = list_is_last(&xfer->transfer_list, &msg->transfers);
+
+		/* Transfer message */
+		retval = xapea00x_spi_transfer(dev, xfer->tx_buf,
+					       xfer->rx_buf, xfer->len,
+					       is_last == xfer->cs_change,
+					       xfer->delay_usecs);
+		if (retval)
+			goto out;
+
+		msg->actual_length += xfer->len;
+	}
+
+	retval = 0;
+
+out:
+	msg->status = retval;
+	spi_finalize_current_message(master);
+	return retval;
+}
+
+/**
+ * xapea00x_spi_probe - Register and configure the SPI master.
+ * @dev: the device whose SPI master to register
+ *
+ * Return: If successful, 0. Otherwise a negative error number.
+ */
+static int xapea00x_spi_probe(struct xapea00x_device *dev)
+{
+	struct spi_master *spi_master;
+	int retval;
+
+	spi_master = spi_alloc_master(&dev->udev->dev, sizeof(void *));
+	if (!spi_master) {
+		retval = -ENOMEM;
+		goto err_out;
+	}
+
+	spi_master_set_devdata(spi_master, dev);
+
+	spi_master->min_speed_hz = 93 * 1000 + 800; /* 93.9kHz */
+	spi_master->max_speed_hz = 12 * 1000 * 1000; /* 12 MHz */
+
+	spi_master->bus_num = -1; /* dynamically assigned */
+	spi_master->num_chipselect = XAPEA00X_NUM_CS;
+	spi_master->mode_bits = SPI_MODE_0;
+
+	spi_master->flags = 0;
+	spi_master->setup = xapea00x_spi_setup;
+	spi_master->transfer_one_message = xapea00x_spi_transfer_one_message;
+
+	retval = spi_register_master(spi_master);
+
+	if (retval)
+		goto free_spi;
+
+	dev->spi_master = spi_master;
+
+	return 0;
+
+free_spi:
+	spi_master_put(spi_master);
+	dev->spi_master = NULL;
+
+err_out:
+	return retval;
+}
diff --git a/drivers/usb/misc/xapea00x/xapea00x.h b/drivers/usb/misc/xapea00x/xapea00x.h
new file mode 100644
index 000000000000..4771a9af71e3
--- /dev/null
+++ b/drivers/usb/misc/xapea00x/xapea00x.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Driver for the XAP-EA-00x series of the Xaptum Edge Access Card, a
+ *  TPM 2.0-based hardware module for authenticating IoT devices and
+ *  gateways.
+ *
+ *  Copyright (c) 2017-2018 Xaptum, Inc.
+ */
+
+#ifndef _XAPEA00X_H
+#define _XAPEA00X_H
+
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#define USB_VENDOR_ID_SILABS           0x10c4
+#define USB_VENDOR_ID_XAPTUM           0x2FE0
+
+#define USB_PRODUCT_ID_XAPEA001        0x8BDE
+#define USB_PRODUCT_ID_XAPEA002        0x8BDE
+#define USB_PRODUCT_ID_XAPEA003        0x8BEE
+
+struct xapea00x_device {
+	struct kref kref;
+
+	struct usb_device *udev;
+	/*
+	 * The interface pointer will be set NULL when the device
+	 * disconnects.  Accessing it safe only while holding the
+	 * usb_mutex.
+	 */
+	struct usb_interface *interface;
+	/*
+	 * Th usb_mutex must be held while synchronous USB requests are
+	 * in progress. It is acquired during disconnect to be sure
+	 * that there is not an outstanding request.
+	 */
+	struct mutex usb_mutex;
+
+	struct usb_endpoint_descriptor *bulk_in;
+	struct usb_endpoint_descriptor *bulk_out;
+
+	u16 pid;
+	u16 vid;
+
+	struct spi_master *spi_master;
+	struct spi_device *tpm;
+};
+
+/* Public bridge functions */
+int xapea00x_br_disable_cs(struct xapea00x_device *dev, u8 channel);
+int xapea00x_br_assert_cs(struct xapea00x_device *dev, u8 channel);
+int xapea00x_br_deassert_cs(struct xapea00x_device *dev, u8 channel);
+
+int xapea00x_br_spi_read(struct xapea00x_device *dev, void *rx_buf, int len);
+int xapea00x_br_spi_write(struct xapea00x_device *dev, const void *tx_buf,
+			  int len);
+int xapea00x_br_spi_write_read(struct xapea00x_device *dev, const void *tx_buf,
+			       void *rx_buf, int len);
+
+/* Shared SPI function */
+int xapea00x_spi_transfer(struct xapea00x_device *dev,
+			  const void *tx_buf, void *rx_buf, u32 len,
+			  int cs_hold, u16 delay_usecs);
+
+/* Shared TPM functions */
+int xapea00x_tpm_platform_initialize(struct xapea00x_device *dev);
+
+#endif /* _XAPEA00X_H */
-- 
2.16.3
