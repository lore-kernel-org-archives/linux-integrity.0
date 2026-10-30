Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390821;
	b=Fsyv37tj1GAkXOcd04BbHqmmH7LYyE8hqj6mGljP+SykA9rWckGP9oBGjI7cv8PUnKIz
	 SFR0o+k0zkV+061TXELB4N/ugDBMG2kJtjepIr6rrsIz/3XNLxJUtG8k0n/vG/UrU72co
	 SXXgygPwfPSGSSKheyFf359Tdnmb27fbTLK5oL073nEOoj8F998j55ncycMbOnBpHLLtg
	 UExQz82wt/WCczshAB52UDk7/6ClcIjvwJSlFA7tXEchERnYxQjXPYRyeJhhyJ1ABAcpI
	 z6RU2b/T5rslj4+gt7zbpxnH4N3CEkz76EOJLoVTAo0H/RA8RwhO1bcxL1p9HGcTXcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390821;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=rSBRyWxD/L6iGcMkwcVuEPYbqUn6cUjGSKoS/CpmhzU=;
	b=VlmKgZxP4uLPuxqq0lJulLQAbyP/g/GRiTgVjVFX7DfgAeDmwo0oQ6WzD9fVfAKWjMlF
	 Fz3dxVibyTtRQF9SDAC4eicdXMG4AzzWaQHjyo+BNexsCO9TTWKmqqDq1vpxKusDQe7WC
	 xXH6A6MtccFlz/CSwdTC+5777/eco3+Ec0gXeosdF38EaJf9++aOPZ8I9G8hoxmS5dzut
	 jypBUtZup/b+BN1LywyPg5jGkXfXvhyvjoeV7VqQ8085jpcyx70VWM9PGOEtmSqxqRkim
	 fdXWOp5R9H8NaFevxnES72x2soBetjR+T09GJszXPlGu8slz3Z4S4aV+4doY4hxcDOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RyB7F3I+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QAZxyDbv;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D3606A31D
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 20:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E20D3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RyB7F3I+;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QAZxyDbv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793390819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rSBRyWxD/L6iGcMkwcVuEPYbqUn6cUjGSKoS/CpmhzU=;
	b=RyB7F3I+FOdqGNVAH11gjpxX6BXW+/HQHvCdxyL3K9XtGTXHnWbh/jC849H03bv24RcsPy
	ciCFAV37w8NYhV9lHYvOgtgZl4Zb9PFTIR5Fbz1QgRl3PKmvB8xTKHkBsLSSREBUGjKH7/
	VjwWWgopgOJoNWStYSnIcYCIUyJJD3E=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-lyOZKUT-P_q6eFFJFAgYOQ-1; Fri, 30 Oct 2026 16:06:58 -0400
X-MC-Unique: lyOZKUT-P_q6eFFJFAgYOQ-1
X-Mimecast-MFC-AGG-ID: lyOZKUT-P_q6eFFJFAgYOQ_1793390817
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c5aef2a74so4313007eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793390817; x=1793995617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rSBRyWxD/L6iGcMkwcVuEPYbqUn6cUjGSKoS/CpmhzU=;
        b=QAZxyDbvM6LMaXvonoV0ftSTB2L1rd4+qz3q/gVDBBGZVpLJH/gPXJDo2twqsy85FD
         E2pehJbrCKyTvzIBNtOfGJP1VeyRMAqMxlMaeeDgemdvOkxdbKOCNBYfqG8p6TsMsxy9
         i0D6KtN5E8T+UmVh8JcmNBlvaEArl1LulP/HjU1jkJyG902tUbAQyDc9FK777RBXV0Xq
         H2H5amtII5jME3OMb8QMKlhpk8N89r7Tan5boQCD+pL8nHwvWprGc8oSnV/JftOvLamo
         1/EA0a01p0EPkhAVdiVUsPOpGJV0r7B+UxE8byngddh3RUnx+OCSnsOfmsPPzWMaz5uP
         Crag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390817; x=1793995617;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rSBRyWxD/L6iGcMkwcVuEPYbqUn6cUjGSKoS/CpmhzU=;
        b=OQgb0YVDelC5mFYtRRT6WrbfEdebOb/mv14joYp1/P0EU9jGIKDw/Kd/5u7pRmP1Sb
         4VLj0gPdMYaU5eaAT5fk67/6STGwodwsyk7t6+3t5paf2FaxAoPCHqFon9i0FTa7b4+A
         WpjP9ZMRKxVD6OIcWzLrHAYmDEeDKOzWzw0ZhSaZzakgsz3sO1U0FFbi1U7Tu44KA/ui
         Hk4XaL/5dk1zcV/a2Q8NSY2S4q+6vDHQ+1qjbwAmWCum/yjXmDiTrSVNuc3tSzuOLEmK
         BSrfi7+zcBD6f1LC+Fz/+avZwc9Xdrafk95TSb8um5uXOFm9Zns4B3khqAT59fXKS1rz
         NqZA==
