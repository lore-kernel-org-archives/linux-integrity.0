Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-00176a03.pphosted.com ([67.231.149.52]:49130 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751554AbeBAPWs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 10:22:48 -0500
Received: from pps.filterd (m0047963.ppops.net [127.0.0.1])
        by m0047963.ppops.net-00176a03. (8.16.0.22/8.16.0.22) with SMTP id w11ELAXM044519
        for <linux-integrity@vger.kernel.org>; Thu, 1 Feb 2018 09:21:10 -0500
From: "Kepa, Krzysztof (GE Global Research)" <kepa@ge.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: xen-tpmfront.c issue on arm64
Date: Thu, 1 Feb 2018 14:20:48 +0000
Message-ID: <4CC5C672-4DB4-4EBE-886D-F6EA86EDD972@ge.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

I'm observing the wrong memory page being passed to the xenbus_grant_ring() call.
This happens when I'm using Xen TPM frontend driver (xen-tpmfront.c) on arm64 platform.
Interestingly, the driver code works fine on x86 platform.

Also, writing to this shared page from the DomB (grantee) crashes the DomA (grantor).

In order to make it working on arm64 I had to apply the following patch:

	--- ref/drivers/char/tpm/xen-tpmfront.c	2017-12-06 09:38:05.000000000 -0500
	+++ new/drivers/char/tpm/xen-tpmfront_fixed.c	2018-01-30 13:22:15.369402054 -0500
	@@ -203,7 +203,7 @@
			return -ENOMEM;
		}

	-	rv = xenbus_grant_ring(dev, &priv->shr, 1, &gref);
	+	rv = xenbus_grant_ring(dev, priv->shr, 1, &gref);
	 	if (rv < 0)
			return rv;


Any suggestions how to fix it properly for arm64?
Please let me know what other information should I provide.

Regards,  
Krzysztof Kepa
