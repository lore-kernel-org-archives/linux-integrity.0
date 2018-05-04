Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:38221 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeEDNB2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 May 2018 09:01:28 -0400
Received: by mail-it0-f65.google.com with SMTP id q4-v6so3262098ite.3
        for <linux-integrity@vger.kernel.org>; Fri, 04 May 2018 06:01:27 -0700 (PDT)
From: "David R. Bild" <david.bild@xaptum.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-integrity@vger.kernel.org,
        "David R. Bild" <david.bild@xaptum.com>
Subject: [PATCH v3 0/2] Add driver for Xaptum ENF Access card (XAP-EA-00x)
Date: Fri,  4 May 2018 08:00:20 -0500
Message-Id: <20180504130022.5231-1-david.bild@xaptum.com>
In-Reply-To: <20180430125418.31344-1-david.bild@xaptum.com>
References: <20180430125418.31344-1-david.bild@xaptum.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This series add a driver for the Xaptum ENF Access card line
(XAP-EA-00x), a series of mini PCI-e cards containing a TPM 2.0 chip
used to authenticate IoT devices and gateways.

The hardware is essentially a USB-SPI bridge and an SPI TPM 2.0
chip. The first patch registers the bridge as an SPI controller and
the TPM as an SPI device. The second patch performs the TPM platform
initialization that would normally be done by the BIOS.

The TPM portions need review from the TPM maintainers, before Greg can
accept it in the USB tree.

Changes since v2:
 * Depend on (not select) SPI and TPM support
 * Remove noisy logging
 * Do not explicitly specify MODULE_ALIAS
 * Use KBUILD_MODNAME macro for module name
 * Clean up formatting & indentation

David R. Bild (2):
  usb: misc: xapea00x: add driver for Xaptum ENF Access Card
  usb: misc: xapea00x: perform platform initialization of TPM

 MAINTAINERS                                 |   6 +
 drivers/usb/misc/Kconfig                    |   2 +
 drivers/usb/misc/Makefile                   |   1 +
 drivers/usb/misc/xapea00x/Kconfig           |  14 +
 drivers/usb/misc/xapea00x/Makefile          |   8 +
 drivers/usb/misc/xapea00x/xapea00x-bridge.c | 380 +++++++++++
 drivers/usb/misc/xapea00x/xapea00x-core.c   | 433 +++++++++++++
 drivers/usb/misc/xapea00x/xapea00x-spi.c    | 196 ++++++
 drivers/usb/misc/xapea00x/xapea00x-tpm.c    | 952 ++++++++++++++++++++++++++++
 drivers/usb/misc/xapea00x/xapea00x.h        |  75 +++
 10 files changed, 2067 insertions(+)
 create mode 100644 drivers/usb/misc/xapea00x/Kconfig
 create mode 100644 drivers/usb/misc/xapea00x/Makefile
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x-bridge.c
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x-core.c
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x-spi.c
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x-tpm.c
 create mode 100644 drivers/usb/misc/xapea00x/xapea00x.h

-- 
2.16.3
