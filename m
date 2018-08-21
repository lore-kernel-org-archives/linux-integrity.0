Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbeHUTRk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Aug 2018 15:17:40 -0400
Subject: [PATCH 01/23] TPM: Add new TPMs to the tail of the list to prevent
 inadvertent change of dev
From: David Howells <dhowells@redhat.com>
To: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com,
        jejb@linux.vnet.ibm.com
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Date: Tue, 21 Aug 2018 16:56:56 +0100
Message-ID: <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Add newly registered TPMs to the tail of the list, not the beginning, so that
things that are specifying TPM_ANY_NUM don't find that the device they're
using has inadvertently changed.  Adding a second device would break IMA, for
instance.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
cc: stable@vger.kernel.org
---

 drivers/char/tpm/tpm-interface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 6af17002a115..cfb9089887bd 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1122,7 +1122,7 @@ struct tpm_chip *tpm_register_hardware(struct device *dev,
 
 	/* Make chip available */
 	spin_lock(&driver_lock);
-	list_add_rcu(&chip->list, &tpm_chip_list);
+	list_add_tail_rcu(&chip->list, &tpm_chip_list);
 	spin_unlock(&driver_lock);
 
 	return chip;
