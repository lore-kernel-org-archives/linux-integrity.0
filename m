Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729690AbeHNUyZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI47bY013688
        for <linux-integrity@vger.kernel.org>; Tue, 14 Aug 2018 14:06:07 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv3cshqa4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 Aug 2018 14:06:06 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:06:05 -0600
From: David Jacobson <davidj@linux.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 5/7] evmtest: validate boot record
Date: Tue, 14 Aug 2018 14:05:49 -0400
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
Message-Id: <20180814180551.28311-5-davidj@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The first record in the IMA runtime measurement list is the boot
aggregate - a hash of PCRs 0-7. This test calculates the boot aggregate
based off the PCRs and compares it to IMA's boot aggregate.

Dependencies: a TPM, IBMTSS2.

Signed-off-by: David Jacobson <davidj@linux.ibm.com>
---
 evmtest/functions/r_validate_boot_record.sh | 140 ++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100755 evmtest/functions/r_validate_boot_record.sh

diff --git a/evmtest/functions/r_validate_boot_record.sh b/evmtest/functions/r_validate_boot_record.sh
new file mode 100755
index 0000000..421cbf1
--- /dev/null
+++ b/evmtest/functions/r_validate_boot_record.sh
@@ -0,0 +1,140 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="r_validate_boot_record"
+
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+
+TPM_VERSION="2.0" # DEFAULT
+VERBOSE=0
+TSS_DIR=`locate ibmtpm20tss | head -1`
+EVENT_EXTEND=$TSS_DIR/utils12/eventextend
+LD_LIBRARY_PATH=$TSS_DIR/utils:$TSS_DIR/utils12
+MEASUREMENT_FILE=$EVMTEST_SECFS/tpm0/binary_bios_measurements
+# This test validates the eventlog against the hardware PCRs in the TPM, and
+# the boot aggregate against IMA.
+
+usage (){
+	echo "r_validate_boot_record [-hv]"
+	echo ""
+	echo "	This test must be run as root"
+	echo ""
+	echo "	This test will attempt to validate PCRs 0-7 in the TPM"
+	echo "	It will also validate the boot_aggregate based those PCRs"
+	echo "	against what IMA has recorded"
+	echo ""
+	echo "	-h,--help	Display this help message"
+	echo "	-v,--verbose	Verbose logging"
+}
+
+
+TEMP=`getopt -o 'hv' -l 'help,verbose' -n 'r_validate_boot_record' -- "$@"`
+eval set -- "$TEMP"
+
+while true ; do
+	case "$1" in
+	-h|--help) usage; exit; shift;;
+	-v|--verbose) VERBOSE=1; shift;;
+	--) shift; break;;
+	*) echo "[*] Unrecognized option $1"; exit 1 ;;
+	esac
+done
+
+EVMTEST_require_root
+
+echo "[*] Starting test: $TEST"
+
+v_out "Checking if securityfs is mounted..."
+if [[ -z $EVMTEST_SECFS_EXISTS ]]; then
+	fail "securityfs not found..."
+fi
+
+v_out "Verifying TPM is present..."
+if [[ ! -d $EVMTEST_SECFS/tpm0 ]]; then
+	fail "Could not locate TPM in $EVMTEST_SECFS"
+fi
+
+v_out "TPM found..."
+
+v_out "Checking if system supports reading event log..."
+
+if [[ ! -f $EVMTEST_SECFS/tpm0/binary_bios_measurements ]]; then
+		fail "Kernel does not support reading BIOS measurements,
+		please update to at least 4.16.0"
+fi
+
+
+
+v_out "Verifying TPM Version"
+if [[ -e /sys/class/tpm/tpm0/device/caps ]]; then
+	contains_12=`grep 'TCG version: 1.2' /sys/class/tpm/tpm0/device/caps`
+	if [[ -z $contains12 ]]; then
+		v_out "TPM 1.2"
+		TPM_VERSION="1.2"
+	fi
+else
+	v_out "TPM 2.0"
+fi
+
+v_out "Checking if system supports reading PCRs..."
+
+if [[ ! -d $TSS_DIR ]]; then
+	fail "Could not find TSS2, please install using the package and
+	 try again"
+fi
+
+v_out "Grabbing PCR values..."
+pcrs=() # array to store the Hardware PCR values
+sim_pcrs=() # What PCRs should be according to the event log
+halg=$(grep boot_aggregate $EVMTEST_SECFS/ima/ascii_runtime_measurements|\
+		sed -n 's/.*\(sha[^:]*\):.*/\1/p')
+
+for ((i=0; i<=7; i++)); do
+	if [[ $TPM_VERSION == "1.2" ]]; then
+		pcrs[i]=`TPM_INTERFACE_TYPE=dev $TSS_DIR/utils12/pcrread \
+			-ha $i -ns`
+	else
+		pcrs[i]=`TPM_INTERFACE_TYPE=dev $TSS_DIR/utils/pcrread \
+			-ha $i -halg $halg -ns`
+	fi
+done
+
+tss_out=`LD_LIBRARY_PATH=$LD_LIBRARY_PATH $EVENT_EXTEND -if \
+				$MEASUREMENT_FILE -sim -ns`
+for ((y=2; y<=9; y++)); do
+	# Parse TSS output - first strip away PCR, then split on :, then
+	# remove leading whitespace
+	x=`echo $tss_out | awk -v y=$y -F 'PCR' '{print $y}'`
+	x=`echo "$x" | awk -F ":" '{print $2}' | sed -e 's/^[ \t]*//'`
+	index=$((y-2))
+	sim_pcrs[$index]=$x
+done
+
+v_out "Validating PCRs.."
+for ((i=0; i<=7; i++)); do
+	v_out "SIM PCR [$i]: ${sim_pcrs[$i]}"
+	v_out "TPM PCR [$i]: ${pcrs[$i]}"
+	if [[  "${pcrs[$i]}" = "${sim_pcrs[$i]}" ]]; then
+		v_out "PCRs are incorrect..."
+		fail "Mismatch at PCR "$i" "
+	else
+		v_out "PCR $i validated..."
+	fi
+done
+
+
+v_out "Validating Boot Aggregate..."
+tss_boot_agg=`echo $tss_out | awk -F "boot aggregate:" '{print $2}'| tr -d " "`
+ima_boot_agg=`grep boot_aggregate \
+$EVMTEST_SECFS/ima/ascii_runtime_measurements|cut -d ":" -f2|cut -d " " -f1`
+v_out "TSS BOOT AGG: $tss_boot_agg"
+v_out "IMA BOOT AGG: $ima_boot_agg"
+
+if [ "$tss_boot_agg" != "$ima_boot_agg" ]; then
+	fail "Boot Aggregate is inconsistent"
+else
+	v_out "Boot Aggregate validated"
+fi
+
+echo "[*] TEST: PASSED"
+exit 0
-- 
2.17.1
