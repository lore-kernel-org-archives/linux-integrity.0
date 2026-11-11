Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391108;
	b=jdpt9BoaOwha4Znwvvm2Tdz2EMH3Ee3cE4Hs0v4qJjgYhl4QQ0Z8DGsxTTA7p+4aWQKG
	 fyV3e97nL+oxeK121xu2JtyCAXWoUuZM4tVjdxDj7579kwTwxEyekVO8S15Ge379jnbxn
	 UXaE724E0wfzrT8wPPkJJReiueQFPjZo6dEUQRVntLqHMKLx1xGCWs0nC+ep13T8ykTvc
	 9dqHFj/sNDRU2tdP/TfHi9ML7M8QntSqjtpZbx3052YgvcePbIgvGIfB6MMEaT+0eZBm1
	 kYZJkkGiJfPWi31YyxgLQLkATURtoYNRBfPlwGIA5aO3nWzO5ArKJfci5JpHBiAXqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391108;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=tGushzrFtrW77V7rVvL3s1nIofkTvVLHjtzLyoCHfR0=;
	b=YB2g0uH3ll+kjj7nxyhzSakRiqrr6p0xi/XEtJ8Xij/Gejt/5/f6fpKXxo1Dm0F61PnF
	 E31W/NP+ObOazqfxJ4nlxKUP/14Xb5NDtLJA++4aWNtiCm28XF+htG9tUCqiGZujlCXyf
	 ne0/HxtLZB/qUvksxW8Nlm1NNJrU6u1MYlSOcXk8n/XCM2JYuaEvyJWJ0hgnmbS1Zk1AJ
	 4ETOw+fW+8pMy8vwGiFI3KqxeatI2B1NG3yHrRiujl/OnybpDWXceObdSSbK9zGlTVcsZ
	 hUaJvEgQzIgrFySzHmcxL7HnKEsUuBYWmGEGaJpDKwcRZqpwhYotCXWkR7MK0SdUxCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="dD/jUv4H";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF5606A331;
	Wed, 11 Nov 2026 09:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDDF5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=dD/jUv4H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=tGushzrFtrW77V7rVvL3s1nIofkTvVLHjtzLyoCHfR0=; b=dD/jUv4HR7WhMkgCSpIrvyXvMy
	CdQzp8TivJzNsLmT2f/ww1N1E9Pf9BsaMqseJ7w2EyKldnuJNgpGPnmA3l4G3MgzuMG672gyiHzgi
	n7DQx8je9z7OMKes3Is0AAN607y35wMnjpnECI1irDFnOZrSAxUZVVjRcp/ll2Hc2ApS/4+kr3Wwf
	F1F1ShwvoeMBQubmAZrfrIOcTLSrTfeUUtNwc4unBeUWBQLuZzQTKggOkmHDAvoog/sT9npN4unks
	pBoHrlB3ZY/zL+BCLdMu/W0RWz+dbiTOB++rKkd7Uif7u1Ot5jYi7JDS5AzJrcEY+vx105WDBE/oV
	QNdV486g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xR562-00D6Ag-05;
	Wed, 11 Nov 2026 09:58:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Nov 2026 01:57:33 -0800
Subject: [PATCH 1/2] tpm: Disable a TPM that stops responding
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
Message-Id: <20261111-tpm_unresponsive-v1-1-42ac1b965eb9@debian.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
In-Reply-To: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; i=leitao@debian.org;
 h=from:subject:message-id; bh=8Km7/zIGwygrBCifvoU5JjUY37dEAbTHjT/QlxC2Mg0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9Dw6mXcwy7JFyMKMD/gGq1CRDCXJOX/lNYyro
 2mvMri2EgmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavQ8OgAKCRA1o5Of/Hh3
 bZFrD/98RXf5kHalz/1PQLMnbHU+hEOlg65ukjdVNPFplWDqK5hCTUZfkGdN2aClZQQrPwdbAqI
 RTWUBcYSmFjI2ejA236zenSJpuqYWTsEV6YyHhjk0uIkbMtAC4XfirgNDx1d07ElKfVuZ0s6WfM
 P+Zwiwmg0DI/sBdQpQdQPfSxxmji+bHG6qzDwzpu6W++70dq13JPwEjMOt+3Ect6V8BRiOGwtDf
 RjwK4pGtNzDzv2HBkRs61s7ghHyLUgU5V7E/edjZIDvuuz0917+Ipvw7SylExpJ1b7kKvB1Yzwn
 KohUgpWKLuUM0Ot8TjlulT4Y3xFgEwocdWXT7REFyec5tyO4v+cMZaT0Rr7axjbxrh2MIOYDs+Q
 0uzPGqgNVCob0toxzV+Xo4y0nyYBdTCaPSEBQPsKQx0yZtyZfPYloAkevy4LHyLKC9vaygFB9mP
 E2tCY3X2mAFkUA1BCwSGhE6GCkcrMYbwWWYNPiN7UvgxkAmi53++1Bvu7ZhQ5O7L4TuXqrjcAYv
 4RW32Pu4AtPuJnvg+XneKxGWAxQoyQGtzMHkV1SUtS/+ASW6JabnStg7ngtLSs6RV12xW44rObX
 XztVNonmw1oyJL9G497wak38ORCJlnXz/07iqiKXZXu5+bK3DeGZ7kTUUHeHxmYaMx34/F2i1TM
 0a+N2ssXZLNU+iA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

