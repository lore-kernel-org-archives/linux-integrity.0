Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959553;
	b=DBY3vJC0oKLqT35SVUHseKbIbY3z12n87kyCs0XiwLNRR/HkTpdbh8nb5pT1mvDsUWDS
	 kmK4jtG2czcESj9nhzp5EDAX2+LzaurwbjEXwi7cDyRjpZ/HTVQS8Pds6NFKPGKV35JIs
	 ogWECY/2HMymWeEBA8nMHX+2/14TzW6oF+uBlebpq3knkA/uS1qaw33UHHmVq1TeORwYK
	 TCkeP6spqdhAudqWRIzCq+Na2eVLPKk4LMSRgR6OSnBnNFPO5bjjAKfopYF/PjCvcBg72
	 qdQm/hYdG9855NmqUrzRIhGwGYOzn/lVqsqMA+rUzfXKYrRFIHm+6I/ps/AjTT6T9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959553;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jtzC8GOmAvHT3XfNpHE4tG+IxT92XswAdGYofHiX++Q=;
	b=J+WxzQYLri2DQbEQwEwIIfgkkkFOURrizRGFT8y/2KEVJlr4EuyC507GHVkDvD5U0Vml
	 8m4pIMfiOzOa+cWN2fLM6QLpViIqRGanGTnI/BlIxaRUPHgAN8t7pjcWeDJph+EjR8DG/
	 EKCF0jf1C56maiSaxEjPb4n/KkEvYadgcNSAODqB88i0paC6r07ZC1aQbcBvChIzoQchl
	 j2KTUJZbL0vZ+s2kxjXrTFs1q/le+XU+8PvIN/tlubgshaRsDHfhp85AVx9+fVtuEDGJV
	 KXEWZyitI4LHOJx9i/Z+1XbrpDlP2zEwL5ZE7H/8SalaxA7ntEnknNR03a/i8jtSIEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WM8O03fA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VUOjKEPd;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1682606A329
	for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 20:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1682606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WM8O03fA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VUOjKEPd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792959551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtzC8GOmAvHT3XfNpHE4tG+IxT92XswAdGYofHiX++Q=;
	b=WM8O03fAlyploiq6vl1QIDFooK4igl7hHOdjKu0X6XccNQRX6uwNTtZOYpNzq9sAqrjZo8
	y1LLsbq0Wb4UQ4KuCGhe6zozJvu8gYn5MgpVM0kd31keSaJg0TZQLkGXeoPjjB3Li6d0HX
	U7MTrMfGriXyPJ7ceTyCEUIbYQHFAAQ=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-Om-Vr2JcPGCrYgnVLhUYcA-1; Sun, 25 Oct 2026 16:19:10 -0400
X-MC-Unique: Om-Vr2JcPGCrYgnVLhUYcA-1
X-Mimecast-MFC-AGG-ID: Om-Vr2JcPGCrYgnVLhUYcA_1792959549
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1663fb7e005so3085140c88.0
        for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792959549; x=1793564349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jtzC8GOmAvHT3XfNpHE4tG+IxT92XswAdGYofHiX++Q=;
        b=VUOjKEPdZjHCRl1eosDhwWnd7HgWKXSbWry5XZhowBHeTzbAEXyiQR0P7DK/h7oCG+
         xV5etLjgn485u4IDz7HaTPtqoYUwnKnz9BuNOxGmqHI3vGWlWZWDQiljIbDhvQVX4Mqg
         NmNBRrqxUDKDba2kHcxW+3cydRaG/wVBALP/Iwy6DUdwy38SwQv+RTxAC14LgqQoHvzh
         9CBuMVgOBnJTrYT4EtSNYKDm+O5fiXBIaVBwKo0pRtMKOnjbdV76nITdD66sHvTeUkln
         leAOJUvcw760TeLyy+RCC7NaSj1KACCE7mBvzyT56q6wkepmTOctwEUPkPkuwYUqxLaM
         jHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959549; x=1793564349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jtzC8GOmAvHT3XfNpHE4tG+IxT92XswAdGYofHiX++Q=;
        b=GQVIXLjtb2x75kbT1DUaA3usMBhHhlkDs+1QJ22K9kpP41BXxv0KWjORytnMMdhuFc
         aJkdBzlfHdmm/CdLnq89kshL/yqO5yT4BnfU1ULvktbWXwjow3fauovQ0raC2M7UpPJr
         v3PX9T76k/j5yOEVrnjtTonOwxWLc+icflV/mMYSs8KX5k18qa0/W9ABgGOuvOsL+wZF
         zgGfjSD8vzOYxknOF2jiXW935kWUQrVQSGD/oTOpssmc7sQavhZxsuXEUSEBHi9Y0V7A
         pPDfNMjznQqSesOC1wY78spZO8KIeRV+c1OkEZ0g3LrNOsKATYFV5cubQ3vJIpfB8We2
         Gd1w==
