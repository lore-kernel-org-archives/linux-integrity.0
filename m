Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794161267;
	b=GQCjVkJNnFfVcTeHE+YTsfCZ04b5T9sAC1Ubt3Q9KK1YVb8XkKRJIFUBj1FZdZpB1BL7
	 nzMOVOT0BrYTRKcOe0et7oj41rgHdOeAmXd3MMyJaRdvcrXkFde3ghikKLwyfCTdo7Ib0
	 WJYF38L4k7d+gZWTVbyDJ8pKu2jo+3L1Q2fczPfgxpUEgj6+e4V4WUITL1wl4eHARMPn6
	 4cQZYLVkYpGjWV8b9uz7D/xm8Wm3JFW7XsyZY6ukDXASxJBWLCdzgzgZn83DK/AXLdrug
	 ZI8PcKnxz/oujBlH7oM7jtTs7+e/OGTNO2DdMNk632T1aPWMH6lGeDMq4iR9u6TJz4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794161267;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ggiYpXk3Lzwp+xYqAP9DpjCuhXF5AKHntpj9iUKybaU=;
	b=M2KhkVEyW9VwGjyuPiLVUYMxb0n3YdGWiOYAcHE2pUBjgyBEcgKNSth0XoQJe8os10tY
	 i3i5misxHThoyctq8r5c/KRm9MLSIriKyJTk+R22NJFudCGjHsPgJmjhkK6QeSo7cIpSO
	 grYNJ3+UQZezu399Agsx/PUKK8gozYrcfia9lbuMEXfpQRPuwr+LS/RzqHAej8miYALfI
	 srVpQZ/ncApEYSLIvV3zZkyVdgc2Xd5834//XYngAvgtuvgFaUWolQ6sJ9nqv9QjOEGaQ
	 SMJzfVe/nkRO3EQ/ft7lqXiK0w+YU9UMB1bD89E4OjE7rbrJDdaJI8MkeC2IHnt/eBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkRQ7Nmf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB2D606A31C;
	Sun,  8 Nov 2026 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkRQ7Nmf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794161266;
	b=lPjf2cz42622sgtgyN97UJ+b2o3dOq9JPykqnQ+k04SvTjzG4o2YFvjwbFLAGyaFpxEQ
	 0wycoa+xqB8Qp4gdq6h3ilIPs0B1+jrxOFACjNIKqKgwz4VAC7kbDcDzxXxQuMgX++FMw
	 AFDkiGsZoBj+hLSBBmW/lle+nvGuqGiY/T2hR0lsgiwp0a8kdN/iNsJ3H+/nUVH2F4bXq
	 bIPQ96wi77QNbPr4z8PAhXpMElocJoewkqlkiZyZS8K/zSV/t07kgtwzg1L4qAaGm5nns
	 3JNGpjL5JeWSSrqj+P4ntwwojA/YwWQQW9Q8jntLJ/0b42teK1xlRJeMdzdLwNm0Avg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794161266;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ggiYpXk3Lzwp+xYqAP9DpjCuhXF5AKHntpj9iUKybaU=;
	b=HnZf+mqKfv2N/DfqDsZGaoyigkV2S42jLcLZWhOvGRPzIv7ohtQQ6G/8KJwQtu3TbVhu
	 yaRGfS2Qizf7xwx88EGZ1sDKM5rqsO5fHPFm66JQm8XcW6boueaqlH+5B+UjZWlEm4GK0
	 YxNjryu9Tm0t9pyaIGX7rdkiQKobEFXa8Zrmsvsr0Ai76pLRjxx82RrB9F0RGZU0sfVej
	 Ul7c4j44IDBMIFSRIhsUlI3e3daxYESaBcg/c6WgglJfl5KFFoAusfsXjNkR5a1sGMAVm
	 ZwyCxTitxuHhYKs4JXuumAXed3crKNazOQbT2fTAFFBGqF8BzIu1UzR4MS3LutMLcdw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2A6721F0089F;
	Sun,  8 Nov 2026 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794161266;
	bh=ggiYpXk3Lzwp+xYqAP9DpjCuhXF5AKHntpj9iUKybaU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=CkRQ7NmfmG8gHq8MQU5i8MmWirDhVEmdDghzXrUy0689QlnvCh5Z/AKJTvAW0R9i0
	 m/EtdlJxjM7kE020vFCZUqw5MuLLJL1TXQzfmLbDIsRt7ZFTkCeibWxUBfT6Y8DfU8
	 spiVaO0iynOf3O5zZmU7f+QDEDaqPwa0pK4T7b0jsC6rigR9vszLt9jju76HEGKI3i
	 yxvHYmBZ9pgPECO9ET7QoX3V40WN9KHLtRaxm8LmaMG69pTmlRM+ZzWSxuc8bvODDQ
	 PNlB5JJg4YKRDUrzc0DHjlTMn+kgVmwM/bFn3a2Dpn4gw0j8qGRtvv+5sQi9QFUtWS
	 T5kiAhdiXJwJQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AFF4748011;
	Sun,  8 Nov 2026 18:07:45 +0000 (UTC)
