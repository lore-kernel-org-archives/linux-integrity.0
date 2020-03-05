Return-Path: <SRS0=36rA=4W=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993FDC3F2D1
	for <linux-integrity@archiver.kernel.org>; Thu,  5 Mar 2020 02:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C57920866
	for <linux-integrity@archiver.kernel.org>; Thu,  5 Mar 2020 02:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZvwxYWcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgCEC15 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 4 Mar 2020 21:27:57 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47244 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgCEC15 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Mar 2020 21:27:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 26D568EE11D;
        Wed,  4 Mar 2020 18:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583375277;
        bh=g4TW3XLI9rheJIt1WcLNVxUfYk0fOQhQmLe5GlsdJ3s=;
        h=From:To:Cc:Subject:Date:From;
        b=ZvwxYWcm/iv23zOU3LCMss3eRlAprdyUi5kD5qVUKZ3ZsIVv4YofIXmSgTQfA2JEt
         fzvUPg6FweqlVLjKFLi6FG2A2hA64dxI1mq5ViPtSlK/qxv9XsOhocJCjhPVc3OL9a
         IVGXzIqH6yYamHAkXgLqP3YvCx3naUpVtDUp5NEc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F_ueiYpaZMBn; Wed,  4 Mar 2020 18:27:57 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9E13A8EE0FC;
        Wed,  4 Mar 2020 18:27:56 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v7 0/6] TPM 2.0 trusted keys with attached policy
Date:   Wed,  4 Mar 2020 18:27:38 -0800
Message-Id: <20200305022744.12492-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a respin to update several patches based on review feedback

General cover letter:

This patch updates the trusted key code to export keys in the ASN.1
format used by current TPM key tools (openssl_tpm2_engine and
openconnect).  It also simplifies the use of policy with keys because
the ASN.1 format is designed to carry a description of how to
construct the policy, with the result that simple policies (like
authorization and PCR locking) can now be constructed and used in the
kernel, bringing the TPM 2.0 policy use into line with how TPM 1.2
works.

The key format is designed to be compatible with our two openssl
engine implementations as well as with the format used by openconnect.
I've added seal/unseal to my engine so I can use it for
interoperability testing and I'll later use this for sealed symmetric
keys via engine:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

James

---

James Bottomley (6):
  lib: add ASN.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted: fix TPM2 authorizations
  security: keys: trusted: use ASN.1 TPM2 key format for the blobs
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy

 Documentation/security/keys/trusted-encrypted.rst |  64 ++-
 include/keys/trusted-type.h                       |   7 +-
 include/linux/asn1_encoder.h                      |  32 ++
 include/linux/oid_registry.h                      |   5 +
 include/linux/tpm.h                               |   8 +
 lib/Makefile                                      |   2 +-
 lib/asn1_encoder.c                                | 431 ++++++++++++++++++++
 security/keys/Kconfig                             |   2 +
 security/keys/trusted-keys/Makefile               |   2 +-
 security/keys/trusted-keys/tpm2-policy.c          | 463 ++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h          |  31 ++
 security/keys/trusted-keys/tpm2key.asn1           |  23 ++
 security/keys/trusted-keys/trusted_tpm1.c         |  56 ++-
 security/keys/trusted-keys/trusted_tpm2.c         | 370 +++++++++++++++--
 14 files changed, 1459 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.16.4

