Return-Path: <SRS0=10M6=AT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0D6C433E1
	for <linux-integrity@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332AC20842
	for <linux-integrity@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594222961;
	bh=221b/j4YBJGJwtLatHEUMclSCzxLCqcNEjhJB+xYaSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+zenQoELgm28y8pHtREyowZp6wPqEkJ3EFnEya3nrp7R+0bb1VySVnVJAMh86bva
	 PAO+AJlASfWelHUKwoJ/dRh+W+TcP9c3TAk/N94x8OW+l+gf4lvfTWhW1qN7eTHwMW
	 qClMgjcLIyJP479U31b79Idf7fcR44cx/vldf36s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgGHPmO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbgGHPmN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 11:42:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656482085B;
        Wed,  8 Jul 2020 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222933;
        bh=221b/j4YBJGJwtLatHEUMclSCzxLCqcNEjhJB+xYaSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJ3gGng8Z6BOh5LbCn+m7DwvkFqj0tJwrOCvPvlXhcKlfkpkUFQ9AKDxbc9JXs/eC
         KaYzhGloY9PjtZKVROZkaimRNixM8j+7KnDDus8EH6aYJbfO/EpGPPZpIr+pipadqb
         rRtW/3fyafu8hIIEbL7H+ZDfFUSMXrrWp/IAJaZ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/5] tpm_tis: extra chip->ops check on error path in tpm_tis_core_init
Date:   Wed,  8 Jul 2020 11:42:06 -0400
Message-Id: <20200708154208.3200232-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154208.3200232-1-sashal@kernel.org>
References: <20200708154208.3200232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit ccf6fb858e17a8f8a914a1c6444d277cfedfeae6 ]

Found by smatch:
drivers/char/tpm/tpm_tis_core.c:1088 tpm_tis_core_init() warn:
 variable dereferenced before check 'chip->ops' (see line 979)

'chip->ops' is assigned in the beginning of function
in tpmm_chip_alloc->tpm_chip_alloc
and is used before first possible goto to error path.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 9b1116501f209..c028ffd953326 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -897,7 +897,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	return 0;
 out_err:
-	if ((chip->ops != NULL) && (chip->ops->clk_enable != NULL))
+	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
 	tpm_tis_remove(chip);
-- 
2.25.1

