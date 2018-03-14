Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751426AbeCNUUn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 16:20:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EKK2Rb074902
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 16:20:43 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gq5c6pnyk-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 16:20:43 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 16:20:42 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 2/4] ima: Simplify ima_eventsig_init()
Date: Wed, 14 Mar 2018 17:20:18 -0300
In-Reply-To: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20180314202020.3794-3-bauerman@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The "goto out" statement doesn't have any purpose since there's no cleanup
to be done when returning early, so remove it. This also makes the rc
variable unnecessary so remove it as well.

Also, the xattr_len and fmt variables are redundant so remove them as well.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_template_lib.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 28af43f63572..5afaa53decc5 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -378,16 +378,11 @@ int ima_eventname_ng_init(struct ima_event_data *event_data,
 int ima_eventsig_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data)
 {
-	enum data_formats fmt = DATA_FMT_HEX;
 	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
-	int xattr_len = event_data->xattr_len;
-	int rc = 0;
 
 	if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
-		goto out;
+		return 0;
 
-	rc = ima_write_template_field_data(xattr_value, xattr_len, fmt,
-					   field_data);
-out:
-	return rc;
+	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
+					     DATA_FMT_HEX, field_data);
 }
