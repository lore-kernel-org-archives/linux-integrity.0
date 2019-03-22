Return-Path: <SRS0=JOkf=RZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC98C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E1E218D3
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b="E4zPyreb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfCVIfD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:03 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:43536 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfCVIfC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:02 -0400
Received: by mail-qk1-f176.google.com with SMTP id c20so716270qkc.10
        for <linux-integrity@vger.kernel.org>; Fri, 22 Mar 2019 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Er3oFsIOCvxKt5MsoXkmkWsUWbLywGi6D9GPsEPoFyY=;
        b=E4zPyrebbceuVVf5IMU/iMY8g0E7nw9ingTUTZ75woXzSds79lTG1JZlxDcStFzX0+
         q5b5rmzdjwFE++3qFDHVbySazFkV90Ihy25sDdI5ZDAuFFyxFcGMv3J4kLePcXmceBUQ
         tdepDz1EII+VBKFK1Rct1V1mlBo1GMbojnkY6LJMkvyL7T3TygqZJ1CBwE62zfYeo8r+
         6nq4ARancQKg44xAd98K7K2JLhWGIFvJkJRJ56khxS5s6whY5Nw4pDO77eH2oisDClev
         4SDbFN9m8OKoBH1yuz1gVGKzHXvr/ZF06DdGwTQuTOP3LZKr24J7xTfTX8lM9RYbyKi2
         MHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Er3oFsIOCvxKt5MsoXkmkWsUWbLywGi6D9GPsEPoFyY=;
        b=EhvczMT/NxOohc96W9+JNRErtfHBdfOZliWlaj2cHEnU68suksZfaOEqLtBQGNge3g
         7BSMCPknKkuWxg/D8yWCc9WqMxpebB6b+OejGB0LDV+WL1V6YHKeubjSGRrn/3M992Cu
         Oy06IDy9/Q76G3ZjWRfHKLFVt5vncHs6ZaKeCahe97miuIelARiBnLXHE7yQERWOhFPD
         Rm/3lM/YHY5r/1o97CqpJTXbnycUWLbczG7xKV2tYxeWLc3iJa42QmUVU/u0n8mxIzZl
         1j43L7aZl131zwADAXpCiUmgw9+qpE1XF2Q15B2Y8uMm4ZUGvNDF2SnxYjXoekS6yBRm
         zwbQ==
X-Gm-Message-State: APjAAAX21OLvEiz4n4GD9JI+Ovjw0uCpFrgZEI8RmVq0CJikLDZtK/pH
        pZynTH87o0ueVXVVS+3EZzO0jiLBQijfMg==
X-Google-Smtp-Source: APXvYqyZnJzvNLJgKrjPqz8K/HWZBy+DDZ1uFHflcivvYKvjWs9R80sugazxFJDwjEwsTlQT9qXZUQ==
X-Received: by 2002:a37:9bc7:: with SMTP id d190mr2456066qke.348.1553243701479;
        Fri, 22 Mar 2019 01:35:01 -0700 (PDT)
Received: from localhost.localdomain ([194.59.251.45])
        by smtp.gmail.com with ESMTPSA id u16sm7441870qtc.84.2019.03.22.01.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 01:35:01 -0700 (PDT)
From:   djacobs7@binghamton.edu
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, pvorel@suse.cz, vt@altlinux.org,
        David Jacobson <djacobs7@binghamton.edu>
Subject: [PATCH v2 2/8] evmtest: test loading IMA policies
Date:   Fri, 22 Mar 2019 04:34:35 -0400
Message-Id: <20190322083441.31084-2-djacobs7@binghamton.edu>
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

IMA can be configured to require signatures on policies before loading
them. This test verifies that IMA correctly validates signatures, and
rejects policies that lack signatures or have been signed by an
unauthorized party (i.e. certificate is not on the appropriate keyring).

This test requires root privileges in order to write to securityfs
files.

Signed-off-by: David Jacobson <djacobs7@binghamton.edu>

Changelog:
* Placed policy_sig on list of tests
* make sure key exists
* shellcheck compliant
* Update makefiles with tests instead of functions
* removed begin
* removed long opts
* Notes file is updated in correct patch
* restructure to use functions
* reword usage
* reworded patch title
* Fixed changes in Notes
* renamed key
* Cut down on functions
---
 evmtest/Makefile.am                          |   6 +-
 evmtest/README                               |   1 +
 evmtest/evmtest                              |   1 +
 evmtest/files/Notes                          |  16 +++
 evmtest/files/policies/signed_policy         |   2 +
 evmtest/files/policies/unknown_signed_policy |   1 +
 evmtest/files/policies/unsigned_policy       |   1 +
 evmtest/tests/policy_sig.sh                  | 110 +++++++++++++++++++
 evmtest/unknown_privkey_ima.pem              |  16 +++
 9 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 evmtest/files/policies/signed_policy
 create mode 100644 evmtest/files/policies/unknown_signed_policy
 create mode 100644 evmtest/files/policies/unsigned_policy
 create mode 100755 evmtest/tests/policy_sig.sh
 create mode 100644 evmtest/unknown_privkey_ima.pem

