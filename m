Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:46770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeINCgv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Sep 2018 22:36:51 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, jgross@suse.com, dunlapg@umich.edu,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] tpm: Restore functionality to xen vtpm driver.
Date: Thu, 13 Sep 2018 17:25:51 -0400
Message-Id: <20180913212551.2435-1-boris.ostrovsky@oracle.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: "Dr. Greg Wettstein" <greg@wind.enjellic.com>

Functionality of the xen-tpmfront driver was lost secondary to
the introduction of xenbus multi-page support in commit ccc9d90a9a8b
("xenbus_client: Extend interface to support multi-page ring").

In this commit a pointer to the shared page address was being
passed to the xenbus_grant_ring() function rather then the
address of the shared page itself.  This resulted in a situation
where the driver would attach to the vtpm-stubdom but any attempt
to send a command to the stub domain would timeout.

A diagnostic finding for this regression is the following error
message being generated when the xen-tpmfront driver probes for a
device:

<3>vtpm vtpm-0: tpm_transmit: tpm_send: error -62

<3>vtpm vtpm-0: A TPM error (-62) occurred attempting to determine
the timeouts

This fix is relevant to all kernels from 4.1 forward which is the
release in which multi-page xenbus support was introduced.

Daniel De Graaf formulated the fix by code inspection after the
regression point was located.

Fixes: ccc9d90a9a8b ("xenbus_client: Extend interface to support multi-page ring")
Signed-off-by: Dr. Greg Wettstein <greg@enjellic.com>

[boris: fixed commit message formatting, added Fixes tag]
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org # v4.1+
---
 drivers/char/tpm/xen-tpmfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 911475d36800..b150f87f38f5 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -264,7 +264,7 @@ static int setup_ring(struct xenbus_device *dev, struct tpm_private *priv)
 		return -ENOMEM;
 	}
 
-	rv = xenbus_grant_ring(dev, &priv->shr, 1, &gref);
+	rv = xenbus_grant_ring(dev, priv->shr, 1, &gref);
 	if (rv < 0)
 		return rv;
 
-- 
2.17.1
