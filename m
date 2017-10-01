Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from blatinox.fr ([51.254.120.209]:33869 "EHLO vps202351.ovh.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbdJATlO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Oct 2017 15:41:14 -0400
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>
To: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] tpm: use ARRAY_SIZE
Date: Sun,  1 Oct 2017 15:30:51 -0400
Message-Id: <20171001193101.8898-14-jeremy.lefaure@lse.epita.fr>
In-Reply-To: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Using the ARRAY_SIZE macro improves the readability of the code.

Found with Coccinelle with the following semantic patch:
@r depends on (org || report)@
type T;
T[] E;
position p;
@@
(
 (sizeof(E)@p /sizeof(*E))
|
 (sizeof(E)@p /sizeof(E[...]))
|
 (sizeof(E)@p /sizeof(T))
)

Signed-off-by: Jeremy Lefaure <jeremy.lefaure@lse.epita.fr>
---
 drivers/char/tpm/tpm_tis.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index ebd0e75a3e4d..e2d1055fb814 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -30,6 +30,7 @@
 #include <linux/freezer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/kernel.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
@@ -365,7 +366,7 @@ static struct pnp_driver tis_pnp_driver = {
 	},
 };
 
-#define TIS_HID_USR_IDX sizeof(tpm_pnp_tbl)/sizeof(struct pnp_device_id) -2
+#define TIS_HID_USR_IDX (ARRAY_SIZE(tpm_pnp_tbl) - 2)
 module_param_string(hid, tpm_pnp_tbl[TIS_HID_USR_IDX].id,
 		    sizeof(tpm_pnp_tbl[TIS_HID_USR_IDX].id), 0444);
 MODULE_PARM_DESC(hid, "Set additional specific HID for this driver to probe");
-- 
2.14.1
