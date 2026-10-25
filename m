Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959566;
	b=Z5ZIh56XXrkuVmTsemKs/x9Ib8hElQC+rsSkPsliwQZLLLxYGy+I12e/GTfH7LgtCEm3
	 bi6hif8hkPswwGoewyeIHm3sqUK9sKOiGwArf0nCotmHnbKXavdhtqJFNkmd/8RE3FSzF
	 pHQQ8zcVoZLAM0QMCdMCPThODXzzK+yBY5msaN5uB5VUmBGrdyep7g9it+biUp1gh/Occ
	 puu1CEqORorgUq2uoGQWwlv33eVF7fAdTL3c6G4jQ+n0CcijisR/I5WXJLDBugDwdrQHA
	 0l9C0H0O37pX2vmBQkIc/fqUjM87AbGAyuf4gddZp4aioXB/ugvHp4USENug8fKM6Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959566;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nFsn6GsCb++hqUei+F0uCFTH8XCAX6AMJvfUo6GyI4c=;
	b=kHPNy6iBXwnstK+nbAUe1D1O5QQL2UPWAfb5cJFr9BGZbMB/rQujVvP6IkEq62yFzSo3
	 2xWGKlKMcjnp0okp7Cmghofp4eAo1Li9+kWWzgVnp2Tlyhma3+VrKV9jPNa0okDYnaug3
	 Kvb2smSJROOMvgL595eIwpDNcej+oN4ADwQJYfe63Lvd25S5olYDcm/+RCOkPjOeHmL5T
	 XNK1TqcjyAC+ckaXBzLQfz/gtTPdknr5TBl5Ky2LL9zR37O+mHyCrPP3p0JXqclEcQuOk
	 yebehnXBSe0+knlgdT4J3dEkDdtQUmWUzRyfD7FjjafZfek8OW8pyMCvSdBahYVSL9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqfDgpp2;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=WnZ44Icm;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C8606A320
	for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 20:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 640C8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqfDgpp2;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=WnZ44Icm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792959565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFsn6GsCb++hqUei+F0uCFTH8XCAX6AMJvfUo6GyI4c=;
	b=OqfDgpp2ufJijIjNkZuggFE7j66lD85wxWAzwzrlEr7H1p3iLTeoxaMq8xwtUtxO7YEzKi
	I8YTCAMkFvojQ99ylDdCsr/DYzeLofo6aUr9Zoq2f/5JhF3jvlTZEiXVAdE1WNS6Y617s1
	JLrHsRsnvOzJcBiFh5KOCUCYARQE73k=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-Ba-26MpGMHu3i0z953pzkA-1; Sun, 25 Oct 2026 16:19:23 -0400
X-MC-Unique: Ba-26MpGMHu3i0z953pzkA-1
X-Mimecast-MFC-AGG-ID: Ba-26MpGMHu3i0z953pzkA_1792959563
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso3981943eec.1
        for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792959563; x=1793564363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nFsn6GsCb++hqUei+F0uCFTH8XCAX6AMJvfUo6GyI4c=;
        b=WnZ44IcmFLif2+4b4RdQrUUKu26CZP/9KT9C34IJzlKs/EceaY1OUZFhc1AnexWG+S
         UzKsTvPj6VgHkWJUdPrZ8A6I7apNPN0UTBdRX3WLVVCe7aCaBOJYVIdguNv+X5Ea3t8v
         thq8vb7Po3nNtBbVDU7h6YQdrVbGBuFjCw/cJK2MK9XAKN4Bxy6UTDguT8knIqnrczUL
         KHRDeenDMVZ+pEmPMdS08j6J+Wy6n5mJorf4q0X+spIDQ4pXPmtQEogWw8XZeU+fdGm0
         nEYIDRDt6IMUFmjbDbhn4NsZ0zQUSLXUtCEcqCAO6YdPjLptzVq1nuuKbuRQJCr5a7Fn
         UHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959563; x=1793564363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nFsn6GsCb++hqUei+F0uCFTH8XCAX6AMJvfUo6GyI4c=;
        b=AXCY/v1Y5n6rIHnCnxBTKfEw4DfsGSx15eq5byt7yhEAgwA5nLQMQYnRcYIsNvLBwA
         xOYV18K9dV7UpVFcuvXVu+bcx9zexkT1D/o7kGyvhLWhZ9wm5qM2fc9SVpy/31T/wzYA
         S6QtrTobpCaBoysz+TradhNGptgl0pJGGXukb/IqV6H5QAagdYdsPjsA/dijl52BqpnB
         MxWmToQ2yQLSvRtsFlurbmFIC/fB7y5IMkAdZpmKyO5DefD6ELsasScYQGSK5CKFL1Jc
         y0UVgbxNoYOfPEjomwC/w0uEht5PNQ4aUA0mj14b2lPl2i9Lkr8VMwjAWpg5uXcExHnk
         fDZA==
