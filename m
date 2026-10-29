Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297754;
	b=StZc7bmWTuzQPTwQ4FtDDAFjLZ+IfgYymyqdLRV/ZSepgjUB8LWziQEvbypi4Uy9gIp5
	 4FQgYFgquqIXJk+TetIS64JyJApk91TaQ8eml+DQVQHawbO7RyIFNO8L27Ag4PBQ/JO2/
	 0lKl0sU75NrgwggkGjRUj47FFnePg6GMmAJZQxBnpnjs9AjxRhth8XyV2WkrvLfO34IYX
	 f+kJKwzXTczGRo1mWZFdjjTLontbR0JL04JJUE5swrOFLg5o/rQBMgjSlQfUBJ4olOhrL
	 XFUD/zmX00FK9JOWKgp9Oe0H6Vz1htJ93C7nYNk0lNZ/SjVZApJDZDxK38O10Vww+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297754;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=nm3DyYmQwwN8ivVQeFLvPuaFwX0wAYrPypwdIL897m8=;
	b=YFhzODslpUO/HCTq2RkgWLAcRhgL2Fdwk2yMfTO9lCtMbOUsQaAlaFWJZwAVtIpUqkZO
	 H+e5TuCpkG8KCR6BpAIf/GAYsFznTx0GWh2GKi6zphvnIwoAjdQwxAvYebwNETBkAuc32
	 QDgoTCLS2iSvH0pcZKBRx9wG0eZ9nUMgyrzch2hJKso3IrMqE6nvKakkscIcpTnv5HHKW
	 Y9yEDemB5FkWSMbdSJFFMvifY/wQU47cCp0rIPADz0aScVh+GIKzQcmdBHM3wro5G7EEy
	 st5MvoDDfYfOqzZ675NvfEUzO/NWdfSBC/nY2cuNEm90VtwAlLVsDea/UKYREUa/swQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YNaAQCIy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e3aHGZMu;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A6606A31C
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 18:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B5A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YNaAQCIy;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e3aHGZMu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793297752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nm3DyYmQwwN8ivVQeFLvPuaFwX0wAYrPypwdIL897m8=;
	b=YNaAQCIy4WWSxairE2vDLlKFpsv8FnFohc5oxvas/lBtPyxzfbAQbEeGoKiiMPtMc4WMwe
	q4d4TwITMX5iyxD2+2dmJ03PJ++dX+vP+D4ioujdNy6jPpw9X76f9oRqDve4VRxaD6TX5D
	ujwoFIqS9a01ESsVK8SA+QNLimMCQvo=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-d-_8hLDLME-Uh5lzbjq3Pg-1; Thu, 29 Oct 2026 14:15:50 -0400
