Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176983;
	b=WXcH+FsdZTQqyOyYwPXxN/e0adMEvHVbZBmlAhsRzQq33mukuC7P/kJVoQGxy3TsRYMY
	 MUq5oD1ZneMVUsY3nis6QCa3j7BWD+oDif4TOOywd33lIJRP6UmtL6ybsUQ6rvxhVEcgD
	 dqTTeteQRTuFfjhYiZkrbqEUNcYJiA+Dhwc+wFbRbJKXHRLpoaba/1aBrVBP9WB/amkiw
	 Hu2P553yE3/b5Ace4i+2GRqTPvzgvwOJmM8ykO+y1metr0bXVr1b9D9v6Luj87sdzxfgo
	 +DXR0hN1F62mWPgaUTtF5pPkczMRAbs0/AkUNEEtOQjgdtXu0WvPyqU31Tx26h6nUjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IknLS1Izf6DM/sF56KVAF42vdnRgs47WGOTqobZZNJY=;
	b=yJP1BvH/A84aVveoF/j88fPi79fybTgfwkkbw4blG3Otq1EJTYW0/LxAaup1l/Gr29X5
	 jUpoYIIslcXONXYPwOU9zEGFT+GZ0tn30qYzjD+FzVX9MnNdkp+atIgyvXqXxalZwUP0r
	 bJo9mbeRhfHWBrOfHeZUny+bFIDui2md972SgXBaqB7BJa5k9TDKdRFGm9SOWaeTyCRhX
	 Q07dL4cuVo43IZaz/nH84ciXdvL8vXaWZ9x6ch+YPBHUufXq+ZPUq7v0s8qfYtfJkry4L
	 xKyr4b5B6EzKWXKPc+HDm4CTQM/kNDLD3EVGHreBC2KMfqTLDc9oo+v69hunGAFO/PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=T9vD3ibR;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C91606A325
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 12:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55C91606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=T9vD3ibR
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f03920c477so6677135ad.2
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 04:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795176983; x=1795781783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IknLS1Izf6DM/sF56KVAF42vdnRgs47WGOTqobZZNJY=;
        b=T9vD3ibRQLSip0fqBDuE3ADF/LJTrbPD5BVSPj9KnfEC11F7KshDIe2v6WWHxEIafs
         c6BIPIiVuyhtlZ9SW/y9+y27NLfofz0s+/JLD8SGcLCJKIJFz8/x4k1xqLA3QVRz8wWW
         QV++PBYMLf3HMfcXxHyc3xbLVg8v2g74m503hHYLvolnX7Z7AJjlRP3XurEEN0D5UEjT
         zRSLYxKBEUtNratmXQRf9290R88Br2oYWf5xLZn0WM/1EWIN6uDXr8tvrS0hFyy7nA88
         L6iiqgAGgZzH7iqKkoJnAzG5MeNZx3+O1qUfxRtOW2vE5N3qBQB3zQ0tQ6TafLQ9sIKM
         AMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176983; x=1795781783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IknLS1Izf6DM/sF56KVAF42vdnRgs47WGOTqobZZNJY=;
        b=woxNxQ/I84tc6QLAz0gtoNqB+0XUMCsWsIm4tGfNu9c9P3ePtqyvOioRVf6LMGKPuB
         WCueEVJa6PgFvnNsEYqhcBTt3M7ki3gu+DxBK4dlJH+SH4BZ+uEm54FAyfXdKy/y7E2T
         uGKTgbFx7LTGbnmzXY41OCEl5dZdgUPopmP7h8qtwtUIQkplraK2/rFdVHvYMQmU606t
         N5mEMMBzkKBwcK/VneOedY78P5DzbALlPm+kVp6Ybl9hHugEr9K6O2klNiZp4ydVdWHz
         Yf+GyYm/WDDYd+k+MDrDV3nhGna8C+wo/0dM3ArS/EaGOtGLXcoYIARK7MeXQ9QlWXTY
         BKhA==
