Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959556;
	b=LPSAG7MgGR7yo6WCO6qSNjGvA//QAPIiuZA+EGyVrG/eumFpyYH1niCszXxNmjSSNgdl
	 y3SccLVhMOsTJGTU73r4fNaYSmf2feLymCoTD+1T9a1vbBY2hJ0Z6SdYYbYONCy8E/5eX
	 /WFnwTeClslEP8BHeya4G6oEt2W+G0jlGTU+xveE1TYGuU12n4KCO1uCAcvhC7iomRu1/
	 vA+pj11fk2psax9wVQKcDBxK0KuwCPwjmwF2oAVpPVqYbsI0/3JslceriaQ7BI/N++uV1
	 UzSFnANuAgbt1rlzmLOYkhUl9oQei/c/pdxwskyAWhBhEaG0fG4oGoKlCzDdPAscWyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959556;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PHTlqtKxDAMI6itVE1f5RAsUNCQfPDsS9induU7HuBg=;
	b=mrdUvAa00RfvuOA/QH95GcyiKcywxupaCoqbYnPlszaL1s6/HsLMTaaHbOSCP5xdZ2Eq
	 GwYzvss26jeVU119AhjXthZCHCtedeb+3Gb5/zUJA6k3jTG1gZ0QjvmLmxKIe41tusqc6
	 3NPy+KzGoxetrg5QtDf0xbb7cZXcgGg/HWvttDnK4YxmmngkqLm6db83FDpYqRuyLnaus
	 LimgXuJao0Dq4RfnOMRgU6v26gSDfhV8AkykeL5xmLN0Q6T3LiAlQqqVc7oWGPKJQLS4w
	 Ah9StKeJlpX3kvhxChKTeP4EATuGVLxRx3LZkZohCfkzXypg7hagvajn8tL45iZ+xpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P4UzLme4;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k7R+ooJS;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D8606A31D
	for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 20:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 390D8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P4UzLme4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k7R+ooJS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792959555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHTlqtKxDAMI6itVE1f5RAsUNCQfPDsS9induU7HuBg=;
	b=P4UzLme4E7y4W+EqIs0awi6MgwY3XTUsYXbKIbfBwXZSC2bq3tOUIfGveLIwQk5ztIo6+G
	oeggc0+21tsXTVQ/JYQseGJw8vCZXB4WSJrAEb7dQCJKzq591TsImJRY45aMuJ0o55wy59
	pnAI6Wjo3nO7B7viXPgaM6i1TPbUW6U=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-xdHkURdKPwWTHGCP-S4VxQ-1; Sun, 25 Oct 2026 16:19:13 -0400
X-MC-Unique: xdHkURdKPwWTHGCP-S4VxQ-1
X-Mimecast-MFC-AGG-ID: xdHkURdKPwWTHGCP-S4VxQ_1792959553
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so7124897eec.1
        for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792959553; x=1793564353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHTlqtKxDAMI6itVE1f5RAsUNCQfPDsS9induU7HuBg=;
        b=k7R+ooJSIaRcMvb2WrGVZEKu+ShKic4QzYfmAQ0DHoKxUDgi0vMyFq9TJpErL/88PJ
         f6U1MWT5DQ7oBcVb3Dda2ZvHgTa0HbF2UYzlNZxE73wVGpc6sSnubFTAYyF/kLZ6qzLA
         AVu6Ms56Uc5QsIMyKOwICcNAq6fjYHvGcIjM36ILEs6xJ+NqlCOW4d/NBJ2LCrIh6qqW
         OTQpq2Rym06ezGpHCD70FpkMoqOvu0DLffkNhopxZvJI9AlkTqiZ2VFnJel1yxI9VYYH
         UNBgu3WpRCJ0AlquKa1bxyq5XFYvZlAn2wYr4Y+vav3j0l26reElqDI9uGDY68vGIb7R
         STiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959553; x=1793564353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHTlqtKxDAMI6itVE1f5RAsUNCQfPDsS9induU7HuBg=;
        b=BSHHdUzD3lUCBdsaamU5faSREINObgDoqOrfKFabtnZizYkrs6atEvVDJPFeT8R6rE
         5F1qSSQt7GrY2AJvm9XUQAwQA7UNqeiUC/EV3U4j9AV293AGWFISJWf7IIChirx4GJjf
         n5bEKz2woY07Cp6TJkS8TFSvrwQ4AcAUt0zVux2ZzQI55i3ITZIsjgEO1FbPc7gd0Fdu
         pNi7DOW7sfpoBdOWmiqfTam/eJtg+V86mfBWu8g4W001S4D3Y6shR3swViPs4wknp5uv
         iAdwyzlX60y7CtrpwdIjnw+qndVu0KPL4EXjUx8uIP847jrrUAank96hkegQ+iMhY8DQ
         ePmw==
