Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:53680 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933452AbeFVKIW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jun 2018 06:08:22 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] MAINTAINERS: Add file patterns for tpm device tree bindings
Date: Fri, 22 Jun 2018 12:08:19 +0200
Message-Id: <20180622100819.29518-1-geert@linux-m68k.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v3:
  - Update for next-20180622,

v2:
  - Add Acked-by.

Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/security/tpm/":

-Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:2/2=100%,authored:1/2=50%)
-Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:1/2=50%)
-Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> (commit_signer:2/2=100%)
-Enric Balletbo i Serra <enric.balletbo@collabora.com> (commit_signer:1/2=50%,authored:1/2=50%)
-Sonny Rao <sonnyrao@chromium.org> (commit_signer:1/2=50%)
+Peter Huewe <peterhuewe@gmx.de> (maintainer:TPM DEVICE DRIVER)
+Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> (maintainer:TPM DEVICE DRIVER)
+Jason Gunthorpe <jgg@ziepe.ca> (reviewer:TPM DEVICE DRIVER)
+Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
+Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
+linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER)
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel@vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c546cf9a53ca301..1030624a6e113786 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14481,6 +14481,7 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
 T:	git git://git.infradead.org/users/jjs/linux-tpmdd.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/security/tpm/
 F:	drivers/char/tpm/
 
 TRACING
-- 
2.17.1
