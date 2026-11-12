Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486718;
	b=Rc+ekqqhxxCKJG++c6AhiBWhSYVjmX4GL0U5fJ+2V19VonnCWz4XhWMPY0uGpe8aFBLT
	 QeFylS0EGpKRefUbvMnfN8Im25e+sgylDc0UC67jqNwXMQOqzFiT8khpmNzPdOIiOdazB
	 1MyTcv2lz1vuWqhlBEufoqeJHW4xqd4sI4GO+tl3jqy4JZ1hQgxlSZcC3U+5WQmUjIpL3
	 aMCycsO/QpBykl9Ju01yeF5aA5yBOfASLmXuJJ3VYu8K+JFFllRXB9e+ATgHJf/XGBQ4W
	 FKRifBAsPeDNqVvGHeqMSpTGl6/tUwDj2Mx3794Vop6IYXALJRZxrH77XTuO9RigSsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486718;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=Rpeyy/GIznFRjlzKynCJz6ZoXdeEJu+5xi4c3nkqiRI=;
	b=BUa1xvZNrWW/MXOK04IhCD5ex9Cx3BmACNr43meJOPIy3FpY3ugnqdo3FtFLPibfGqxL
	 9c2rICEXYDNNaV/wJXJlxreytK25QRxuJn5vjGm5zZEr48ux3Lr/Ag8GQtfKCBHyK/V5J
	 y4oo4pE0OwJVcubvwWIwB/gbW5Djzc3bSAvWJQdQNnANB2j+4Dt4ire5tdt1GZrlHPGbg
	 MMT2AbsqQQI+EcttsSI8fmDs0KGqe/CYsu0SqzToqIVU5FyS+pLAr8ZBq2OGBJ7rUMAES
	 J6IvhwbnJXiFhT/IFsCtWrvtR/VJGwfhdF14AAdubQxSC68GOD3BBnoO4ZE8SnHr24g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gPnmUwHk;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440F606A89C;
	Thu, 12 Nov 2026 12:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A440F606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gPnmUwHk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Rpeyy/GIznFRjlzKynCJz6ZoXdeEJu+5xi4c3nkqiRI=; b=gPnmUwHkDEnEofKuQeq9hgB30A
	RQzco8XP3lHc0XXnP+2CBvpthG0W5pSDgReI19pmr59Vev26OxO8FPvE2U1N0/p+8GhQk6O37/8Yn
	5qVjzeFRPBs/Qjxt/7sQrQ3Xupqyr5o5AiTOz1vNJ7j/8MR+/ttNjAUKD63zreofBxVsAxBFy/UhH
	IjpVcchgH9Fm2RD8IHisjX4icO3TrnKdao2ZHA/+hp3EE0DBBwQeQnqvogBqS2QJS89UqHl2fSBLP
	eOw5TrJXY9XuEFh3jcew9WoeU7TDcEFVZ+txtVzCqpumJ/B5eLQEFtn1sqRdaz3ybrZqSPMEoWHhY
	GZlSGFZQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRTy8-00DyDK-01;
	Thu, 12 Nov 2026 12:31:56 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 12 Nov 2026 04:30:18 -0800
Subject: [PATCH v2 2/2] tpm: Disable TPM on TPM_RC_INITIALIZE
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
Message-Id: <20261112-tpm_unresponsive-v2-2-7454d2c899ef@debian.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
In-Reply-To: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=leitao@debian.org;
 h=from:subject:message-id; bh=70GLasvP5mc5EGM4TjI3WhjxR0dBNNop5jafxcSIF/s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9bGwwSXNc2OzTWlOkH8s48dvMlt9ir6LAQ3cx
 izW4ayVsGCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavWxsAAKCRA1o5Of/Hh3
 bYmMD/9I6//t1dCAhchfyi8UCOMxid21J/XAqFkiSheVefdOgoIcpohNWpg3sEXRROyvIAM1Pnw
 CvOYxgaUqThIjIQwhGDJHsH0nWmbT6p2+LnM4Dmf86Mgtisj5IxCkLeB+fFWWfW8LK5XOIgnRwY
 iUhK/I86qyxh3I47nYjuDJFyKtUDTwFEUloKVLw7ttzgDl4OYkYFe8ZSJ7BXBPmdez+WeR+kxDJ
 t7rD6wd1osSdXWM6fpQdC/7RF6ZPq+D7wlDyKdnDZEFiMSdCo2xmHYHbFvInd2vOERhhcN/fAFV
 TKuVKj7K5I2GTfxlZEkDuci045rtn/6MjyXeUUTIzLXSnsNCstvqvXJMKq5YzlAikQzLYP/HQY2
 tqfo1wLutrBmc1xZ5ulH1RLLjL58Ezf53mBpGYqWjr6llWuqW7F61rDJ9qDcfW+W8sJaySynbdV
 kQcKsOUnlypW1NF7mm2IttbscUXinWCEVNSa3PAkmal12k26kTjr2YbIGrFlcfge5dyYsJIxSJu
 z7N9NDR++4CCeZGWBwTtCWt3tsoiZZMaZu2HNKKK2Umh7YhJ8Ylp496qMi1C21hihxMH7Kh8BKv
 zFmKKYeSh8CsJQSA+N8wp/Z14rksws+wZDuxTtZRO4JpQVUZAijY4EoKXjPXssGd/PWLlO/R+P5
 eZeQPkQ1VIqVtUQ==
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
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/char/tpm/tpm-interface.c | 5 +++++
 drivers/char/tpm/tpm2-cmd.c      | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b7865ccb799289..144e2dbae66853 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -252,6 +252,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
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
2.53.0-Meta

