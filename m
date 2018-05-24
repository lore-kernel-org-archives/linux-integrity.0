Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967724AbeEXULJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 May 2018 16:11:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4OK4EaY058612
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:08 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j63aua4y5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:08 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 24 May 2018 16:11:08 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 0/8] IMA: work on audit records produced by IMA
Date: Thu, 24 May 2018 16:10:57 -0400
Message-Id: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This series of patches cleans up some usages of the audit
subsystem's API by IMA and extends the audit subsystem's API
with API calls for adding new fields to the audit_buffer. Besides
that we extend the existing audit records created while parsing
IMA policy rules with fields that are common for audit records
produced by IMA. Besides that we introduce a new record type
that IMA creates while parsing policy rules.

   Stefan


Stefan Berger (8):
  ima: Call audit_log_string() rather than logging it untrusted
  ima: Use audit_log_format() rather than audit_log_string()
  audit: Implement audit_log_tty()
  audit: Allow others to call audit_log_d_path_exe()
  integrity: Add exe= and tty= before res= to integrity audits
  integrity: Factor out common part of integrity_audit_msg()
  ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
  ima: Differentiate auditing policy rules from "audit" actions

 include/linux/audit.h                | 10 ++++++++++
 include/uapi/linux/audit.h           |  3 ++-
 kernel/audit.c                       |  8 ++++++++
 security/integrity/ima/Kconfig       |  1 +
 security/integrity/ima/ima_policy.c  | 12 ++++++++----
 security/integrity/integrity.h       | 26 ++++++++++++++++++++++++++
 security/integrity/integrity_audit.c | 32 +++++++++++++++++++-------------
 7 files changed, 74 insertions(+), 18 deletions(-)

-- 
2.13.6