X-Forwarded-Encrypted: i=1; AKwUvBxfpoHysKa960leHTVFLGVv+X3Zty4MfYqgEo0hyHV9Zhd/yWgig1ySynrzxl+2H+viuAO44ecFQaCqeK0OCTc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoF5NEWl91tD+/1JBN1ci33mSYua8RluEolKFhejePSVYpzjrV
	2seckYaWQpmEWI+itqyxKwcexmrQEsL/VHh2OD1IR5czYxtTqaZoosLzcQMfcBSouLVZnnPpUC0
	m3+kTbromlODqcEIrFJG3WUNKjY+VwjA70V+1VXCtpvT/qtyAZmUSp3+pKEXO8WV0+MHMwQ==
X-Gm-Gg: AYBFou0eDn92qhX/9pZ2Q5pCAdL5n3h52AiNbHhEQ0ZxxKzaWvCwIoV59mB2obdBV7p
	t8OKriDOsTH2kVfhBneTKf04Fcte1mH9NVvpS/7KPvTGWXFGu5H+u9+nysrxeUg9tCv91nPuJWu
	f9JbgFLey2j4PJu+7w6EQ+dbuKh5azfaj555vvri5+bzJ7IFp9C+2hn0LMoCwvmCZoeQoS5HMQ1
	pXj2rbbkd8qXtVhdqK8IpHTHA1i/8Y+9yNGhkw048t2mGmdfX8BdPC6MeWTBVjrt2NNvNR9i90P
	5dvPGa2zyK0iL0pbjONEB6CCnTCXk9et+J75lPwZhlM/DmUmzPlFQ4olI2NNN5fvUslDItx2mlv
	BLRM7w7cXK1n1M9tv3nsFJ4dvm6KHGYelHuvHSIvy
X-Received: by 2002:a05:7022:1702:b0:18d:5988:8d3 with SMTP id a92af1059eb24-199290fe35amr6864959c88.3.1792959552517;
        Sun, 25 Oct 2026 13:19:12 -0700 (PDT)
X-Received: by 2002:a05:7022:1702:b0:18d:5988:8d3 with SMTP id a92af1059eb24-199290fe35amr6864928c88.3.1792959551834;
        Sun, 25 Oct 2026 13:19:11 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm17656169c88.3.2026.10.25.13.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:19:11 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 2/6] tpm_crb: Split start method into a separate header
Date: Mon, 26 Oct 2026 01:48:54 +0530
Message-ID: <20261025201859.221991-3-armenon@redhat.com>
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

The current implementation handles different platform start methods
(ACPI, ARM SMC, and ARM FFA) directly within crb_send().
Move this logic into a new helper function, tpm_crb_start(). This is a
pure refactor with no functional changes intended.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index d76f9e30f036..9a2f512b4ae3 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -446,6 +446,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
 }
 #endif
 
+static int tpm_crb_start(struct tpm_chip *chip)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	int rc = 0;
+	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
+	 * report only ACPI start but in practice seems to require both
+	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
+	 */
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
+	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
+	    !strcmp(priv->hid, "MSFT0101"))
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+	if (priv->sm == ACPI_TPM2_START_METHOD ||
+	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
+		rc = crb_do_acpi_start(chip);
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
+	}
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
+	}
+	return rc;
+}
+
 static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
@@ -471,29 +497,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	/* Make sure that cmd is populated before issuing start. */
 	wmb();
 
-	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
-	 * report only ACPI start but in practice seems to require both
-	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
-	 */
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
-	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
-	    !strcmp(priv->hid, "MSFT0101"))
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
-
-	if (priv->sm == ACPI_TPM2_START_METHOD ||
-	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
-		rc = crb_do_acpi_start(chip);
-
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
-		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
-	}
-
-	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
-		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
-	}
-
+	rc = tpm_crb_start(chip);
 	if (rc)
 		return rc;
 
-- 
2.54.0