X-Forwarded-Encrypted: i=1; AKwUvBx5wJZ2chK5mmaI9Ou+TN56YEQgGOiVj3ZMq5jLsmMrKRgmAwhtHtuUvzdj7WrFet4MdnmTA9YugphDD0aI5no=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTsDdDjoY3kX7r5g+pRs8uVToHLlgV+uv5PT++x+A35EViNNMq
	5JrJJ74x/CGx8UBFalo7o5fWWYMWI7nK/JOYsy4xWYy7h+XkGcst4r/fkVcZyDm2Zib0j5Jg0t8
	LTYBe21rLuXAeUlMytvk5ytAg8vBtNWINYD7LymsewBHlKqq+LQpLc2K8TyoAyK+rrrptKfwcDB
	XA1w==
X-Gm-Gg: AYBFou1ua+Z4KILHidcxEhLSBo3fPjjn2yjaXusTbP5/PvXP1g6r6gBcFNNL76O5qtt
	IhchiJesLvAeuZ0pWEt85GumQ2VxEJuX/3w+DjpPMv7hyNYXBp5GtxHLNBx1THBoI/S8qvl7k4i
	0LFF9HFGJPk3Q3+HXGPwI3btD6xMo48uIfBC6FLDlnu2r75eZ1eYJNgqubCphg9/Gcw/Zr6lMRF
	uFpnzVgIIe9Q3wdHMazCJ6tQVIMYNCI0zQWo5enlmpPGbMELg6rKPv9Blr0G8LJTGZY6N+k7Ia3
	mFCglGxph/jDnW6c733IX6V4xNRVZx23mt/ObGw96LkP/ulwlZtzCVuHWTGUA6DrD5JToSrqHzc
	X9d/8oItozXINE2wFsD8wXLZogZOEy+uvTnqJR6HiZSRcHgbuBkfYJHnyEC1VRfMl5oUL9qkYCC
	iavuhQX8WgpbCLVA==
X-Received: by 2002:a05:7301:490c:b0:36a:1819:4d0c with SMTP id 5a478bee46e88-36a42438ebamr4845649eec.41.1793390817131;
        Fri, 30 Oct 2026 13:06:57 -0700 (PDT)
X-Received: by 2002:a05:7301:490c:b0:36a:1819:4d0c with SMTP id 5a478bee46e88-36a42438ebamr4845613eec.41.1793390816512;
        Fri, 30 Oct 2026 13:06:56 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm10581834eec.29.2026.10.30.13.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:06:55 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 0/7] tpm_crb: Add command and response buffer chunking support
Date: Sat, 31 Oct 2026 01:36:42 +0530
Message-ID: <20261030200649.357508-1-armenon@redhat.com>
X-Mailer: git-send-email 2.56.0
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

v6
--
-  Rebased on master and the sparse __iomem warning is fixed.

v5
--
- Split [PATCH v4 06/06] into 2. The preparation patch separates the
  no-chunking send() and recv() from chunking.
- Fixed block comments to respect kernel's preferred multi-line style.
- Added citations to the TCG TPM and NIST FIPS documentations. Explained
  the logic and newly introduced registers in brief in the git commit
  message.

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

Arun Menon (7):
  tpm_crb: Add register definitions of TPM CRB chunking fields
  tpm_crb: Split start method into a separate header
  tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
  tpm: tis_i2c: Use local 4KB buffer to limit memory usage
  tpm: Increase TPM_BUFSIZE to 8KB for chunking support
  tpm_crb: Factor crb_send()/crb_recv() bodies into helpers
  tpm_crb: Implement command and response chunking logic

 drivers/char/tpm/tpm_crb.c     | 228 +++++++++++++++++++++++++++------
 drivers/char/tpm/tpm_tis_i2c.c |   5 +-
 include/linux/tpm_command.h    |   2 +-
 3 files changed, 190 insertions(+), 45 deletions(-)

-- 
2.56.0