From: Alban Munari via B4 Relay <devnull+alban.kernel.gmail.com@kernel.org>
Date: Sun, 08 Nov 2026 18:05:39 +0000
Subject: [PATCH] tpm: Fix the value of TPM2_SE_TRIAL
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-tpm-se-trial-v1-1-492218f9de41@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwML3ZKCXN3iVN2SoszEHF1TC4Ok1DTLJJM0Q3MloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loA2450enAAAAA=
X-Change-ID: 20261108-tpm-se-trial-580bef9b4f17
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Ard Biesheuvel <ardb@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alban Munari <alban.kernel@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794161265; l=1447;
 i=alban.kernel@gmail.com; s=hephaestus; h=from:subject:message-id;
 bh=oXjBD4XWIC/ZjW4m/+tswgFBCuflIPHtvzC/8fbK08o=;
 b=rnhjKXXFmP/oNAF4G5smGF3owTZwVYlv7Fam4wDkci8AXwYUuHEwnNgwdB2Qzu9kQsIdWedUA
 j6B8RlB09pACHIdSJWu10IRT+c6fJ1mVZYTKQnJAydA6WGepGio0RLJ
X-Developer-Key: i=alban.kernel@gmail.com; a=ed25519;
 pk=E4gTLxHRk8yuKicoDcjhUfRHnlctgbnlV9dmOwM5338=
X-Endpoint-Received: by B4 Relay for alban.kernel@gmail.com/hephaestus with
 auth_id=1455
X-Original-From: Alban Munari <alban.kernel@gmail.com>
Reply-To: alban.kernel@gmail.com
Content-Transfer-Encoding: 7bit

From: Alban Munari <alban.kernel@gmail.com>

The TPM 2.0 Library specification, Part 2: Structures, defines the
session types (TPM_SE) as TPM_SE_HMAC = 0x00, TPM_SE_POLICY = 0x01 and
TPM_SE_TRIAL = 0x03. TPM2_SE_TRIAL is defined as 0x02, which is not a
session type: TPM2_StartAuthSession with it fails with TPM_RC_VALUE on
the sessionType parameter, as swtpm 0.11.0 shows.

No code in the kernel uses TPM2_SE_TRIAL, so nothing changes at run
time. The TPM 2.0 selftests already define it as 0x03 in
tools/testing/selftests/tpm2/tpm2.py.

This change was found and written with an AI coding assistant (Claude
Opus 5.5, Anthropic), while building trial sessions on an AMD fTPM with
the value 0x03.

Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
Signed-off-by: Alban Munari <alban.kernel@gmail.com>
---
 include/linux/tpm_command.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index fc446a1282e2..076ee8ce816c 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -171,7 +171,7 @@ struct tpm1_get_random_out {
 enum tpm2_session_types {
 	TPM2_SE_HMAC	= 0x00,
 	TPM2_SE_POLICY	= 0x01,
-	TPM2_SE_TRIAL	= 0x02,
+	TPM2_SE_TRIAL	= 0x03,
 };
 
 enum tpm2_timeouts {

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261108-tpm-se-trial-580bef9b4f17

Best regards,
--  
Alban Munari <alban.kernel@gmail.com>


