Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794684881;
	b=YTbKou+f57GPR1GQfOkCJjm5UXew6FxNWsJbKlqiTyxDQWjJnchddnMRWEwhQtF/BUk1
	 A7xYASm1ZdV95hKU282DVcLWbRngJgvZZ+WuLu2aniOLot+talWIKBVZCOZF0g6isbDOb
	 r26OKmnb9YeDux+banpRoVGBolikMJYb8Gh6GZp8CiyN8/N6tTjQBVEUa/O0pNLr1PQ9W
	 Vg6cUlE03EAjkbXSUJSYgqF2KNeqO/5lqIP2VGWRJ6OA4S+1X/p0jH6orjyUIOPwMDP52
	 cGce2BzJI2iy3H4B9coOUFYXGHC7aaXWRN+7Uayvn/bJJqG1mOB0xLJT3wAysKfZkBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794684881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9ar4Opp2H1k6OcNUZh0cDsgFhCHm2e923NlD+vqOgvM=;
	b=qDjxGojUtfNJQDtFyuky6GCvIFHBD5h6lwqwgrmUqkfKKuAguT9AOEOr5N5und6Xa0d2
	 0OuUs6d0kpsLDmdsuuH9jlB56Z4loE+ofTrhEX8bUYxZ9+8msp5ZN12qXfwQVLV785KjL
	 nQqo3mdF5NXvl63usxigmXawNhyh1p+cJUWC9r1LPbikBXM8hyvlFLhn8nfLJ+IyGdGpJ
	 1zCUAaX7KZsC0whDQHJTzx6k+ctwzUl6Ahs4uOqZ4IxHF32qjTu7xX8Zvl11wZePljpXA
	 Zgbvz6DMG9Cb1FjmttevpolBqHvEYyY9/jn/VDzBARSHLbIePcPiChQnMGfUAqsQAig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=epLbi5iJ;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C87606A335
	for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 19:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96C87606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=epLbi5iJ
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2041829a91.2
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794684880; x=1795289680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ar4Opp2H1k6OcNUZh0cDsgFhCHm2e923NlD+vqOgvM=;
        b=epLbi5iJdzMB05sfV7Gtp3qf/9N2YK034SUivD9cDXtjgeYKCwAezyizQi+hKIQSdz
         ZO+La2Wr77teoodUhLzZFpdxS+PcrDxD5DpdD/rE0/tAmzyFYIaL4UN7dINsfDh2oucA
         xJKJ3tFf/aUsq5lZ1eHHqFy0y5jTDXgzf/SgCtqVgcMMhvcsO1GdAcV/97xpYJsFpRu2
         r4U1XPHlH819WbBA5k7IIGwg6iB5xYSnDQId5eGcaGxBrGkAgV8ILTcWVREi4lfB7Q30
         j/FxUSTG744TR0RWnh5eTef4H/w4CD1bU8bkCOR5RJo8DNymxgUmc1XWXMgtcurLu17n
         jr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794684880; x=1795289680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ar4Opp2H1k6OcNUZh0cDsgFhCHm2e923NlD+vqOgvM=;
        b=VLXKPT9cbVlj/2OlchuRsSchR5r56Kcpp61BJzfAwplJ1+AVauGOyXIYy4Ze3f4dQ1
         C3YQvA7LEEh1gpmg0SW2qH53PeJYcSuBO8q8Jn5ysOAI7s68Oc1G+usbLIR6bsVXgpuL
         0TdrJTp891Bmash58BTCHxSG5bJZ6NHs2m1q9BKxFp8kzzOBQb4JKBILhCkm53GRuH/Q
         gOpMqxCwGJ2CDDZFPQUoSXvE2Mrv8EDa9ov+8KrTKBmV41xM+NRn4m44YdmIGXnKLbOa
         7d+h/KcrMnCDDkOIzGoHwZIv6gUBuzPxNmrFOTUNkyQIqhm+lzBNMyvP9+M8CyPS7x0s
         2phw==
X-Forwarded-Encrypted: i=1; AL+hErGIi+lchpldn+WKU5und1cSJ49BpIoFLaXksfdvxz3PY808Jr4oxr5dvJVFMb2IHZ/KutbmbFUyWeeOtEubxsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XmrkSXBt9RHoAVcOU02Tkpyo+Wva0Jpef1gP2/HxMwCE58I5N
	QherpC70VsNVmrFzjP5QqYC8Sq+2Ggkntbvczmsk4ryT3/3PT10B7Q+c
