Return-Path: <SRS0=36rA=4W=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A914FC3F2D1
	for <linux-integrity@archiver.kernel.org>; Thu,  5 Mar 2020 02:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE4720838
	for <linux-integrity@archiver.kernel.org>; Thu,  5 Mar 2020 02:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YQuxEDgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgCEC2v (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 4 Mar 2020 21:28:51 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47326 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbgCEC2u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Mar 2020 21:28:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5BAC38EE15C;
        Wed,  4 Mar 2020 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583375330;
        bh=utjcIpzB5cKz3QfoZk7p4oF7i25SrMb648uT7GA0lew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQuxEDgDuhWZBEL+55Bm5vTesgz/CwfdzL+uYd2mfeRDT9vsVxT3e+TNkU9AWB0lx
         krS0JWxuEfyjUytjfPTnigEuZvKlZoR7ZZnevP9IuCzxZcJaG5JwCG/LYmj18WJDjd
         lO5loQkgObihCwXlhPVobOGeK5S/9NfQEJwSqCfc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w005RdTteFZj; Wed,  4 Mar 2020 18:28:50 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E90AA8EE0FC;
        Wed,  4 Mar 2020 18:28:49 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v7 2/6] oid_registry: Add TCG defined OIDS for TPM keys
Date:   Wed,  4 Mar 2020 18:27:40 -0800
Message-Id: <20200305022744.12492-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200305022744.12492-1-James.Bottomley@HansenPartnership.com>
References: <20200305022744.12492-1-James.Bottomley@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
key uses.  We've defined three of the available numbers:

2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
		RSA2048 or Elliptic Curve) which can be imported by a
		TPM2_Load() operation.

2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
		RSA2048 or Elliptic Curve) which can be imported by a
		TPM2_Import() operation.

Both loadable and importable keys are specific to a given TPM, the
difference is that a loadable key is wrapped with the symmetric
secret, so must have been created by the TPM itself.  An importable
key is wrapped with a DH shared secret, and may be created without
access to the TPM provided you know the public part of the parent key.

2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
		bytes) which is sealed by the TPM.  It usually
		represents a symmetric key and must be unsealed before
		use.

The ASN.1 binary key form starts of with this OID as the first element
of a sequence, giving the binary form a unique recognizable identity
marker regardless of encoding.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---

v3: correct OID_TPMImportableKey name
v7: add ack
---
 include/linux/oid_registry.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 657d6bf2c064..f6e2276e5f30 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -107,6 +107,11 @@ enum OID {
 	OID_gostTC26Sign512B,		/* 1.2.643.7.1.2.1.2.2 */
 	OID_gostTC26Sign512C,		/* 1.2.643.7.1.2.1.2.3 */
 
+	/* TCG defined OIDS for TPM based keys */
+	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
+	OID_TPMImportableKey,		/* 2.23.133.10.1.4 */
+	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
+
 	OID__NR
 };
 
-- 
2.16.4

