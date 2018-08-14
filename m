Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729839AbeHNUyZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI4NqP077322
        for <linux-integrity@vger.kernel.org>; Tue, 14 Aug 2018 14:06:06 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kv3ar9tge-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 Aug 2018 14:06:06 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:06:06 -0600
From: David Jacobson <davidj@linux.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 6/7] evmtest: test the preservation of extended attributes
Date: Tue, 14 Aug 2018 14:05:50 -0400
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
Message-Id: <20180814180551.28311-6-davidj@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

IMA supports file signatures by storing information in a security.ima
extended file attribute. This test ensures that the attribute is
preserved when a file is copied.  This test requires root because only
root can write "security." xattrs to files.

Signed-off-by: David Jacobson <davidj@linux.ibm.com>
---
 evmtest/functions/r_xattr_preserve.sh | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 evmtest/functions/r_xattr_preserve.sh

diff --git a/evmtest/functions/r_xattr_preserve.sh b/evmtest/functions/r_xattr_preserve.sh
new file mode 100755
index 0000000..e7f0e2a
--- /dev/null
+++ b/evmtest/functions/r_xattr_preserve.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="r_xattr_preserve"
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+
+VERBOSE=0
+# This test ensures that extended file attributes are preserved when a file is
+# moved with the correct flag
+
+usage (){
+	echo ""
+	echo "xattr_preserve [-hv]"
+	echo ""
+	echo "This test must be run as root"
+	echo ""
+	echo "	This test ensures that extended file attributes (specifically"
+	echo "	security.ima labels) are preserved when copying"
+	echo "Options"
+	echo "  -h,--help       Display this help message"
+	echo "  -v,--verbose    Verbose logging"
+}
+
+TEMP=`getopt -o 'hv' -l 'help,verbose' -n 'r_xattr_preserve' -- "$@"`
+eval set -- "$TEMP"
+
+while true ; do
+	case "$1" in
+	-h|--help) usage; exit; shift;;
+	-v|--verbose) VERBOSE=1; shift;;
+	--) shift; break;;
+	*) echo "[*] Unrecognized option $1"; exit 1;;
+	esac
+done
+
+EVMTEST_require_root
+
+begin
+
+LOCATION_1=`mktemp`
+LOCATION_2=`mktemp -u` # Doesn't create the file
+v_out "Labeling file..."
+
+evmctl ima_hash $LOCATION_1
+initial_ima_label=`getfattr -m ^security.ima -e hex \
+	--dump $LOCATION_1 2> /dev/null`
+
+initial_hash=`echo $initial_ima_label | awk -F '=' '{print $2}'`
+
+if [[ $initial_ima_label = *"security.ima"* ]]; then
+	v_out "Found hash on initial file... "
+else
+	fail "Hash not found on initial file"
+fi
+
+initial_hash=`echo $initial_ima_label | awk -F '=' '{print $2}'`
+
+v_out "Copying file..."
+cp --preserve=xattr $LOCATION_1 $LOCATION_2
+v_out "Checking if extended attribute has been preserved..."
+
+
+second_ima_label=`getfattr -m ^security.ima -e hex \
+	--dump $LOCATION_2 2> /dev/null`
+second_hash=`echo $second_ima_label | awk -F '=' '{print $2}'`
+if [[ "$initial_hash" != "$second_hash" ]]; then
+	fail "security.ima xattr was not preserved!"
+else
+	v_out "Extended attribute was preserved during copy"
+fi
+v_out "Cleaning up..."
+rm $LOCATION_1 $LOCATION_2
+
+passed
-- 
2.17.1
