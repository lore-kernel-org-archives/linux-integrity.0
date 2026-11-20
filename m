Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207895;
	b=0+G2zZppTYvcLgCc4HOWoNqKZgNa7d7LvJ+DsL2rCF+ziRSYJIKmx2rg60rQB5VOUSdF
	 h8LtXoXU48CB0qdt2qmWlhbsVTOxF7d502uKDK1tkj3Mj+8txxntFLurcJMn245W+VdZT
	 zFoysY3IIjhz0THMCaIoCl01SQsDnJemhwcajvxvdIN357DJ4u5XBXsm/DfJ4htxxrqLV
	 4YTW8tn5254csxWPr06VwHnZkB1m0ZhUEVm2PW0VR+waOgJa3FlG9bn24UZLl1JMnk5GL
	 h1VzP94fJjdrEmgA1OiyVT6KvlPsVOmcM6fwLncmW+Xbc+x88jSMWPwMWnBnlwMG6pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207895;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=yA4q9BECD3fF1s8uqr2VolmeomijaxkoI3eekCtTSsQ=;
	b=ytWetG6ShVvxWRgSH9X1bAZYqekhbJSmlgJabA+28VGbSDcn2XayLG939bWDzapPAe/n
	 NcqPebbxoop3e+cw2X6EYo4X+d4fL+J8Z5qWnV21kKVJHRsLzZ0yg0ImjV/o54gNEfhfU
	 SAco+psKY5J+6dXWFAW4eiAFYDwhYn2+ce2UAQQQ+z4AU6sAwf1o7Tqb2d+Ce0euM9aZF
	 OxDywt23aaiTwUGCLr4NlS28bOKX2s9xHfUanFcKMInRfUQ4NjtL5BSUx+GcUhX+6HfIq
	 vnBEuy9F7vK0Zw/LMBvUPFAqP6PPfafbkm16JSnTOQPdnmH1r9XBakrXdZ+H2skGUqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="C7/z8nH+";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBC606A69E;
	Fri, 20 Nov 2026 20:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8FBC606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=C7/z8nH+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=yA4q9BECD3fF1s8uqr2VolmeomijaxkoI3eekCtTSsQ=; b=C7/z8nH+0HfmQwcFK7unEvAKmN
	SeTiNaGaFqMIoySYzo2ZVh5UE9mqxstJuKFnwMyiTsBsNlX7UAt+WH1OeAkWzcYAIpTnkHVKyMQXU
	fmU04h7JlnVP7vHWTWvMBkFADiLmHF0/kds9h+9sq9/5OM4GjB57H+tuqHGxfTUk8W57iuZ4yxlu+
	ceSsDqtXeNCaPR540rW3ll36VmMAVj6dXJ9Wnyn9cYkiaPuGHrrk0TXxwJBm+F2N4OCY0/6HZQs4K
	DR/Ox2TbtYujjQqqW+AuGfOryJh/uhlaFaSscmGyGoSlDmSHPGUhxhbe3kmvkhMVOQAB6uUKiX91n
	tgV/lPTA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xUVZw-0038uN-2W;
	Fri, 20 Nov 2026 20:51:29 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 20 Nov 2026 12:47:08 -0800
Subject: [PATCH v4 2/2] tpm: Disable TPM on TPM_RC_INITIALIZE
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-tpm_unresponsive-v4-2-b9043735ec1b@debian.org>
References: <20261120-tpm_unresponsive-v4-0-b9043735ec1b@debian.org>
In-Reply-To: <20261120-tpm_unresponsive-v4-0-b9043735ec1b@debian.org>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, 
 David Laight <david.laight.linux@gmail.com>, 
 Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=leitao@debian.org;
 h=from:subject:message-id; bh=t38GlIRgFKOMU2hpAZQ/gqstw2UdocyRhcO268hn7RQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBrALLEWpxzMeEbITcb8NaWAYWaaMXI1gm0xHwyr
 dSDdM9cRLWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCawCyxAAKCRA1o5Of/Hh3
 bYL/D/wM0ZNd2aFDTOPWNujDC9oTP8VlmxkllGUjriHpdHoCoTchxLyQF9UA34vq1SViiEOXf6O
 q4T3vEfi5T7R06vjdDhOC4JOHN9LNO9j9OFl/ysCMpUCSRgnEv9qox0f3awSM9gfzG9CCtQZiPp
 Y0LSk3ntGl92rHCcn//ofluDcjXMasquKfWeVD+bI240r4KC1ZpS65m0OxNWAK9llswClBC90rH
 mHL98HKe9C09DO0ztjuln+3KbX8HLsLRNPjRaWJsLtIyUtYJOCGVMYrD8fYziqRPt/9hJaUzoh2
 ZQJoCnuvvsv5tZ+b9PHBrkWXMwwMIF6mL9lgPUtsDq6uHQMDwuClIpVC1D20LFYlzhfshBFTE5T
 90fCzBnaG5UbYSlIAltOz/DSpgsw+rZRymj/MOowfKwfAQFqrF0RhDxaiZgXu4PQSmTRTHwAlMo
 kbEgLE7Y/DYJyf1Eka31NskeaPotgX1aI4juIacUdMOYO24PL6N18sHFkTfKtj0+tuTD+ApiF0T
 PiozgViqnYPBPxhrLknP0UlAwOl5zGdjDMxrUd9t4YUShfFvfiesGlOZqjeGrlPqNy79+z0TFmh
 VapnzktVHqnE8Pi5tZcv+t5cZxGppNSswB3kHzL8V2qmSB0oiDwQIskNXgjjZ4YU+17Ff+XTvsf
 qVfcyLuluvJSvkQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

From: Jarkko Sakkinen <jarkko@kernel.org>

If the TPM has been spuriously disabled, the game is over. Let's reflect
this truth with TPM_CHIP_FLAG_DISABLE.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[leitao@debian.org: check rc before the loop breaks out on anything but
 RETRY/TESTING, skip TPM2_Startup, which a TPM that is already started
 fails with TPM2_RC_INITIALIZE, and fix the TPM2_RC_INITIALIZE and
 chip->flags typos]
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/char/tpm/tpm-interface.c | 5 +++++
 drivers/char/tpm/tpm2-cmd.c      | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index cb794cfc5f63e8..2ea10fd89a70f1 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -248,6 +248,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 		if (ret < 0)
 			break;
 		rc = be32_to_cpu(header->return_code);
+		/* A TPM that is already started fails TPM2_Startup this way. */
+		if (rc == TPM2_RC_INITIALIZE && cc != TPM2_CC_STARTUP) {
+			chip->flags |= TPM_CHIP_FLAG_DISABLE;
+			break;
+		}
 		if (rc != TPM2_RC_RETRY && rc != TPM2_RC_TESTING)
 			break;
 		/*
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 4b2bb2ddc321a9..65928ae85b496c 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -724,6 +724,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	if (rc == TPM2_RC_INITIALIZE) {
+		chip->flags &= ~TPM_CHIP_FLAG_DISABLE;
+
 		rc = tpm2_startup(chip);
 		if (rc)
 			goto out;

-- 
2.53.1-Meta

