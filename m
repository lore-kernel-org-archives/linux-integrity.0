Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C034E741;
	Wed, 28 Jan 2026 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594163; cv=none; b=NF0wJTZMTpFRAQsFlqm27Xps3KZ4QgkZtamdYaLs39qje5F9wjCnUTdoNr2Vv4uVnep7wr0yLZObWJ++gZNK+bhL43VqbmhX4mu/nklljqIaxgvvJjhREsVL8TCHW8+4IjuhctGwa+/XQuOoEV/dE3h4E/JXlAc2C3C6hyjUEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594163; c=relaxed/simple;
	bh=mg4KK6kRphfn0fp0eq2b27K11ZtfAbz9mfXPYOWdMJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxEE/KBW6kNvFeBsTe0L3WrcklH1mGDV/EQ0AAupQ5rjmpDwXAJ/cPhUyvmM64vPIGQeEomgeCozeymsZhFshz8hzwzRRGN5yQasMJ4rlsxVguTneDN3MqjkZqLPe1mrDMfx/OtFvUITzeo2ovZbNPDm7ubF05IDnHoWiCApjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0TXBfhz9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5mRIb1Wq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0TXBfhz9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5mRIb1Wq"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUN1HTRsfp/pT32vkRCQTzRlDbGshc9all+/znGUtLY=;
	b=0TXBfhz9zrNGuPKGssPHl+AurLb7FeANVOozo6sJyW1CW2dMdAL6lEmpcar7l2+ZKC4J10
	xGilhusFxZrbptaY5y/jdW5NQtj95taZAasr0++PEfHErJUQkprsYhEMYMxKXWqOEGyqZO
	ZoUDvOm5kOffAT4YdfeSuAsGfPgkCnVxEDT/v8cZmiW3Y/qK+1CMQXTFdG/fKX2Mc9a+gz
	L6jlBPMbzKHiJXOeTbgLRvAQpTvu7xYNC6+kEf3oOb44zK0aoGNKvfi3Sw3P5B3m9A5xNo
	h+wVtSx5gugXKrtW/xKMoEP4K8Fu4A1bZvKLVK2ynPY4UGa8EczBaWoTC1YRDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUN1HTRsfp/pT32vkRCQTzRlDbGshc9all+/znGUtLY=;
	b=5mRIb1WqdtF/x+E2+5oEtz0uK6dcEQT41+86vGH+HUV6hIjrFhDD3b6F7t6bXOvxSfQryC
	LKTzprTpCHoLMhDg==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 09/20] char: tpm: cr50: Remove IRQF_ONESHOT
Date: Wed, 28 Jan 2026 10:55:29 +0100
Message-ID: <20260128095540.863589-10-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
 drivers/char/tpm/tpm_tis_spi_cr50.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis=
_i2c_cr50.c
index fc6891a0b6936..b48cacacc0664 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -749,8 +749,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
=20
 	if (client->irq > 0) {
 		rc =3D devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
-				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				      IRQF_NO_AUTOEN,
+				      IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
 				      dev->driver->name, chip);
 		if (rc < 0) {
 			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis=
_spi_cr50.c
index f4937280e9406..32920b4cecfb4 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -287,7 +287,7 @@ int cr50_spi_probe(struct spi_device *spi)
 	if (spi->irq > 0) {
 		ret =3D devm_request_irq(&spi->dev, spi->irq,
 				       cr50_spi_irq_handler,
-				       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				       IRQF_TRIGGER_RISING,
 				       "cr50_spi", cr50_phy);
 		if (ret < 0) {
 			if (ret =3D=3D -EPROBE_DEFER)
--=20
2.51.0

