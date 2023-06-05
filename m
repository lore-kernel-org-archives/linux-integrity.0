Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A4C7EE23
	for <linux-integrity@archiver.kernel.org>; Mon,  5 Jun 2023 17:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFERx3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 5 Jun 2023 13:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjFERx2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 13:53:28 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946DAD3;
        Mon,  5 Jun 2023 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1685987607; x=1717523607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qnXdKp0XxJiBddmgvvjVvqWfVgIMwaT9ivNZNQ/2ryI=;
  b=n87eyRq7cJC9duI2iiK84uzQjtaX8h49oKarsKiOufqx5C+EfbHQTugS
   bAALTSrXQm+5qt1mpaWzwxIYV9ff1IUpFgRei9ssYp1YQsLh+BrlnVyko
   QyNwLbVPG4Car78TVtXHIq5nFNhakS4e/gVndFNXbkBtLYwM9FchZuaav
   o=;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="40772631"
X-IronPort-AV: E=Sophos;i="6.00,218,1681164000"; 
   d="scan'208";a="40772631"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 19:53:25 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 19:53:24 +0200
Received: from ISCNPC0VBFBX.infineon.com (10.161.6.196) by
 KLUSE818.infineon.com (172.28.156.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 19:53:23 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH 2/4] tpm_tis: Move CRC check to generic send routine
Date:   Mon, 5 Jun 2023 19:52:48 +0200
Message-ID: <20230605175250.2055-3-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20230605175250.2055-1-Alexander.Steffen@infineon.com>
References: <20230605175250.2055-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.161.6.196]
X-ClientProxiedBy: MUCSE817.infineon.com (172.23.29.43) To
 KLUSE818.infineon.com (172.28.156.171)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The CRC functionality is initialized before tpm_tis_core, so it can be used
on all code paths within the module. Therefore, move the CRC check to the
generic send routine, that also contains all other checks for successful
command transmission, so that all those checks are in one place.

Also, this ensures that tpm_tis_ready is called when a CRC failure is
detected, to clear the invalid data from the TPM, which did not happen
previously.

Change-Id: I334abe9accc45efa679e23d391705322886bd0e3
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index aaaa136044ae..5ddaf24518be 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -466,6 +466,12 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		goto out_err;
 	}
 
+	rc = tpm_tis_verify_crc(priv, len, buf);
+	if (rc < 0) {
+		dev_err(&chip->dev, "CRC mismatch for command.\n");
+		goto out_err;
+	}
+
 	return 0;
 
 out_err:
@@ -510,12 +516,6 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if (rc < 0)
 		return rc;
 
-	rc = tpm_tis_verify_crc(priv, len, buf);
-	if (rc < 0) {
-		dev_err(&chip->dev, "CRC mismatch for command.\n");
-		return rc;
-	}
-
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
 	if (rc < 0)
-- 
2.34.1

