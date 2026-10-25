Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959563;
	b=kmW2Sz2lcTrT4faESCs3gv35Wmn4frjkuheBakN8llGqoIQzkQBmsDJe71qvVbpRgElz
	 9C9F/rvm69n+q7zccW+L5G633m6k1ggULprbcX4DXHvKn6YNL8UUM9aCBUlN09S2m6+KD
	 YMhIivv2Tvueha/bItxvriEqpA9RV57zT/LaEI2pOWBtGsG83uNaSQaewbcFPcEyQ1ovU
	 FJvDNgmCZKFd7j67gGmUxLXGpD80KpMC55byxseVydRWD4yTiS5SyOiXWwpSLsgLeNLqD
	 lCADWRMqZRkKyXx2QKKYB3kB7kYPHJDJJF3Cf42Y8sR6JIgsyZ8e/f+5rsp83R2Hp/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959563;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZVwblgn8BYaO2Yir+1yQyjgwaD83vNJgvPl88UMx6rY=;
	b=3xI0qaJtx387cFSO+gfzI50p7uim7B5CDNFnR9U3PFQwVksTYbLj3JphVX6NC9qR6Asm
	 gnOdIFayE4l0Xi7LLH3q2ap7pySRoJVdktFo74zB9r9Jz2X0j7wvTALlYX60mx8Q18Gw4
	 X4wLwUkEyipSjuk3aH5iYmIgsjHUacWg6b4lKr21t1AsYRPzIdwAMckV+hsU0oMDWUbtb
	 8WkS6aS26lRPduhQhS8K28ojfvp7sO6q3KPxcK+vEC63bkV/65wAboRKvDMyO+ncETjgb
	 CzadboccSEdJXwINTKMhNrKYLIfcgZ4DIKGCt+CUOMVBEqKKLTA5yqzdMD8IAnvWHrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SJd77E3n;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jlwOd8Xn;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129E606A328
	for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 20:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D129E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SJd77E3n;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jlwOd8Xn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792959562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVwblgn8BYaO2Yir+1yQyjgwaD83vNJgvPl88UMx6rY=;
	b=SJd77E3n7NngTgRCIXfrgyW97B/uaLwthf782qZ+ndmoVJ1ux2gHdV/cuP+VmBK86Jw0JC
	BB/17CHqALBPJ+xznWjDAREXqagD+sJQFf9aftJy8UZX3VAp1eyXudZTYEZTVXllHkWEUw
	jPFjIjNGojdvAIUze93quUIQD//8O74=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-xraVU1xJMRy8aZ37ItPhQQ-1; Sun, 25 Oct 2026 16:19:20 -0400
X-MC-Unique: xraVU1xJMRy8aZ37ItPhQQ-1
X-Mimecast-MFC-AGG-ID: xraVU1xJMRy8aZ37ItPhQQ_1792959559
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36637676140so4075550eec.0
        for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792959559; x=1793564359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVwblgn8BYaO2Yir+1yQyjgwaD83vNJgvPl88UMx6rY=;
        b=jlwOd8XnuqKh2GG30zzpHkq+EuKbi/rJtT/yRKaQRrxdUHLwev75bLz6lUhjUnLOE5
         aeIM0rmZ4UTsCXlfC7bdBnp1IRGILMEQ3K17QTyM+Bg28clk7atVBphLNT557kpS8qfC
         fwXDUspvymtdmEOKMwfLkE4OKQ/99XfMLNxkkWdSdjGmks2EtO2AMHQ9sIXBCz143+9N
         5vnPjUg0+8+wrvzIypqx3B+70HvZTl6AUiCHvvDenwJxqPnARQHqbVWJSwTMFq/pQsMG
         bylnojweWal+Xw67HjQpOheMesAfHoIew8Ze572dPOWoY3D4ZFNoZTFiDElPXffVbu1f
         e06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959559; x=1793564359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZVwblgn8BYaO2Yir+1yQyjgwaD83vNJgvPl88UMx6rY=;
        b=ysD1CoRNMOxGvts4rfdK6PkaPpDsX4eN8Z5DrTQ05L4rD4CDnM6FFNt0/4LMe8QGOg
         SEf9o3rr4wenQxRfri1ySMAhM/6jCA42ttCoNpQdaN1v+uzLgJnv3DXV1e1AQCMeWtnM
         vVs4Ks1EoGEvuG+zLAlYBd6HXxpCTzkQwu1px4CIPkJiMRYMSqOtu6RZdJdXVcb2hX+5
         ao5Tv9DzmhMK9xQrgqJPt4E/AnL5pzhxgOb9K9m0DPnk2acO2PzViHyWeraaeMqH9HL/
         LvGvYJYdthCT+hTmHI17mN/0nId82YNwCHCYtd2AFySS+zbz0makfgsXm7TxkJCDvQGP
         EiEQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1RVrlOWwG87bebr5KJuFq3H7EILqhEv2EFKtoKafpi99gpe3HYXVkvNQRtWzBjjcQazqMFfQFVHGGRUIDujY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDR5+dMc9tSeambhdkA3eMWVvnl96UHtx+2E/w/rKU6Uk+rprn
	m1WQC1WzmV50iJKTH7lVYrphRMdU8WMj6RzEs56PrHKQbmwntj7tIkrIIc1mCFukr4OMedry5aq
	Gnw7TAJ95q/FV7Xx6K/yxbqu1DbLb2JJioU7Y9XJvdNCaqDNyDDazC4hRVpBzr7epZwLgbA==
