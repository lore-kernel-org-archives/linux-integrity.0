Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959561;
	b=B4nU8XykTEqRTLyL7vLVeQzn6pN3GEUrDgSiE4LUx1FJ159BxDODgc7ACz4MoSHlEnH4
	 6hs88CE2XoFSx1jRjvCYbiwnM5PjSm+NHnN8fRfzKstMXQ6geGeltHWWqUlo8Ya2SuJN/
	 dTbqIBue9IOXIiCikcjqlQhRsQqgMDP88MC28C0EyCNXFczem5BTfbh/1RHVL13+FeF0H
	 WgCxCiMDwXB++tVmBQvDVUqezcwLdKoxh8PMUTPnGxL/PgMkeYxZYQXPgRUU2FuzVKAYy
	 Uhzopn+4Ln4tXYDKIoXKX2qcJRqdBCefev8x9mBCOgv36Bn1b+YXUF/9V56mX7XNDMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959561;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CDCto1XEIuD8+bFpZYgUHlrlM57aJmVNdz64GvF6tOs=;
	b=UiufWU+wYWvQErkOb6zQztf5fwIOgbMJIraLR0j1fou5IxdZmD9rXB4jnjHZJ4k/d+lR
	 //sg0JSXz+8JVKjhRNM35n8fTD8Fyx9d9rA4qDiXfq4giCwCkFpPeFdo8Wby5MuUqfJ8z
	 IZB9tldinZ+bxfiOlaWluKXa+hBKJRhp+KznMQwEklXx5KC86vS+Jyoe1ulrj44JsS8aV
	 4azjECfCrBaxnjB16+GjqPBvnswmaHsSlDp0nDCr4RcF7Mct1xGlz/LjCoqKEG5CNBZar
	 ma3/KmOaji6yfsqO6OLTfinPK4bzEixYKXQQMIBoLidt318sifT/Co+ARXq6z5mnfpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IUKEZdcE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AHMIsp0k;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C8A606A31B
	for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 20:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C8A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IUKEZdcE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AHMIsp0k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792959559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDCto1XEIuD8+bFpZYgUHlrlM57aJmVNdz64GvF6tOs=;
	b=IUKEZdcEHvZRc6wMK9lK9Dl6czKa2d1RHiMARgqwWycTWdWeOGV5RAHhV311+vudIPBN1g
	coSiZx2e2jBE+bZQdBWqZbBcUz8eQAefmsTnRm1bT4nwpRgM2KecTgunfvYNQeaycWBvzC
	U7bto9R0lvSjXNe0vCkLUR22vU6aGSI=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-cLYzObtHO5KoNUn_Xi-uwA-1; Sun, 25 Oct 2026 16:19:18 -0400
X-MC-Unique: cLYzObtHO5KoNUn_Xi-uwA-1
X-Mimecast-MFC-AGG-ID: cLYzObtHO5KoNUn_Xi-uwA_1792959557
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-169846a19aaso3162115c88.0
        for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792959557; x=1793564357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CDCto1XEIuD8+bFpZYgUHlrlM57aJmVNdz64GvF6tOs=;
        b=AHMIsp0ksQeXfpGMUFGahZbj8A7HbzH7z0y6o3DmxCHabN++KWh0zmdHRxTdVzCwvP
         s9NnPskECYzJEyxjXkY9fotvoPBWteZfN2TK1zI8qcQ7yDd3Qnw5jKhKA2nyjXKZDlHz
         dUnkz3JT5UAJClPTMTLj2RB7h9GcKgR1JSyBw/t+jctoiuNPqhAPuGbRChlDOOUhULZ0
         INNkIuXelZCz2eqPsSV/1ZssdlviLLqU/XgPFWWTrmotmhDYHNUybwpwVkPQHpaA5CTy
         moklGoFFkDngyD4K97ZbxdTjL3O+DXRpenlZ9azFY8Y8gTaoFCaWWRTUIxNBeMPqcrYf
         KFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959557; x=1793564357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CDCto1XEIuD8+bFpZYgUHlrlM57aJmVNdz64GvF6tOs=;
        b=gB/9/O80tuIfm1y2WIvGC95gwOzzqEaLBDA6WHxyDdL9+a2d5HTAWuJ0rbFIHhf30p
         hLC9uXTz0Z8uQic4mnSLDnxs5rPiBNiiX18hzbRLV6GIoNFqJ7rq8ybXK3FVYV3o7cPL
         iP1WUwhdzt2/LBHOdkkhm76kWKsXU6iQXn/rIWJ/Ewwl6xPDY29h+jex+JNamKyQPpM+
         Pn7fwEvBwq8PTQdbalzjN/W8gyhlOcQwkxhVxConzuB/5/6xdiwzRqKxJesfJzNnDgt6
         FUDWPsxcGV1Xp5DBpJRM3FHWg4QhAJcJ+RP7XerNM/GPdrWJjZ7WB/59jaQd9w4g8FFT
         ETDw==
