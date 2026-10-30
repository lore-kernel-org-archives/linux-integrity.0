Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390824;
	b=IA0Z5s/f9sbHluBMvCWpLuNPJ0um2kk9nG9AyLTr3m1kIztygCLwtN4vwEARv3B6YF8e
	 WN4F4th1AVqpN5JfVQv0EJZGEnHMvMRdYbqAFT14RTAGD2VNzIcEg0tExS4oXW1GyJHX6
	 FtfYq+9KF7mC8ntrcr5TEoM+MgIr66zk+K+1UYi4BtMMnW4voKbmdq3jJmzyacc5fQ4Kq
	 Q0hG5eyDScCtGH9tzrHxZbGFJzDJXW85BkMQnf5kNZIFgz8adCrUCHyRcheFK0FuHCml0
	 CuZ5cVXLSmRkCr/2q0hR7KJCT3auzsFE3z4t57UJQy0CBQKDznNS1uZJN0ldiaKjjSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390824;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=G+u0MMaB0Chjq0cRmNk+9/pu3PKAcwfxS8n0Z1mbg/8=;
	b=hsOKc086SxvehAeiWvhLx0Sdzd2XjLJzy3J0huSfym7xYM7GqOzbJwFUxudSu/L47oFT
	 1T+mZmd93Qwml2hk2Q6Bxo+Le1RFoOsRwShEcv5RJUuZ0K7ZIXoosDHTdGNLKFr1DnwfA
	 PPdAEQUOY+hoCSQFRxcM9U9GshO+CiglmRGVDLyZewEeKAINNbRbZjfifKF7X24W5kuzG
	 lNG6vrR0BiDkzFUdS/JTnD90ouJz4rYaizADQnoS9Mmd/NvQoLlFfyunbYGiJbNFquZcy
	 zKx/9Fg1oq0y5eFpLmOVz46RQVp3pOID7rV9XzeBjp+4Nwqq95/uCmbgY7nxu9GTbvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dEbHn7cq;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="T/V4HYbj";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B438606A322
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 20:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B438606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dEbHn7cq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=T/V4HYbj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793390823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+u0MMaB0Chjq0cRmNk+9/pu3PKAcwfxS8n0Z1mbg/8=;
	b=dEbHn7cqezKSC7Dsa+miiZLUKrBnP+3uVIwGxaAULsPsB3xdIaZ/Mlcn/NlkyUH8X5Lcp3
	v/TeQN7SsPh3LGHjwBHseWgqLrvYFSOE1ttqjpnP6XSx5ChhJIizw7pQe51vF8cyB6ONJu
	u5LWSNjnx9ZEsRQQJrYzQIP09WvK1Mw=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-LCHj7-9PNouuV9UAEP8T4g-1; Fri, 30 Oct 2026 16:07:01 -0400
