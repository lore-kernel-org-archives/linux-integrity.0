Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:65061 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753710AbdJPRbG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Oct 2017 13:31:06 -0400
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
Date: Mon, 16 Oct 2017 19:30:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Oct 2017 19:12:34 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation
    in tpm_ascii_bios_measurements_show()
  Delete an error message for a failed memory allocation in tpm_ibmvtpm_probe()
  Improve a size determination in nine functions
  Less checks in tpm_ibmvtpm_probe() after error detection

 drivers/char/tpm/st33zp24/i2c.c      |  3 +--
 drivers/char/tpm/st33zp24/spi.c      |  3 +--
 drivers/char/tpm/st33zp24/st33zp24.c |  3 +--
 drivers/char/tpm/tpm1_eventlog.c     |  5 +----
 drivers/char/tpm/tpm_crb.c           |  2 +-
 drivers/char/tpm/tpm_i2c_atmel.c     |  2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  2 +-
 drivers/char/tpm/tpm_ibmvtpm.c       | 23 +++++++++--------------
 drivers/char/tpm/tpm_tis.c           |  2 +-
 drivers/char/tpm/tpm_tis_spi.c       |  3 +--
 10 files changed, 18 insertions(+), 30 deletions(-)

-- 
2.14.2
