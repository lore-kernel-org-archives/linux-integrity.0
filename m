Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207889;
	b=iupTxlsKRBBko1NzLjOje1GaqbRQreG6ynUiatDTM6DSoxJZaBiSptnnscSqgH0yR6nz
	 YdjAIuePoMmTB8ETE523MOeXLDMNvbESWMUADfXVkScAcgIzDQFIUX0GpqJyqiy/D8UTC
	 onjYVxS4nndiolzStktgIm2olxpGWz7eg6hTHxMl7YXT+cC4t8D/Go6P0Wk5AgFggV2JN
	 e33kaqzgBEIu4rxgiHYalCkLWEETTSr0Od5qQ5Rr7dWqPhRYj+22L3gfcBjVLjkf3m9GF
	 co9zwDxRjJTNxh9GSRAK/dtDSO92V84psF97PJUFkLe98S69g0ZTNdQOkAiuIqfBE0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207889;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=TJxydRvQkAQBYBtecCvgYzRn3WRFXzy09zHe7Li2czc=;
	b=5UkSK6CzowJ8T7iqdsnOgvACUPry87Zw9dYkXQVGCYSfKeGB9LoafBsRUDquvpy4J18i
	 Onw4s0PBJYlfh9hLaNsEPY0u6ZFQeszhxXg4UcGWEzLJa0Zl6vqVVD3ydNVWM1Q9Kzt84
	 5/msZ1ZjowO3K+/qBC/HPcZVdi8kPP7dCtIX1FoJ/vbN4+pN3E+oIDaFxl6+j09lG3ojy
	 4qppXUb4SQxYaIV5kAbg3NlYGuqNhbknOKrn2jh68NK7LXKrvK/QiTvcrtkamnq9RCTuC
	 qnJT+6FLlyZmLU0fjX3adjcagNBos3SYJG0RNFCfG5t+AbL/vjRXAH5c6bc8T7GHPPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=glicsDEq;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3860A2605;
	Fri, 20 Nov 2026 20:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF3860A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=glicsDEq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=TJxydRvQkAQBYBtecCvgYzRn3WRFXzy09zHe7Li2czc=; b=glicsDEqSSkWQaIyPKaj+hAVqL
	NaUdKQrbUtey8KrKTdIFCHOp81/z2l9qeM1sSPVNplTW8w6UreZagd4uFvwdpKzmRGBBjdEd2aYA9
	Hq4Xp/OArRzCgZ3Niim53pXiJksBHE0IBXQFDzrpBsSDCqLqimBGbg67JrTkiOYIkzdn+EFdULqlj
	oS1qu9agBu/xH3RC+/8Q1IhdKqAA+ZPYf+0J6+NwAx6nARgwwoBewVv9ZsYaNhG0hAlGNlmxJMWww
	B2ka/B8dLiRtsPbbNovT2BWXADBU0Dm54bcenRlWTo+MRGYvbuk2m6h6V0IaVKrvNCAG/7ELuqTcT
	7Qjx6bsQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xUVZs-0038u0-2n;
	Fri, 20 Nov 2026 20:51:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 20 Nov 2026 12:47:07 -0800
Subject: [PATCH v4 1/2] tpm: Disable a TPM that stops responding
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
Message-Id: <20261120-tpm_unresponsive-v4-1-b9043735ec1b@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014; i=leitao@debian.org;
 h=from:subject:message-id; bh=hNz7ScOOaF1XG+gXUd7JxuHsmD4p+69M6a24y0FGzII=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBrALLEZ7ciN9xXOvG/m6mBYmhrZfpJyhnhdklsQ
 ndkMjAcExyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCawCyxAAKCRA1o5Of/Hh3
 bVmeEACcC+fMbNAEifzc4vB0fnhHFMuwuj/M2wPUXbVDwOc9qRFADIruYgboKEmH0eUrdKc7jUx
 2JDm2oi0UMMCsRuUb6YhGqJzH0YIhUVSOWrWBf5EunN6o5xGE90z3aYzHU8s+4D77QzyyywvaQK
 VV6IsqdYBIU+Q5caGbCoZJu7eE0S8t/xnme2WXiynZ7VO21ECkx0pdZ50lGlC89xSPMOxdrwzD9
 VFmTOvrTxh4niJWkcx18b7j9YteuPoeguSCQzovC8CKCQXXqzwdHx0wGyGh2qTJAQ7sF/m4gg8Y
 DIkN9bM4MTq6OTIjNBut1RCa4qaJA6zaS2eAmx9+rb49keINrXEn9Gp0zQrzo3Q1GtNPPJN0ypM
 /xjNrEHpWzBpSCynFk02yzQJwG5hD+94+1MSYzJngUXttFhrhhEtp1rpiFJxCtiGCX3PMd9QM5L
 RjsRpJaeR5y8OSJcqzmsRVSQTWhEgYp9TTaBqivmrgv50TVNPS6tMeXY6HrBGP5f+0om7VNQ0O9
 axKc9JLzOn1i9K2L50arWdCdj+zprA1lEHepgRzP2Vz0v2vQ1r3HhAJWDML6kUM6jh2i4eKsj4C
 zZJcCGA5QDKt4c6I5CiGtsyZbsSV8PqGxyyuJwpt0grUPeeRZViOSqTMy2n1B+lDMUfZGSHkm/g
 ajElED+7s3XHgBA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Some TPMs stop responding at runtime, hours to months after they passed
