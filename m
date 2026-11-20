Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184492;
	b=f/QMagd+daHKYZPpD1EInvEpYzgrug4Sh8mhf9syF+WTTCrOT+ZLwZIKeXUDRdzd0coN
	 vcH35TVZ0Ndr8C/hCaprWzq9WEnLXbr4I9Yuu7lU8UJWDy0SdqsJkHfM/kVNlHHCR7csE
	 QGvMjOXcX9AiNVCflZyyfFU1Bcm7nAMrtn91RfudopxZ74OjBHHAf4elHbbEaTYqVcbSY
	 9yJQ4jVqQL+9BNMnsUlMKpS/Fxo6+1ObbfoCXwxs4foDybQCXJLXnrUUalFZVHjpg8NeA
	 /CPj2SUUhcq6/bypKFVxFbsGQ7/o9eLMwnzS1fn3t7QgDVQeQaDrwfMmcjr/YkiMPUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8kbIPnTNVoYxnzuCSc7WD/8P36oFIhxLoZp7Il+xHts=;
	b=4oYCLCAA8NOc67FM+Z5baUMkBxOgxZA0GubFUOGZjvZActwAAzH4hcYTVgTED2t9UNCS
	 JlD5DxzZw/mVOahjDkU75a7vYIYF/BCvB3BgoDV12d0x6aJWqtTwFNf2NWW2CiS5SVtwW
	 f997brOw2rCtJcBuxyzWCHi0OzBWl8VhkozwikUfKyHa/ZSsVjyanIJbeypyaoUrtHE68
	 wd4sPa93AuOdzUjaVsR7hFE72sxEIrlzjAyz9+k1wemdraOplzndirNCcOV3vyrDGeUNP
	 5RICSdNXdUWz9wPtwCH0vLNASHnCEfkOmkQhO0mxHIdvXipYHN+n9eSX/bLHaBvjRfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=YCXylLXu;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A522606A326
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 14:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A522606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=YCXylLXu
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso794750a91.0
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 06:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795184491; x=1795789291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kbIPnTNVoYxnzuCSc7WD/8P36oFIhxLoZp7Il+xHts=;
        b=YCXylLXuGacjr7o0Nj79F2yQRaIici/FHZRxISZWCv/UwhQz2VuGPEp1KArPhA1hzC
         EtNjTpC9GEeLrjlReZnG+jF9Icg+UPOaqACbrkcaOZuXDGeCEhUWhKp1ohWL2ccBEHJ9
         XmWkwouL02hOYTa3Nc3O+8e7FD1AW/JRqthUP+LSlUoDcsJJXio9MT7lg1FnQ9pCuKpx
         dW57n7UoS7zUblmhogpl4Lb0FOOdUV9zfK4RbnsaxRiz53NlVsLaRyOyPymHNlHHWq0+
         rPyCtQJG+9ZEXuKX0pOcrxHCs2XVKHzJBoEE42DWQlZctaIM/7Pt8uBGW+Spp/TTvK4e
         +phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184491; x=1795789291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kbIPnTNVoYxnzuCSc7WD/8P36oFIhxLoZp7Il+xHts=;
        b=nDnJLf52qQKzAKCL1+nQ/K+TYw0LSlvIRc4TqL9qha+5mJsEyzYENE+x/jzuyLLciK
         Z1c0eTjcs80JDeyTmUQOwfMXefOZF6i9QR+57jTU6WedZ7Sp3ruuUECpOxxvqxFriZs0
         t5WnXFyw9CHjQOf3TOp+1Uu5VzKnJgr+E7rNmkkbw5CDmT4ChJfNORwamPjTgLG+c2r9
         aPwT0bGswuVkYUiX018j8w+ojad4hO3pS5Rque0k/eWMRo70mxWJX8bPE5rNqlKl7RTP
         +uYa53Sk67JF1S5+x1dM9SbfqVibC8WyjR90dbVIQBnbkfCvWvRPJ02ofBp8Tm5Qm3Ri
         xylQ==
