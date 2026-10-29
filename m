Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297779;
	b=Y+0ohP02DL0cfVb8ZXdRMM2PWA7TZZTwvtr/IjvpskhBOE+Uj1J/R/hxGBLUl8rYBvKe
	 DebRcrQ99pm+y+xPInT6APv4iPL/GxCq/XWtM+GYKH1VMSLz8sRvVsbUsihibFm/kRX8/
	 TiCo4OQDDismwVv+ZMUqNpvYuBkLuvFetlE4xz+ZSSLttxvHpCFhYC3d5BAahnH0XVSwN
	 JyzzgKurT/L5DxNYBtEH5MgcfF8bKbEhRSvoMJnfQ6oVHyp7oJfYbiRbbqQJ/s4veW6kr
	 yWqrWbW+kvpvhVaINlM3ufeicgacFwEj8EC3/k1nBgy9qbj8LFhchbZzNbBVpvqxilw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297779;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SbGRSkF9pUn2CydJkzRh5tNHBjPKK+0FwPmwEY8AU7g=;
	b=yc2XJTTYbMMPVU/kezUc6yOgAJ804b8ohQYuGfgpCkf9fm5oDI0KPvDp3CM5/AHrH2eL
	 K/zU2/cluB5JWJ9nyQJnnSmOMuMmCbQfGu98NKYLPq0PkMxV0Mf3hevci6zLuxXuvNiLj
	 mcaLV3IvnNrQarDqP3f6a+sPfyyK2iVbv1iMQS20n9b/dO59fm9CZEmERSyISKrV+YmTv
	 jyi8dq+rMbJjI8bpDdl9THiAxnkoOVChOOyKJU1QuKDPit5UXwzYE3P9+4ks4XzdgIzBm
	 ZPkwSKUVZ43vB7HpsBNuLLXMeof7L5uZiLose7CkzwgwN1+LRnjInEf3ieXghlMZy1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fx+9vJR7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tjPXf4c4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20E606A31D
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 18:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F20E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fx+9vJR7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tjPXf4c4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793297778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbGRSkF9pUn2CydJkzRh5tNHBjPKK+0FwPmwEY8AU7g=;
	b=Fx+9vJR728+RFYyT3t6y+MbgoajFjMmxbEE9Kz00uzVY93FP6PZavXVB6zTPgrr00m09Mo
	ivcvunYde2oUumPX2U2NZzPdAfcytjVbJ/ouwxkwjNudmkwGEuQP+LuFeKEGYjzP/f3/sB
	/E/d5aA/fgYjAMo/GJl5E8eCWpcewGA=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-JsOxfKhBOZCL1pkLHPnKtg-1; Thu, 29 Oct 2026 14:16:14 -0400
X-MC-Unique: JsOxfKhBOZCL1pkLHPnKtg-1
X-Mimecast-MFC-AGG-ID: JsOxfKhBOZCL1pkLHPnKtg_1793297773
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36637676140so3402718eec.0
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793297773; x=1793902573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbGRSkF9pUn2CydJkzRh5tNHBjPKK+0FwPmwEY8AU7g=;
        b=tjPXf4c4E/N0wwi7tZzaSxj6KmCN2cQIVeWEZuY8sd4bIDaAKBaki+KGcCiRMlDyLM
         gC3nvrtDW8KuT9Pxjv/UvCbvfT3+Tn3RG7CF9BUpJ1kCR8Llhe3p38q7evPtP3KZr09C
         fmIRQehjQajeg4ZA66V54248exrpSOtHpNGK4jqDLvqrQIc2U3IdMfS4HfPYWX64Jq5i
         QB8UpPVbPaYf78rM6oa9C5v41540NVLHIVsDW2xrWtzkUoymwkAsB41U2WYB08/FCLg1
         iqe0pvrUHuvUfHCzXbufA48g5EtD63fjEhLh0TJRSx1dgk5TaTyqS+KjQNAoN4+tEiKD
         M9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297773; x=1793902573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SbGRSkF9pUn2CydJkzRh5tNHBjPKK+0FwPmwEY8AU7g=;
        b=Ho45ZPhUl3nVqCDwCVQJHjU9KJSp/Rb4lqLCQ8FV6/t5j6JD7WnzYMiBuRvOKq87Dh
         FfTucGx88TJPHItF/s32HW3JwOTbq2n6nL0UYepDvVqsv1rjnQDjwKnUCjq0qJuYlN3O
         Wl/jlHgVdMf8vH3acS3ype7cDo9ffItq6Xuwtfe81fDWpNvr4jE4P+dNRX2D9O0ZXXi0
         CoemyrRQe/RhtRiqehv4Raxa9Te735eeS+rwiBFWru24mvbb9dxyXQl3IOfIxu+qBC2C
         KHLjUVTPZkKezwl+Xd2+dywjYmM8+bcuUylZdqUNAgNacJbh7AUfZhQ05zeFtydmBZbd
         pcGw==
