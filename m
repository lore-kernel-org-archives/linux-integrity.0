Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391112;
	b=GZTjdHJ1zy9xF8l6+ASxw/PIZjtFNbFggR4VngRn0xGhREZMl384liKUMvecSqpVBsDc
	 dTd7Fnmr+ul36KM6mXGAZi2H3HcLTjvAWQ3BIfXjh2GFQXfgfhkTbdKXmFr+w/y2DDLI8
	 AFeSgxGRXZgaUmnb1k0yHioZUwGxOx2KCCQhD8xZH3IeIEudA8ZjIZygsQH2dxMwHxP9D
	 lUyHOZ4G/FkvmzkdWnRJTuWdNmRYn8Lr4v5WzHfVxUosB0AZxRgarGnmRtLgOSV19ZiJP
	 1ySxK8mP5rfwr5wD/KQMQDPZoetkMI4sA4q6CBNTXpQkIk4TFDa6RVVQlN6aIBTLO9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391112;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=7qBqijEg3j5itL5NDjhxpRdtP7gusIM2gmMrcRmtQxI=;
	b=20RmIj+RfOT2x2/9YkvkFB/kytHYA8SIlEIjJtgt6KlPiDM3pb1waHF5FqhiUGDfhEKX
	 dwCUaIZrwOw7JWzS3mYUjfJ+sy6J0ntq1cEQmnxFpp3Pn3tz3V+0GFeIKmXut0O+SezgM
	 0PBImA93QzJJs4x5JqShkrL90kI6yiGpCeBucN2T0n84dImeb8qGmyuThWJYJCLhRE2BV
	 /eYCLOUd89r6MDn1Vu5plm5g+XzVxyOVdvHSayhSJVNRi5OSMVuIzez0qbmu0R30ozclx
	 OH59xP3vWBnjeo66ie2o6v0t4hwMTRb5Hsl88eO9Mjlm/fsj9wPz5lil0ALbHUcmvNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=bQf4fdnb;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281A606A331;
	Wed, 11 Nov 2026 09:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0281A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=bQf4fdnb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=7qBqijEg3j5itL5NDjhxpRdtP7gusIM2gmMrcRmtQxI=; b=bQf4fdnbJPHep2hoXXtpkKYvBn
	bp9mEP/pS2wX7uQUf7HhOzrEdYThhEYvSEX33s7arKtv92v0oyaJtbeaPqTWewacYFq/TjJaUp8ag
	vMXmjbPSDRVfJs4H8Oh3rtPMUabFiZ9v0v/vC6i7owDjUHP0M44vAxlbNL8RcEasLSSwhWT3WxI0Z
	ou5N6p5iBdjLOHgTxKgYurJiQ2YAlrAiT9xRhVl+/YNZLmdQJEG/bMOefNhxoBxyrsqiJrMO/+X6W
	jh1SWy6cbt7RHh8bY7TFuTQ51bHu4J4UM1l8IREe052P1f5sWGsQHfFxGZ/7HkgdgrJ0JJGdtqbdr
	I6KPnnXA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xR566-00D6Av-0Q;
	Wed, 11 Nov 2026 09:58:30 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Nov 2026 01:57:34 -0800
