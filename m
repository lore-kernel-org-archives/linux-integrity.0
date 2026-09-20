Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC481388E58
	for <linux-integrity@vger.kernel.org>; Sun, 20 Sep 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889679; cv=none; b=kHh6qD6PRv7N71Ezd8wPdEhNLycdj5mZHuVvID+oIhNsUh4K54B2xuLNoyxr+yIXdfRAXrjvTjdHZG6FYc6pvPRzYSnwoUF2hAOGTqQRZGquYV71WtiB/05QiQfuk55qOPRZRmdj1ruTcUvsg8ktUN51XLGiZ+Qm0z6GzhuS16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889679; c=relaxed/simple;
	bh=Y0vWIwcel8T5ZiRhWrg2QMH1GGMx/xCwZl8it+HQC6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+Nbt4u+/pNv1SpaG6O3yw+5oY3zwN7ynjpiNNtGoWRwvtv3zh5HBpsNd5SQ7QzEYDsgLAjwp5QsGztSan0NUK2lPVTGKfJhElUu6vyj5ISBCInTy9Qzor6buCEk+1BMvWUJHYpy7OwOa9SzuphIp/NB+PZrXSbU55dT8USvvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1vyzj8k; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1vyzj8k"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25400so1500509b3a.0
        for <linux-integrity@vger.kernel.org>; Sun, 20 Sep 2026 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889677; x=1790494477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0vWIwcel8T5ZiRhWrg2QMH1GGMx/xCwZl8it+HQC6s=;
        b=o1vyzj8k7ZU+K0eTMvOakrVZ/+0TzqwLtHzIxAOp/yv7fPplQ+9lNGrOLelYqUJL80
         WALOShO8hSArhEuAu1BhpLK4iC/B8xnXBn/LEOyh1WYXXdiHoAFZ6L7LQM5WoHTin4mz
         97Bqsc9rtzfhLb9OVziyDEqICN/hAxkhQdiKrpiWrOYH6UlAZfkqy+xyIluEFdQa5xNq
         qJj4T0Nlog7KcsktR0Jl1X3CK6s+DKrk8dKJf2XTxwpbZQ1LDBZmP6ESu2kpQ2SEd6xM
         u0adS0osf1KwE558f3/+JdhC9mCWrNBb2X/fHMDAnkhIZMZY/vEEKvqBSf5h+ylaKRVK
         JXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889677; x=1790494477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0vWIwcel8T5ZiRhWrg2QMH1GGMx/xCwZl8it+HQC6s=;
        b=qw7yaMC+BAgpT8edS1LLGLeTsa3CZfGfpszAw0wezyTqo57ymt9wHu/oxWcKrC2Jdl
         SmZf+qxThyoqxY+9zUsAlABcDTEeEuYvNtH/Zn6H4L5z8WpVKlMR0qPRnPKqezqKf0Fp
         4//asLQBFXaZ6Ez9dw8u6qgCRiKR7pjHrxsXHwJuGNmqwJWMeJTWheg7QhLYO3kZv97G
         JFihtx8PSTkNZ2KMsLhpE0b1BRHZlG1DwNa+YiTNesNQUYEmwiYFM8Z3I0Gd1FO9eeGI
         icsMIJykT8yDc+DvXLtYsZBO8CNL/xyf0JjMgSNF4ZIUkAjPHmFN5rnEaZJov674Y0E+
         G0yw==
X-Gm-Message-State: AFuF++myBsWYnvf8iQBRKViljZ0su+0V8hAgGdj4/Q30Kt8ii/fGN+kn
	YFbqmlTrbWPspwO5mzZmF/+3hqAr8Tq2yU3GwrDvGC5be66HpLfH4Adz7FwCWkCVORqZy5Ak
X-Gm-Gg: AYBFou3fByMpsEFWyvV/hEqqH3z3CYeKgfb7HcELRq2xihLqmciy/aitCsYJU5dvSGY
	Dz0WWL3GJZM6u6n1H6+y0Px2b2uV0bwgL0jr69jZeWro5IDwOs+39389fw2//CUYMFfgMzbUwMg
	bJDujR5skjilpzaHDX+3d5nATol4JN52dOEj/mbcPT5W90PMnBSViRrx9uo8K/i+314Z7d8n6Hf
	49gHQCuwFQSiqYO7yexoEzskDXTpZnxv4xvAoqK3oVMSn1ja//3gbtDo3nAOPDT9gdV9C1coweY
	lilnImrvTvHjEeYNQicUzmWC99sCqriQ5hh5NLI7xNg2eJ9EAuKPAnwd53B6k+c3JXnnOFwO49P
	wsr5xjphYSLOpPZKYqNri/j4YDt6iKQG0VA7+1FU2JihdRIb/XW5jf4y7P6Raai/mhssyHfcecy
	ks60WAXWyeTbfMEHYnBo6pWL1A6r5QvTfQ010Spka7W5ftFey5pMyKDivpUI43TCxlHSbnrpG8b
	RBV4uopo4G7Yn1ew9fXyU1GXaX0HzrVhxN+TZ7yMv8tDHHTbDDgvK2ZMmP1UNsjydRri5cWtHhT
