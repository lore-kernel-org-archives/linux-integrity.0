Return-Path: <SRS0=Ey5g=SK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B259FC10F13
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Apr 2019 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8865E20880
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Apr 2019 16:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDHQ5I (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:57:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfDHQ5I (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Apr 2019 12:57:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C4A4C05243E
        for <linux-integrity@vger.kernel.org>; Mon,  8 Apr 2019 16:57:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 429D35D71E;
        Mon,  8 Apr 2019 16:57:02 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     linux-integrity@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau85 v1] ima: add support for AUDIT_INTEGRITY_EVM_XATTR records
Date:   Mon,  8 Apr 2019 12:56:38 -0400
Message-Id: <1554742598-1562-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 08 Apr 2019 16:57:08 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In commit fa516b6 ("EVM: Allow runtime modification of the set of verified
xattrs") support was added in the kernel for the
AUDIT_INTEGRITY_EVM_XATTR record with the EVM_ADD_XATTRS config option.
Its record number is 1806. It has a field "xattr=" with result field
"res=".

Add support for the record type number.  Since the xattr field isn't
searchable, a parser wasn't necessary.

See: https://github.com/linux-audit/audit-userspace/issues/85

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 auparse/normalize_record_map.h | 1 +
 lib/libaudit.h                 | 3 +++
 lib/msg_typetab.h              | 1 +
 3 files changed, 5 insertions(+)

diff --git a/auparse/normalize_record_map.h b/auparse/normalize_record_map.h
index 085437f67724..fee778e76db7 100644
--- a/auparse/normalize_record_map.h
+++ b/auparse/normalize_record_map.h
@@ -99,6 +99,7 @@ _S(AUDIT_ANOM_LINK, "used-suspcious-link")
 //_S(AUDIT_INTEGRITY_HASH,"")
 //_S(AUDIT_INTEGRITY_PCR,"")
 //_S(AUDIT_INTEGRITY_RULE,"")
+//_S(AUDIT_INTEGRITY_EVM_XATTR,"")
 _S(AUDIT_KERNEL, "initialized-audit-subsystem")
 _S(AUDIT_ANOM_LOGIN_FAILURES, "failed-log-in-too-many-times-to")
 _S(AUDIT_ANOM_LOGIN_TIME, "attempted-log-in-during-unusual-hour-to")
diff --git a/lib/libaudit.h b/lib/libaudit.h
index ca7aa63e354e..797e0a7be5a8 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -142,6 +142,9 @@ extern "C" {
 #define AUDIT_INTEGRITY_PCR		1804 /* PCR invalidation msgs */
 #define AUDIT_INTEGRITY_RULE		1805 /* Policy rule */
 #endif
+#ifndef AUDIT_INTEGRITY_EVM_XATTR
+#define AUDIT_INTEGRITY_EVM_XATTR	1806 /* New EVM-covered xattr */
+#endif
 
 #define AUDIT_FIRST_ANOM_MSG		2100
 #define AUDIT_LAST_ANOM_MSG		2199
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index f5d76e4f38a1..af34c04c65d4 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -152,6 +152,7 @@ _S(AUDIT_INTEGRITY_STATUS,           "INTEGRITY_STATUS"              )
 _S(AUDIT_INTEGRITY_HASH,             "INTEGRITY_HASH"                )
 _S(AUDIT_INTEGRITY_PCR,              "INTEGRITY_PCR"                 )
 _S(AUDIT_INTEGRITY_RULE,             "INTEGRITY_RULE"                )
+_S(AUDIT_INTEGRITY_EVM_XATTR,        "INTEGRITY_EVM_XATTR"           )
 
 #ifdef WITH_APPARMOR
 _S(AUDIT_AA,                         "APPARMOR"                      )
-- 
1.8.3.1

