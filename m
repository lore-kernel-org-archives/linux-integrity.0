Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390838;
	b=OVYVSPHzo8ql+ZM4sGCUvSAcPEdnLKdv8fQH5cMz6W7CQku654eqy7mlKsvesWAXWpBc
	 w0F7eyUPKdLGgF+4YsF3d4zt69mcRnKV5WPBz7ApXpkQYB2ur/CILjFNz+HwzS2eYu8Sg
	 LxGJGy0Li0rG1/cqc+s6vvwSu9pQko0dgp+oDxPiUSDk+Pwm8VvBBDHRdDuqoXZqp0jxr
	 C83gBLxt+Hn8gddzVpzJhLI+8jGF0BhW0IZDx5gQrVTZesPSbYRCBtb3IOrAY07v9+2oL
	 sWyihDzjQ0TuxUk8zMMAwKLIlQ/e69ufHFutTJik2zA0eK5nYwjG63qacH+i2af9/5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390838;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KmJVN+NKveF6HgY1Y/eSpfSbY+XEPQzQszmXYvUfvC4=;
	b=YJrDN5cFwxjofnr7fuzyMdgLUPBUCFYHXj7lM3mWHjpe3uqmhPa1ODOXYsejjTkxB0Ez
	 GuzsObIZBONfeUwjMHlLY4khqX1e+/xGNTogxIhqY5vw9I+DRyUhPf3q5/+elEy035lQc
	 WiXQE7RqH0nOYyB8XhCb35FLVt/d9TebQRq2h7YAP6HjM0iCk2zJvx3qsgxLRS1FDE63m
	 KfW5g5ktUlSuKwi5s/WkH+ooj3S8KVvAEaXQQ1xs0MrX4yslV/TcJoof3/om2gXVBn+El
	 7zH7BCuzIfPQ2JGuHgoNvktiK+qNujITe7dILYs1gjFO0INoTk+ahc28Y4D/nAtnqHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="JNfA/ShB";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jzkq7PHf;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9B606A323
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 20:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16D9B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JNfA/ShB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jzkq7PHf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793390837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmJVN+NKveF6HgY1Y/eSpfSbY+XEPQzQszmXYvUfvC4=;
	b=JNfA/ShB/hbCEdIiwOlkHQyl4LSCaeLBvsgm5/L8t6e680hDsHomsrtZsjKSj1fc8XAOcl
	PNzE4w2Py0ooVc7TQkYRfrhPrDZi0cDU9GimukvUcX3zHnTo2+eh8wQeDwV2yls+l3x5+X
	5aX5Bq8ety31HH4pm3PrRd+63sGnafU=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-sHqgejQaNrajsbMqXlqEaQ-1; Fri, 30 Oct 2026 16:07:15 -0400
X-MC-Unique: sHqgejQaNrajsbMqXlqEaQ-1
X-Mimecast-MFC-AGG-ID: sHqgejQaNrajsbMqXlqEaQ_1793390835
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3552883bd19so4424750eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 13:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793390835; x=1793995635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmJVN+NKveF6HgY1Y/eSpfSbY+XEPQzQszmXYvUfvC4=;
        b=jzkq7PHf3CZp7AsHDDr6pFlanEm5fLjGRAJNZN78d95nRU5gTJiUhQ89yWBd+4dkMR
         IYyl+CrEEmQujw69VsAm1KT7EQNmNYy5nr/C3TmyCoJPqYIbv4/ini4F4Y//U7HsAoS2
         /xty1ecluaD3hWLo0dnaFNP+W/I6VqF34Jd1vLxBzvZd/xW3eR90MM0K9jHEj7Omu8s1
         YiHIj0T/0Up/IWBXsblEDIWXAI4Y1MrE+jr11SoJDC/vIdFui427B+xW4xXGsTcng+co
         Hr0VmQpAmtJP440Mn6tYam6O4L76jFeuSY5WpeWT690kr+aqAyPK/fOZlMffjSycFkYb
         FS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390835; x=1793995635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KmJVN+NKveF6HgY1Y/eSpfSbY+XEPQzQszmXYvUfvC4=;
        b=PJS312OeLanKkJfGraE8lwEdI90lbmI4KpiQX5/hzpjN0cdw3HqKBPpGJVVk/PBavg
         wSVh7kRIUaSOygt5iAqrXpIa3/QYvMxFfrpf6dGirlnuig72KjWn0EhgV2NGN2rxekZs
         Oq80p5bsK1EHg+W29yJSD32lsYAWhshbU2vR24M4RMelcMhxCLzuM7AaC5tI9wyTIxDH
         BYBl1BaQjYRE7IFtFtUMK2Dx4hkmVbVK4I9xSYXEwYMk+WRBggiqJH9LUl21SuqLLdSh
         r6nZ13lyjUA5XZ1YPCAzdZA99U9VAecyY6s67GRi/O1MlWBYGtJrrnkNhhHqcV1yTass
         OIoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwG1X/gyYlOZEn/7YH4WrQet+kTQra8DL+HzxVYy6r1EJ30WMzKRFSqqgPizzZESYn7AHDYCCpl9gj2lIJENM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4UITiv+Yykbtyal/zWlbAASP5+sjeZUII2fmo9MqyRjmh9VeS
	U4pPsjWEbeuoSa4Kju5dksen+cnIYSzFod/vP69Chrok/4A+7xJ6ewSSiY2esbp+5GT/3jbWvsx
	mChp/nXBbOSNZ2MXtRf8nS2GcvLMd+kL9XQH08RznzD5o3lX/Vnwi290cELCuzg57e/1X0Q==
X-Gm-Gg: AYBFou3tLV3O9ddX6reOA9G/iPwuSyFF9U+pW7dwDqf4T6au0EcwA32WGIVBzSoq8LK
	mRREQeGwpusKk8AqlGXW/46Y9f+2pKr/W5L5nb7WpRfkPnt3jFdRwZ5E2ac0KBXux7zhiW9rz3J
	RrUm+ZxuhcFv7BWvZsl+fVCu0rJruWxsT3RqpKd7B6sMwzD8PJAE+li/F6DCKhOy5Vv/Z2G/2Ol
	Nx4LWcc4RyWKBUciEpBTLTtGhQhDrdJD2l+HdQUHR/IKCzdnA3YbpPcPpLvsbFuYPQxmyGnuQBA
	laRDnIrWGZClcmG8MlTVyNsySBgnEfHC1lifK7SOj5byfpt5BASp0lwyhIV9by9qyXKO4iGIQQ4
	5ffQ04c5f818l2lHbIzjSHv+yC9357CL0trqTNr1klgLw8EEve6xY+t62xUH3wXiQ+M955EpR4n
	FuFb4lPD9Z6W67lA==
X-Received: by 2002:a05:693c:880b:20b0:369:ff7d:840 with SMTP id 5a478bee46e88-36a423e3607mr5250114eec.21.1793390834441;
        Fri, 30 Oct 2026 13:07:14 -0700 (PDT)
X-Received: by 2002:a05:693c:880b:20b0:369:ff7d:840 with SMTP id 5a478bee46e88-36a423e3607mr5250070eec.21.1793390833726;
        Fri, 30 Oct 2026 13:07:13 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm10581834eec.29.2026.10.30.13.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:07:13 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 5/7] tpm: Increase TPM_BUFSIZE to 8KB for chunking support
Date: Sat, 31 Oct 2026 01:36:47 +0530
Message-ID: <20261030200649.357508-6-armenon@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030200649.357508-1-armenon@redhat.com>
References: <20261030200649.357508-1-armenon@redhat.com>
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261029181541.99505-6-armenon@redhat.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
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