X-Forwarded-Encrypted: i=1; AKwUvBwoLfUNbtxp1gMWeD8Vtlrwow9mk7UnRukmmSK47kXrVfCldqlycP0mkiAyZpfvB1N7bzZ72GOlHv+zeRtcg0c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhJK+43j8RUr2v9AHo++Yf0hz3YBdggujs49JEI1noaOkGC76i
	M2DzgZqTVm4z7HWdiwciIK47iNaQBoG2F4KBye4IfNkrPrpFWU3tnLbsoSy500lEJO4FpxzrNom
	U3ysAVKN7PJ/yJlPyAKCXLRiV9k7axXf4/SuaKb1o2g/CSpUSTc7/ES500eRuljS7cv+m/g==
X-Gm-Gg: AYBFou16gG2mMiWA4ccMd59ApaFbmxBSrJDWJql1rush9BLnfAsIDV4LC3rnQ3YJ1Je
	rf9QUvxiu3yJA24scMIjexf+kR4oAdIJCrxaLvyPEYzO9/UmOydkfch1b8MTqd/e6kf8AZGHmYK
	3ndcA7D1jYxWpmPpnQwaSfpTk3yyXX+3orbyKwi69qF7VGUNJp8jBmLzbqLbV27rxkLZt6q2vdl
	Vi5yjH9IJQd97vHee/pnvitAAc6o0XagcO1hITbmqu5TObkFmxIiJ786oR5Qt1er3QBe9Cp/H3p
	SiBP4yuavMev3BtaeF7Q8V8qQ6bOjfEWGwXxE9t1Y2tMeHMz1h7knYkXcmdiITnJ2dyIJvoBabP
	RCGKfUxU0+b5cyyjVfVOtu8QpJhPMoz6aJZ7iWHpQ
X-Received: by 2002:a05:701b:42c5:20b0:143:4450:e1e6 with SMTP id a92af1059eb24-19935fcae7cmr7287994c88.35.1792959557043;
        Sun, 25 Oct 2026 13:19:17 -0700 (PDT)
X-Received: by 2002:a05:701b:42c5:20b0:143:4450:e1e6 with SMTP id a92af1059eb24-19935fcae7cmr7287925c88.35.1792959555500;
        Sun, 25 Oct 2026 13:19:15 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm17656169c88.3.2026.10.25.13.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:19:14 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 3/6] tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
Date: Mon, 26 Oct 2026 01:48:55 +0530
Message-ID: <20261025201859.221991-4-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025201859.221991-1-armenon@redhat.com>
References: <20261025201859.221991-1-armenon@redhat.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arun Menon <armenon@redhat.com>

The current implementation of tpm_crb_start() is limited to triggering
the CRB_START_INVOKE bit. To support command and response chunking, the
driver must be able to send other control bits, like
CRB_START_NEXT_CHUNK, using the same platform-specific paths.

This commit adds the start_cmd parameter to tpm_crb_start() so the
caller can specify which command to send.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 9a2f512b4ae3..31f530744e90 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -446,7 +446,7 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
 }
 #endif
 
-static int tpm_crb_start(struct tpm_chip *chip)
+static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	int rc = 0;
@@ -457,16 +457,16 @@ static int tpm_crb_start(struct tpm_chip *chip)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
 	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
 	    !strcmp(priv->hid, "MSFT0101"))
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 	if (priv->sm == ACPI_TPM2_START_METHOD ||
 	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
 		rc = crb_do_acpi_start(chip);
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
 	}
 	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
 	}
 	return rc;
@@ -497,7 +497,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	/* Make sure that cmd is populated before issuing start. */
 	wmb();
 
-	rc = tpm_crb_start(chip);
+	rc = tpm_crb_start(chip, CRB_START_INVOKE);
 	if (rc)
 		return rc;
 
-- 
2.54.0

