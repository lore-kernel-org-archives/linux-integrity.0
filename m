Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189008;
	b=PodNdf4+t6HX9I/sYjDkjG4B0Z1/BPfO9Um0PWAseuOcnb7lvQPTUmZZ4tQCHgJcELsY
	 562ugGjMNH2v07NosBjYwshH141+dnJuxh4GkACKAsX789x20hQlMlzGWse/kW0wXPfee
	 e5RXbcIt83y0VpH2nZarvATkSWmuiwdCx2glutGvkcqZkcX3RMt1MbjW3OxAaH3fXKzUj
	 28BQPvtq3TuZ7xnpGrIykE7wFSC/Kytu9E37fzUlJtu46zUlR7KXxcvgiAUi62bBCtrvj
	 l/luCONChQyCyFn6wan/h4Ht8YhkPmyQRAg4vPRo9+ISDkJjIvjWNzsKkxDkirGsP7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189008;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V38T8aAeXJ9M+jcD3MoRT7yJtF10TXOXINWjQCRAFE8=;
	b=HGGCMelS5Qn1bphwlwrUdt9+49cNpJxQ4P4zIcuMdcj9gcBEruoLAkyCLVVr11DD39E3
	 w41hLEJIUJ3FKfxG7QopgndVtYDOvNXksuDEGrXqeSGUVpTD3I4UaOeMifUmMevOJgpm4
	 J5x8My3PJma3X/Z/CMdO4ePw1DkmI7skZNuUi7MyJEyAcwyxBzKVXrtB22aRFr18zKNXI
	 +pAMCVsDQfFh/AYlNZZUjQ15OkxsBXnC78FoHcYzjFCdLaGf2yDL1bO4XaqNnDaelerSZ
	 tQUx/Nb0ouwLPxgd4Wfm0IPHFHNp8D5rxC0IEtdLQs12xx8S8dBk6E7RcjzRO5oHplw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=C53JELFA;
	arc=none smtp.remote-ip=115.124.28.5
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D5606A321;
	Mon,  9 Nov 2026 01:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 997D5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=C53JELFA
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794188998; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=V38T8aAeXJ9M+jcD3MoRT7yJtF10TXOXINWjQCRAFE8=;
	b=C53JELFAPm/TOk9tzJLkKQxl146l103+Ek4b52U9UYZPz2KJ5QWmJa2PkhGEJ8/fNvl7PAoUFV3OpV5AkwqOW37bgIyu0y5nH7+bHGzmENWoC/wLda+gGLCy/EfVa3Gwb4bO7MAborsj7Czt6FmM3x8kA9Y05a2QoPaPygL0YPk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07461259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00469702-0.00473385-0.990569;FP=10823690688715638298|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jzgjJbI_1794188997;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jzgjJbI_1794188997 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 09:49:58 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Ashley Lai <adlai@linux.vnet.ibm.com>,
	Kent Yoder <key@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: ibmvtpm: check the response size against the buffer size
Date: Mon,  9 Nov 2026 09:49:57 +0800
Message-ID: <20261109014957.2777790-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <au3w4NDX1Uqz-iqd@kernel.org>
References: <au3w4NDX1Uqz-iqd@kernel.org>
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

The send path validates the transfer size against the size of the
RTCE buffer:

	if (count > ibmvtpm->rtce_size) {
		dev_err(ibmvtpm->dev,
			"Invalid size in send: count=%zd, rtce_size=%d\n",
			count, ibmvtpm->rtce_size);
		return -EIO;
	}

The receive path has no such check: the response length is whatever
the hypervisor reported in the completion CRQ, and it is only
compared against the size the caller asked for before being used to
copy and clear the RTCE buffer:

	len = ibmvtpm->res_len;

	if (count < len) {
		...
		return -EIO;
	}

	spin_lock(&ibmvtpm->rtce_lock);
	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
	memset(ibmvtpm->rtce_buf, 0, len);

A response length larger than the RTCE buffer makes the memcpy read
past the buffer and the memset clear past it.

Reject a response that does not fit in the RTCE buffer, mirroring
the check the send path already performs.

Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---

v2: Drop the Fixes and Cc: stable tags, as suggested by Jarkko
Sakkinen: a hypervisor reporting an oversized response is not
known to violate the architecture, so this is hardening rather
than a bug fix. No code changes.

 drivers/char/tpm/tpm_ibmvtpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 6fb4d30eb6f6..bfef4bc14767 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -121,6 +121,13 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -EIO;
 	}
 
+	if (len > ibmvtpm->rtce_size) {
+		dev_err(ibmvtpm->dev,
+			"Invalid size in recv: res_len=%d, rtce_size=%d\n",
+			len, ibmvtpm->rtce_size);
+		return -EIO;
+	}
+
 	spin_lock(&ibmvtpm->rtce_lock);
 	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
 	memset(ibmvtpm->rtce_buf, 0, len);
-- 
2.50.1