A TPM that stops responding fails each command only after the transport
timeout, and its callers keep sending more: the hwrng thread every 10
seconds forever, and userspace through /dev/tpmrm0. Each attempt holds
tpm_mutex for the whole timeout and logs an error:

  tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
  tpm tpm0: tpm_try_transmit: send(): error -62
  tpm tpm0: tpm_try_transmit: send(): error -62
  ...

The core already stops using a TPM it cannot trust: tpm_try_get_ops()
fails with -EIO once TPM_CHIP_FLAG_DISABLE is set, which
tpm2_load_null() does when it cannot restore the null key. Set the same
flag when commands have kept timing out for ten minutes, with none
completing in between.

A completed command, whatever its TPM return code, resets the clock. A
disabled TPM stays disabled until the driver is rebound or the machine
reboots.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/char/tpm/tpm-interface.c | 29 +++++++++++++++++++++++++++++
 include/linux/tpm.h              |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e0385b16616b46..c6278ef8d1095e 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -30,6 +30,8 @@
 
 #include "tpm.h"
 
+#define TPM_UNRESPONSIVE_TIMEOUT	(10 * 60 * HZ)
+
 /*
  * Bug workaround - some TPM's don't flush the most
  * recently changed pcr on suspend, so force the flush
@@ -206,6 +208,31 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	return rc ? rc : len;
 }
 
+/*
+ * Disable the TPM once commands keep timing out for TPM_UNRESPONSIVE_TIMEOUT.
+ * A few timeouts are not enough: some TPMs stall for half a minute and recover.
+ */
+static void tpm_check_unresponsive(struct tpm_chip *chip, ssize_t ret)
+{
+	if (ret >= 0) {
+		chip->nr_timeouts = 0;
+		return;
+	}
+	if (ret != -ETIME || (chip->flags & TPM_CHIP_FLAG_DISABLE))
+		return;
+	if (!chip->nr_timeouts++) {
+		chip->first_timeout = jiffies;
+		return;
+	}
+	if (time_before(jiffies,
+			chip->first_timeout + TPM_UNRESPONSIVE_TIMEOUT))
+		return;
+
+	dev_err(&chip->dev, "%u commands timed out in %lu seconds, disabling the TPM\n",
+		chip->nr_timeouts, (jiffies - chip->first_timeout) / HZ);
+	chip->flags |= TPM_CHIP_FLAG_DISABLE;
+}
+
 /**
  * tpm_transmit - Internal kernel interface to transmit TPM commands.
  * @chip:	a TPM chip to use
@@ -268,6 +295,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 		delay_msec *= 2;
 		memcpy(buf, save, save_size);
 	}
+
+	tpm_check_unresponsive(chip, ret);
 	return ret;
 }
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c393..4264c87a04d98c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -131,6 +131,8 @@ struct tpm_chip {
 	struct hwrng hwrng;
 
 	struct mutex tpm_mutex;	/* tpm is processing */
+	unsigned int nr_timeouts;	/* consecutive command timeouts */
+	unsigned long first_timeout;	/* jiffies */
 
 	unsigned long timeout_a; /* jiffies */
 	unsigned long timeout_b; /* jiffies */

-- 
2.53.0-Meta

