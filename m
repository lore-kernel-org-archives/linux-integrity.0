Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297787;
	b=pejrr+zOkTfEX2spkjjtB5p9De5fTS6SDgmKrOR0CKxSQ8TKg+yoeWiGTwJinCbEHwq+
	 +qFKC6ibnXZ6ZhAxxpdZ2LzBHC4UAtkaBDTkHSjZEQ0yskZcJivl/BG1kcUnS4NESr8Qt
	 StKNC7bg/o6wS7ihx4eY7lSPPG6DVrmRpoYXHkOfy7D00HgYOPURpwxEw6OtX2sEFnCCa
	 iV5/9iAksH9xd4TxJHy3TqdrqP89UlpbceH7/QaT+vlhQbXJZO6tTFKmG2Ov0cOmD392s
	 MuaX5jaBr1eSQYFxpFFReDWKHFlkX7PjnlKUmIy0170tz8GQwgGPidiQ/I5FbVWCp5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297787;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+i6F46/tXcylsBNxFPdwtmDz3b/c8K1JJTOkI+5K2yM=;
	b=ZwkMBFT/LU+x03nPxaGC+VX0EVdxGs+Z07yvmjGlPOgXMNyJLLFBrWRf3ABtdxl6LUQA
	 lRyLsGFVWNsXe9vjpAXsF+bCQnx0CEq8oyndPs+0KMSkjbb6X2dbdsJo5YdHmX8xvL8qT
	 s5QtFW8g3SnPFU6sSVGJ8JiVdOmY6/cnrBHI6LkAgVBQF2mWmNX3MSbHhpZy4yrXs1pu6
	 y3JuKIFYi6KirE6pJFOKMwyOxLj9wkgsghwJ2UM7jI+1ioj2LSF5DPWcy80DV9Zr1tPTG
	 lfdhNnw4lNy7TnCaleQZtUxTG80kOIhuz5izoZuyBwu0ZQpYcojbJUUTzQwtWrsQSiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TixSZE9w;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XHcpRs4v;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC904606A33E
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 18:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC904606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TixSZE9w;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XHcpRs4v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793297785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+i6F46/tXcylsBNxFPdwtmDz3b/c8K1JJTOkI+5K2yM=;
	b=TixSZE9whhYEqHcDYsFX2pBfJDD86ZMFtfLK9kqL6jvx62FB0LYxb5E2eue5OD5uzjiCbo
	XgY20YBdRrLLcP6nCkrFYh0g0E+RclUfbeuraDnv8DA+t+DqpKSibnFD3XiFyfBXMrNNDA
	tjNAc7pISOkQQsWwnpv80i/lNPYUkcg=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-lyVaBMUiMLCTtFyXiHHHKQ-1; Thu, 29 Oct 2026 14:16:17 -0400
X-MC-Unique: lyVaBMUiMLCTtFyXiHHHKQ-1
X-Mimecast-MFC-AGG-ID: lyVaBMUiMLCTtFyXiHHHKQ_1793297776
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3698bd5392cso887433eec.1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793297776; x=1793902576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+i6F46/tXcylsBNxFPdwtmDz3b/c8K1JJTOkI+5K2yM=;
        b=XHcpRs4v9e6IKkcg6yPQuamvVd/wXUkndgLdANzw9E3bm2a6nd6YIhzQLmpTlFh1zP
         rTdXmw9Vkhu4CTiKtv67rrh9VezQGgD1J9KagbhfsrWrDKnERbqlugSObI8I1xIgA/IJ
         0x5Lzk3H4zSheH39PE+eVupp/XmJT6kjey10ln9NKUpA1WQxIhbjyTDRJvBOyMxf4MPK
         AxmwgFF30WVoICjLJBsRNXin9e3+buNAZl/HPVGeYUzxvGfQRxj2go52C+H/bjVVLxFf
         0hsher/8gzcxCuzdTUFlxg4c4tD7W7OWRa8ehXGl8ddAIEki7frvTmiaFQZLorBImmDs
         hS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297776; x=1793902576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+i6F46/tXcylsBNxFPdwtmDz3b/c8K1JJTOkI+5K2yM=;
        b=KmKgW76Md66NZs3AsYaQ+rJ1Wx8Cm/QQKZHKSiDSY8z0vOut44pR3g2aMY+9uPV4oI
         o6SsnnfzdPCzRss8aatD8H5KqFODR94wzCu4Nc9l1PFDLHCmyzi9io/bKZLzGMIkNktA
         DrhzRcsBvSwDEcyB1s5Ek/4so8WyYSznJK17ARVgEzFvKez9YVXUHaWFsTRg7mGeoe7d
         c2fhTUf2vcZfUpsAIdgm4djKMuMX7+8XT1kY1+zRNGJoRpOsTEhxhu37PUfQgRsVTqRi
         pDKIKek23buzMJwhgdEiQCNRyWizm8oh7HsGypaOnP909e3irBwF9w8hJj8VChkNWJMc
         pBTQ==