X-Gm-Gg: AYBFou1Rns+osWOhZpyZovjPHqFVIYrDdGooYQs7KFgtWB6ukVa05eRxYnJKmzL03yg
	htzbChdp5DiV/MbqzCRLlNZyaa0b6EvMRO3see4Tpe8zMic+Ha+TDvZswDJ+rDNERpv3CNtl4bb
	fcY6JCoSQqfD82IFcK9MrTZVYa1zKS4dqp1KgGF93lXNVdwufsFFs7IRJ1hjfUs9dgUk9e5s2UN
	e5L87FGWSVfWeIZQCvA/gZPGjflovS28NagGn9EZwMVlynTqLLuoN7lxYMf0bsKF59qqJ1H3Uj+
	hmCqfW6YcKJDohDQvhx5xkZ4qLmvwCHdz2UYUdkEQfRvCJztfB1f0mDyPD6GxS1Ttaf5dmq57Bd
	IFvTnxwGeDHbPog75YJPV08LfoECNbpKdcIgONyw1FyaZZoXptpWJJ1TdXvrpvrtq44WVwYOWou
	XeUOsnPgMQfgDsez3HkhJ2qXGeOeiKYEXgBPhxodjErgXiX7pGlljujK812WA6Y1p/lxda+C9Y2
	EaRk+W1jVPDfZkJjDG3szP7reQMduRNVhMe1GQHMY/CrRdMHiAxUD19AXt62uXxzBTOCQztjgqc
	EiIrW0ynM5FOFXuWlnZD/e2li86mpm34OIzcSVlVLHIriURGFpg79ttHLUGTpy0hgGwYIjkFQd9
	xVn82W4JPq0b8xM5FBt4aypW20gm9k+yg8zpqZkqNrRG86e4bQQSp1o1VV9LsaO1TlN3QkUstM4
	khFcBxYe99dAE+XqLC7kVhQmzFI55KDKVo0tJahoch0rI0ahfcgjCXr5+cM5cKVg==
X-Received: by 2002:a17:90a:c88b:b0:3ac:3588:b548 with SMTP id 98e67ed59e1d1-3b1b09e69c6mr6471730a91.13.1794684880041;
        Sat, 14 Nov 2026 11:34:40 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm5093969a91.1.2026.11.14.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:34:39 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v2 1/4] tpm: Cache TPM2 start method
Date: Sat, 14 Nov 2026 19:34:31 +0000
Message-ID: <20261114193434.117714-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114193434.117714-1-sidchintamaneni@gmail.com>
References: <20261114193434.117714-1-sidchintamaneni@gmail.com>
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

From: Jarkko Sakkinen <jarkko@kernel.org>

Both tpm_tis and tpm_crb retrieve the start method from the ACPI TPM2
table during device probe, and tpm_crb_ffa also needs it before chip
allocation.

Cache the start method in tpm2_acpi_start_method during tpm_init() and
export it for the leaf drivers, defaulting to ACPI_TPM2_NOT_ALLOWED when
the table is absent or invalid.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Co-developed-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++++
 drivers/char/tpm/tpm.h           |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e0385b16616b..7b7da79bee7c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -534,8 +534,17 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
+#ifdef CONFIG_ACPI
+u32 tpm2_acpi_start_method = ACPI_TPM2_NOT_ALLOWED;
+EXPORT_SYMBOL_GPL(tpm2_acpi_start_method);
+#endif
+
 static int __init tpm_init(void)
 {
+#ifdef CONFIG_ACPI
+	struct acpi_table_tpm2 *tbl;
+	acpi_status status;
+#endif
 	int rc;
 
 	rc = class_register(&tpm_class);
@@ -562,6 +571,18 @@ static int __init tpm_init(void)
 		goto out_unreg_chrdev;
 	}
 
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_TPM2, 1,
+					(struct acpi_table_header **)&tbl);
+		if (ACPI_SUCCESS(status)) {
+			if (tbl->header.length >= sizeof(*tbl))
+				tpm2_acpi_start_method = tbl->start_method;
+			acpi_put_table((struct acpi_table_header *)tbl);
+		}
+	}
+#endif
+
 	return 0;
 
 out_unreg_chrdev:
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index fa554c5ad80b..212ca2410c93 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -100,6 +100,7 @@ void tpm_sysfs_add_device(struct tpm_chip *chip);
 
 
 #ifdef CONFIG_ACPI
+extern u32 tpm2_acpi_start_method;
 extern void tpm_add_ppi(struct tpm_chip *chip);
 #else
 static inline void tpm_add_ppi(struct tpm_chip *chip)
-- 
2.45.4

