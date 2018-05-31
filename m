Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755274AbeEaOZJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 10:25:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VEOi7D130653
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 10:25:09 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jag9hxxh6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 10:25:08 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 31 May 2018 08:25:08 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 0/4] IMA: work on audit records produced by IMA
Date: Thu, 31 May 2018 10:24:56 -0400
Message-Id: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This series of patches cleans up some usages of the audit
subsystem's API by IMA. We also introduce a new record type
that IMA creates while parsing policy rules.

   Stefan

v1->v2:
 - dropped several patches that extended existing messages with missing
   fields
 - Using audit_log_task_info() for new record type in last patch
 - rebased on security-next; new message type is now 1807

Stefan Berger (4):
  ima: Call audit_log_string() rather than logging it untrusted
  ima: Use audit_log_format() rather than audit_log_string()
  ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
  ima: Differentiate auditing policy rules from "audit" actions

 include/uapi/linux/audit.h           |  1 +
 security/integrity/ima/Kconfig       |  1 +
 security/integrity/ima/ima_policy.c  | 17 +++++++++++++----
 security/integrity/integrity.h       | 15 +++++++++++++++
 security/integrity/integrity_audit.c |  6 +-----
 5 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.13.6
