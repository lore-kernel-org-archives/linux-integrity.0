Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3011BC433F5
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Sep 2021 14:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191DB60FA0
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Sep 2021 14:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbhIMOvs (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 13 Sep 2021 10:51:48 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:42991 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1347151AbhIMOsZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 10:48:25 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 18DEiZGw003117;
        Mon, 13 Sep 2021 17:44:35 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 41AE863A1D; Mon, 13 Sep 2021 17:44:45 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v14 7/7] \tpm: Add YAML schema for TPM TIS I2C options
Date:   Mon, 13 Sep 2021 17:43:51 +0300
Message-Id: <20210913144351.101167-8-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20210913144351.101167-1-amirmizi6@gmail.com>
References: <20210913144351.101167-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Add a YAML schema to support tpm tis i2c related dt-bindings for the I2c
PTP based physical layer.

This patch adds the documentation for corresponding device tree bindings of
I2C based Physical TPM.
Refer to the 'I2C Interface Definition' section in
'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
for specification.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 .../bindings/security/tpm/tpm-tis-i2c.yaml         | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
new file mode 100644
index 0000000..217ba8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C PTP based TPM Device Tree Bindings
+
+maintainers:
+  - Amir Mizinski <amirmizi6@gmail.com>
+
+description:
+  Device Tree Bindings for I2C based Trusted Platform Module(TPM).
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # Nuvoton's Trusted Platform Module (TPM) (NPCT75x)
+          - nuvoton,npct75x
+      - const: tcg,tpm-tis-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupt:
+    maxItems: 1
+
+  crc-checksum:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set this flag to enable CRC checksum.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      tpm@2e {
+        compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+        reg = <0x2e>;
+        crc-checksum;
+      };
+    };
+...
-- 
2.7.4

