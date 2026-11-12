Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501923;
	b=yLgWcxS9DtPcc03HF8espAa89PE5/DmIiNIr7N3b1987W7e0JIZAR6xNjd0SQXgqWrxU
	 7Vj36sEm4lSLY0YcF2S3gCdWGqx4VRc9utGtXu3vS0gJdXJpfVBTLT6X9nVYTeWYAgZaJ
	 gSy0zD7CzY4eyg8vho5DVkpVywuEyRzyQX5YLfJuZ9dfIQr7l7eCpiBCIuDWyT8h3macR
	 SIM0fiPMHAwbgn3N+w2QfXku5WgQbUhtY3KSbNZUDkYN/tewgLv9BUVVmoun8vmju0fJb
	 ATAMvIv0PhM04eK5KCrdm4k2JWMbNeUG5rJnNA411ETrnFNwpUdePmsSa+dpbctTP9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501923;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=nPlghjJQHTi8UZkaTa1+oXme21voZk/Qt9DJCI8EY78=;
	b=yvZhrwFbKSI9u1+xsUqyrYu1RjTuYKHl0CP1eaIfC1mna2p9qRwFECl0ZhqKP+5NeunG
	 pwHepeIi3FiMo93S84rY1mZxVi2drqQDgLGYxUH5IuLpC1ivKzVG3aieFVZURlRmuMbg6
	 UVlj8rpaDy4wJi6Z33gtolF5QqKb7d3eyXv+4dexJIcprYsjKXc8TflXgTerY53v8Gn7S
	 R9Z5TfVNNJVL9m+oC5r+DBTDKc9S6wHRqEdy5hjBFTcwrIA7Mhl7ocVCRLk9qsYTW3ctE
	 54YiR4mqyKEnzRDaPQDKYKvAHW1lf8sM33nFxu+4hQ52ThuqOme5hvCsOXKLR75l+pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=OHU53M1U;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E9606A31C;
	Thu, 12 Nov 2026 16:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE0E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=OHU53M1U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794501922; x=1826037922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nPlghjJQHTi8UZkaTa1+oXme21voZk/Qt9DJCI8EY78=;
  b=OHU53M1UpQRuEYm5E2B4g9JjmQyrZ+FHfi/25firyVGBuIDUCMu0HZRz
   aB06S5QzWjP5MorjDacCAadzw4Mgsw3uOIdQd4YP8RGGfN6+U1+tEG2Ag
   D1X7KufErPk7RQCs+e24a4MQWfHzMhXTxCmu07ppxkNqAB8W6WSgUEWQe
   tB1gxBTrrIVFpf+euM39nrcd4gvSN7Xm4Kxc55IkGbuUqbI3carIOLUmF
   HTXfmM0YF7p9Hjiuw1HHSmnyyUAeNLGMtc6Kx+9X72J0HKL5DYl4taesp
   clzN4P9AKPXZXTvYvtokaN9Xs5uhiRtHOoc4KUVfCkPhgpeDe2aVwHa8U
   Q==;
X-CSE-ConnectionGUID: JDwR471zQzabr4MaEeQ0OQ==
X-CSE-MsgGUID: UtJ/A5JnR6+JRy9R/07xJg==
X-IronPort-AV: E=Sophos;i="6.27,210,1787011200"; 
   d="scan'208";a="33343637"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:45:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:13743]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.127:2525] with esmtp (Farcaster)
 id 8c8c2008-3ce1-4ff7-9460-e60988eeef12; Thu, 12 Nov 2026 16:45:21 +0000 (UTC)
X-Farcaster-Flow-ID: 8c8c2008-3ce1-4ff7-9460-e60988eeef12
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 16:45:21 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 16:45:21 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Jonathan McDowell <noodles@earth.li>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [RFC PATCH v3 7/8] tpm: Show timeouts and durations for TPM 2.0 chips
Date: Thu, 12 Nov 2026 16:45:06 +0000
Message-ID: <20261112164506.83817-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112163846.97654-1-surenkj@amazon.com>
References: <20261112163846.97654-1-surenkj@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The timeouts and durations files exist only for TPM 1.x chips, so a
TPM 2.0 chip exposes none of its wait limits, even when tpm.limits= or
a driver's ->adjust_limits() hook changes them.

Both files read the limits table, so add them to the TPM 2.0 attributes
too. A TPM 2.0 chip reports none of these values, so for it "[adjusted]"
means that tpm.limits= or a driver's ->adjust_limits() hook set one of
the shown values, or that validation changed one. TPM 2.0 chips get no
device/ links, so the files are /sys/class/tpm/tpmX/timeouts and
durations.

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 drivers/char/tpm/tpm-sysfs.c |  2 ++
 drivers/char/tpm/tpm2-cmd.c  | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index b289a7f6f085..6bfc366fa120 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -340,6 +340,8 @@ static struct attribute *tpm1_dev_attrs[] = {
 
 static struct attribute *tpm2_dev_attrs[] = {
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_durations.attr,
+	&dev_attr_timeouts.attr,
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 629caaeffa17..8cc1a262d668 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -41,9 +41,26 @@ int tpm2_find_hash_alg(unsigned int crypto_id)
 }
 EXPORT_SYMBOL_GPL(tpm2_find_hash_alg);
 
+static bool tpm2_limits_adjusted(struct tpm_chip *chip, unsigned long mask)
+{
+	const struct tpm_limit_entry *e = chip->limits.entry;
+	int limit;
+
+	for_each_set_bit(limit, &mask, TPM_NR_LIMITS) {
+		if (e[limit].src != TPM_LSRC_DEFAULT ||
+		    e[limit].flags & TPM_LF_CLAMPED)
+			return true;
+	}
+
+	return false;
+}
+
 int tpm2_get_timeouts(struct tpm_chip *chip)
 {
 	tpm_limits_update(chip, NULL);
+	chip->timeout_adjusted = tpm2_limits_adjusted(chip, TPM_LIMIT_INTF_MASK);
+	chip->duration_adjusted =
+		tpm2_limits_adjusted(chip, TPM1_LIMIT_DURATION_MASK);
 	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
 	return 0;
 }
-- 
2.47.3