X-MC-Unique: LCHj7-9PNouuV9UAEP8T4g-1
X-Mimecast-MFC-AGG-ID: LCHj7-9PNouuV9UAEP8T4g_1793390821
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c3c370b17so1834522eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793390820; x=1793995620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+u0MMaB0Chjq0cRmNk+9/pu3PKAcwfxS8n0Z1mbg/8=;
        b=T/V4HYbjvJEKKGd1tir+C6AC3retQ9slj0Xh/WmSarCbB6ufieqQqUvENyj/kiwrg6
         XNC3Mrgn0qkU1AnvrVANEEE6+ifz1WVlg4JvWjXDulnp7tPY7VVNMYHU0qpoMItPrx7Y
         RyZi5FP8CnL1XgUaChcZLjR3fQdaT2054QyOghUdfrEYHVuoFxlnb1UVZoJpwJ+GsK/I
         CKXEs1nlsCcjRKvhGj79rTAtXipFtvrB5KSH+KE4OAuzUv+M/zIRSIXTK+1DeQc4mXwz
         bakdNCW55te0YRnGzusQiNS/Sfc/G495qgPeoBv9QcM1QxNjHpbFz30KdBNJ9yP0wd3K
         JlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390820; x=1793995620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+u0MMaB0Chjq0cRmNk+9/pu3PKAcwfxS8n0Z1mbg/8=;
        b=vqnsw1gnHWq8wh4iKnp75+Ji5G+e0lPwhOBW2mBtMGEXvs4bo2ZLDK9u3Jyd1eZVnM
         n/VxeYMFV65VpCqiNZlPJ4V/jbdrf6rkftawwwrSfSxaUdJjTVgE84+LSEHRFOak1LkY
         Et2dQuNQDThTq24CiQ5XPKn6YdeH6GpG4FhF+hB+J66ugGa/WGqwrQAdwfWApyyXb1mg
         IYWMuE4u3KijqhVHj3ezetXCE1zJydjhKzn+6mUEtsvyIDSV8v4qc6/gy3o+iySppcMi
         T18LicHZS5ZXahG3g5wAMb+9wiR7+DUxXa/QljY4GZLBmrl97/LfUEHt9acpKJ7O0Udb
         GDvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwFYrrLQQ+M/2Eg1vg7Wz2xjc+c0O/y/EpNY5hAVBEQsMPSnN8J7PEp2awkjw+Ii3HctIz7krLDapdBVKpry4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKt7UpvfoSQ9BEgyLpkkfa5XPJr0nF64pxg7hR6njhY/5x9Hvt2
	dusRc2Bb0txeFg9YOPgOU1b5intmSJ8/4/kqJKmc9yINHysoZwSr9cGepJBW0BVJXoqr2U1+X7q
	yUBbCfHVTTYgq3KFmvWTU7+X665B/6XtrYZc5nDRcmoGwov8OzC6ZD90Bva3zL/A5ZZieWg==
X-Gm-Gg: AYBFou2s5oozXbIczFpy+JXEouAi7d5E7By62wlhQq3xqj+bCbkf+2TyEnz29LqB1wm
	DHpaPY2ar0CmO00McF3p4V4FZyI9nPAlIJhUHdUH1dq7ncWQsFWg2bMuBhQGeXfTahLf+apg9nH
	8CYl+wb4bxRA3LmvbTFd++dfmGRbsAgerLg28QvgtPBo6s7LilRk7F78YOcvyAPp94+Of+Ps5c0
	A6H+1SXmaaqyvhpFaF7a0mozTI2hE1pLhHiIK+yeneFzVxbnh9NLO6czWODPqpwygbhQvZq2iHQ
	FXIEezXNpk1tv0EOkrSt0Pxadear3FP2HtUb9S5iq6rqkAqHjHZifVNGpkAPHkG4JIOWg0SUSAz
	ReXn2E1PZRfRDa5bkw9i2JhcWWxERO5M7wBhkotd95BWlbNMHkBWW7khmqVA0W8jNNUqi8rBEm8
	2OxUDaszEnFe55Sw==
X-Received: by 2002:a05:7301:618a:b0:351:68e8:4646 with SMTP id 5a478bee46e88-36a424199bemr4511588eec.37.1793390820500;
        Fri, 30 Oct 2026 13:07:00 -0700 (PDT)
X-Received: by 2002:a05:7301:618a:b0:351:68e8:4646 with SMTP id 5a478bee46e88-36a424199bemr4511552eec.37.1793390819849;
        Fri, 30 Oct 2026 13:06:59 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm10581834eec.29.2026.10.30.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:06:59 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 1/7] tpm_crb: Add register definitions of TPM CRB chunking fields
Date: Sat, 31 Oct 2026 01:36:43 +0530
Message-ID: <20261030200649.357508-2-armenon@redhat.com>
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
Link: https://lore.kernel.org/r/20261029181541.99505-2-armenon@redhat.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
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
2.56.0

