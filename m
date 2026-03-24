Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858E3358B9
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375984; cv=none; b=JqG5OmvzV3l1cGvvi+sHtOS6dFf/SfKFa8LNQv6gTI7fmUL8YkBwSIOjD/bIX7z63DSBTywDVTjo+WNmEsZzR6LadzbCveErR2+yOJg1B3WbP+p3Zi1mxev6770omrBYKmNcp8VZqoL21zpb7Dg54BF9lImRxZpfiypSTLNUEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375984; c=relaxed/simple;
	bh=hPL25OKm9bNXmRnz6cKeOMLxQeuKkk2o8t12Orj5iNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXccd9Bd8lO9zpyb7+oi52pKdd2WfyVcMocj1YnTRqKr0gFJaoVSD5GxnWL4qrBSCx6rug0wAWYnGDVQC+Ko+D7AocdD1H1vRUc85rfuXzS2Edgl7CsGPFBdRaSQxi8DScfSb93r+OfStKotVeE/GoamJk8ZFAhsGaGNExE1i5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvKMqmbb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXyWSQja; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvKMqmbb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXyWSQja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774375982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imwEJb99lBD32TauVrG1INXQ5z6pQWDRIPso/BjwfkI=;
	b=SvKMqmbbCriXb/tARtOFq0XZlXN7CMdSef3+AFxozOHWaWHmveSjdpu3KHXS8lw4ajVoYx
	7hyp8NXHHo9ue/AKRAzidJALyBm9BKW9ryk7F8lb4y35tCYx0qf6qiXo9ZEtV2LRuwI/RC
	4LCK+6UPH4d1jVjnpLGa218u2FKon5c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-2stY12caNzSeeHEu8H_KXw-1; Tue, 24 Mar 2026 14:13:01 -0400
X-MC-Unique: 2stY12caNzSeeHEu8H_KXw-1
X-Mimecast-MFC-AGG-ID: 2stY12caNzSeeHEu8H_KXw_1774375980
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so154764b3a.1
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774375980; x=1774980780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imwEJb99lBD32TauVrG1INXQ5z6pQWDRIPso/BjwfkI=;
        b=GXyWSQjaOiKIPiBmOP7/hSxhZIiu1GvuCa+CMvvbN0xOySN3uKhFqSdUK+Ft4sSeN6
         0AaoD30aseDgPzeqQ2F9NCZTh88EOp247Sqd4JjOZ5dFRqmLIhTljnmfVqiAIor91jgS
         W+FAjg0hl3Mmda0x30JM+TEOL+yqbDd6ZnWR2LZsx3RVwb2yeEgxYL1pAb5j0qL1oFaT
         GNYq+MFEmvF3CX632SzgLK+0js6z1O8UzTsNTyxqbaeOoBmBrCcTToMIcKae4L4pJMPP
         hMik7QwigcdkeiJnvYu4j2u9MOVoJx14tpPxqNA7KcKJ1dCl6pI6bRfPG3qIbfAlU9Kl
         RP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375980; x=1774980780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imwEJb99lBD32TauVrG1INXQ5z6pQWDRIPso/BjwfkI=;
        b=EAXBHxkJlsJqJxRO3kCdV1eB/AUUbyw94GRknt3B9FeZmGA4+msFNPOVf4Tsdr+hrv
         ZEBY/REhmmMwxvKavOJv0MdPcoLZ+82U0hYuhJ+vsWs5ag1H6istTeUexpad8C6GVN5D
         ShMyKykqBXigq1tVqnmQ4Sg9CqTf2Q2U6cJObWTTeK0p9Nop47FbDWWV35lU3cgbHMu3
         nEprAEC+z65ddTpQCuF0XXMN/Ml96bwAT8rPbiw+pWBASNHmu+Do4R1gPiWs3x7AyjC4
         +ysqYM4nlNL/pxy0wmvHHb0K92s4gQ7AmG1CjXFKCEsrnbS+x0ZXnm1g8I1GKnedvETK
         2D4A==
X-Forwarded-Encrypted: i=1; AJvYcCVXIdkApw4j63W7wmOP+XCfThPtr5GEdTMM3IYB0/BRawfmMopgqgaP+OWkAOVD5WwEwFrWP7BjjSklo7QKYRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoG2ogCrN8JKPTAj5jx/yVjDoxRAPEmpiW8fVXPor0R2lR15uG
	DoNN5oXPYnfWEIDQCQjuZ1W/4kZUCyq7h5yFiNAmGPPSLw+LPDfeVFGkxuvB3GC+TK4rpE6pgMg
	dXUg7iEZ+O/G4kmD+NUG2Ms3TmajVze/2l2IznSNhBZ9SZOO0i4VXc4DQU8SMLiSmsloIog==
X-Gm-Gg: ATEYQzzJna8D1oCmPOhY7gB3XZWNBGJp+GiUZnDGSjC9cvAXK4uUQuZVttDFqRuxC3x
	DGtB8iCnZsKK5KbJ45vm9u1bJyEfRvUlWW3p3KrM4aCxS4gHrCbSKcpT8mWeOpsEAVkiKOE1j5V
	RilLAjZKelMKtJ/kzZj1WkIDx5HfG7kYtPDTCOOrAqSLvYb9pW0YBDPjUYClh79pP+bDrDuc3ec
	EjaV2RzP2M8aLYPQS5Je6YZFja9+m7T+t/ah2V21UJPK6rpkTN3cVQL8ujIK2S+KTbaNrNx28Mb
	ipeGYjpbvD1F9XvdIoTQaigSfNIlH7u1Vivja6L4cG7Laanc3MEsnuscBErbey/ujPFyAnatYVT
	rE5xFb2auvE36kszBvjuv5KfwPJYZrrU0mgtC+zBRnZDoIMJSt37IVP+YcGb6/w==
X-Received: by 2002:a05:6a00:3497:b0:81f:c6d1:5608 with SMTP id d2e1a72fcca58-82c6d846a06mr610591b3a.1.1774375980200;
        Tue, 24 Mar 2026 11:13:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:3497:b0:81f:c6d1:5608 with SMTP id d2e1a72fcca58-82c6d846a06mr610560b3a.1.1774375979655;
        Tue, 24 Mar 2026 11:12:59 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm16654229b3a.57.2026.03.24.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:12:59 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC v2 4/5] tpm: Increase TPM_BUFSIZE to 8kB for chunking support
Date: Tue, 24 Mar 2026 23:42:43 +0530
Message-ID: <20260324181244.17741-5-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324181244.17741-1-armenon@redhat.com>
References: <20260324181244.17741-1-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of the command is checked against TPM_BUFSIZE early on before
even sending it to the backend. We therefore need to increase the
TPM_BUFSIZE to allow support for larger commands.

For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
also order-1 safe.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 87d68ddf270a7..26c3765fbd732 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -33,7 +33,7 @@
 #endif
 
 #define TPM_MINOR		224	/* officially assigned */
-#define TPM_BUFSIZE		4096
+#define TPM_BUFSIZE		8192
 #define TPM_NUM_DEVICES		65536
 #define TPM_RETRY		50
 
-- 
2.53.0

