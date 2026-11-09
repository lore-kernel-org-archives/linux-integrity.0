Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202770;
	b=DdD2Ko5eCeFAr/j3Z4fmfwofX9sDOa24kF7xL5qdiAVn8uQ/g2lxigCbwMQ5DV2Ejsg9
	 6LY5yzhI41rDvD3NMXTr/nmTTFI3DJd0PCSlG64WAQ0fUiZtc87I0N9tosexMjI166aP3
	 jHmUIFeFdRRFTOZp1Ln3gWe/M6T+8VdHv3woMjt56nkuIg5/U/JWyYRf5ioX9OU5+q6AK
	 fr1m7xae2/Zj9a89JwPqWL/y9YlAeRhq76N1JIESWLJi2lkQD05Xx0VyFba9+RhvEDfxg
	 L7O4xa11l+pBl6MH5Axf9E4pWHCEn8tNU0wMcCgG9Ya2x74c0LPYegZ89EidxgbtU7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-Mailer;
	bh=4uU3D93eNb0dcAsvNYKSr00RkTcidb/i2o2hNB/WLWc=;
	b=SMEqm6fa0Fkhzvw68uDiuLfIT6cdROhDpa3hyBlGRPqkKj2vzd51nfrQVB44MaCcLAIo
	 k2NRUVROJGGZ4GxsKaVUCr+h4of4ZFqmPEct2AqTr576OEqaKmqSmgX/H5+0uCvaONKIL
	 X0Lh8a1x1EeEWRU5AArjZPDwPVyYoNhcJO0MWa9yUc37lz0rNXnEy8aBgCqhSnrCercEG
	 sG7ZuVtkshuuk/GER58+h1cGe5xuGi9S+TEKyo8EpURa3CUVVpFUw8DKh/9lngEXcnSpf
	 BAhJf+24tdMCg7QeY3uXhrZp3G9OwzOL1qaYPYa5CveuPGPqIi7didbIsqMBhiif36Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m/c396Cw";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E6606A333
	for <linux-integrity@vger.kernel.org>; Mon,  9 Nov 2026 05:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 889E6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m/c396Cw
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso273045f8f.1
        for <linux-integrity@vger.kernel.org>; Sun, 08 Nov 2026 21:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794202769; x=1794807569; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uU3D93eNb0dcAsvNYKSr00RkTcidb/i2o2hNB/WLWc=;
        b=m/c396CwshKMa2EHH+DQktTUWKdT+G4FYhJZRO1ZyIRIhcH4JLYWrzEMYp+ItdlBIA
         TfrpaAz5zE0hxf52AhEiwplZI2VXfKYLCOe+FYHpU03rM56D8UVCIbC4EkcKucUXujME
         UqLm9dyYq2Pd28HnP+Gy67SC8ArUdRCZcomkUowXHVNoiFIICmBTIVdlsiscdGA64vyO
         RBLD8ILK91ZHqy91P5VTxFDBpvH+IqxaQ1CA0lQRBHmprYuUvpkUhVStr1VvYNw7G1dZ
         nYRFBFec5K4S/6FdpKhkVPUYrgzt6s8D/Fsckxa/yVxaOe5ssdJEt9lk6iqQknhDSoKJ
         IOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202769; x=1794807569;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4uU3D93eNb0dcAsvNYKSr00RkTcidb/i2o2hNB/WLWc=;
        b=mIskQGW1j7WQ7BiespYAV/HgSsg0fSVv9c5884JU3K++BbIn3pBEvwldS/VKBgoXty
         SmEjZb7BCEGe08qLdyb1rjTXtNTzkHPbcwuQXpXowlaiKfbmmpY+5Fh731RvGa0SdsEq
         Gqtj1ws9alEhgEgA+yIgACOAPuSaAwRzlFOhzPDuiqLqto4x6XoLYqgzVfkxv1AOh1Hz
         tTcrx3esKxU4pVxa0+RVWTJPLfWSZNLwKAAhtLZq773uirNbQPjDAHKUQBub5puajyxZ
         Pcb6W0GHldU7BA6WH5MrSY01LmHwICrL1qkfq6xWhulaL7VeMPM/2gkadLZks+IRdPjb
         rL4w==
