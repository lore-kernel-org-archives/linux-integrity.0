Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728145AbeHUTTI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Aug 2018 15:19:08 -0400
Subject: [PATCH 14/23] TPMLIB: Make store_s() take a void* data argument,
 not unsigned char*
From: David Howells <dhowells@redhat.com>
To: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com,
        jejb@linux.vnet.ibm.com
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Date: Tue, 21 Aug 2018 16:58:24 +0100
Message-ID: <153486710407.13066.16921127654210787068.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Make store_s() (store arbitrarily-sized data) take a void* data argument, not
unsigned char* so that it can be given a pointer to a structure to be included
without the need to cast.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/char/tpm/tpm-library.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-library.h b/drivers/char/tpm/tpm-library.h
index c1af99dba08d..861e67df27fc 100644
--- a/drivers/char/tpm/tpm-library.h
+++ b/drivers/char/tpm/tpm-library.h
@@ -46,8 +46,7 @@ static inline void store32(struct tpm_buf *buf, uint32_t value)
 	buf->len += sizeof value;
 }
 
-static inline void store_s(struct tpm_buf *buf, const unsigned char *in,
-			   int len)
+static inline void store_s(struct tpm_buf *buf, const void *in, int len)
 {
 	memcpy(buf->data + buf->len, in, len);
 	buf->len += len;
