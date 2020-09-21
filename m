Return-Path: <SRS0=63nm=C6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EEEC43466
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Sep 2020 08:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D86620EDD
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Sep 2020 08:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgIUIDC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:03:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbgIUICp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:45 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BD625B29417C5FE20116;
        Mon, 21 Sep 2020 16:02:41 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:31 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next] tpm/st33zp24/i2c: simplify the return expression of st33zp24_i2c_remove
Date:   Mon, 21 Sep 2020 16:24:56 +0800
Message-ID: <20200921082456.2592242-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/char/tpm/st33zp24/i2c.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index 7c617edff4ca..b180171e5678 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -267,13 +267,8 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
 static int st33zp24_i2c_remove(struct i2c_client *client)
 {
 	struct tpm_chip *chip = i2c_get_clientdata(client);
-	int ret;
 
-	ret = st33zp24_remove(chip);
-	if (ret)
-		return ret;
-
-	return 0;
+	return st33zp24_remove(chip);
 }
 
 static const struct i2c_device_id st33zp24_i2c_id[] = {
-- 
2.25.1