X-Forwarded-Encrypted: i=1; AKwUvBww1vEzwPHfaG9XcdlToT/qFeb+X4T6tSkt5ErcwKjd9xhmSnbwW6rKLjQ3HQALaBlvlFhmvty1o6a6/lLnuCo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqCZgCcJBGcge1miRtn0+OtSnn4feo5v5+I7+B9AZ49Unng9FV
	P531M9o6vSy0sbiO51iDJAuwz1tMLMDuER54FQVg4tgKHC7kj0UqbuIhKh+evI51+uODBww0rZb
	1xlWpO+qFlCIz9k4aTe7uNim9la3xmNZM5XIhGb7e8fMSKI8xtIYPIy/gXnu1HnYrMZGb0YJ1fO
	tgLA==
X-Gm-Gg: AYBFou0s84VO2p1vegx+otDANhvUy53pedALVf2MkEY1tmi5+E6FamPGvPjf+PUuGP2
	z44oPNyfccknr8HqVYXs5p8aftdefaDUDt107OECHiFJn0mT/bEsK1sqgaxYKJYdDrRpypeuih5
	VSwNsVhRjxDmwgJahB9+eQ7yScR0uONhFNgRX5uIAA3nu3xYRCZpOMcAM+HlvNQ2mV3X0fwNSnR
	Mq5SnAHOlj9pYwoEbN7yBHesyNi4xV4ebCaSn4Yrb2C7PLlDRWcY3LJTr47fnzPxIrk+gQsnvv2
	tG3YfycVd7UJUJ/UoDM5cLKhVyzSKpdRY9DxiQHew5rJZoBFyk6ygXEEXM/5qtPlrI5Xg1ADkJ8
	is50lfdUBs4vxvPlNmuecX0NUcgYCCp3phgCUIMKn
X-Received: by 2002:a05:7022:c43:b0:16c:6459:35b1 with SMTP id a92af1059eb24-19935fcbbfdmr6156283c88.28.1792959549096;
        Sun, 25 Oct 2026 13:19:09 -0700 (PDT)
X-Received: by 2002:a05:7022:c43:b0:16c:6459:35b1 with SMTP id a92af1059eb24-19935fcbbfdmr6156258c88.28.1792959548453;
        Sun, 25 Oct 2026 13:19:08 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm17656169c88.3.2026.10.25.13.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:19:08 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 1/6] tpm_crb: Add register definitions of TPM CRB chunking fields
Date: Mon, 26 Oct 2026 01:48:53 +0530
Message-ID: <20261025201859.221991-2-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025201859.221991-1-armenon@redhat.com>
References: <20261025201859.221991-1-armenon@redhat.com>
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

Post-quantum cryptographic (PQC) algorithms can require buffer sizes that
exceed the physical capacity of the TPM's Command/Response Buffer (CRB).
To support these larger payloads, the TPM 2.0 CRB specification [1]
allows for data chunking when the physical MMIO window is smaller than
the required buffer size.

To support this protocol, the TPM driver must be able to detect the
chunking capability, and signal the backend using specific start
method flags, also known as the control area start register bits.

As per sections 6.4.2.2 and 6.5.3.9 of the specification document [1]
Add 2 new bit flags to the existing enum crb_start and add the
capability bit.
- CRB_INTF_CAP_CRB_CHUNK: A capability bit used to detect if the backend
  supports chunking.
- CRB_START_NEXT_CHUNK: A control bit to signal the TPM to consume the
  current command buffer, or to get the next chunk from the response
  buffer.
- CRB_START_RESP_RETRY: A control bit to signal retransmission of a
  response buffer.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ceb4100ba400..d76f9e30f036 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -57,12 +57,18 @@ enum crb_ctrl_sts {
 
 enum crb_start {
 	CRB_START_INVOKE	= BIT(0),
+	CRB_START_RESP_RETRY = BIT(1),
+	CRB_START_NEXT_CHUNK = BIT(2),
 };
 
 enum crb_cancel {
 	CRB_CANCEL_INVOKE	= BIT(0),
 };
 
+enum crb_intf {
+	CRB_INTF_CAP_CRB_CHUNK = BIT(10),
+};
+
 struct crb_regs_head {
 	u32 loc_state;
 	u32 reserved1;
-- 
2.54.0