Subject: [PATCH 2/2] tpm: Disable a TPM whose hwrng reads keep failing
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
Message-Id: <20261111-tpm_unresponsive-v1-2-42ac1b965eb9@debian.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
In-Reply-To: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2655; i=leitao@debian.org;
 h=from:subject:message-id; bh=smou7fUGe3NRb6a1h+kZU3AB4shLYZ9dPaGLC8pnQzw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9Dw66TawD4Z/0NUvVIZWwOkxC3+hxyei2R89B
 z8jyvVfQVuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavQ8OgAKCRA1o5Of/Hh3
 baJGD/0QH6odvOY+bXjc7t4CSBu7W6JHpamlsiEzqBDKIYc80KA3qFzKd86b4E6pxfiJjcdvcvq
 L4hbrOP7so2K4VWNNy4vlRvML+PcWSUThCwJy16aQRC/fA5kn5axNcj4sH+7Vq+k5jsPJvxz00q
 FkSfLU7b+eV2m5+D0j4YtdNo1mn6jVMCOnANmqFvm0bWBs336krMVaGcQM96MZDllk6OJeKGbzo
 BdEYvyyki0ENYhhiuS5ffIGdSpbKPMoIkHeK3yaMaiccMtLnS8q40bABC1C7BzC4aq6a00xluY8
 pTgjIXspYKuqvaRpJKaqiYuIkOpFUbTcuBXtbHsJlXdk6vnrHzvcvnOTXvZ5/Ima81KiWAunMuf
 ZApnYJX0B1efKi/nAFarpy6BqvdD3RaheRswNYGWjmDu3ZsJ3iwBQUQjrOtUKigNgEotcFDlaq9
 OKycfEoxVDT/gOieWL++iSGj7XyuYjPDrFyR89Vh6GOmQXaX+t0oBV7O7eQfowyvoadBbB7mTRf
 L2Jg3APt+b4AkjdX4o868E5ZXJvE0X8XXL+cvSx2uUayKJ7wCFz+MvgxzQ8SvzhrKs/Pooq02zs
 p0U8RY6CPTK3BKFaiidx40cYYk+HKHW1sJGORNzQjuTsJ2nNasWXX0+ZAFhl7CXxT6IpF3tAMHl
 L9sA0ntl+pKo33A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The hwrng core retries a failed read every 10 seconds, forever. When the
TPM keeps answering GetRandom with an error, each retry logs a line:

  tpm tpm0: A TPM error (256) occurred attempting get random
  tpm tpm0: A TPM error (256) occurred attempting get random
  ...

Neither clears on its own, and the TPM does answer, so the timeout check
in tpm_transmit() never fires.

After 60 failed reads in a row, ~ten minutes of retries on my system,
set TPM_CHIP_FLAG_DISABLE as tpm_transmit() does for a TPM that stopped
responding. Later reads then fail in tpm_try_get_ops() without sending
the TPM a command. A successful read resets the count. A handful of
failures is not enough, since some TPMs stall for half a minute and then
recover.

This also takes the TPM away from userspace, which could otherwise
still send TPM2_Startup or query the failure mode. Rebinding the driver
brings it back.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/char/tpm/tpm-chip.c | 20 +++++++++++++++++++-
 include/linux/tpm.h         |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0be5dbfaa72ebf..d94ea462a5ef0c 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -466,11 +466,29 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
 	return 0;
 }
 
+#define TPM_HWRNG_MAX_FAILURES	60	/* ~10 minutes of retries */
+
 static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
+	int rc;
+
+	rc = tpm_get_random(chip, data, max);
+	if (rc > 0) {
+		chip->hwrng_failures = 0;
+		return rc;
+	}
+
+	if (++chip->hwrng_failures == TPM_HWRNG_MAX_FAILURES &&
+	    !(chip->flags & TPM_CHIP_FLAG_DISABLE)) {
+		dev_err(&chip->dev, "hwrng: %u reads failed in a row, disabling the TPM\n",
+			chip->hwrng_failures);
+		mutex_lock(&chip->tpm_mutex);
+		chip->flags |= TPM_CHIP_FLAG_DISABLE;
+		mutex_unlock(&chip->tpm_mutex);
+	}
 
-	return tpm_get_random(chip, data, max);
+	return rc;
 }
 
 static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4264c87a04d98c..402b5160db962c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -129,6 +129,7 @@ struct tpm_chip {
 
 	char hwrng_name[64];
 	struct hwrng hwrng;
+	unsigned int hwrng_failures;	/* consecutive failed reads */
 
 	struct mutex tpm_mutex;	/* tpm is processing */
 	unsigned int nr_timeouts;	/* consecutive command timeouts */

-- 
2.53.0-Meta

