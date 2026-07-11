Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E83CEBA7
	for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785702; cv=none; b=BYyLfS9vEWCK3dI8GMWVa9npdc4w9+dLZ+4abzY7bEat4SusSav/nsWnb5wldiLg78KJmkrfP4+ksk4fCf0dlNaM0B8Z3IkYV2bJ6Saka7BZno+b23GNi0BRvxZ6U8sxFKny35i5h8rWYQU3UK43YALjXY9tLG6vf/OvooXsq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785702; c=relaxed/simple;
	bh=OhR3jksgiJE0o7foAJ3ocqiSNmyJW9mbxX+rNOXqb98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqXDIT+qrgsUKRP8CDC0IZY+yIu1xuka4CpdAKhbyWhvM9oFOwYW8KGiEuKYKZ0MeI7xPDIZEOreIIKvdRQmAs/BjlsGCra8xbnXPxTs7BKXnS3LWTDJP/kDLZjTAKrsUjsW4sfcPm6+uYah6sYy7lnw4xnw8IqFXxWlD2oLX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9cXs2Tp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9cXs2Tp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso22047765ad.3
        for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783785700; x=1784390500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5tpVMPDTFvUicz2+KLP8Hde8q3QB+Jxc+FUe7rT1AhQ=;
        b=c9cXs2TpEjXm1a4uDiNX96FO7aegjxbngYacQH1eKdK3vtFtIYb42DaRy0EmNWa7cR
         3U5j4lUU8MkGX3rFOJw01ZH5wecRSS1dxB6kybij/bR413DgR8TbFmO09Vc1SUM1areP
         G7bszIDezITBC9Ql6csioBDePNHncBvcKQk+rNE0WkTbOT4YshQfoMCa8XkEplMx70bT
         8zmUPJaitIRj9iE8UDOI93BQnKDOeiC8FHsIoAHipnUPkS6VT3C9GUmLGtrYRVevLFUi
         fm2+ZTzu4WuZRJeuWJJqVJlaO9OuAmDAjJOLEKhHP8ezuVGaKeLDj4mpqBHjbRoKPtS3
         8wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785700; x=1784390500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5tpVMPDTFvUicz2+KLP8Hde8q3QB+Jxc+FUe7rT1AhQ=;
        b=a4+Ow+PwGVW3oYNE22V9Q+layud1NOTC6PPI8UjDYoTWdwqA9ke8yzlswxiWicHn5p
         ebnO3yhMlbwurErWwpRI3tFX22KphbIJ/Ovp3XKB7OZDILSv8hdrqU2iMMnz/ghjKFLD
         8RvIBI5ZekDZ4Qr/ngNGWKwin+2ShPDH39swdl5DjSR7oZlp/pkIgA7lM5z9h+8r8RWd
         gb/LAFvVkXj8IE7/LvR9SXw9xfXQ6prIqYgGTMPX5lBEA76wZZqA6VGIV0ItJaCrr1dM
         lAHfhqad5uOvbSwP5/cPCGSOBQFkgZh8pE+81+uycowNAn+b6l9hA0jkh0n3tOifj/Bu
         ykJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCQ8UMfb4gLFiKYh3UcAKgqyXEieGVDU7MmOTVe/HJOxkFKr2MYUxddOBRqYGgJfSofSIe1ih+Yh38D63uj9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNxDUKXP600BqvMDT+5VPK0uws2iNkYwb7FQXJBF3/UYsynCK
	VRhCUABVATvEU/MfeDxk5X1sQQ9MYQx+OwIV0ChaNQmlEwSGKCeYTBVS
X-Gm-Gg: AfdE7cmsvNNuQ+pfKMCONEWDO+6Yd4nR6hhMLoovNhh/mpxP6nZdutvYECwSQ/blzg/
	+Rm31ixHcWdm/Qm4YkANL/eeoKijYvHsqQTHWlywSGNbZIqYrZMet5qvNEfKgPmzHNav597SzbG
	8mchttkN/YuO1aVo/gqNA5D6EZpCLocWlWZ9Xl/zZLLNR/h1oA5BXUhnWyWM/4n5Az1vrZw12l0
	2l86m00gjo2XUSpnhMMNpbphGL0/rPIEz1FTLRQGvR6uLbPWfUKb0ExFz7vV9C05XCan5sLbuIt
	siCxFGVgYu/Qn4d82xzzhVMrQRjLMF2STQwNUKGwTnZ0QljD84Lo0gp3s58PvleF1O9eGvKyjgc
	Rb6+mi8ZDcXB8Zjfw8levz0/84CCDcxAdlK2wfv5CKt98mBq4Z9VXLpDvXZUlrS4e4097XqKjC4
	6pmN552XnTXzYeg1Qz7c6E
X-Received: by 2002:a17:90b:5343:b0:37f:ad36:8fc5 with SMTP id 98e67ed59e1d1-38dc7759428mr3420382a91.23.1783785700259;
        Sat, 11 Jul 2026 09:01:40 -0700 (PDT)
Received: from titan.lan ([2603:8000:df01:38f7:255c:dd03:30a6:e57b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b9ca880fsm12560829eec.23.2026.07.11.09.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:01:39 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	luto@amacapital.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v2 08/10] tpm-buf: Remove chip parameter from tpm_buf_append_handle()
Date: Sat, 11 Jul 2026 09:01:08 -0700
Message-ID: <20260711160110.267780-9-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711160110.267780-1-ross.philipson@gmail.com>
References: <20260711160110.267780-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Remove the TPM driver chip parameter from the function
tpm_buf_append_handle(). The chip parameter is only for error logging
which can be done with other facilities like WARN().

Message-ID: <20260125192526.782202-11-jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c       | 9 ++++++---
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm.h              | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 61833b4d81f0..99811809a72a 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -146,17 +146,20 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
 /**
  * tpm_buf_append_handle() - Add a handle
- * @chip:	&tpm_chip instance
  * @buf:	&tpm_buf instance
  * @handle:	a TPM object handle
  *
  * Add a handle to the buffer, and increase the count tracking the number of
  * handles in the command buffer. Works only for command buffers.
  */
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle)
 {
+	if (buf->flags & TPM_BUF_INVALID)
+		return;
+
 	if (buf->flags & TPM_BUF_TPM2B) {
-		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
+		WARN(1, "tpm-buf: invalid type: TPM2B\n");
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 280f870e6517..c7952319384e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -198,7 +198,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		}
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(chip, &buf, pcr_idx);
+		tpm_buf_append_handle(&buf, pcr_idx);
 		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index a1ae5e1829cb..0d89643e6880 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -260,7 +260,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(chip, buf, handle);
+		tpm_buf_append_handle(buf, handle);
 		return 0;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3c6a5bcc138a..b357f8971d03 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -235,7 +235,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.55.0