X-Gm-Gg: AYBFou3nzP4MT4b3AUzTUY29dZ4nnkwOmLtdDPSQMjA4cBUW+msEBEh38KX7oAroRBl
	QXKsU9s6GYemzZ17jXpV7TKnL/Jz7X0n6SlNSntM31P/CsJXDjVfqRUX+L73YZlaciqF8/qDoi9
	DKM9WAL2MXIXJzbv200CHhqOlSSNC4lxNSb7RhzKZBLdE1QbWiE8U6EVJxom/9EKSfMDsSQtGMP
	vYLXAlnB1SgubitAUysN3pghLYQf+HJLOocWpKgl8gDbVf03uFZR7fOGZJdna+Nl5a7jBcEGQIB
	8dxXXqcGc2hs8uCl1UNXRCONS3amIcNi+3weTLWwmmJzhR7L1Gw7gk3GEbVpy56JT9TuW03XPzK
	+VBhB1xu+L0sHBv24Nq7ocZGLt4BJIVq7LRSrH9KM
X-Received: by 2002:a05:7022:b057:20b0:19a:ace1:793b with SMTP id a92af1059eb24-19aace17b02mr6777430c88.18.1792959559182;
        Sun, 25 Oct 2026 13:19:19 -0700 (PDT)
X-Received: by 2002:a05:7022:b057:20b0:19a:ace1:793b with SMTP id a92af1059eb24-19aace17b02mr6777387c88.18.1792959558551;
        Sun, 25 Oct 2026 13:19:18 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm17656169c88.3.2026.10.25.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:19:18 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 4/6] tpm: tis_i2c: Use local 4KB buffer to limit memory usage
Date: Mon, 26 Oct 2026 01:48:56 +0530
Message-ID: <20261025201859.221991-5-armenon@redhat.com>
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

The global increase of TPM_BUFSIZE to 8KB is necessary to support
Post-Quantum Cryptography (PQC) payloads. However, applying this increase
to the tpm_tis_i2c driver is unnecessary and wasteful due to physical
transport limitations as pointed out in [1]

This commit introduces a local buffer limit that is used in the i2c
driver.

[1] https://sashiko.dev/#/patchset/20260324071803.324774-1-armenon%40redhat.com?patch=8319

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_i2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index cde0b093ed58..4667eef15ff1 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -55,6 +55,8 @@
 #define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
 #define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
 
+#define TPM_I2C_BUFSIZE 4096
+
 struct tpm_tis_i2c_phy {
 	struct tpm_tis_data priv;
 	struct i2c_client *i2c_client;
@@ -233,7 +235,7 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	int ret;
 	u16 wrote = 0;
 
-	if (len > TPM_BUFSIZE - 1)
+	if (len > TPM_I2C_BUFSIZE - 1)
 		return -EIO;
 
 	phy->io_buf[0] = reg;
@@ -341,7 +343,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev)
 	if (!phy)
 		return -ENOMEM;
 
-	phy->io_buf = devm_kzalloc(&dev->dev, TPM_BUFSIZE, GFP_KERNEL);
+	phy->io_buf = devm_kzalloc(&dev->dev, TPM_I2C_BUFSIZE, GFP_KERNEL);
 	if (!phy->io_buf)
 		return -ENOMEM;
 
-- 
2.54.0