X-Received: by 2002:a05:6a00:3e1a:b0:857:7384:b5fa with SMTP id d2e1a72fcca58-874dd9f68cfmr9984638b3a.22.1789889676965;
        Sun, 20 Sep 2026 00:34:36 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa107365sm1716383b3a.47.2026.09.20.00.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:34:36 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH 1/1] tpm: ignore duplicate PCR banks in tpm2_get_pcr_allocation
Date: Sun, 20 Sep 2026 15:34:28 +0800
Message-ID: <20260920073428.64168-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <85b8cbb1985c743325d57e05d51d8814d3c56549.1789800840.git.xuyuqiabc@gmail.com>
References: <85b8cbb1985c743325d57e05d51d8814d3c56549.1789800840.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review. We checked all three items against the tree this
patch was based on. Two of them describe real pre-existing validation gaps
in tpm2_get_pcr_allocation(); the third does not apply to that function.
None of them is introduced or altered by this patch, which only makes
allocated_banks[] unique by hash algorithm.

> 1) Stack out-of-bounds read in `tpm2_get_pcr_allocation()` when parsing
> TPM response due to trusting `size_of_select`.

Confirmed, and it is pre-existing. struct tpm2_pcr_selection declares
pcr_select as a fixed u8[3] (include/linux/tpm_command.h:419-423), while
size_of_select is a u8 taken verbatim from the TPM response
(drivers/char/tpm/tpm2-cmd.c:567). memchr_inv() is then called with that
attacker-controlled length over the 3-byte stack array (tpm2-cmd.c:570), so
size_of_select up to 255 makes it read up to 252 bytes past pcr_select. The
value is only used as a boolean, so this is an out-of-bounds read rather
than a direct information leak, but it is still undefined behaviour and
KASAN would flag it with a hostile TPM. It was introduced by bcfff8384f6c
("tpm: dynamically allocate the allocated_banks array"), long before this
patch.

It is a different root cause from ignoring duplicate hash algorithms,
so it is outside the scope of this series.

> 2) Heap out-of-bounds read in `tpm2_get_pcr_allocation()` due to
> insufficient buffer length validation before copying the TPM response
> payload.

The "insufficient validation" part is correct, but we do not think it is
reachable as a heap out-of-bounds read. The guard before the copy only
proves that marker + offsetof(size_of_select) is inside the response, i.e.
3 bytes (tpm2-cmd.c:560-565), while memcpy() then copies
sizeof(pcr_selection) = 6 bytes (tpm2-cmd.c:567). memcpy() can go past
end only because of that 3-byte guard versus the 6-byte copy, so the
source read exceeds the logical end by at most 3 bytes.

After a successful tpm_try_transmit(), len equals header->length
(tpm-interface.c:202), and tpm_transmit_cmd() stores that value in
buf->length. rsp_len taken from the header is therefore the same length,
not a weaker bound than buf->length.

The loop is capped at nr_possible_banks <= TPM2_MAX_PCR_BANKS = 8
(tpm2-cmd.c:548), with marker advancing by at most 3 + 255 per iteration.
The last memcpy source is therefore at offset 1825; after the loop marker
is at most 2083, still well inside the TPM_BUFSIZE (4096) kzalloc buffer,
so the read never leaves the allocation. The over-read is limited to the
area between the logical response end and the end of the same buffer.

This guard also predates the patch (1db15344f874).

> 3) Function mixes goto-based error handling with `__free()` scope-based
> cleanup, violating subsystem guidelines.

We could not find such a mix in tpm2_get_pcr_allocation(). The function has
no goto: it uses only break and return (tpm2-cmd.c:534, 544, 551, 597),
with __free(kfree) on buf as the only cleanup construct.

To summarize: item 1 is a real pre-existing out-of-bounds read. For item 2
the insufficient guard is real, but a heap out-of-bounds read is not
reachable. Item 3 does not apply to this function. This series is
intentionally limited to ignoring duplicate hash algorithms so that
nr_allocated_banks, and therefore groups_cnt, always equals the number of
distinct algorithms the TPM reports.

Best regards,
Yuqi Xu