X-Forwarded-Encrypted: i=1; AKwUvByErc7PaaMOErK4VyWTdOJ2XzOfJAZa1HPzwM30yM4XWcXQUfP0CXjyewcTS/vXeNO0QMyKrcMGoaQkMehZ/So=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUvvzjflTxhsoSh0aDuoHl6LeIK7/SN8mPuk5PhotfokbCqtrd
	PxlmvyOiaX+Pq1+fg9GnuYFpoBxCesaATCHBBCtHCOR6JuvnoraSJV1cA9WZsuOpGw1nnFabzJq
	dQC8PVc7NhT7Boci+6PuxSI7efIaN09zc5KQOWz9SdkltN3NbqS81iG4vC8rUrltAgRQ3wJ0aUr
	oUUg==
X-Gm-Gg: AYBFou14x5kcjcGUF8cPedTtYRCw5fp0e4YUw19ZY6JWOQsH91rm8/sz4Vo9RikLULG
	xTnCc36fSPvFCiJK6KhOKYF3/YjTQUEv798EJmPhTLk+mboed+oBnZOzYhA5FYyrz8QQb8E5Cjk
	Qnl6r98Mx5v1epfi3eVOu0toonLVUS7v18Z2ch1NjSdjJhcV6nqFdmVT6bZhno0K7yQiVt1KWg3
	4+AOovN/5gKJEonbDEGMYyu6F/cDb6ltmyFDUp8HuuvGaP0aNrC80SVueSNHLZPvqSoM7VJdfrg
	kJd8dPgfdb5YszhOE5mKNlooXFvESu9O9A9EMFpPLimA7A0gnMLeq+iGBMS5py8zuLYL1ll+Dp4
	6+BoDsmavQ6OHXaxJWUauJO/mnGgeq7BI8RMXaLXs7RVplcl7RpQwRkBuXgbiLLrWOp2lJdQ9Ar
	vNRvSLHwb+ryM4JA==
X-Received: by 2002:a05:7301:716:b0:36a:31b2:8643 with SMTP id 5a478bee46e88-36a42453282mr173703eec.38.1793297773005;
        Thu, 29 Oct 2026 11:16:13 -0700 (PDT)
X-Received: by 2002:a05:7301:716:b0:36a:31b2:8643 with SMTP id 5a478bee46e88-36a42453282mr173659eec.38.1793297772238;
        Thu, 29 Oct 2026 11:16:12 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm259163eec.4.2026.10.29.11.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:16:11 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 4/7] tpm: tis_i2c: Use local 4KB buffer to limit memory usage
Date: Thu, 29 Oct 2026 23:45:38 +0530
Message-ID: <20261029181541.99505-5-armenon@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029181541.99505-1-armenon@redhat.com>
References: <20261029181541.99505-1-armenon@redhat.com>
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
2.56.0

