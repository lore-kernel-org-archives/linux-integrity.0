Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390835;
	b=V1hs7jbO0oxXHvty77dzrwEC6+jQegR/tv1DF209zSH0cvTP5kMSM4Z9wKHbnw0Zz8Ez
	 uz7nUKkf2mCKSP2IaOVe51ZURvb+keGpcROW6jGWRmnF74NhwAHZeNF68Eu+auAAeSFlb
	 XeAuaiDRF7ZuZ77dxCkfE2jI+owdlCyOtUXLxgcqHHI+AeYMm9BA/YdrVuTLTCIC5Xs7J
	 BNMuTBMz5oksooZ+e2g5oY7Sldr0B7psFrwS8glRvPhybp/vCoaM7g+zOK39cPe/6HBMx
	 x74qrTsuhbz1zhA+B1rtOEUxvdcbGUMUAvx7EiYrdB5KG2DsQ3hP3OvPbwpnv0eHoyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390835;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8reQ6REQEA2k8KRp1SWplSOof/sTUnH2B+t/FwFcDO0=;
	b=z2AM8HlYS6pU9k6oghzxEUeAjyTbZ4+B1XeP7WxQ/esK3zD2a/omD31iDiSA+dUHy3mC
	 cFqMDsCHg1F6IXq2opc7pB197ad95dM7sbn7q8gxRQOOf5Z23AcPTjoWCmElHjcppKyHU
	 AeGReWJbXy7xmKS1l75HgeOP1KXycsAYMm3B6RaGpbIpyfbfL1j2xCYyT6+Iwd0nEZAGy
	 RQlsuoPYAlxDEqwVhjSTibzbTnCJv+r13fOZZr/blr9iCub3luCnShAaLhj7CAAGbMpmM
	 mDhwZeVu2ieBSOHM56OYoj5blFu/xQAS/V4TwYIpfCKXhDHMYgmXF78otpRlm4bFJgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X1Gb8Vkm;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=G42P3DKd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A9606A32E
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 20:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D2A9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X1Gb8Vkm;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=G42P3DKd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793390834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8reQ6REQEA2k8KRp1SWplSOof/sTUnH2B+t/FwFcDO0=;
	b=X1Gb8VkmdkX9UjP0I3/GX4wul7NZ9U7xTTb7BKMwDZJxs5q0a9TBbf+dgiUtoFV/qmIqUr
	ayhWLNgv7GB3c+XSfeqIY3lCCTwr4C3KUwvSmkYKAq7UfKXUphnYZpDoKogkNbB5FsaZ34
	Rht8hM5ZzmL/issJiAI+XIe3MuowHWA=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Zjdy9gmNP2KJOaHT-rQMtw-1; Fri, 30 Oct 2026 16:07:12 -0400
X-MC-Unique: Zjdy9gmNP2KJOaHT-rQMtw-1
X-Mimecast-MFC-AGG-ID: Zjdy9gmNP2KJOaHT-rQMtw_1793390831
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3662e7a9299so4058751eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793390831; x=1793995631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8reQ6REQEA2k8KRp1SWplSOof/sTUnH2B+t/FwFcDO0=;
        b=G42P3DKdCFvNUBdSKukPkBS1/gUGuYd16ytyY53WBQ17DsWvHTlVVsy/gjVI5j1pig
         S2wjsztn7VR1MflEXhc3NzZTw0CahoeHXmjBix8OzCMRA7WQ0/ZIJITX24qDyX7/HCKs
         xHMcgZPgz3+sg/Z6U0l7RaZDaWPQED+phXHWAhNDosDG7CCq2QMWbQkRDS5+omeyRLKS
         KGp4p1wYitgupqDacRi4QpUH4WqFESpux+39+tdTDU/A9fBEc6ryU6hkzIZ9S5Z2ytBj
         ZfPSwt0lta7UUeAoKD7EA6cC/YyLiPv2Y3Nb+NT8GBU0ZmhIP/sZnYJlpW9V/RyZ34RP
         G1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390831; x=1793995631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8reQ6REQEA2k8KRp1SWplSOof/sTUnH2B+t/FwFcDO0=;
        b=VXbhwjXN5I3Ogo7kidZ/7OF6Aj2JAZalhYPXWjjyzPsJrtakoFXSxr6z3NeKPswkwI
         eRgaycK2OfETdQq+zJKwrxJKV6UX0etDHqlOpplemKLx+8K7lX6ioARV/24wDMRfBHt/
         KpgRSx5MliGdjh4+tEHOzcoxmfL2QczeTQ+EKBJaf1PYrHwxypWVWRjmSibz/0y9ZaQ6
         Iwc/ZadDlDIaSjmgFUiQRG9m7U71c0mOHFlt5iy9K0zf/fN3Tt8a2+0ncQwVug6ngdb5
         Ik89/KkXjCakt4Apdf0jbCPfHfK43gwjL51h9i/fQYidl11bfaZbegs67rZNNvdlfJJO
         cbZg==
