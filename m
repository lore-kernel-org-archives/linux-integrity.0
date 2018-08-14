Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728618AbeHNUyb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:31 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI49Ja013855
        for <linux-integrity@vger.kernel.org>; Tue, 14 Aug 2018 14:06:12 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv3cshqe1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 Aug 2018 14:06:12 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:06:08 -0600
From: David Jacobson <davidj@linux.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 7/7] emvtest: Add ability to run all tests
Date: Tue, 14 Aug 2018 14:05:51 -0400
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
Message-Id: <20180814180551.28311-7-davidj@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

evmtest tests functionality of different IMA-Appraisal policies.

To simplify testing, this patch defines an evmtest config file.  This
allows for running all tests at once, rather than invoking each test
individually. Variables can be set once rather than specifying
parameters at runtime on the command line.

Signed-off-by: David Jacobson <davidj@linux.ibm.com>
---
 evmtest/README       | 19 +++++++++++++++--
 evmtest/evmtest      | 51 +++++++++++++++++++++++++++++++++++++++++++-
 evmtest/example.conf | 14 ++++++++++++
 3 files changed, 81 insertions(+), 3 deletions(-)
 create mode 100644 evmtest/example.conf

diff --git a/evmtest/README b/evmtest/README
index ac0c175..6f1c5c8 100644
--- a/evmtest/README
+++ b/evmtest/README
@@ -20,8 +20,8 @@ used to check a kernel's configuration and validate compatibility with IMA.
 COMMANDS
 --------
 
- runtest <test name> - Run a specific test
- runall <configuration> - Run all tests
+ runtest <test name> 	 - Run a specific test
+ runall  <configuration> - Run all tests
 
 OPTIONS
 -------
@@ -34,7 +34,21 @@ OPTIONS
  --vm				Validate compatibility with a virtual machine
 
 
+CONFIGURATION FILE
+------------------
+
+The `example.conf` provides a skeleton configuration file, where the only
+variable that *must* be defined is `IMA_KEY`.
+
+* `IMA_KEY` - The private key for the certificate on the IMA Trusted Keyring
 
+* `KBUILD_DIR` - Should point to a kernel build tree. If not provided, the test
+will use `/lib/modules/$(uname -r)/build`.
+
+* `KERN_IMAGE` - Should point towards an unsigned kernel image. If not provided,
+the test will attempt to use the running kernel.
+
+* `VERBOSE` - If set to 1, will add -v to all tests run
 
 BACKGROUND
 ----------
@@ -42,6 +56,7 @@ The Linux kernel needs to be configured properly with a key embedded into the
 kernel and loaded onto the `.builtin_trusted_keys` keyring at boot in order to
 run evmtest.
 
+
 === 1. Confirming the kernel is properly configured with IMA enabled.
 
 A number of Kconfig options need to be configured to enable IMA and permit
diff --git a/evmtest/evmtest b/evmtest/evmtest
index dfe39a9..74c829c 100755
--- a/evmtest/evmtest
+++ b/evmtest/evmtest
@@ -17,7 +17,7 @@ fi
 
 source $EVMDIR/files/common.sh
 usage (){
-	echo "Usage: evmtest [[runtest] <test_name>] [options]"
+	echo "Usage: evmtest [[runtest|runall] <test_name|config>] [options]"
 	echo ""
 	echo "Tests may be called directly by cd'ing to the evmtest directory:"
 	echo "$ cd $EVMDIR/functions"
@@ -69,6 +69,55 @@ elif [[ "$1" == "runtest" ]]; then
 		runtest $@
 		exit $?
 	fi
+elif [[ "$1" == "runall" ]]; then
+	if [[ -z $2 || ! -e $2 ]]; then
+		echo "evmtest runall <config file>"
+		echo "[!] Please provide a config file"
+		exit 1
+	fi
+	source $2 # Load in config
+	if [[ $VERBOSE -eq 1 ]]; then
+		V="-v"
+	fi
+
+	# Key is not optional
+	if [[ -z $IMA_KEY ]]; then
+		echo "[*] Please correct your config file"
+		exit 1
+	fi
+
+	EVMTEST_require_root
+	FAIL=0
+	echo "[*] Running tests..."
+	# 1
+	$EVMDIR/functions/r_env_validate.sh -r $V
+
+	# 2
+	if [[ -z $KERN_IMAGE ]]; then
+		$EVMDIR/functions/r_kexec_sig.sh -k $IMA_KEY $V
+	else
+		$EVMDIR/functions/r_kexec_sig.sh -k $IMA_KEY -i $KERN_IMAGE $V
+	fi
+	FAIL=$((FAIL+$?))
+	# 3
+	if [[ -z $KBUILD_DIR ]]; then
+		$EVMDIR/functions/r_kmod_sig.sh -k $IMA_KEY $V
+	else
+		$EVMDIR/functions/r_kmod_sig.sh -b $KBUILD_DIR -k $IMA_KEY $V
+	fi
+	FAIL=$((FAIL+$?))
+	# 4
+	$EVMDIR/functions/r_policy_sig.sh -k $IMA_KEY $V
+	FAIL=$((FAIL+$?))
+	# 5
+	$EVMDIR/functions/r_validate_boot_record.sh $V
+	FAIL=$((FAIL+$?))
+	# 6
+	$EVMDIR/functions/r_xattr_preserve.sh $V
+	FAIL=$((FAIL+$?))
+	echo "..."
+	echo "[*] TESTS PASSED: $((6-FAIL))"
+	echo "[*] TESTS FAILED: $FAIL"
 else
 	usage
 fi
diff --git a/evmtest/example.conf b/evmtest/example.conf
new file mode 100644
index 0000000..fd1c8fe
--- /dev/null
+++ b/evmtest/example.conf
@@ -0,0 +1,14 @@
+# This is an example config file
+# There are three variables that can be set when using evmtest runall
+
+#Set this to 1 for verbose output
+VERBOSE=0
+# Path to the private key for the IMA Trusted Keyring
+# This is required
+IMA_KEY=/path/to/your/ima_key
+
+# If this is not provided, tests will run but attempt to copy the running kernel
+KERN_IMAGE=/path/to/unsigned/kernel_image
+
+# If this is not defined, tests will try to find build tree
+KBUILD_DIR=/path/to/kernel/build/tree
-- 
2.17.1
