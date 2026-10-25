Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959550;
	b=mpliHNCoQ1guJoKhCgjLcLD/qGDXwO9ApBV1TpBI9hOtnVK+0HvkC1HCSa7l82lW5/QT
	 sB50bbCSz0BtKN0Hbf/84yhKViPPc6wCOVNTYpx9VtuNnRKAPjecrjRfEXwBO/YWRcvLh
	 NRQyNwlxf89ngP9coc8p0YuvwC5t1uIeNZu8YugqO75bfm7bW7ymlZRwETA7IIz7coo5j
	 161CszRDDPCEyS9ruDeHw3cuUnJa03hP5ANA2EPHYoyDDhoSySiuK8CtWehAU4JWYJac+
	 MYe2rcYXcfCmrG93ii/cy11cj38EBkgJ35nwCHXazaHqcJKtWWr6sbYPobd/aF2LYmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959550;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=38omCnsO4pVkAGZlh9VCUkEXdgM52Ut5/eZHNeUrnD4=;
	b=dH5JWs8UOuFJxtUP4h2Ox7QD0LReeDesHi//WJ9/b5JVyoL1ugAHBuDDRgXnMM0kOW4q
	 ted07Sv22xjQ7qk0Kt6LLnt/PC0gCEGNQcg6uIElU/MwpYYVOqsYB9oR5nEKgWeRZASUi
	 Faup7ZrgeJ3Jjle+P2sLR9xe9GiStnJc3MzJsRPcj2gQzHU0UoxLirD8h83gs1zVy94t4
	 BO6sg4eurUFW57pcBcCAz4lr66zPuVKIq7YpS8x4JkDNBtQJYSSL+VZfOafOrqFEB0xA0
	 cUpVy3iHMx/CZTXOE3RQmot0OQYo0aLnVHfcIaXatq3Gli9Cpuu+/77KBqV6QXxfM6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eyjtlzer;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=idE3UMqd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DA606A31A
	for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 20:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D05DA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eyjtlzer;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=idE3UMqd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792959548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=38omCnsO4pVkAGZlh9VCUkEXdgM52Ut5/eZHNeUrnD4=;
	b=eyjtlzerSL7btPqqeIvFKz9Sc0A7pnhSlNJxR6TdHhTejf6EsrBL7PZCXKi2oRW/hbnL6Q
	+GPPjrdEYU/sC8c9ng8/YnSWpEQw3vUPIHUGSDFuGR3R1bM4zv1owWCFUq8JjwE3clDl86
	gsO4PMK5huGUSbSI/knf40Bphh4WiWY=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-NHQRA4lcOuWaMORlj-zp6g-1; Sun, 25 Oct 2026 16:19:07 -0400
X-MC-Unique: NHQRA4lcOuWaMORlj-zp6g-1
X-Mimecast-MFC-AGG-ID: NHQRA4lcOuWaMORlj-zp6g_1792959546
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso5097260eec.1
        for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792959546; x=1793564346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=38omCnsO4pVkAGZlh9VCUkEXdgM52Ut5/eZHNeUrnD4=;
        b=idE3UMqdtax/dl+u1EWX8lzLXUHssBV/OJlDqTyJ+tUlo67BIhfI/OKfXudRvf9GqG
         cRxKtqmGZDP4Dc6ZHtr67uV8Jq6PosNLHyarZPvGe8dtYrdIUdw7tN3M9OvpfhkZDFlv
         RvcWWW2JPq2FyRD2n1G3r4a7PdenPNgGAexUKRqJbXpFnA+FhJh8BBcR8JF+aGcWlLIw
         jLWxhOUrvdILjLezReWPVU22WJReLbdePqxmC0qq5nBYdHity1zyv7nwKZb8B5EhQSZq
         tnynhEGD89mjSE/nurszZWFqtWLMPOF1Kt2Rt7GMCjIasMyIaakVoBy87B8ueXNGTbyJ
         shjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959546; x=1793564346;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=38omCnsO4pVkAGZlh9VCUkEXdgM52Ut5/eZHNeUrnD4=;
        b=Faa4yivkLk6p1yZRvjmZUxnaGf+7MS+UfvH2ynjMkv9yJpqGpC5IMduvU3C+P1MIga
         2vQJByCrkwGJD6PrFuuo6/WRdhgZ0X/8f2gSgji1QTwUo31NM5HLCN80Lz10uJQBE5cJ
         UkDRoxNLC39GJ9YS3beMPRbApT64t09RmvmueYNwhyzKADfPCXb0BEoZcA2Ydvmmd4iC
         pJ4WIc1Y6Fnl0EBxf/HG79KxeV80dOEnZrCTl5717vRwY4gmDMGiZFMlfrmiO6fsbo0I
         65eeJxT/xnQ/s8IOsJlAZczW5zjTE79DV6pJRTxIZ/ZV36nUjMShJBry6M06P5cti7w9
         SdRg==