X-Forwarded-Encrypted: i=1; AKwUvBykzNL+RK+vk3CUnWVonj6v6zEZUbTkcKZWLYr5UIRJWU9vxdbLtt0lgjScBWDi1RJH1ZGThWYWSSoSF/5lzQk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSbniJ1GkDo9vIlLkPJbMEtE10XoU1axMwSG7AL8/c/RnjrZhc
	GPWUo4denpeieDs928eQnHPz73GBCLuwh5JMhdWBnq3OvE8o3xRofSiAFQJQsPQSQ2Y6BInPIB1
	4bYyth1V/zuXNpkdgrUOeegTuGETvIN/Im9lwqEQXI+Q4WS0gav1EQHYmm2tvKZqI5MMmtg==
X-Gm-Gg: AYBFou1llhGqybC0HNAcqO9CAhaawZ2jmZdmCRXd01MzieZHokKcwnqvj7dTbt1NEad
	19HTg5CiNMd6Bv3FVYkAHD9MJfEp/6VE9ZO0vbgK19EjLVIdTSMPg8amqrmLxMgLWXlT4xJkxvh
	ImUSHcLxyy+ToAs+mevW8hJfXl6vEbBrArM1o1yg7nQzEbE2CIULCQcnGapHsiTRxHRixJQx0S7
	3UkRC3aofTiIdGgFubALMqW4PBDyiPYRr4CIredtrOZs1QDEHyb/9Hz/Lh35O3pV/DsZJ4+sAqx
	5iVGgIPPVjOcQ38maOhXOI/X3KII361Iwjd8WAsuxeiSfKExLJh3sESV3KiDe7iEOIUPBfeSAHs
	gyXwUsxPZ6GhimON3c7+3RD2LJHwPntgwY4ro2iHlkkZikpHgSPKECBPjpEomF9/9hXtO4voQMJ
	NGTqW7TcOkUnBpZA==
X-Received: by 2002:a05:7301:301c:b0:367:a092:3c73 with SMTP id 5a478bee46e88-36a3002ed72mr4310886eec.12.1793297775974;
        Thu, 29 Oct 2026 11:16:15 -0700 (PDT)
X-Received: by 2002:a05:7301:301c:b0:367:a092:3c73 with SMTP id 5a478bee46e88-36a3002ed72mr4310858eec.12.1793297775404;
        Thu, 29 Oct 2026 11:16:15 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm259163eec.4.2026.10.29.11.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:16:14 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 5/7] tpm: Increase TPM_BUFSIZE to 8KB for chunking support
Date: Thu, 29 Oct 2026 23:45:39 +0530
Message-ID: <20261029181541.99505-6-armenon@redhat.com>
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

TPM_BUFSIZE limits the TPM2 command the kernel builds before handing
it to a chip driver's send() callback. TPM 2.0 Library Part 3:
Commands v185 adds ML-DSA key objects and the ML-KEM
TPM2_Encapsulate()/TPM2_Decapsulate() commands (sections 14.10,
14.11) [1]. NIST FIPS 204, Table 2, gives the largest ML-DSA
parameter set, ML-DSA-87, a 4896-byte private key and a 2592-byte
public key [2].
Loading such a key pair with TPM2_Load, plus header, handle and session,
comes to roughly 7.7KB - more than the current 4096-byte TPM_BUFSIZE.

Raise TPM_BUFSIZE to 8192 bytes. It covers this command with
headroom, and keeps every kzalloc(TPM_BUFSIZE, ...) call in the TPM
stack at an order-1 page allocation rather than a higher order.

This matches the largest parameter set defined today. NIST has already
published PQC families with larger keys and signatures than ML-DSA
(e.g. FIPS 205/SLH-DSA), so a future algorithm could exceed 8192 bytes.
CRB chunking, added later in this series, does not change that; it only
lets an already-built command cross a smaller MMIO window in pieces,
it does not change how large a command the generic stack can build.

[1] https://medias.cdn.trustedcomputinggroup.org/production/Trusted_Platform_Module_2_0_Library_Part_3_Commands_Version_185_pub_87a5c10230.pdf
[2] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.204.pdf

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
2.56.0

