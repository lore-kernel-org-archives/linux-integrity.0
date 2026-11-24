Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530280;
	b=1amYf9Eb9yinYJhKBKPZBzKgKqpZ7Uy/Sa81iZ1b2SE3nB70OMWR89jibDu2Rg9uXgYc
	 uVX9CHz/YJ1tbFsBmKx9UdWnIYJeQ/24z5dRZcXnYyauM99EUWsy6Xty7eCDqhQ3IbcFY
	 DwSVvPtejGScDMJq8a7nCKHHDcBLUdqf+HOp+W5vMccxx9zUzLenqfAhlVe3iWtdixe4x
	 I5r7cxgZMijaz/TG0EIPErWTGuEtgiAXT93r7MQF2pL7f/5ykCc9YoESW+37OKe0FqGhf
	 nFtU1Ui1KShs/HOOboEgAy4GCnVaAsKMwIR92q27iJvGSBq7TtVgzE4Cyb1J28U8z7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zeYR8ZpHeq1pZR+dWFeLvQVug9RPwZ0JSTo3dxUe7oU=;
	b=p2QdwOQxX+YufJMqyy6r60dKRUjh/7u/47vE0Ga3ELp3CXP42+N0SG9mr7K5/k1REQ9O
	 jz5Y/SqU3h6bn5KmQq8zPD1iqJ3av4KI0R5MsKxb+/twkUqvVx05l6q6Fh54kXw76ZCfz
	 0G14NmWwgf1XvCAjLJ8REtHFd8646NhZxCCdSYj3YUTt3wTnG80UotVUr1VV9iuLLN2jy
	 Q3wNndBL5RoVd3eS/3eSGc1GSp+OJ0QzIWChJ9hRH7PsBPXLNbH1guS20IThLLVCkvukz
	 EUjklQkZyPRYGry14pDMGfKsHEqYAUJDWCh3C+FT2Gm8JkHFAWuZtEv5+HqgpUsObVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=LmHp0DqC;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842C606A32A
	for <linux-integrity@vger.kernel.org>; Tue, 24 Nov 2026 14:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4842C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=LmHp0DqC
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4c685c751so39308937b3.1
        for <linux-integrity@vger.kernel.org>; Tue, 24 Nov 2026 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795530279; x=1796135079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zeYR8ZpHeq1pZR+dWFeLvQVug9RPwZ0JSTo3dxUe7oU=;
        b=LmHp0DqC0LRcWzknI/MLiNMBE5IdV/Pjma5UHmY8zzorIPCtV77jLK8KiLMmtFYLBa
         89+/Z7XRSKgZNZi/nP/r/BuULrWI8qfvyRnxdRp5fo5qaRng8tk6qVQPcotdmlglWm3+
         SgfB610d4aAbAILLqBTOthGY7bd8E116LiOqP0ypMvHkcA4PSjyQwVzkfxgVwwQOlkmS
         IMJ31/cqmFDQd21IDMxpIVV0OQeZwvyvEBPu2gBWJE+1QJz/3t6HvR4n9x0+SF5ymL8j
         Q6pKroRBs45PhDK1IuSE17NFWuehw3+EfRM6C28jlCVOSQ43D5Ntiimv0yoYBSJYQGbw
         XyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530279; x=1796135079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zeYR8ZpHeq1pZR+dWFeLvQVug9RPwZ0JSTo3dxUe7oU=;
        b=iVCQjYqOweLAoWTfWO42FTomcLkZ3knuon4cOdNXx/p8/bSrA+fJUuUeDvbKtQyibp
         td2Y7EuC0zIH15GDvsllaL/RTYgPt5VNFCPKvleh3aV0pFvWJ8YSB/nm+KsM8quqOBDf
         wzzqOP1GhVtFgG/7eySI2GUFLp89dXgH+kvGowQKgoa9fwHA18rb2xP7crnPIDPjR+OT
         N64rvVFDYW1rnm4sMaFV/wQ3CR6UEu+tpuxnYKpePksZxS5xkqYvAWMm76OYEk0Ji97L
         2SIwj/rmD2XnxIO6fRLlZ2Sjyl7sw6D817J1jUajGVXr8vD6iG1XwWOJsugD040k7Nz2
         GDwQ==
X-Forwarded-Encrypted: i=1; AL+hErEmVylESDgnVhGCf3WLEobS4Am8LUIPeGD6zL/C2jnOwvmlgnqHkfy0oo623MpYu6oAy+KhnrKBF4Gt1wDnwOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z2ytk2UuPcm4Sq7BAKWJd9RqEj3fanDqOC6JXzX3m6QGcxNbJ
	UvRRXxuTOnNIfBXu7CvdJbjxiw7x/jmsdi6huWn768j5/eYaCYDWW0ezHcszqhKPAyE=
