Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56723 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeDRLVK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Apr 2018 07:21:10 -0400
From: Colin King <colin.king@canonical.com>
To: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/st33zp24: Fix spelling mistake in macro ST33ZP24_TISREGISTER_UKNOWN
Date: Wed, 18 Apr 2018 12:21:05 +0100
Message-Id: <20180418112105.894-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Fix spelling mistake, rename ST33ZP24_TISREGISTER_UKNOWN to
ST33ZP24_TISREGISTER_UNKNOWN

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/tpm/st33zp24/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index 0fc4f20b5f83..d7909ab287a8 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -40,7 +40,7 @@
 #define ST33ZP24_OK					0x5A
 #define ST33ZP24_UNDEFINED_ERR				0x80
 #define ST33ZP24_BADLOCALITY				0x81
-#define ST33ZP24_TISREGISTER_UKNOWN			0x82
+#define ST33ZP24_TISREGISTER_UNKNOWN			0x82
 #define ST33ZP24_LOCALITY_NOT_ACTIVATED			0x83
 #define ST33ZP24_HASH_END_BEFORE_HASH_START		0x84
 #define ST33ZP24_BAD_COMMAND_ORDER			0x85
@@ -84,7 +84,7 @@ static int st33zp24_status_to_errno(u8 code)
 		return 0;
 	case ST33ZP24_UNDEFINED_ERR:
 	case ST33ZP24_BADLOCALITY:
-	case ST33ZP24_TISREGISTER_UKNOWN:
+	case ST33ZP24_TISREGISTER_UNKNOWN:
 	case ST33ZP24_LOCALITY_NOT_ACTIVATED:
 	case ST33ZP24_HASH_END_BEFORE_HASH_START:
 	case ST33ZP24_BAD_COMMAND_ORDER:
-- 
2.17.0
