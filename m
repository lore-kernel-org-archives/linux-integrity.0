Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297761;
	b=hc4J5bp7jYnb2DT0q09Ay+GjVtsIE1crpjygHXrAqIPIIdZt+rEIqwSPZp/AqByUNFmJ
	 KV5FgR2yO53Yw+KrqxwyJhHDwLRdg0KS9jaJTAJyy9RJyQWisi5FNAs3syAMGySEBKt+m
	 T+v2MiQkFY2rOie/Y9Xz8Dq5veIfYKb5uRKHGEw5yC3hFKEX9eWrnfm425kpUbW6dNEfE
	 AmGmt0hvrQIAOyUGCXSCgDiiOGng861xR+YzKyQcT20qE+nXyPU5GgJnolC9OPJruwG22
	 NA99A5NhJ9IxtAIzvRZkbkKLdnUTGoUMjBoX59iFkWk16DpJgEUSNcxv9aK15KnQQGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297761;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UtHIiSkqX2bxSTjandVXhxVopv7WL1ebZlXZPqH7xYU=;
	b=Qz3feOtFa41BJL6maS66D84ElW3hTAY8Dy4uJIFfnHS7ZrZMc6a5H5el6VkXVNPWz/52
	 QwHWE6/fHmzWFJdJevzGhvt/y6bEmBWCENvPig41WlZJyGdV+CuIMjdxf1KYwnCWS3MSd
	 i7KAA15n39RU5dafnBjDSSAZVAxnwHDgZQxzq57kurPystFpljP1hwKtyzOxS956G1FSE
	 gHgPz8xFFu6UZexJuj211Bj5ZXMq8yed17Ime8bbIbqYNdBL0ZgqPIWQo6deB+RWRWqVG
	 YEpHRU7ZYbcJoY22hAmnlr6sZ8cuYCb2KSZxikl3bGw4rRFFZ44fg/Fqtu7WaPceEfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QdDNNQC3;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZQdqC4u6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A27606A31D
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 18:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A27606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QdDNNQC3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZQdqC4u6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793297759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtHIiSkqX2bxSTjandVXhxVopv7WL1ebZlXZPqH7xYU=;
	b=QdDNNQC32+Tv/cgxcy7uJBD3pFk3q3hn8O8+bpfxg+LhF/aIt+s5kwKZSWcN+vUPurpeFZ
	LmhLkLzXjdLMYQpicVefJP6RmFy5DT/uktOL1s2KmmIBfFkyTs7APTGbJCU7/1o4NLQd3I
	61fGAhK1Fk+fqcBSzGkTgR6LdbytZ4Y=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-y6INHjR_PGKFCzYiGuSUcg-1; Thu, 29 Oct 2026 14:15:56 -0400
X-MC-Unique: y6INHjR_PGKFCzYiGuSUcg-1
X-Mimecast-MFC-AGG-ID: y6INHjR_PGKFCzYiGuSUcg_1793297755
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-359b81ad4e8so3116969eec.0
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793297755; x=1793902555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UtHIiSkqX2bxSTjandVXhxVopv7WL1ebZlXZPqH7xYU=;
        b=ZQdqC4u66b8CtI3GKrk6PVPDK2rL6BB1LCqVoiPmxEvEqTXlNYbfwsVyz767qKVbML
         m/8PxY8x0uTR/JF8AsgpLWlUviGCQ8m4iWj9uuUJJlrM376hOAqxFRtwB7nEo1ANNNB2
         KFAlyd50GZjYw3uSjutjuRAqkPdcE8khsL8hJ08Vo5vKReK4Upa4mV3ugpSK1/DwxEdM
         g+nxOD7EPfP4nTsh/BBicknM8LLMT8M1D0RQ7c55uxhNu7B0jOmCdSH+8VnvxSIRsXf1
         sZnSmg0DbkQq3w6QRUHRuRAq8tjrjBHSHuQ0Hu+p0jevVNydhVPcTDkhqttWnixFaxp9
         pseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297755; x=1793902555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UtHIiSkqX2bxSTjandVXhxVopv7WL1ebZlXZPqH7xYU=;
        b=KYgQL/oO24RAMXxl4BJtacvn91++l+fqU55uttF3bWCuijf8cnB4FssIZHTtGHTlG1
         MKx4+MDt//gcYT+9GAGnf34UMH3htPKgXhFiKB6FQWBlIY/KxYwgWtDQRIJd8wNi/j0A
         bbORo4wxeeVoBOI5pfN1J6Y7oJ7Pt0HOBm3bWaTYqZz/CJnRe2m2Rranl6LsVXlHA6mf
         /jkHx4+iIWxKXbR8X6vKp+xWOmMWTsBW11GdCdhtT+HAkNR8L+yIgs30+hxBuIJoAVAY
         F17c4XZTI4Y5xExw0WpPVvG97nIgazKRE2WfZi4zb1n0zJtzaqBldkO88NJdYLF6cVE6
         8iiw==