X-Forwarded-Encrypted: i=1; AKwUvBzW2ANc+dP5lfOpNuxVvSpbSgu10Voe5vzeRMrFXyr8lW0WW9NXMo3kdpSWsioMIbyVNHEPyTjcBDrwOgCd+BU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7FCGG/Ib1XuKx9K+akLMvfY6rWfjHCWCjLzvVL9YVtMRQV8XF
	33OQScdKlclEU/13Vc7RreU1a/AmXugbQcxNj9xAf6oHfYOFA6RznyTpU2UmOvvBiH/PXxD4A3e
	GtALWSTogCV1E0htjH8HMTGv/5dLV1mZ016O9aOq0+R2zKQdQSwLr7Du09y9LopZGbHTgtA==
X-Gm-Gg: AYBFou1U90ptk59lxAGx4Wu+/MnQChBASDl83WXsFgwqV5594VaeF6arKssXLLnIJ0l
	CMetS0cYdZC+issElOfS53oeEoIb4yIulcxcyJFoe4l7SXtss+HVuqr2SLNQDT5qkq8fNACF7z0
	nHm3N3v/4ge6C2+uNaWlNE93oIq5cbgdySlLFW6k4aeGRNwp5lmRc59Th/jocOyKwaFcZbdekfu
	vV/gMGH+nGgQQpp3YwjWPNK7WFiourlH6VWY1ZGlzZ5XRsvqc1QqVgw93d3xKXg9QUzoGtGUG4u
	07ui2OJjENPYEYFmKki9oqNpI5cXkdM7MzXR7EJBXLGtBSbAaxcc5rcjV7IQODvXt3b8kSKFm4/
	weZtaPn9ktWuZoM/423myLIgeOo66Q6B3AQmoMSCftbX50Qbutq0zv25bI4QtL6wfuFnePA3JuV
	avVdOupy9YTsb49A==
X-Received: by 2002:a05:693c:20d0:20b0:36a:112d:fae3 with SMTP id 5a478bee46e88-36a42435927mr4887080eec.40.1793390830816;
        Fri, 30 Oct 2026 13:07:10 -0700 (PDT)
X-Received: by 2002:a05:693c:20d0:20b0:36a:112d:fae3 with SMTP id 5a478bee46e88-36a42435927mr4887052eec.40.1793390830363;
        Fri, 30 Oct 2026 13:07:10 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm10581834eec.29.2026.10.30.13.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:07:09 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 4/7] tpm: tis_i2c: Use local 4KB buffer to limit memory usage
Date: Sat, 31 Oct 2026 01:36:46 +0530
Message-ID: <20261030200649.357508-5-armenon@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030200649.357508-1-armenon@redhat.com>
References: <20261030200649.357508-1-armenon@redhat.com>
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

The global increase of TPM_BUFSIZE to 8KB is necessary to support
Post-Quantum Cryptography (PQC) payloads. However, applying this increase
to the tpm_tis_i2c driver is unnecessary and wasteful due to physical
transport limitations as pointed out in [1]

This commit introduces a local buffer limit that is used in the i2c
driver.

[1] https://sashiko.dev/#/patchset/20260324071803.324774-1-armenon%40redhat.com?patch=8319

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261029181541.99505-5-armenon@redhat.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 8bcbc84815fd..36f56ee75cd4 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -61,6 +61,7 @@ struct tpm_tis_i2c_reset_timings {
 	unsigned int assert_us;
 	unsigned int deassert_us;
 };
+#define TPM_I2C_BUFSIZE 4096
 
 struct tpm_tis_i2c_phy {
 	struct tpm_tis_data priv;
@@ -240,7 +241,7 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	int ret;
 	u16 wrote = 0;
 
-	if (len > TPM_BUFSIZE - 1)
+	if (len > TPM_I2C_BUFSIZE - 1)
 		return -EIO;
 
 	phy->io_buf[0] = reg;
@@ -349,7 +350,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev)
 	if (!phy)
 		return -ENOMEM;
 
-	phy->io_buf = devm_kzalloc(&dev->dev, TPM_BUFSIZE, GFP_KERNEL);
+	phy->io_buf = devm_kzalloc(&dev->dev, TPM_I2C_BUFSIZE, GFP_KERNEL);
 	if (!phy->io_buf)
 		return -ENOMEM;
 
-- 
2.56.0

