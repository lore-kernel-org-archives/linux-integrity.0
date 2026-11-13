Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566374;
	b=CzOfR1L3NsJlIwJ7DgvikJ61SDnSyV6R/I/n2F0kmnsx9nS/igMNSRlq7suFcg28jaRF
	 EfH7qwZfYgeXO83sDMnpMxsbE5xf5sV2wDnATPBjDvzaRptAUmbdtTFF2+UfBIx3WSI02
	 u7TtqNRzLItzvkWlld81DE3gf1lEp1xWyA3GzPoznzBztADD0AmpRxVmnBavUBziyku28
	 oUiUcNaaufJhQbCHt3L+KnnJHyy92bW6uQ6bDanDSTSKK3jCMAOwkd1ZcCTTl555rH0e4
	 bt420OzU54xvYWjrJPGLZBeqCFC1CInsWiaa7V0DjHCsP5KV5bGiZXIimYxJgIMv8UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566374;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=CVxi1AYHWuIcryjMWNZ6qdSREDmPih18Eo6xn5fFjlQ=;
	b=WA5w8nOpmKIMSFWemVRhcIvCEXOH7rbKdaRtVRARwm2Sn3vPfGMfX7ZiSU5KCDDw07lz
	 VfIP1fKN1ii4wrbIFZLe3lr0Mvcg8boceHCnML2MTmfz9FcXKnG3sEW7X5PH9M4b3LENE
	 1wO5c7hENNGtVhWUUKlH4x3e6okp+1lBIH62PM8UiII0XiDLySLTXbz2QquZtPf3fMh7x
	 OFAIwMIJ0G/rLVC+TXaBwxyJCQP0c/+siC4k1CpuKiSnseOlCpIj/Ktv+6vSNyuJ3hgqI
	 4H9Yd/8ZObOQiwXqCqdCe2r8JlK90SiOcXDbBcFiuvCarOb6PJqBpYiVkBsS+sTV3Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Gi+Ky9Ya;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF62606A89D;
	Fri, 13 Nov 2026 10:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF62606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Gi+Ky9Ya
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=CVxi1AYHWuIcryjMWNZ6qdSREDmPih18Eo6xn5fFjlQ=; b=Gi+Ky9YawitWxcWOlBIbMuSK2D
	4v5EMTWjdl+EjDU90c3zgtVguCbZB4/IJWtiVjS9E9+62KHGHmKYBxCmffQf8KJTIYtkV0163bgXU
	V1FqmjNCQFKP3Ho0QbcKnFd9sJ+d2E+XcMM3EKZ39DZmA0hvRfWT/EsfUxTM2aVolfIMzQEk2By6g
	eN5lw1ujx1x5Fecxs132SyZGBI2eLVZMj3plfVQhET4IDACtYhE32RvvYWTl8y93wUT+n2fCSHWmz
	+bii/JRYclRuH9GXwj4H7FiXsCORkWz4vtko2Pcte6hkcZ+XzGvpSwLqUFFMQqlCSmwpCp7gmA0GH
	R/paTa+g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRogu-00Eh0y-0E;
	Fri, 13 Nov 2026 10:39:32 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Nov 2026 02:38:59 -0800
Subject: [PATCH v3 2/2] tpm: Disable TPM on TPM_RC_INITIALIZE
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
Message-Id: <20261113-tpm_unresponsive-v3-2-8138c8e283b8@debian.org>
References: <20261113-tpm_unresponsive-v3-0-8138c8e283b8@debian.org>
In-Reply-To: <20261113-tpm_unresponsive-v3-0-8138c8e283b8@debian.org>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, linux-doc@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=leitao@debian.org;
 h=from:subject:message-id; bh=aEJVxTYLdJtovgrgov2gP7g819h4QzOhdaoHNgxzJZc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9ujV+VjVyR8c5k+l33iUFgncNXOMPh9fCgcpx
 bQsULt0AYuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavbo1QAKCRA1o5Of/Hh3
 bbzvD/9l+1xXuDdrFKaJjAr3eIhBrzA/Wl4rks//zufV5u7MQTaNvg99MW2wM87X57oDPgPoVdz
 UU3aPsvA0x32Xs7C6GE9kVJTkjthA+4jUvvvs9gHpMxj9bId7mNpFu88wpPdcGiB4vEaPNcCg/n
 wYp5lDH6TXGFVlG85Llvi7uJDacWR0H/H+d04pXfuDTHINjdvRYHaNvaKW9V5abtmcFeQmvlotf
 n2bWo5GxwCmi/4xerV8JaWje9a53Awm1PruxLUlHVQuDCDGZv7yV5JcDAz/U118UB5tdE8zP4lj
 4LI5WLAB7tJ9AsH2R2cTrD314IvqC2dovyQsrFBQRkmXQDjNa/j9fRzPtDBHyv/lro7X8iWDDyb
 42zDZZkMtUvs7e/GiHD1WRJdpPmNDMbqvCSOFTL6eMU6b3CHBCtbBcfQxFuWvLVWMdwzt/V/Rcc
 rI8N2WhHL0r8XyiKjERqXqOqbO+H84bSeXg9pl40cUnia7v5EJI7z15UcDaKmFIhQ7A9WuaZeaT
 MvTTM/DDBCLxhjxNNof34io/9ETnVw+6KN19aPr4c8lHh4h3/xXuI2zd5hzc23h4FBGt1Fctlc5
 iiZz8Go+rwGfuH+AF8X8g5xJh6LpbV8vldJ8Y4Ok5kPlEPfJ+65YowXujPJSLtFcUOvJBy7YNRZ
 cTTKABY1k0ZQT5A==
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
index 977e205807033d..dd6bb518ab7d9c 100644
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
2.53.1-Meta