X-Forwarded-Encrypted: i=1; AKwUvBx/yF37FRlCQgUdy5AIglViQtAZrCkupwTmYzSoRAVIu/SI+uqQDshVpuxy1brJohXw8nvSaWVSSEvCc2njW2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0fC4mG7Nm5itGWBuJ9NIf8G8+mR6Qmk5Hx/ZwLB3d1Or7FfIM
	1aykmYiJO5xRSfD+efIY5Nrz9ox3PPNOoquD03Oy1G4NbqGtceeGkXYFN2uLQk84vdIi+zyNf+n
	2JWmADEK6W2r4dlCP/nCXC2/n3aEQvMzFtvGuRG2PPawDRRgQBRR3a2Bd59iD/19fNtRHAA==
X-Gm-Gg: AYBFou2e1gB0fGe1HXPM1UDrBdpZv25/3QuhyhAq9bmvWCPWcan2D41U01Dt56TQi9Q
	0Fqz4qbm0WtJ77nq3y3H676cIKw9y/D/hATOkfq4nVdC3g5vNzf2F+vwi9miXNeJmvGJeaLGe8E
	HBjwGTdNhTd2AqBulAG61HXVD6qTsRuw5QzHGzaYL34gTYc24efNfflGF9vW/IOU9i67+Ig+BaL
	xr5U2QR2hhb08FJIEYUdJvUF1kAd7yZEicXPsA0rqaNNYpZw9HbmNkP2X1vd/fYJJcUOlzXMHwV
	Xpgi9N19TwBlPlWepPFr42o06mx4T7uThS1eh2GGw2Owfcp9jG7vsI7M7nhRIdGhEfyTohAt5nA
	H9hqS6xhzg8bvOvHThTh2mFRXKsDugtL7v+AdI+Wu
X-Received: by 2002:a05:701a:ca0d:b0:144:eb46:be0 with SMTP id a92af1059eb24-19934a952bbmr8319085c88.13.1792959562374;
        Sun, 25 Oct 2026 13:19:22 -0700 (PDT)
X-Received: by 2002:a05:701a:ca0d:b0:144:eb46:be0 with SMTP id a92af1059eb24-19934a952bbmr8319058c88.13.1792959561796;
        Sun, 25 Oct 2026 13:19:21 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm17656169c88.3.2026.10.25.13.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:19:21 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 5/6] tpm: Increase TPM_BUFSIZE to 8kB for chunking support
Date: Mon, 26 Oct 2026 01:48:57 +0530
Message-ID: <20261025201859.221991-6-armenon@redhat.com>
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

The size of the command is checked against TPM_BUFSIZE early on before
even sending it to the backend. We therefore need to increase the
TPM_BUFSIZE to allow support for larger commands.

For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
also order-1 safe.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/linux/tpm_command.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index fc446a1282e2..4ad11068b090 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -434,7 +434,7 @@ struct tpm2_context {
  */
 
 #define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
-#define TPM_BUFSIZE		4096
+#define TPM_BUFSIZE		8192
 
 /*
  * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
-- 
2.54.0