X-MC-Unique: d-_8hLDLME-Uh5lzbjq3Pg-1
X-Mimecast-MFC-AGG-ID: d-_8hLDLME-Uh5lzbjq3Pg_1793297750
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3425098ae4bso1422223eec.0
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793297750; x=1793902550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nm3DyYmQwwN8ivVQeFLvPuaFwX0wAYrPypwdIL897m8=;
        b=e3aHGZMuFBYsLWALbK2afwadqK22umr0GncxNAs5pKEs2kv/+jYtF9NLwKn6fv3gxE
         BuFaFe53Bt9CxNGbDZriSgnJEXz6Q8C78TPR9va8QzXPD4PZf7bVHoh0pJs8TJWqGJBG
         7EGmBClfeu2ibH/frUXTCiE1N19LPCGJa5dvOr6+ZafBTwKEortjxkspXN4ZTpLgwW7H
         MTrGwK7c9p30LB9qTUAoT7Qj1dIX7naVvvQ9xPfG9/WiJaLDvrcooBSgSb2y8jWc1yrO
         ZRNb1jTQCTy6Jc4WV8n2AlAq7tF+/zVm1slDaEKTMS3p8tY8nnQP9mV2Fgk8dmeaJk0g
         W+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297750; x=1793902550;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nm3DyYmQwwN8ivVQeFLvPuaFwX0wAYrPypwdIL897m8=;
        b=2VW8QAyMVzlJf/Chnj9tmkwNrmAEt2O77QiKSBPKKJB/c1l3IsELNqkqyh6oJHbTro
         e19ADv9Pd0nUqFMm0IiMBfiY/ebNhXt/pj/HsvD6acS8TzrdpriamdVPLRVdowFk+gC2
         F9c5r5g2pKUgqZX8fnonmOenUhT9tVVmRDtiJbx8jGcFNO6tg35R8AIq7oc9XTr2VDBS
         TFNRI1MWpzTsP4J2mCQFcneOePUdRNB5CwjxfkANbVK21hfTkjl9+d/cuvrQRcYda9Gf
         +cDMz2KWJnwY4FrWDGN3Mhf7VTRA1NqMEjqwjQcmQXZZFD43+oZRfZlzXwxTIO7N/HiB
         tToQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5I2O1t37gxjsshPxmZFRQ/1ncuKFH24kHaKR00OGUqE9J0krMIqBP8+mDplhcLb9GWOlz1Y/eeW3T4UzY9NI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9ll3RGuXXCBlzr8hjTVkD4ZbpYnhW6s3q57wpg/o1Sc90ZjbO
	v13XX0w8uxgY6LXoIhVNesWkHDdirCP3vkmcZd6PI0qs0Ixuac9blleg0J3RQFZ9m5DJ6H5W7C4
	UgXqZRfPQYZtv0zAehdKmD2l14Nihsj6VmTfYEclj3wsSn2BNWEHDStmZCWdRz1YWMDEzHg==
X-Gm-Gg: AYBFou0IEq4yoNbRYi0pYjJ8IW3Japwd2mXJ1D7/CcVhYyofNN7hgqi34KrOzF7rLAn
	Qe2cWp/SVo3E8YPG3820wJPqpiPYtRiRNg+6GSGmrPBOMY1WA+6zSpa/kl0IcOj6LS4DxfcrCFH
	ergBBUCrLvlEHkbHfKUZ1MF7jtSCvPdkVQu/2vtGTAdQJR92XdaaTUiXEdCUGvtCi/10g7UKkYa
	WMQhbRZkqg6J7yJKqOGFrGD8CSwGlptdzBLm9CCWsCrc6EyqCoRWgHF1Mx6iyv9AbNheIHnDpD2
	iatAt7vw0shoLLtTt/B8zJO8mRFu0Ah0QReUPLJchfWK55TX3geYiJ1zC3Dtpwur+sswttdsGYm
	rxnwElzY2wUhzHKNZj1OlljidtnbNjGvZm7kl4JftNgVAFcds3mp1KpynIIISzNGmV5uMHh183u
	kB6Ql2/7StDbNFBQ==
X-Received: by 2002:a05:7022:f907:b0:145:ac96:3917 with SMTP id a92af1059eb24-1a94a3408aamr3771861c88.21.1793297749237;
        Thu, 29 Oct 2026 11:15:49 -0700 (PDT)
X-Received: by 2002:a05:7022:f907:b0:145:ac96:3917 with SMTP id a92af1059eb24-1a94a3408aamr3771818c88.21.1793297748355;
        Thu, 29 Oct 2026 11:15:48 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm259163eec.4.2026.10.29.11.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:15:47 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 0/7] tpm_crb: Add command and response buffer chunking support
Date: Thu, 29 Oct 2026 23:45:34 +0530
Message-ID: <20261029181541.99505-1-armenon@redhat.com>
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

 drivers/char/tpm/tpm_crb.c     | 226 +++++++++++++++++++++++++++------
 drivers/char/tpm/tpm_tis_i2c.c |   6 +-
 include/linux/tpm_command.h    |   2 +-
 3 files changed, 189 insertions(+), 45 deletions(-)

-- 
2.56.0