probe. The first sign is usually "invalid TPM_STS.x 0xff", and from then
on every command fails only after the transport timeout. A TPM that is
already dead at boot fails to probe and never registers, which this
patch does not change.

The callers keep sending more commands: the hwrng thread every 10
seconds forever, and userspace through /dev/tpmrm0. Each attempt holds
tpm_mutex for the whole timeout and logs an error:

  tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
  tpm tpm0: tpm_try_transmit: send(): error -62
  tpm tpm0: tpm_try_transmit: send(): error -62
  ...

The core already stops using a TPM it cannot trust: tpm_try_get_ops()
fails with -EIO once TPM_CHIP_FLAG_DISABLE is set, which
tpm2_load_null() does when it cannot restore the null key. Set the same
flag when two commands in a row time out.

The first timeout sets TPM_CHIP_FLAG_MISSED_RESPONSE, and a command that
gets an answer, whatever its TPM return code, clears it.

With interrupts, the wait helpers in tpm_tis_core, st33zp24 and
xen-tpmfront return -ETIME as soon as a signal is pending, so an -ETIME
with a signal pending is not counted. Otherwise any user could disable
the TPM by interrupting two reads of a PCR file in sysfs.

Some TPM 1.2 chips do not get ready while their self test runs, and
tpm1_do_selftest() keeps polling through those timeouts, see
commit 4643826a3da1 ("TPM: Work around buggy TPMs that block during
continue self test"). It now clears the flag after each of them.

A disabled TPM stays disabled until the driver is rebound or the machine
reboots.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
 drivers/char/tpm/tpm1-cmd.c      |  1 +
 include/linux/tpm.h              |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e0385b16616b46..cb794cfc5f63e8 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/suspend.h>
 #include <linux/freezer.h>
+#include <linux/sched/signal.h>
 #include <linux/tpm_eventlog.h>
 
 #include "tpm.h"
@@ -268,6 +269,20 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 		delay_msec *= 2;
 		memcpy(buf, save, save_size);
 	}
+
+	if (ret >= 0)
+		chip->flags &= ~TPM_CHIP_FLAG_MISSED_RESPONSE;
+
+	/* Some drivers also return -ETIME when a signal interrupts the wait. */
+	if (ret == -ETIME && !signal_pending(current)) {
+		if (!(chip->flags & TPM_CHIP_FLAG_MISSED_RESPONSE)) {
+			chip->flags |= TPM_CHIP_FLAG_MISSED_RESPONSE;
+		} else if (!(chip->flags & TPM_CHIP_FLAG_DISABLE)) {
+			dev_err(&chip->dev,
+				"two commands in a row timed out, disabling the TPM\n");
+			chip->flags |= TPM_CHIP_FLAG_DISABLE;
+		}
+	}
 	return ret;
 }
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 7a8606e8c7117b..e4e1f0799da196 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -647,6 +647,7 @@ int tpm1_do_selftest(struct tpm_chip *chip)
 		 * until the self test duration expires.
 		 */
 		if (rc == -ETIME) {
+			chip->flags &= ~TPM_CHIP_FLAG_MISSED_RESPONSE;
 			dev_info(&chip->dev, HW_ERR "TPM command timed out during continue self test");
 			tpm_msleep(delay_msec);
 			continue;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c393..0f97abc82846ae 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -197,6 +197,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
 	TPM_CHIP_FLAG_SYNC			= BIT(11),
+	TPM_CHIP_FLAG_MISSED_RESPONSE		= BIT(12),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)

-- 
2.53.1-Meta

