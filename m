Return-Path: <SRS0=MdHQ=RR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DC4C10F06
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 18:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AE8218A5
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 18:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfCNSmd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:42:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727950AbfCNSmT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Mar 2019 14:42:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EIexsJ120887
        for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2019 14:42:18 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r7snp0mrb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2019 14:42:17 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Mar 2019 18:42:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 18:42:11 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2EIgA7L62849064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 18:42:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22D0942042;
        Thu, 14 Mar 2019 18:42:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 239864203F;
        Thu, 14 Mar 2019 18:42:09 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.108.186])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 18:42:08 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4 8/8] selftests/kexec: check kexec_load and kexec_file_load are enabled
Date:   Thu, 14 Mar 2019 14:41:16 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1552588876-28481-1-git-send-email-zohar@linux.ibm.com>
References: <1552588876-28481-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19031418-0020-0000-0000-000003236307
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031418-0021-0000-0000-0000217568F9
Message-Id: <1552588876-28481-9-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140130
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Skip the kexec_load and kexec_file_load tests, if they aren't configured
in the kernel.  This change adds a new requirement that ikconfig is
configured in the kexec_load test.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/kexec/test_kexec_file_load.sh | 5 +++++
 tools/testing/selftests/kexec/test_kexec_load.sh      | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index 6cf6a99f6a64..1d2e5e799523 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -151,6 +151,11 @@ require_root_privileges
 # get the kernel config
 get_kconfig
 
+kconfig_enabled "CONFIG_KEXEC_FILE=y" "kexec_file_load is enabled"
+if [ $? -eq 0 ]; then
+	log_skip "kexec_file_load is not enabled"
+fi
+
 # Determine which kernel config options are enabled
 kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
 	"architecture specific policy enabled"
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index afd440ee23cb..2a66c8897f55 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -10,6 +10,14 @@ TEST="$0"
 # kexec requires root privileges
 require_root_privileges
 
+# get the kernel config
+get_kconfig
+
+kconfig_enabled "CONFIG_KEXEC=y" "kexec_load is enabled"
+if [ $? -eq 0 ]; then
+	log_skip "kexec_load is not enabled"
+fi
+
 get_secureboot_mode
 secureboot=$?
 
-- 
2.7.5

