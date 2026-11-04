Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761094;
	b=EbOl+q31U4jagy2lBAWTijMUBEfJIeMkIvumVvi4IrHFdE+hN/DD1saQQ+cDa6hP5/Uk
	 iEzhvsm52UulCskslglp0VxSEXAmGhxjSWDyXSLbaLWlw3aTQAsqjpBv9VVcnHRqUqkQ4
	 Uf2QCqO9NLcUP8sPIR7mydGzHo3z/NmhMw/ljOcdLyklWDtH2YSGgb2d8OKGTpaZLCHll
	 uIiZTxuOpoRX+oIKpApl3r4YXq7vhJgC73FWnOAuhpt4ugVt7tRFB1Dd9MWI57/J3v6FD
	 QIz9KweglTxN5Ef8qkZE/eBUxHYLowL7YVzgERNkgauGkezVcSP/KqoHz+zyFeshYnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761094;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6K7mdgwtT1pUptQZb8V/YwrLp8kJMPOp/OKvTUNrc9w=;
	b=qtZCfpIPLSxbHgXJtKorU0fXyWwa6OShbD5XIrgg3BixY1VJxZL1LW+Jon1sl8hF3cp6
	 hYfpTbgJ1/+IWCHG92bZi1lezsvodZ8dtbV1ogTmTzPm0+5kwjTexAYhP+EgEcy0v/SnA
	 RhrvJjUxI13Jgj3cOE+2ctWaRXyBJ6ecPyl1ol8+mBpQtPArCDAsOlDzTQ6ym3lsmjBQK
	 tIUaaJVbY9s/bWY7ofETSdLC9qofBxC9NoOuNxMBX2aptEPbcvKEOgWtb95c2kvBvWcs1
	 Q30Q5HgYdqF655sWGvKZBgPD+Rvm5w0nkpdW7Z/lVaXvPMACLu6IMEj67JSSJWs9Aqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=KTm+tbmQ;
	arc=none smtp.remote-ip=115.124.28.196
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED5606A31B;
	Wed,  4 Nov 2026 02:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12ED5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=KTm+tbmQ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793761090; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6K7mdgwtT1pUptQZb8V/YwrLp8kJMPOp/OKvTUNrc9w=;
	b=KTm+tbmQxOTe/7VPdO3EG+oghYyTmTR40kFWEi+jb5x8tc6EivVlypfVZu1GYUTI22d1GYXiFNIl70ZhqgOZwwC5P3Moy83UGfo08JEwCYk+i9s3TPad8rQgY2e+ntmHXYP1sJX5i4SHRt5AiZwiywQ6n/EgZPm0ioh2GF9nFf8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3239649|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.128799-0.138537-0.732665;FP=17242777726901411837|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jwIggha_1793761089;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jwIggha_1793761089 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 10:58:10 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: jarkko@kernel.org
Cc: peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com
Subject: Re: [PATCH] tpm: eventlog: check the payload size before reading tag events
Date: Wed,  4 Nov 2026 10:58:09 +0800
Message-ID: <20261104025809.787723-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aunbAIcxu8XTW0Ph@kernel.org>
References: <aunbAIcxu8XTW0Ph@kernel.org>
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

The legacy PC Client spec defines the EV_EVENT_TAG payload as a
TCPA_PC_EVENT: event_id, event_size and event-type-specific data.
A conformant entry carries the 8-byte header, and the hash-type
ids carry a full digest.

The catch is that the log is an ACPI table the firmware leaves in
memory: the TPM never measures the log itself, so the kernel cannot
tell a conformant log from a corrupted one.  The iterators already
work on that assumption - they stop once the declared event_size
runs past the buffer end - and this check applies the same rule to
what the EVENT_TAG branch reads off the payload.