X-Forwarded-Encrypted: i=1; AKwUvByy/Yp3j41lJhJBaTxeFTG+40iCr8+YI1i968KGitjEq90+XGt+QjGBJJJn+iTqGkvVs3lHPQxmcNw/OLCt41c=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7AscycU9so/EnWD47s1Tu2U9nf51BHm1ynac+PbC8G8r9sr6s
	ze5OYKomrepahyKyjrZZsjwdzQjt/pIbVErZkBYy2QKQlFhwG864WPZ9GKL0Qdsyq9IO1DXF/1N
	IqDqCYD+YriwF0S2AIODHm8m9wzH7wJeKMouVrxtTtKIbDuA7SrFW9aCGcIycASEDxQ2ILg==
X-Gm-Gg: AYBFou0jzklkesLhVAkxr5gEntAwmzgG8ZzGLOm3delGg6u3KH4V9C/S/NAydARjF4c
	JMUtxO4Ck3CHlHBFZGHEQzIS6OPYnMXSUqs7Gsy9YgZBXF1romEKPXF54abvDbZ4mOvgNR9g59y
	ncHx9biYBQkWKo/YVbjOzhHGShbaL7foDGpvLYEflO02L8LGwFYAhK0vFIiV53Knq/UIoKPq7xB
	k21TbnI7qs1ElH0b/H432zUjuScX8UC0ff8dSsPY7yskKvsXbzm3GBMiJqK8wvZbD5kwNt+OzaF
	Nrlv3Hf2C0zKdVRgWXGFolM7YSMedIgUPZOjxS4qh3trfoH1hdux+SwNX0oonzGU0LhuGlroPBw
	T6C+PTG7CNtJ72V2zTv54d+KNcW3qUBv7fBqEOzAY2rpvayKuFmJdlXFQ35uVXXX/Pc/b56lV9L
	LHBZieodVr75rA0w==
X-Received: by 2002:a05:693c:6211:b0:36a:1cbc:1093 with SMTP id 5a478bee46e88-36a42417707mr205740eec.30.1793297754989;
        Thu, 29 Oct 2026 11:15:54 -0700 (PDT)
X-Received: by 2002:a05:693c:6211:b0:36a:1cbc:1093 with SMTP id 5a478bee46e88-36a42417707mr205705eec.30.1793297754300;
        Thu, 29 Oct 2026 11:15:54 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm259163eec.4.2026.10.29.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:15:51 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 1/7] tpm_crb: Add register definitions of TPM CRB chunking fields
Date: Thu, 29 Oct 2026 23:45:35 +0530
Message-ID: <20261029181541.99505-2-armenon@redhat.com>
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

Post-quantum cryptographic (PQC) algorithms can require buffer sizes that
exceed the physical capacity of the TPM's Command/Response Buffer (CRB).
To support these larger payloads, the TPM 2.0 CRB specification [1]
allows for data chunking when the physical MMIO window is smaller than
the required buffer size.

To support this protocol, the TPM driver must be able to detect the
chunking capability, and signal the backend using specific start
method flags, also known as the control area start register bits.

As per sections 6.4.2.2 and 6.5.3.9 of the specification document [1]
Add 2 new bit flags to the existing enum crb_start and add the
capability bit.
- CRB_INTF_CAP_CRB_CHUNK: A capability bit used to detect if the backend
  supports chunking.
- CRB_START_NEXT_CHUNK: A control bit to signal the TPM to consume the
  current command buffer, or to get the next chunk from the response
  buffer.
- CRB_START_RESP_RETRY: A control bit to signal retransmission of a
  response buffer.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ceb4100ba400..d76f9e30f036 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -57,12 +57,18 @@ enum crb_ctrl_sts {
 
 enum crb_start {
 	CRB_START_INVOKE	= BIT(0),
+	CRB_START_RESP_RETRY = BIT(1),
+	CRB_START_NEXT_CHUNK = BIT(2),
 };
 
 enum crb_cancel {
 	CRB_CANCEL_INVOKE	= BIT(0),
 };
 
+enum crb_intf {
+	CRB_INTF_CAP_CRB_CHUNK = BIT(10),
+};
+
 struct crb_regs_head {
 	u32 loc_state;
 	u32 reserved1;
-- 
2.56.0

