Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from eu-smtp-delivery-170.mimecast.com ([207.82.80.170]:55779 "EHLO
        eu-smtp-delivery-170.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752549AbeEGOTI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 May 2018 10:19:08 -0400
From: Jeremy Boone <Jeremy.Boone@nccgroup.trust>
To: "David R. Bild" <david.bild@xaptum.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: EXTERNAL: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Date: Mon, 7 May 2018 14:12:53 +0000
Message-ID: <72b699b19123432db15c566fbc42c670@MANDBSEXCH03.nccgroup.local>
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
In-Reply-To: <20180504130022.5231-3-david.bild@xaptum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi there,

I have some feedback. A few months ago, I disclosed a series of bugs to this list that could be triggered by an interposer that sits on the serial bus between the TPM chip and the kernel.  These patches can be found here [1], and the tool/whitepaper to go with my research can be found here [2].

I noticed that your change set contains similar flaws that may be triggered by an interposer.

================
Unsafe parsing of TPM response header
================

The function xapea00x_tpm_recv is used to receive bytes from the TPM after a command has been issued. This function does not adequately validate the cmd->size field which is contained in the response header. Below, if cmd->size is less than TIS_HEADER_LEN (10 bytes), then the arithmetic operation "size-=TIS_HEADER_LEN" will underflow.

+static int xapea00x_tpm_recv(struct xapea00x_device *dev, void *buf, u32 len)
+{
...
+retval = xapea00x_tpm_read_bytes(dev, TPM_DATA_FIFO_0, buf,
+ TIS_HEADER_LEN);
+...
+size = __be32_to_cpu(cmd->size);
+if (len < size) {
+retval = -EINVAL;
+goto cancel;
+}
+size -= TIS_HEADER_LEN;

Once the underflow has occurred the value of `size` will be very large. Consequently, the following while-loop will take too many iterations, causing the write of too many bytes into the response buffer, `buf`:

+while (size > TIS_HEADER_LEN) {
+xapea00x_tpm_burst_count(dev, &burst);
+burst = min(burst, size);
+
+retval = xapea00x_tpm_read_bytes(dev, TPM_DATA_FIFO_0, buf,
+ burst);
+if (retval)
+goto cancel;
+
+size -= burst;
+buf += burst;
+}

Here a simple check is needed to ensure that `cmd->size` is not less than `TIS_HEADER_LEN`:

+size = __be32_to_cpu(cmd->size);
+if (size > len || size < TIS_HEADER_LEN) {

================
Use of sessions
================

The xapea00x_tpm_get_random function does not use a session (it uses TPM2_ST_NO_SESSIONS), and as such, the response bytes are not encrypted and are not protected by an HMAC. This allows an interposer device to eavesdrop and/or modify the traffic. James Bottomley recently proposed a patch [3] that would add sessions to TPM2_GET_RANDOM commands, and you may want to take advantage of that in your driver.


[1] https://lkml.org/lkml/2018/2/26/1176
[2] https://github.com/nccgroup/TPMGenie
[3] https://www.spinics.net/lists/linux-integrity/msg02000.html


-----Original Message-----
From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-owner@vger.kernel.org] On Behalf Of David R. Bild
Sent: Friday, May 04, 2018 9:00 AM
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Peter Huewe <peterhuewe@gmx.de>; Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-usb@vger.kernel.org; linux-integrity@vger.kernel.org; David R. Bild <david.bild@xaptum.com>
Subject: EXTERNAL: [PATCH v3 2/2] usb: misc: xapea00x: perform platform initialization of TPM

Normally the system platform (i.e., BIOS/UEFI for x86) is responsible
for performing initialization of the TPM.  For these modules, the host
kernel is the platform, so we perform the initialization in the driver
before registering the TPM with the kernel TPM subsystem.

The initialization consists of issuing the TPM startup command,
running the TPM self-test, and setting the TPM platform hierarchy
authorization to a random, unsaved value so that it can never be used
after the driver has loaded.

Signed-off-by: David R. Bild <david.bild@xaptum.com>
---
 drivers/usb/misc/xapea00x/Makefile        |   3 +-
 drivers/usb/misc/xapea00x/xapea00x-core.c |  25 +
 drivers/usb/misc/xapea00x/xapea00x-tpm.c  | 952 ++++++++++++++++++++++++++++++
 3 files changed, 979 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x-tpm.c

diff --git a/drivers/usb/misc/xapea00x/Makefile b/drivers/usb/misc/xapea00x/Makefile
index c4bcd7524c31..aa3f8803cdf5 100644
--- a/drivers/usb/misc/xapea00x/Makefile
+++ b/drivers/usb/misc/xapea00x/Makefile
@@ -4,4 +4,5 @@
 #
 obj-$(CONFIG_USB_XAPEA00X) += xapea00x.o

-xapea00x-y += xapea00x-core.o xapea00x-bridge.o
+xapea00x-y += xapea00x-core.o xapea00x-bridge.o xapea00x-tpm.o
+
diff --git a/drivers/usb/misc/xapea00x/xapea00x-core.c b/drivers/usb/misc/xapea00x/xapea00x-core.c
index 885bcda9c01d..53e82f8b38f3 100644
--- a/drivers/usb/misc/xapea00x/xapea00x-core.c
+++ b/drivers/usb/misc/xapea00x/xapea00x-core.c
@@ -280,6 +280,31 @@ static void xapea00x_tpm_probe(struct work_struct *work)
 struct spi_device *tpm;
 int retval;

+mutex_lock(&dev->usb_mutex);
+if (!dev->interface) {
+retval = -ENODEV;
+goto out;
+}
+/*
+ * This driver is the "platform" in TPM terminology. Before
+ * passing control of the TPM to the Linux TPM subsystem, do
+ * the TPM initialization normally done by the platform code
+ * (e.g., BIOS).
+ */
+retval = xapea00x_tpm_platform_initialize(dev);
+if (retval) {
+dev_err(&dev->interface->dev,
+"unable to do TPM platform initialization: %d\n",
+retval);
+goto err;
+}
+
+/*
+ * Now register the TPM with the Linux TPM subsystem.  This
+ * may call through to xapea00x_spi_transfer_one_message(), so
+ * don't hold usb_mutex here.
+ */
+mutex_unlock(&dev->usb_mutex);
 tpm = spi_new_device(spi_master, &tpm_board_info);
 mutex_lock(&dev->usb_mutex);
 if (!dev->interface) {
diff --git a/drivers/usb/misc/xapea00x/xapea00x-tpm.c b/drivers/usb/misc/xapea00x/xapea00x-tpm.c
new file mode 100644
index 000000000000..27159043ce3c
--- /dev/null
+++ b/drivers/usb/misc/xapea00x/xapea00x-tpm.c
@@ -0,0 +1,952 @@
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
+#define TPM_RETRY50
+#define TPM_TIMEOUT5    // msecs
+#define TPM_TIMEOUT_RANGE_US300  // usecs
+
+#define TIS_SHORT_TIMEOUT750  // msecs
+#define TIS_LONG_TIMEOUT2000 // msecs
+
+#define TIS_MAX_BUF1024 // byte
+#define TIS_HEADER_LEN10   // byte
+
+#define TPM2_TIMEOUT_A750  // msecs
+#define TPM2_TIMEOUT_B2000 // msecs
+#define TPM2_TIMEOUT_C200  // msecs
+#define TPM2_TIMEOUT_D30   // msecs
+
+#define TPM_ACCESS_00x0000
+#define TPM_STS_00x0018
+#define TPM_DATA_FIFO_00x0024
+
+#define TPM2_ST_NO_SESSIONS0x8001
+#define TPM2_ST_SESSIONS0x8002
+
+#define TPM2_CC_STARTUP0x0144
+#define TPM2_CC_SHUTDOWN0x0145
+#define TPM2_CC_SELF_TEST0x0143
+#define TPM2_CC_GET_RANDOM0x017B
+#define TPM2_CC_HIERARCHY_CHANGE_AUTH0x0129
+#define TPM2_CC_DICT_ATTACK_LOCK_RST0x0139
+
+#define TPM_RC_SUCCESS0x000
+#define TPM_RC_INITIALIZE0x100
+
+enum tis_access {
+TPM_ACCESS_VALID= 0x80,
+TPM_ACCESS_ACTIVE_LOCALITY= 0x20,
+TPM_ACCESS_REQUEST_PENDING= 0x04,
+TPM_ACCESS_REQUEST_USE= 0x02
+};
+
+enum tis_status {
+TPM_STS_VALID= 0x80,
+TPM_STS_COMMAND_READY= 0x40,
+TPM_STS_GO= 0x20,
+TPM_STS_DATA_AVAIL= 0x10,
+TPM_STS_DATA_EXPECT= 0x08,
+TPM_STS_SELF_TEST_DONE= 0x04,
+TPM_STS_RESPONSE_RETRY= 0x02
+};
+
+struct tpm_tis_command {
+__be16 tag;
+__be32 size;
+__be32 code;
+    u8 body[0];
+} __attribute__((__packed__));
+
+/*******************************************************************************
+ * TPM TIS functions
+ */
+
+/**
+ * xapea00x_tpm_msleep - sleep for at least the specified time.
+ * @msecs: minimum duration to sleep for in milliseconds
+ */
+static void xapea00x_tpm_msleep(int msecs)
+{
+usleep_range(msecs * 1000,
+     msecs * 1000 + TPM_TIMEOUT_RANGE_US);
+}
+
+/**
+ * xapea00x_tpm_transfer - execute an SPI transfer.
+ * @dev: pointer to the device
+ * @addr: the TPM TIS register address
+ * @in: if a write or write_read transfer, the data to write
+ * @out: if a read or write_read  transfer, the buffer to read data into
+ * @len: the number of bytes to transfer
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_transfer(struct xapea00x_device *dev,
+ u32 addr, u8 *in, u8 *out, u16 len)
+{
+u8 header[4];
+int i, retval;
+
+header[0] = (in ? 0x80 : 0x00) | (len - 1);
+header[1] = 0xd4;
+header[2] = addr >> 8;
+header[3] = addr;
+
+retval = xapea00x_spi_transfer(dev, header, header, 4, 1, 0);
+if (retval)
+goto out;
+
+/* handle SPI wait states */
+if ((header[3] & 0x01) == 0x00) {
+header[0] = 0;
+
+for (i = 0; i < TPM_RETRY; i++) {
+retval = xapea00x_spi_transfer(dev, header, header, 1,
+       1, 0);
+if (retval)
+goto out;
+if ((header[0] & 0x01) == 00)
+break;
+}
+
+if (i == TPM_RETRY) {
+retval = -ETIMEDOUT;
+goto out;
+}
+}
+
+retval = xapea00x_spi_transfer(dev, out, in, len, 0, 0);
+if (retval)
+goto out;
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_read_bytes - read data from the TPM
+ * @dev: pointer to the device
+ * @addr: the register to read from
+ * @result: buffer to in which to place the read data
+ * @len: the number of bytes to read
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_read_bytes(struct xapea00x_device *dev, u32 addr,
+   void *result, u16 len)
+{
+return xapea00x_tpm_transfer(dev, addr, result, NULL, len);
+}
+
+/**
+ * xapea00x_tpm_write_bytes - write data from the TPM
+ * @dev: pointer to the device
+ * @addr: the register to write to
+ * @data: pointer to the data to write
+ * @len: the number of bytes to read
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_write_bytes(struct xapea00x_device *dev, u32 addr,
+    void *data, u16 len)
+{
+return xapea00x_tpm_transfer(dev, addr, NULL, data, len);
+}
+
+/**
+ * xapea00x_tpm_read8 - read one byte of data from the TPM
+ * @dev: pointer to the device
+ * @addr: the register to read from
+ * @result: pointer to the destination
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_read8(struct xapea00x_device *dev, u32 addr, u8 *result)
+{
+return xapea00x_tpm_read_bytes(dev, addr, result, 1);
+}
+
+/**
+ * xapea00x_tpm_write8 - write one byte of data to the TPM
+ * @dev: pointer to the device
+ * @addr: the register to write to
+ * @data:  the byte to write
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_write8(struct xapea00x_device *dev, u32 addr, u8 data)
+{
+return xapea00x_tpm_write_bytes(dev, addr, &data, 1);
+}
+
+/**
+ * xapea00x_tpm_read32 - read one integer of data from the TPM
+ * @dev: pointer to the device
+ * @addr: the register to read from
+ * @result: pointer to the destination
+ *
+ * The method performs any required endianness conversion on the
+ * result.
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_read32(struct xapea00x_device *dev, u32 addr,
+       u32 *result)
+{
+__le32 result_le;
+int retval;
+
+retval = xapea00x_tpm_read_bytes(dev, addr, &result_le,
+ sizeof(result_le));
+if (retval)
+goto out;
+
+*result = __le32_to_cpu(result_le);
+retval = 0;
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_write32 - write one integer of data to the TPM
+ * @dev: pointer to the device
+ * @addr: the register to read from
+ * @data: the integer to write
+ *
+ * The method performs any required endianness conversion on the
+ * data.
+ *
+ * Context: !in_interrupt()
+ *
+ * Return: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_write32(struct xapea00x_device *dev, u32 addr, u32 data)
+{
+__le32 data_le;
+
+data_le = __cpu_to_le32(data);
+return xapea00x_tpm_write_bytes(dev, addr, &data_le, sizeof(data_le));
+}
+
+/**
+ * xapea00x_tpm_wait_reg8 - waits for the specified flags on the
+ * register to be set.
+ * @dev: pointer to the device
+ * @addr: the register to check
+ * @flags: mask of the flags to check
+ * @timeout_msecs: maximum amount of time to wait in milliseconds
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_wait_reg8(struct xapea00x_device *dev,
+  u8 addr, u8 flags,
+  int timeout_msecs)
+{
+unsigned long stop = jiffies + msecs_to_jiffies(timeout_msecs);
+u8 reg;
+int retval;
+
+do {
+retval = xapea00x_tpm_read8(dev, addr, &reg);
+if (retval)
+goto out;
+
+if ((reg & flags) == flags) {
+retval = 0;
+goto out;
+}
+
+xapea00x_tpm_msleep(TPM_TIMEOUT);
+} while (time_before(jiffies, stop));
+
+retval = -ETIMEDOUT;
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_request_locality0 - sets the active locality to 0
+ * @dev: pointer to the device
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_request_locality0(struct xapea00x_device *dev)
+{
+int retval;
+
+retval = xapea00x_tpm_write8(dev, TPM_ACCESS_0, TPM_ACCESS_REQUEST_USE);
+if (retval)
+goto out;
+
+retval = xapea00x_tpm_wait_reg8(dev, TPM_ACCESS_0,
+TPM_ACCESS_ACTIVE_LOCALITY,
+TPM2_TIMEOUT_A);
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_release_locality0 - release the active locality
+ * @dev: pointer to the device
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0.  Otherwise a negative error code.
+ */
+static int xapea00x_tpm_release_locality0(struct xapea00x_device *dev)
+{
+return xapea00x_tpm_write8(dev, TPM_ACCESS_0,
+   TPM_ACCESS_ACTIVE_LOCALITY);
+}
+
+/**
+ * xapea00x_tpm_burst_count - fetch the number of bytes of data the
+ * TPM can currently handle in one burst.
+ * @dev: pointer to the device
+ * @counter: pointer to the destination for the count
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_burst_count(struct xapea00x_device *dev, u32 *count)
+{
+u32 reg;
+int retval;
+
+retval = xapea00x_tpm_read32(dev, TPM_STS_0, &reg);
+if (retval)
+goto out;
+
+*count = (reg >> 8) & 0xFFFF;
+retval = 0;
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_send - send the command to the TPM and execute it.
+ * @dev: pointer to the device
+ * @buf: the buffer containing the command
+ * @len: size of the buffer in bytes.
+ *
+ * N.B., the command may not fill the entire buffer. This function
+ * parses the command to determine its actual size.
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_send(struct xapea00x_device *dev, void *buf, u32 len)
+{
+struct tpm_tis_command *cmd = buf;
+u32 size, burst;
+int retval;
+
+/* wait for TPM to be ready for command */
+retval = xapea00x_tpm_wait_reg8(dev, TPM_STS_0, TPM_STS_COMMAND_READY,
+TPM2_TIMEOUT_B);
+if (retval)
+goto err;
+
+/* extract size of from header */
+size = __be32_to_cpu(cmd->size);
+
+if (size > len) {
+retval = -EINVAL;
+goto err;
+}
+
+/* Write the command */
+while (size > 0) {
+xapea00x_tpm_burst_count(dev, &burst);
+burst = min(burst, size);
+
+retval = xapea00x_tpm_write_bytes(dev, TPM_DATA_FIFO_0, buf,
+  burst);
+if (retval)
+goto cancel;
+
+retval = xapea00x_tpm_wait_reg8(dev, TPM_STS_0, TPM_STS_VALID,
+TPM2_TIMEOUT_C);
+if (retval)
+goto cancel;
+
+buf += burst;
+size -= burst;
+}
+
+/* Do it */
+retval = xapea00x_tpm_write8(dev, TPM_STS_0, TPM_STS_GO);
+if (retval)
+goto cancel;
+
+return 0;
+
+cancel:
+/* Attempt to cancel */
+xapea00x_tpm_write8(dev, TPM_STS_0, TPM_STS_COMMAND_READY);
+
+err:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_recv - recv a command response from the TPM.
+ * @dev: pointer to the device
+ * @buf: the buffer in which to store the response
+ * @len: size of the buffer in bytes.
+ *
+ * N.B., the result may not fill the entire buffer. The caller must
+ * parse the response header to determine its actual size.
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_recv(struct xapea00x_device *dev, void *buf, u32 len)
+{
+struct tpm_tis_command *cmd = buf;
+u32 burst;
+u32 size;
+int retval;
+
+/* wait for TPM to have data available */
+retval = xapea00x_tpm_wait_reg8(dev, TPM_STS_0, TPM_STS_DATA_AVAIL,
+TPM2_TIMEOUT_C);
+if (retval)
+goto cancel;
+
+/* read the header */
+if (len < TIS_HEADER_LEN) {
+retval = -EINVAL;
+goto cancel;
+}
+
+retval = xapea00x_tpm_read_bytes(dev, TPM_DATA_FIFO_0, buf,
+ TIS_HEADER_LEN);
+if (retval)
+goto cancel;
+
+/* extract size of body from header */
+size = __be32_to_cpu(cmd->size);
+if (len < size) {
+retval = -EINVAL;
+goto cancel;
+}
+
+size -= TIS_HEADER_LEN;
+buf   = &cmd->body;
+
+/* read the body */
+while (size > TIS_HEADER_LEN) {
+xapea00x_tpm_burst_count(dev, &burst);
+burst = min(burst, size);
+
+retval = xapea00x_tpm_read_bytes(dev, TPM_DATA_FIFO_0, buf,
+ burst);
+if (retval)
+goto cancel;
+
+size -= burst;
+buf += burst;
+}
+
+/* wait for valid */
+retval = xapea00x_tpm_wait_reg8(dev, TPM_STS_0, TPM_STS_VALID,
+TPM2_TIMEOUT_C);
+if (retval)
+goto err;
+
+return 0;
+
+cancel:
+xapea00x_tpm_write32(dev, TPM_STS_0, TPM_STS_COMMAND_READY);
+
+err:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_transmit - transmit one command to the TPM and receive
+ * the response.
+ * @dev: pointer to the device
+ * @buf: the buffer containing the command and to place the response in.
+ * @len: size of the buffer in bytes.
+ *
+ * N.B., the command and result may not fill the entire buffer. The
+ * caller must parse the response header to determine its actual size.
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_transmit(struct xapea00x_device *dev, void *buf,
+ u32 len)
+{
+int retval;
+
+retval = xapea00x_tpm_request_locality0(dev);
+if (retval)
+goto out;
+
+retval = xapea00x_tpm_send(dev, buf, len);
+if (retval)
+goto release;
+
+retval = xapea00x_tpm_wait_reg8(dev, TPM_STS_0, TPM_STS_DATA_AVAIL,
+TIS_LONG_TIMEOUT);
+if (retval)
+goto cancel;
+
+retval = xapea00x_tpm_recv(dev, buf, len);
+if (retval)
+goto release;
+
+retval = 0;
+goto release;
+
+cancel:
+xapea00x_tpm_write32(dev, TPM_STS_0, TPM_STS_COMMAND_READY);
+
+release:
+xapea00x_tpm_release_locality0(dev);
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_transmit_cmd - build and transmit one command to the
+ * TPM and receive the response.
+ * @dev: pointer to the device
+ * @tag: the TPM command header tag
+ * @cc: the TPM command header code
+ * @body: pointer to the command body
+ * @body_len: size in bytes of the command body
+ * @rc: pointer to the destination for the result code
+ * @result: pointer to the destination for the result body. If NULL,
+ *          the result body will be discarded.
+ * @result_len: size in bytes of the result buffer
+ * @actual_len: size in bytes of the result body. May be NULL is
+ *              result is NULL.
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_transmit_cmd(struct xapea00x_device *dev,
+     u16 tag, u32 cc, void *body, u32 body_len,
+     u32 *rc, void *result, u32 result_len,
+     u32 *actual_len)
+{
+struct tpm_tis_command *cmd;
+void *buf;
+int buflen, cmdlen, retval;
+
+buflen = TIS_MAX_BUF + 4;
+cmdlen = buflen - 2; /* reserve 2 bytes for realignment */
+
+if (body_len + TIS_HEADER_LEN > cmdlen) {
+retval = -E2BIG;
+pr_notice("transmit_cmd: body_len + TIS_HEADER_LEN > cmdlen (%d)",
+  cmdlen);
+goto out;
+}
+
+buf = kzalloc(buflen, GFP_KERNEL);
+if (!buf) {
+retval = -ENOMEM;
+goto out;
+}
+cmd = buf + 2; /* ensure all fields are properly aligned */
+
+/* Build the command */
+cmd->tag  = __cpu_to_be16(tag);
+cmd->size = __cpu_to_be32(TIS_HEADER_LEN + body_len);
+cmd->code = __cpu_to_be32(cc);
+memcpy(&cmd->body, body, body_len);
+
+/* Execute the command */
+retval = xapea00x_tpm_transmit(dev, cmd, cmdlen);
+if (retval)
+goto free;
+
+/* Extract result code */
+*rc = __be32_to_cpu(cmd->code);
+
+/* Copy the response data */
+if (result) {
+*actual_len = __be32_to_cpu(cmd->size) - TIS_HEADER_LEN;
+if (*actual_len > result_len) {
+retval = -E2BIG;
+goto free;
+}
+memcpy(result, &cmd->body, *actual_len);
+}
+
+retval = 0;
+
+free:
+memset(buf, 0, buflen);
+kzfree(buf);
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_transmit_cmd_simple - build and transmit one command to the
+ * TPM and discard the respone body.
+ * @dev: pointer to the device
+ * @tag: the TPM command header tag
+ * @cc: the TPM command header code
+ * @body: pointer to the command body
+ * @len: size in bytes of the command body
+ * @rc: pointer to the destination for the result code
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_transmit_cmd_simple(struct xapea00x_device *dev,
+    u16 tag, u32 cc,
+    void *body, u32 len, u32 *rc)
+{
+return xapea00x_tpm_transmit_cmd(dev, tag, cc, body, len, rc, NULL, 0,
+ NULL);
+}
+
+/*******************************************************************************
+ * TPM commands
+ */
+
+/**
+ * xapea00x_tpm_startup - executes the TPM2_Startup command.
+ * @dev: pointer to the device
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_startup(struct xapea00x_device *dev)
+{
+u8 body[2] = { 0x00, 0x00 };
+u32 rc;
+int retval;
+
+retval = xapea00x_tpm_transmit_cmd_simple(dev, TPM2_ST_NO_SESSIONS,
+  TPM2_CC_STARTUP, body,
+  sizeof(body), &rc);
+if (retval)
+goto out;
+
+if (rc != TPM_RC_SUCCESS && rc != TPM_RC_INITIALIZE) {
+retval = -EIO;
+goto out;
+}
+
+retval = 0;
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_self_test - executes the TPM2_SelfTest command.
+ * @dev: pointer to the device
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_self_test(struct xapea00x_device *dev)
+{
+u8 body[1] = { 0x01 };
+u32 rc;
+int retval;
+
+retval = xapea00x_tpm_transmit_cmd_simple(dev, TPM2_ST_NO_SESSIONS,
+  TPM2_CC_SELF_TEST, body,
+  sizeof(body), &rc);
+if (retval)
+goto out;
+
+if (rc != TPM_RC_SUCCESS) {
+retval = -EIO;
+goto out;
+}
+
+retval = xapea00x_tpm_wait_reg8(dev, TPM_STS_0, TPM_STS_SELF_TEST_DONE,
+TIS_LONG_TIMEOUT);
+if (retval) {
+retval = -EIO;
+goto out;
+}
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_dict_attack_lock_reset - executes the
+ * TPM2_DictionaryAttackLockReset command.
+ * @dev: pointer to the device
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int
+xapea00x_tpm_dict_attack_lock_reset(struct xapea00x_device *dev)
+{
+u8 body[17] = { 0x40, 0x00, 0x00, 0x0A, // TPM_RH_LOCKOUT
+0x00, 0x00, 0x00, 0x09, // authorizationSize
+0x40, 0x00, 0x00, 0x09, // TPM_RS_PW
+0x00, 0x00,// nonce size
+// nonce
+0x01,// session attributes
+0x00, 0x00// payload size
+// payload
+      };
+u32 rc;
+int retval;
+
+retval = xapea00x_tpm_transmit_cmd_simple(dev,
+  TPM2_ST_SESSIONS,
+  TPM2_CC_DICT_ATTACK_LOCK_RST,
+  body, sizeof(body), &rc);
+if (retval)
+goto out;
+
+if (rc != TPM_RC_SUCCESS) {
+retval = -EIO;
+goto out;
+}
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_get_random - executes the TPM2_GetRandom command.
+ * @dev: pointer to the device
+ * @len: number of bytes to request
+ * @bytes: pointer to the destination
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_get_random(struct xapea00x_device *dev, u16 len,
+   void *bytes)
+{
+__be16 body;
+u8 *buf;
+u32 buf_len, result_len;
+u32 rc;
+int retval;
+
+buf_len = len + 2;
+buf = kzalloc(buf_len, GFP_KERNEL);
+if (!buf) {
+retval = -ENOMEM;
+goto out;
+}
+
+while (len > 0) {
+body = __cpu_to_be16(len);
+
+retval = xapea00x_tpm_transmit_cmd(dev, TPM2_ST_NO_SESSIONS,
+   TPM2_CC_GET_RANDOM,
+   &body, sizeof(body),
+   &rc, buf, buf_len,
+   &result_len);
+
+if (retval)
+goto free;
+
+if (rc != TPM_RC_SUCCESS) {
+retval = -EIO;
+goto free;
+}
+
+result_len = __be16_to_cpu(*(__be16 *)buf);
+if (result_len > len) {
+retval = -E2BIG;
+goto free;
+}
+
+memcpy(bytes, buf + 2, result_len);
+len -= result_len;
+}
+
+retval = 0;
+
+free:
+memset(buf, 0, buf_len);
+kzfree(buf);
+
+out:
+return retval;
+}
+
+/**
+ * xapea00x_tpm_randomize_platform_auth - sets the platform
+ * authorization to a random password and then discards it.
+ * @dev: pointer to the device
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+static int xapea00x_tpm_randomize_platform_auth(struct xapea00x_device *dev)
+{
+u8 password[16];
+u8 body[35] = { 0x40, 0x00, 0x00, 0x0C, // TPM_RH_PLATFORM
+0x00, 0x00, 0x00, 0x09, // authorizationSize
+0x40, 0x00, 0x00, 0x09, // TPM_RS_PW
+0x00, 0x00,// nonce size
+// nonce
+0x01,// session attributes
+0x00, 0x00,// old auth payload size
+// old auth payload
+0x00, 0x10,// new auth payload size
+0x00, 0x00, 0x00, 0x00, // new auth payload
+0x00, 0x00, 0x00, 0x00, // new auth payload
+0x00, 0x00, 0x00, 0x00, // new auth payload
+0x00, 0x00, 0x00, 0x00// new auth payload
+      };
+u32 rc;
+int retval;
+
+retval = xapea00x_tpm_get_random(dev, sizeof(password), password);
+if (retval) {
+dev_err(&dev->interface->dev,
+"TPM get random failed with %d\n", retval);
+goto out;
+}
+
+memcpy(body + 19, password, sizeof(password));
+
+retval = xapea00x_tpm_transmit_cmd_simple(dev, TPM2_ST_SESSIONS,
+  TPM2_CC_HIERARCHY_CHANGE_AUTH,
+  &body, sizeof(body), &rc);
+if (retval)
+goto out;
+
+if (rc != TPM_RC_SUCCESS) {
+retval = -EIO;
+pr_notice("HierarchyChangeAuth result code: %d\n", rc);
+goto out;
+}
+
+retval = 0;
+
+out:
+memset(password, 0, sizeof(password));
+memset(body, 0, sizeof(body));
+return retval;
+}
+
+/**
+ * xapea00x_tpm_platform_initialize - performs the minimal
+ * initialization of the TPM normally performed by the platform code
+ * (e.g., BIOS). This consists of executing the TPM startup and
+ * self-test commands and setting the platform authorization password.
+ *
+ * @dev: pointer to the device
+ *
+ * Context: !in_interrupt()
+ *
+ * Result: If successful, 0. Otherwise a negative error code.
+ */
+int xapea00x_tpm_platform_initialize(struct xapea00x_device *dev)
+{
+int retval;
+
+/* wait for TPM to be ready */
+retval =  xapea00x_tpm_wait_reg8(dev, TPM_ACCESS_0, TPM_ACCESS_VALID,
+ TPM2_TIMEOUT_A);
+if (retval)
+goto out;
+
+/* issue TPM2_CC_STARTUP command */
+retval = xapea00x_tpm_startup(dev);
+if (retval) {
+dev_err(&dev->interface->dev, "TPM startup failed with %d\n",
+retval);
+goto out;
+}
+
+/* issue TPM2_SELF_TEST command */
+retval = xapea00x_tpm_self_test(dev);
+if (retval) {
+dev_err(&dev->interface->dev, "TPM self-test failed with %d\n",
+retval);
+goto out;
+}
+
+/*
+ * The TPM will enter dictionary lockout mode if turned off
+ * too many times without a proper shutdown. For the
+ * "thumb-drive"-esque demo devices, this happens whenever it
+ * is unplugged. Dictionary attacks against the demo devices
+ * (XAP-EA-00{1,2}) don't matter, so reset the lockout on every
+ * boot. Production devices (XAP-EA-003) are internal mPCI-e
+ * devices that should not be hot-plugged, so do not need to be
+ * reset.
+ */
+if (dev->pid == USB_PRODUCT_ID_XAPEA001 ||
+    dev->pid == USB_PRODUCT_ID_XAPEA002) {
+retval = xapea00x_tpm_dict_attack_lock_reset(dev);
+if (retval) {
+dev_err(&dev->interface->dev,
+"Resetting TPM lockout failed with %d\n",
+retval);
+goto out;
+}
+}
+
+/* set the platform authorization to random bytes */
+retval = xapea00x_tpm_randomize_platform_auth(dev);
+if (retval) {
+dev_err(&dev->interface->dev,
+"Setting TPM platform auth failed with %d\n",
+retval);
+goto out;
+}
+
+retval = 0;
+
+out:
+return retval;
+}
--
2.16.3

________________________________

Jeremy Boone
Principal Security Consultant
NCC Group
51 Breithaupt Street,
Suite 100, Kitchener, N2H 5G5

Telephone: +1 226 606 8318<tel:+1 226 606 8318>
Mobile: +1 226 606 8318<tel:+1 226 606 8318>
Website: www.nccgroup.trust<http://www.nccgroup.trust>
Twitter: @NCCGroupplc<https://twitter.com/NCCGroupplc>
        [https://www.nccgroup.trust/static/img/emaillogo/ncc-group-logo.png]  <http://www.nccgroup.trust/>
________________________________


This email is sent for and on behalf of NCC Group. NCC Group is the trading name of NCC Services Limited (Registered in England CRN: 2802141). The ultimate holding company is NCC Group plc (Registered in England CRN: 4627044). This email may be confidential and/or legally privileged.
