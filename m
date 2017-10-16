Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:64704 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754274AbdJPRfQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Oct 2017 13:35:16 -0400
Subject: [PATCH 4/4] char/tpm: Less checks in tpm_ibmvtpm_probe() after error
 detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
Message-ID: <09a2c3a1-1b10-507d-a866-258b570f6da1@users.sourceforge.net>
Date: Mon, 16 Oct 2017 19:34:56 +0200
MIME-Version: 1.0
In-Reply-To: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Oct 2017 19:00:34 +0200

Two pointer checks could be repeated by the tpm_ibmvtpm_probe() function
during error handling even if the relevant properties can be determined
for the involved variables before by source code analysis.

* Return directly after a call of the function "kzalloc" failed
  at the beginning.

* Adjust jump targets so that extra checks can be omitted at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index a4b462a77b99..b8dda7546f64 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -610,7 +610,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 
 	ibmvtpm = kzalloc(sizeof(*ibmvtpm), GFP_KERNEL);
 	if (!ibmvtpm)
-		goto cleanup;
+		return -ENOMEM;
 
 	ibmvtpm->dev = dev;
 	ibmvtpm->vdev = vio_dev;
@@ -619,7 +619,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	crq_q->crq_addr = (struct ibmvtpm_crq *)get_zeroed_page(GFP_KERNEL);
 	if (!crq_q->crq_addr) {
 		dev_err(dev, "Unable to allocate memory for crq_addr\n");
-		goto cleanup;
+		goto free_tpm;
 	}
 
 	crq_q->num_entry = CRQ_RES_BUF_SIZE / sizeof(*crq_q->crq_addr);
@@ -629,7 +629,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 
 	if (dma_mapping_error(dev, ibmvtpm->crq_dma_handle)) {
 		dev_err(dev, "dma mapping failed\n");
-		goto cleanup;
+		goto free_page;
 	}
 
 	rc = plpar_hcall_norets(H_REG_CRQ, vio_dev->unit_address,
@@ -683,13 +683,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 reg_crq_cleanup:
 	dma_unmap_single(dev, ibmvtpm->crq_dma_handle, CRQ_RES_BUF_SIZE,
 			 DMA_BIDIRECTIONAL);
-cleanup:
-	if (ibmvtpm) {
-		if (crq_q->crq_addr)
-			free_page((unsigned long)crq_q->crq_addr);
-		kfree(ibmvtpm);
-	}
-
+free_page:
+	free_page((unsigned long)crq_q->crq_addr);
+free_tpm:
+	kfree(ibmvtpm);
 	return rc;
 }
 
-- 
2.14.2
