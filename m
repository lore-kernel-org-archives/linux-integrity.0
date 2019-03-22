Return-Path: <SRS0=JOkf=RZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03228C10F0E
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C778E2083D
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b="HggEDh+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfCVIfJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45304 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfCVIfI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so1553986qtv.12
        for <linux-integrity@vger.kernel.org>; Fri, 22 Mar 2019 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyR5K000eJqDJS2DYCuM2fzt+a01LslORKwShJPCIkI=;
        b=HggEDh+WehkMnrpSFHpp0f11kdWfugptRsPBK5fvEj0QpDbv53G9Hcw+RebQqOzCis
         ULpf22W8E2mVn4LSAYOoprBmv5Mp/nUH5l7+rouxxvDI6LDcuTUQitX1BTV1nGnZUJ7C
         +LdtHzDvep7QKPKXfIYDl9A2hm1bPvVUbNeMVCT6KiVc8e4CpJL/eVf5St4372dK5L9i
         9OuXdz0zwEqLmk+7UtyIxZd8Kg6cNkPoa0h7Is+vuN+h8v6Qbh/W+bp9P/KVDdjVrFAo
         UL2Erbr4z4cl8YGoPZuOa8i9lzTmI2EPfDNWkF1OPXpDL/smWpOtVjMU9d/FQUqPvjLk
         BR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyR5K000eJqDJS2DYCuM2fzt+a01LslORKwShJPCIkI=;
        b=BuRu0dEudCZvPn4Phg48zqUtKsz+CKdl53U63sgXPigDJRY53MqP1EmhVvBoYlM+1x
         TVHnmP4JMSRlqCtlGlNF830hhW+xg0e6nMU8I2nm8Oq+Kw8hqJKHAk0PZRIkm4MPXFgg
         JEYODCwbrciMjR+OjVzrVG1JGP7x8q8ybBccW5DXlDjj26+ktB2DV60Awv+DXkYSoTfs
         SV9CFhrNdUrtyGRnuE9xSZ7W/P5RwgSFcRykBEkp7pmlyFJv+M4HsmkV3gMU1T8QGTKq
         tvrhnBNgGTWHJhE0Up/pUJ/F00DyAqXn/9uM6YrQzp1uvqnbtVDXxWcMWi8/ASTEsnK1
         iuIg==
X-Gm-Message-State: APjAAAUAerTM8Te2a3aFXjThFFW+mWz6SFAQttsV8wdRHfqI0qxHPi5e
        bWmoVH04HfoVcVKPZtv/ATPDuMDQsCLMUQ==
X-Google-Smtp-Source: APXvYqzcfm/HHhcnTTmMRlkLsiJWZP0e96qeIDSYtvQ+TQCaEwBUIMOJukaxavKymlOUwrhbd+DjbQ==
X-Received: by 2002:ac8:1b63:: with SMTP id p32mr7142703qtk.173.1553243706447;
        Fri, 22 Mar 2019 01:35:06 -0700 (PDT)
Received: from localhost.localdomain ([194.59.251.45])
        by smtp.gmail.com with ESMTPSA id u16sm7441870qtc.84.2019.03.22.01.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 01:35:05 -0700 (PDT)
From:   djacobs7@binghamton.edu
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, pvorel@suse.cz, vt@altlinux.org,
        David Jacobson <djacobs7@binghamton.edu>
Subject: [PATCH v2 8/8] evmtest: virtual machine compatibility
Date:   Fri, 22 Mar 2019 04:34:41 -0400
Message-Id: <20190322083441.31084-8-djacobs7@binghamton.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322083441.31084-1-djacobs7@binghamton.edu>
References: <20190322083441.31084-1-djacobs7@binghamton.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: David Jacobson <djacobs7@binghamton.edu>

Regression testing kernels is a task that is often virtualized. This
patch adds functionality to evmtest that enables a developer to
determine if their kernel build is suitable for running in a virtual
machine.

Signed-off-by: David Jacobson <djacobs7@binghamton.edu>

changelog:
* shellcheck compliant
* updated patch to work with function restructure
---
 evmtest/tests/env_validate.sh | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/evmtest/tests/env_validate.sh b/evmtest/tests/env_validate.sh
index c630a23..09b1a87 100755
--- a/evmtest/tests/env_validate.sh
+++ b/evmtest/tests/env_validate.sh
@@ -4,12 +4,13 @@
 TEST="env_validate"
 ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
 source "$ROOT"/files/common.sh
+VM_VALIDATE=0
 VERBOSE=0
 CONFIG_FILE=""
 
 usage () {
 	echo ""
-	echo "env_validate [-c <config>]|-r] [-vh]"
+	echo "env_validate [-c <config>]|-r] [--vm] [-vh]"
 	echo ""
 	echo "	This test validates that a kernel is properly configured, "
 	echo "	based on either the provided config file or the builtin"
@@ -18,12 +19,13 @@ usage () {
 	echo "	-c	Kernel config file"
 	echo "	-r	Will attempt to pull running config"
 	echo "	-v	Verbose testing"
+	echo "	--vm	Will validate that the build is VM compatible"
 	echo "	-h	Displays this help message"
 	echo ""
 }
 
 parse_args () {
-	TEMP=$(getopt -o 'hc:rv' -n 'env_validate' -- "$@")
+	TEMP=$(getopt -o 'hc:rv' -l "vm" -n 'env_validate' -- "$@")
 	eval set -- "$TEMP"
 
 	while true ; do
@@ -32,6 +34,7 @@ parse_args () {
 		-c) CONFIG="$2"; shift 2;;
 		-r) RUNNING=1; shift;;
 		-v) VERBOSE=1; shift;;
+		--vm) VM_VALIDATE=1; shift;;
 		--) shift; break;;
 		*) echo "[*] Unrecognized option $1"; exit 1 ;;
 		esac
@@ -154,6 +157,22 @@ check_config () {
 	validate_defined "CONFIG_MODULE_SIG_KEY"
 	validate "CONFIG_MODULE_SIG" "y"
 
+
+	if [ $VM_VALIDATE == 1 ]; then
+		v_out "Validating VM configuration"
+
+		validate "CONFIG_BLK_MQ_VIRTIO" "y"
+		validate "CONFIG_MEMORY_BALLOON" "y"
+		validate "CONFIG_VIRTIO_BLK" "y"
+		validate "CONFIG_SCSI_VIRTIO" "y"
+		validate "CONFIG_HW_RANDOM_VIRTIO" "y"
+		validate "CONFIG_VIRTIO" "y"
+		validate "CONFIG_VIRTIO_MENU" "y"
+		validate "CONFIG_VIRTIO_PCI" "y"
+		validate "CONFIG_VIRTIO_PCI_LEGACY" "y"
+		validate "CONFIG_VIRTIO_BALLOON" "y"
+	fi
+
 	if [ ${#INVALID_DEFINITION[@]} != 0 ]; then
 		v_out "The following Kconfig variables are incorrectly defined:"
 		for var in "${INVALID_DEFINITION[@]}"; do
-- 
2.20.1