X-Forwarded-Encrypted: i=1; AL+hErFWqWV8iiWVLdK7fqXTokuLShsbAjogsSU/CsWk7TiwgGGU1uphyNp9kylUzm1jOao3uIn+N1BqXcdGHizmsy4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EtreHafWmzKo3VP+WVNkdHaIWJRKLubLpz2ej+eAfMeIk936a
	VyNcF977xEvj0PwGJ7GS0Ocz4fS16hMKl9s85zRjfofgftZ7KXmfwDsiNuiMwILlViGYdUVb
X-Gm-Gg: AYBFou14SZqdE94dXm1SlVEiQ8/9VAAbdmshahzQ9kHDMoCrXjV9pCvqbJSvZcVNqy/
	mDLLc4n/WG2E5N22Xi4TQLAEsUp3gj/EI2RjEBSB3ZrncZKk04wymVQMm+OMhYfmE9nw5KDEn+e
	DNFJvm7TQ+27ZYz0HrMKSAop07VKjWYHoYXkwYpkXasK7VbSrICfOs5Ri2KCUCMycdJyx0DUwu9
	LDuBxorV/AnBjwhdYDktFPIRYy4v9BIVrZLSYljVt586lQSkUk3fbxJwZc7Zq8XJJbJvwXm3l5a
	QL0m8bqqDJ3xFON+SGwPniGtgrsP4eYpjL5/eNhhiawU7u9BKfK3aOBeMuB8wDJ/3SPiZm3ARVB
	h+Ahl/AKq8m8M6jUcIunmZW2ux22d2VuW3qAPfI7/0GZF2pKNjBTttqO/Xfosh9fJ23lXx5m4jr
	HJvTVN2BZP/5ZjtViqwHpFo2bn0f635Msp9XqSqYUWoSTgt/dClBDAfo99abIwRAHwciird1Nr4
	EJIS8BRxvjoqHjLhLxsi2iwb4A4wbENynjqtuZv+aUnUcKKwCDiqMf1vTGvBMIXI0n6nGDlq8G/
	fUzpkAOuTZTghgY6XpvGqSwfpP1ol8+phYEb4rFCmDRa1xuCd9kwBj3VsSDoq44YrV/tpzGlVVj
	wsBanwpLDpz7hjHZkujbSySVeldD/aTNjy49zeU1Amm25vRC1Kwl0LQq8Ec9Uk/tx0Q==
X-Received: by 2002:a05:6000:250a:b0:48e:d40:a87c with SMTP id ffacd0b85a97d-49423997d63mr12864728f8f.16.1794202768807;
        Sun, 08 Nov 2026 21:39:28 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4967a70a35dsm4750189f8f.9.2026.11.08.21.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:39:27 -0800 (PST)
Date: Mon, 9 Nov 2026 08:39:24 +0300
From: Dan Carpenter <error27@gmail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <avFcjHwnh9mrOEnz@stanley.mountain>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In C23, "bool" is a keyword so rename this array from bool[] to boolean[]
to avoid a conflict.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 30188a0ec676..2d6cc53539c8 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -59,13 +59,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			       asn1_oid_len(tpm2key_oid));
 
 	if (private->blobauth_len == 0) {
-		unsigned char bool[3], *w = bool;
+		unsigned char boolean[3], *w = boolean;
 		/* tag 0 is emptyAuth */
-		w = asn1_encode_boolean(w, w + sizeof(bool), true);
+		w = asn1_encode_boolean(w, w + sizeof(boolean), true);
 		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
 			return PTR_ERR(w);
 
-		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
+		work = asn1_encode_tag(work, end_work, 0, boolean, w - boolean);
 	}
 
 	/*
-- 
2.53.0