X-Forwarded-Encrypted: i=1; AKwUvBwyEAXE1GGfrJ9D+J0WxkYU6rGTxa/mWDJaVgtEkTSYWzLN7uRSzKeUD93X2/g35AXL75a9IH3NWvmgT8QWtgs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8LIzJ7ajdi9njCWogCE06G/BZE9T4XdizeyHUNh0Or0e4hgJy
	wWUJ6GzavMN8s25AupgULAczmS48snXgRVO7yYrCuUi94Ew/cXWAkDjO3z1ZsUzKRkmZI0DjaEW
	P1FB2kHNWnFOfbg7NmZtGAtRjxurH6FW9IluLFASuHFxV7OZoT+220gLtq/bevUvdgIXRdw==
X-Gm-Gg: AYBFou0IyZvZZoEljP4MVVPSkEpr9xPM1JkeqwJgHbZE61KAro2MLsb7Bxf0a9L0sr2
	30bvuWLp6yJMIIQMVnlhIVcnNVCiXyOGG3l7kQ421pRH6Y4oFwFzncnvsqbeoRtsz8I3ePpOtHp
	tg7o8N0b3MfYB+kI0w9wjcDVbdOhaQWAxyy1Uw9mVaTUk4rYSy8WcUlIq17RF5c9VvM+lIj7pzl
	4OBd05Se30zcBD2HWstXCp8yT2wz3it9gm1sUrJjnrPTfyO7KECXxca2NTFF72dNi6vJsTmOXpO
	UGVGX+2n94IWMlmoUkNMhevoinQWBcdz4bgzz3jR3JfKd5Ksn3+qa4drupMeqpDMuUS0B+9rFuo
	IKLUOG2B9iDB0s4L81m9xwDCeZYYpD6dceQD1l7m7
X-Received: by 2002:a05:7022:e28:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-1991b42085bmr10139597c88.0.1792959546132;
        Sun, 25 Oct 2026 13:19:06 -0700 (PDT)
X-Received: by 2002:a05:7022:e28:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-1991b42085bmr10139568c88.0.1792959545352;
        Sun, 25 Oct 2026 13:19:05 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm17656169c88.3.2026.10.25.13.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:19:04 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 0/6] tpm_crb: Add command and response buffer chunking support
Date: Mon, 26 Oct 2026 01:48:52 +0530
Message-ID: <20261025201859.221991-1-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
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

The new version of TCG TPM v185 [1] supports sending data/commands in
chunks for the CRB (Command Response Buffer) interface. This is in line
with the initiative to support PQC algorithms.

This series implements the logic to send and receive larger TPM
cmd/rsp between the linux guest and the TPM backend in chunks.
Currently, the TPM CRB driver is limited by the physical size of the
MMIO window. When userspace attempts to send a payload that exceeds this
size, the driver rejects it.

This series introduces chunking support. The driver now checks the CRB
interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
backend, the driver will slice oversized commands into MMIO-sized
chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
with CRB_START_INVOKE. Responses are also read back in a similar chunked
manner.

If the backend does not support chunking, the driver retains its legacy
behaviour and enforces the standard size limits.

This feature also requires the QEMU to interpret the data in chunks and
forward it to the TPM backend and subsequently dispatch the TPM response
in chunks back to the linux guest. This is implemented in [2] and
already merged into the mainline.

The whole series applied on top of for-next-tpm (including prerequisite)
can be found here:
https://github.com/armenon-rh/linux/tree/tpm-crb-linux

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
[2] https://lore.kernel.org/qemu-devel/20260601215410.517009-1-stefanb@linux.ibm.com/

v4
--
- Rebased on master (or for-next-tpm, both point to the same commit).
- Resolved one conflict in PATCH v3 05/06, as TPM_BUFSIZE is declared in
  include/linux/tpm_command.h.

v3
--
- Split patch 2, so that the code is cleaner.
- Re-order the buffer size adjustment patch.
- Rename crb_trigger_tpm to tpm_crb_start.
- Add dispatching logic in send and recv functions. Chunking is
  separated from no-chunking for clarity.
- Increase TPM_BUFSIZE in the common file include/linux/tpm.h following,
  [PATCH v9 11/11] tpm-buf: Implement managed allocations
  https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/

v2
--
- Add size checks before copying memory.
- Update TPM_BUFSIZE to 8KB.
- Commit messages updated to indicate motivation and logic of the change.

Arun Menon (6):
  tpm_crb: Add register definitions of TPM CRB chunking fields
  tpm_crb: Split start method into a separate header
  tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
  tpm: tis_i2c: Use local 4KB buffer to limit memory usage
  tpm: Increase TPM_BUFSIZE to 8kB for chunking support
  tpm_crb: Implement command and response chunking logic

 drivers/char/tpm/tpm_crb.c     | 257 +++++++++++++++++++++++++--------
 drivers/char/tpm/tpm_tis_i2c.c |   6 +-
 include/linux/tpm_command.h    |   2 +-
 3 files changed, 204 insertions(+), 61 deletions(-)

-- 
2.54.0