X-Forwarded-Encrypted: i=1; AL+hErESQz67AinXw8A82NYKBqLbScV0BhLTLwZ/HSStV8sO/MZLiLkgZ+52K2HikX0jnFszVgP051wVhYx0/CPiH7U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iH81hG/fBpjyN5tD/Udl3iYhtTRDb8DrNIy96UEvGsghgq3h0
	2iClDBQAMzDbb3OrKOBfKPLHHqc0OQTQ2B7hK3NCD/hxlsuQ8CjumxSaChdRgge8K58=
X-Gm-Gg: AZFdTZcqoC3knimYDgviGeep8I6AzzZ13A4wHvD1gN4GRqKPSrqhI1Zk/oElyCh7IPf
	1F887PST2sJu0etZ6oCSBUyB05p3U/UJBHX6SPB+iaD4KlEcfKZEz9kuQUIDUVKiUn5lXTIM2ML
	rmHb94QNcoRYAKxLLll6LQA2aZ9svuwsTuiyGixsg7aGK7KxgPCBY/MITjgsSryoOeY5t7Ewzlh
	3RaedQYKVinSUm8aAuDUnGqICU1i9ufldGlrQ9qxMcySD1vRalbf3qiXUjmnArZWQ74UBdeG6hw
	CMlf3r1/kHSShximCUlQ5Jrl9Z2xNeCEAJd97RjkiJ6PPd+e9p2kA+lFYfrNvswR4B5FVCcor/T
	4U939bL+4a4V/DMvHlHhuHtoERSUAIXWzJawVg85kCDBrTrD1GSiGI1J48oQzrik0no6b3DM4uA
	3hiF968ZJuanPLSWdVPR2fqaiRdcK4nkRPtcfYykVUsviD2l/2igOR9aYBl3wOQ7IDA5buWdFK7
	dMjw9p5XvIasA+Lk5L0yWmMUWKLZYWc4vaQSp4gPrZwuDO+0QVMqCS19eRY/xHz2tumlf/72Fsa
	SDA7TYicRRk6mudCBkdcoEMlj5HTBUfJeOzI
X-Received: by 2002:a17:90b:442c:b0:3ac:aa8d:19de with SMTP id 98e67ed59e1d1-3b41c7d17d9mr3258685a91.3.1795184491524;
        Fri, 20 Nov 2026 06:21:31 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm4622229a91.6.2026.11.20.06.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:21:31 -0800 (PST)
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
Subject: [RFC PATCH 0/1] tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
Date: Fri, 20 Nov 2026 21:21:15 +0700
Message-ID: <20261120142116.1630010-1-rmustafin@cloudlinux.com>
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

Patch 1 blocks io_uring as suggested in the v1 review of the base
series. AIO is rejected the same way, and readv() and writev() keep
working.

The simpler alternative, read_iter/write_iter callbacks that just
return -EIO, would also break readv() and single-iovec writev(), which
work today as well, e.g. a readv() of the 10-byte response header and
the body into separate buffers.

This series requires "[PATCH v2 0/2] tpm: Track the response read
position internally":
https://lore.kernel.org/all/20261120121614.978396-1-rmustafin@cloudlinux.com/

On its own, patch 1 closes only the io_uring trace of the base series;
the read()/write() race trace stays. It also opens a new path: the new
->read_iter() lets vfs_iter_read() callers such as Coda reach
tpm_common_read() with their own offset. Today these calls fail,
because the TPM files have no ->read_iter(); without the base series
that offset would index data_buffer again.

Tested in a QEMU guest with swtpm and KASAN: the tpm2 selftests pass
with both series applied.
Claude Opus 5.5 was used in preparing this series.

Rustam Mustafin (1):
  tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0

 drivers/char/tpm/tpm-dev-common.c        | 72 ++++++++++++++++++++++++
 drivers/char/tpm/tpm-dev.c               |  4 ++
 drivers/char/tpm/tpm-dev.h               |  4 ++
 drivers/char/tpm/tpmrm-dev.c             |  4 ++
 tools/testing/selftests/tpm2/tpm_uring.c | 14 ++---
 5 files changed, 91 insertions(+), 7 deletions(-)


base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
prerequisite-patch-id: 929c8a56f28a166a5961816bde23cb25204ac74a
prerequisite-patch-id: 624623d00390085ca69fae7309aee60aa27b163e
-- 
2.52.0