X-Gm-Gg: AZFdTZdkOjxY8NrFFV9WMxTDhWDY2Ou/NI6yyVMG7gRxfpqNRW8aemov4l7z5gQpgnW
	0QTNm11SuUKRHbJ2h9tHEVb3jFcv56K4DBUTW+1rCSEhozzxjC6AMOUnNDc5QgDBhGIWM+DsjKC
	/ZRlINvqpM5ne4lVLom5Cy2dIW6fiNNMOEvPrQAQGLpb2JrWKX+kh+X4mn4a9qmUg7FcqQ4WNIl
	QHbfi277xrjuPscnvcrUBiWcdFjvpvNVyiqw48XfpLrTvbup71ZZYGNL39c2qw/4sboZrUemPZQ
	uQbyban4t9A2QtbWxc1ZG3uvME9RkiHiuzxbFLECm2Kkn94U7LXrOqTBjOPB6ubxHzjdG2BfR69
	zZAek47pNlVt4abOEolrRpNhUtUmCET9rHS0RDeeKIhXK9LqVAOvHP8agW1VEdy7nY2jAVdsLj7
	qSe5Lt7C4i8cguZ0Nw7zDuv38ReJ9690Dzm7WNa/PM/kRHZ57ZXiT0H7IasF5wmzKuebUUPHaZp
	6zwror8TJgHso7xj1gboe+n8384s9o7yEAuuNJo3OKf3kI5ZOTGpbeODr6leBHpBbAhJk/nUv50
	FnDkgy05HmCHs06FkKnGdQdrAAbMaGjgTeg8zl4=
X-Received: by 2002:a05:690c:e004:20b0:8b5:6583:a09f with SMTP id 00721157ae682-8b56583a41dmr3892037b3.100.1795530278752;
        Tue, 24 Nov 2026 06:24:38 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52033c2d4sm58062957b3.36.2026.11.24.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:24:38 -0800 (PST)
From: Rustam Mustafin <rmustafin@cloudlinux.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>,
	Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rustam Mustafin <rmustafin@cloudlinux.com>
Subject: [PATCH v3 0/2] tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
Date: Tue, 24 Nov 2026 21:24:30 +0700
Message-ID: <20261124142432.368943-1-rmustafin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
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

io_uring passes its own file offset to the TPM character devices despite
nonseekable_open(), and its asynchronous requests do not fit the single
command and response per open file. Patch 1 rejects io_uring and AIO with
-EIO. Patch 2 adds the selftest and replaces the separate selftest
patch [1].

The series applies on top of "tpm: Track the response read position
internally" [2].

preadv2() and pwritev2() with RWF_SYNC, RWF_DSYNC, RWF_APPEND or
RWF_NOAPPEND now succeed and ignore the flag, instead of failing with
-EOPNOTSUPP.

Tested with swtpm in QEMU: the tpm2 selftests pass, and the new one fails
without patch 1.

Changes in v3:
- squash the selftest into this series, SPDX GPL-2.0-only (Jarkko)
- keep tpm_common_read_iter() and tpm_common_write_iter() non-static:
  like tpm_common_read() and tpm_common_write(), they are used in
  tpm-dev.c and tpmrm-dev.c (Jarkko)

Changes in v2:
- open the message with the use case, rewrap (Jarkko)
- drop the CONFIG_IO_URING guards (Jarkko)
- drop Suggested-by

[1] https://lore.kernel.org/all/20261123165638.2161305-1-rmustafin@cloudlinux.com/
[2] https://lore.kernel.org/all/20261120121614.978396-2-rmustafin@cloudlinux.com/
v2: https://lore.kernel.org/all/20261123173321.2363162-1-rmustafin@cloudlinux.com/
v1: https://lore.kernel.org/all/20261120142116.1630010-1-rmustafin@cloudlinux.com/

Rustam Mustafin (2):
  tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
  selftests: tpm2: test that io_uring reads are rejected

 drivers/char/tpm/tpm-dev-common.c          | 70 +++++++++++++++++++++
 drivers/char/tpm/tpm-dev.c                 |  2 +
 drivers/char/tpm/tpm-dev.h                 |  2 +
 drivers/char/tpm/tpmrm-dev.c               |  2 +
 tools/testing/selftests/tpm2/Makefile      |  2 +-
 tools/testing/selftests/tpm2/test_uring.sh | 15 +++++
 tools/testing/selftests/tpm2/tpm2_tests.py | 72 ++++++++++++++++++++++
 7 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/tpm2/test_uring.sh

-- 
2.52.0