diff --git a/evmtest/Makefile.am b/evmtest/Makefile.am
index e74feaf..496a5de 100644
--- a/evmtest/Makefile.am
+++ b/evmtest/Makefile.am
@@ -14,9 +14,13 @@ evmtest.1:
 install:
 	install -m 755 evmtest $(bindir)
 	install -d $(datarootdir)/evmtest/files/
+	install -d $(datarootdir)/evmtest/files/policies
 	install -d $(datarootdir)/evmtest/tests/
-	install -D $$(find ./files/ -not -type d)  $(datarootdir)/evmtest/files/
+	install -D \
+	$$(find ./files/ -not -type d -not -path "./files/policies/*")  \
+	$(datarootdir)/evmtest/files/
 	install -D ./tests/* $(datarootdir)/evmtest/tests/
+	install -D ./files/policies/* $(datarootdir)/evmtest/files/policies/
 	cp evmtest.1 $(datarootdir)/man/man1
 	mandb -q
 
diff --git a/evmtest/README b/evmtest/README
index 5a44070..480f426 100644
--- a/evmtest/README
+++ b/evmtest/README
@@ -38,6 +38,7 @@ TEST NAMES
 
  env_validate - verify kernel build
  example_test - example test
+ policy_sig - verify loading IMA policies
 
 
 Introduction
diff --git a/evmtest/evmtest b/evmtest/evmtest
index d579d03..9902e61 100755
--- a/evmtest/evmtest
+++ b/evmtest/evmtest
@@ -28,6 +28,7 @@ usage (){
 	# placement of a script in tests/
 	echo "[R]	env_validate"
 	echo "[ ]	examples_test"
+	echo "[R]	policy_sig"
 
 	echo ""
 	echo "Note: Tests may be run directly from the \"tests\" directory"
diff --git a/evmtest/files/Notes b/evmtest/files/Notes
index f20a272..8aa2670 100644
--- a/evmtest/files/Notes
+++ b/evmtest/files/Notes
@@ -3,3 +3,19 @@ This file contains a description of the contents of this directory.
 1. common.sh
 
 This file contains useful functions and variables for evmtest scripts.
+
+2. load_policy.sh
+
+This is a script to load policies. The first time this is called, it will
+replace the existing policy. Subsequent calls will append additional rules to
+the existing policy.
+
+3. policies/
+
+This is a directory that contains IMA policies with self explanatory names.
+
+4. unknown_privkey_ima.pem
+
+This file was generated such that its corresponding public key could be placed
+on the IMA Trusted Keyring, however, it has not. Therefore, any policy (or file)
+signed by this key cannot be verified, and is untrusted.
diff --git a/evmtest/files/policies/signed_policy b/evmtest/files/policies/signed_policy
new file mode 100644
index 0000000..87828f0
--- /dev/null
+++ b/evmtest/files/policies/signed_policy
@@ -0,0 +1,2 @@
+measure func=POLICY_CHECK
+appraise func=POLICY_CHECK appraise_type=imasig
diff --git a/evmtest/files/policies/unknown_signed_policy b/evmtest/files/policies/unknown_signed_policy
new file mode 100644
index 0000000..1f8f8f4
--- /dev/null
+++ b/evmtest/files/policies/unknown_signed_policy
@@ -0,0 +1 @@
+audit func=POLICY_CHECK
diff --git a/evmtest/files/policies/unsigned_policy b/evmtest/files/policies/unsigned_policy
new file mode 100644
index 0000000..1f8f8f4
--- /dev/null
+++ b/evmtest/files/policies/unsigned_policy
@@ -0,0 +1 @@
+audit func=POLICY_CHECK
diff --git a/evmtest/tests/policy_sig.sh b/evmtest/tests/policy_sig.sh
new file mode 100755
index 0000000..174d111
--- /dev/null
+++ b/evmtest/tests/policy_sig.sh
@@ -0,0 +1,110 @@
+#!/bin/bash
+TEST="policy_sig"
+# Author: David Jacobson <davidj@linux.ibm.com>
+
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+#shellcheck source=/usr/local/share/evmtest/files/common.sh
+source "$ROOT"/files/common.sh
+
+VERBOSE=0
+POLICY_LOAD="$ROOT"/files/load_policy.sh
+# This test validates that IMA measures and appraises policies.
+usage() {
+	echo ""
+	echo "policy_sig -k <key> [-vh]"
+	echo ""
+	echo "  This test first loads a policy requiring all subsequent"
+	echo "	policies to be signed, and verifies that only signed policies"
+	echo "	may then be loaded."
+	echo ""
+	echo "  Loading policy rules requires root privilege. This test must be"
+	echo "	executed as root."
+	echo ""
+	echo "  -k	The key for the certificate on the IMA keyring"
+	echo "  -h	Display this help message"
+	echo "  -v	Verbose logging"
+}
+
+parse_args () {
+	TEMP=$(getopt -o 'k:hv' -n 'policy_sig' -- "$@")
+	eval set -- "$TEMP"
+
+	while true ; do
+		case "$1" in
+			-h) usage; exit 0; shift;;
+			-k) IMA_KEY=$2; shift 2;;
+			-v) VERBOSE=1; shift;;
+			--) shift; break;;
+			*) echo "[*] Unrecognized option $1"; exit 1 ;;
+		esac
+	done
+
+	if [ -z "$IMA_KEY" ]; then
+		usage
+		exit 1
+	fi
+
+	if [ ! -f "$IMA_KEY" ]; then
+		cleanup
+		fail "Missing key"
+	fi
+}
+
+load_signed_policy () {
+	v_out "Signing policy with provided key..."
+	if ! evmctl ima_sign -f "$POLICY_PATH" -k "$IMA_KEY" &>> /dev/null; then
+		cleanup
+		fail "Failed to sign policy - check key file"
+	fi
+
+	v_out "Loading policy..."
+	if ! "$POLICY_LOAD" signed_policy &>> /dev/null; then
+		cleanup
+		fail "Failed to write policy. "
+	fi
+	v_out "Loaded"
+}
+
+load_unsigned_policy () {
+	v_out "Attempting to load unsigned policy..."
+	if "$POLICY_LOAD" unsigned_policy &>> /dev/null; then
+		cleanup
+		fail "Failed to reject unsigned policy"
+	fi
+
+	v_out "IMA Blocked unsigned policy"
+}
+
+load_unknown_key_policy () {
+	v_out "Signing policy with invalid key..."
+	evmctl ima_sign -f "$ROOT"/files/policies/unknown_signed_policy \
+		-k "$ROOT"/files/unknown_privkey_ima.pem &>> /dev/null
+
+	v_out "Attempting to load policy signed by invalid key..."
+	if "$POLICY_LOAD" unknown_signed_policy &>> /dev/null; then
+		cleanup
+		fail "Failed to reject policy signed by unknown key"
+	fi
+
+	v_out "IMA blocked policy signed by unknown key"
+}
+
+cleanup () {
+	v_out "Removing security.ima attribute from policies..."
+	setfattr -x security.ima "$ROOT"/files/policies/unsigned_policy &>> \
+		/dev/null
+	setfattr -x security.ima "$ROOT"/files/policies/unknown_signed_policy \
+		&>> /dev/null
+	v_out "Done"
+}
+
+POLICY_PATH="$ROOT"/files/policies/signed_policy
+
+EVMTEST_require_root
+echo "[*] Starting test: $TEST"
+parse_args "$@"
+load_signed_policy
+load_unsigned_policy
+load_unknown_key_policy
+cleanup
+passed
diff --git a/evmtest/unknown_privkey_ima.pem b/evmtest/unknown_privkey_ima.pem
new file mode 100644
index 0000000..dcc0e24
--- /dev/null
+++ b/evmtest/unknown_privkey_ima.pem
@@ -0,0 +1,16 @@
+-----BEGIN PRIVATE KEY-----
+MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMOnki6OKMHExpH1
+IWgUlPWWSbsDpW1lpqXMj0/ZWo9xU5W2xZC53TVArUGOImQ5PcMNkw1VcHhKbFKO
+jYT0gEE0Sv+VbePiEnhUheFOWUxNNFE3DVQaOpBN0OzsUCSGX9RKIIwkIAwJkvWA
+MHzR4ZPQGGM9hMJKhEvlTG4PP96LAgMBAAECgYBKVKVCrptpUhqmZNx2MCuPSbNl
+KzNz5kRzhM2FZmvzRvicTj2siBA0JQgteZQzQ1PlgIi3bhg2ev/ANYwqUMFQWZv9
+zm5d4P7Zsdyle15MDTSrQIaroeb1nbfNvaB0L4D4Inv0p6ksyIFp7TR5MLVenC5k
+bxfESVWVPDseiAFKUQJBAPQ/x3LmnT0RiMeX6quCGAON7DGpV5KFwL97luWO6vH+
+qZ2W1/J0UxTbruv7rA+tj3ZXpdNOxfmq+JStY0jrJV0CQQDNEUqomnA183rX0dv8
+MWyOPmX0Z9SMSTRvflNRW85Bzbosq68uLTq3qOBj+td9zUlopsLpJlfF0Vc+moff
+uq0HAkEAi/Sz47oTZXfTqZL6TBZ6jibXrck8PeBYhyBZYebX55ymMn/J88sGBFCx
+VdVbTYyFRSmKAqADv0FhuUf1OUZMnQJAOayjUsgcxw+zfP+I32UHIvppslOBc/Mi
+zDi7Niab2+YAdo/StSoDWaQld/kUok0aWFSOfQRLq1c1MmZD0KiwAQJANY0LopqG
+pxACc4/QawxtBoV1a8j5Zui8LZPRtKwjkA30Nq8fOufzMuBeJIlLap45uD1xC7St
+bsPWG5+uz18e5w==
+-----END PRIVATE KEY-----
-- 
2.20.1