X-Forwarded-Encrypted: i=1; AL+hErEhl+wAaXc292QE1KV/0wirIsMP6G6d8VAK6GWuFqb3hm0N8YTvLA18rgG45q2G8v+z+Y/Bsd4FehNiMFeH9O4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G6PJSfyIBkmoNsKi8XEH0e6ukTYlEHWtmmvV5yDChXBpC/maj
	FG9w8qdD5GVaQV+M1e77yXra8QMaoZc+kPEPdldUxlC0OPXWZEwo7N1aaXMZ6ZcDavk=
X-Gm-Gg: AZFdTZfXnPHraTgXud2pFIQPNexL139MRB7Pk+wKsM5Drbs6ZzveSysWBrnKE/6I/0R
	VXNe4hopJkHcGu6PxUwFkDwLkaiJMhpog1aJYYUXcNEBO/pstq+wqinUSXgoh8grLGDX+dOdWCl
	ahDNIkAaBrM5ddk+UU8oz/P6TcI7gs0OOQrjIHfTG11DEU3s7tBQA97cKaUNRfAbAqFpfB5YFsZ
	Mz5AkTkbxg6TYq8Y5J3mXFXsJE3XGPHhVTNVbG70IE7onHjXq46TBl0loOtnRDzIlMajrqyLzsa
	lDK3md3s+ZghF/8GOj98rPi1nOMgOIC36qAgT8J9RswyQ8hGVP1Q7AO2hEiOQJqAmJ6TeehqZrl
	bT5QTYmZtrlFitACHV8pSjkqMelVDRWxQoRCsWSOn8NzNYRj6Ct8Ey77Y92NnHX4ec+tcR5rEUn
	/IPm30rKH75QTOu82fkc2HLLppPwdpVrIpUcEqjTZKsnF2yvo44fmPZx/ia96KWQqRWBZyTBH2x
	ORAHM5GqNIBPGYxREB8oX1nWyswOUchhr5dQ8H/gLytDtZE+nd1meWz+Jj1L/xibMVT1IpdTu/b
	RZD39lQgnNV9K4N4iarYNlCnY/D22NbwXM1B
X-Received: by 2002:a17:90b:1f87:b0:3b3:ca9e:9e22 with SMTP id 98e67ed59e1d1-3b41c9b2667mr2658990a91.17.1795176982660;
        Fri, 20 Nov 2026 04:16:22 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm4463146a91.1.2026.11.20.04.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:16:22 -0800 (PST)
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
Subject: [PATCH v2 0/2] tpm: Track the response read position internally
Date: Fri, 20 Nov 2026 19:16:12 +0700
Message-ID: <20261120121614.978396-1-rmustafin@cloudlinux.com>
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

tpm_common_read() uses *off as an index into priv->data_buffer.
nonseekable_open() makes pread() fail, but an IORING_OP_READ request
still reaches tpm_common_read() through loop_rw_iter() with *off set
to sqe->off, and a plain read() racing a write() reaches it with a
stale f_pos. Both allow out-of-bounds reads and zeroing of kernel
memory.

Patch 1 moves the read position into struct file_priv, under
buffer_mutex, and ignores *off.

Patch 2 adds a kselftest: an io_uring read with sqe->off inside the
response buffer must return the whole response from its start.

Blocking io_uring, suggested in the v1 review, is no longer needed for
safety with patch 1; I discuss it in the v1 thread.

Tested in a QEMU guest with swtpm and KASAN: the tpm2 selftests pass
with patch 1, and the new one fails without it.
Claude Opus 5.5 was used in preparing this series.

Changes in v2:
- commit message reworked per review, read()/write() race trace added
- add a kselftest

v1: https://lore.kernel.org/all/20261117104838.2650999-1-rmustafin@cloudlinux.com/

Rustam Mustafin (2):
  tpm: Track the response read position internally
  selftests: tpm2: test that io_uring reads ignore the file offset

 drivers/char/tpm/tpm-dev-common.c        |  11 +-
 drivers/char/tpm/tpm-dev.h               |   1 +
 tools/testing/selftests/tpm2/.gitignore  |   1 +
 tools/testing/selftests/tpm2/Makefile    |   4 +
 tools/testing/selftests/tpm2/tpm_uring.c | 131 +++++++++++++++++++++++
 5 files changed, 143 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/tpm2/tpm_uring.c


base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.52.0

