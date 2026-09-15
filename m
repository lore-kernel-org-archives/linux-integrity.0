Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B74432A3FF;
	Tue, 15 Sep 2026 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503191; cv=none; b=kkc91RAlfJKEXIJWJYvYesCz2XT5J3KzIY3bsu4WLL6X/g+9BaFMHiW+RL70f+Yve28Cc+NOWDlwIkxM34gk+mbte7+iMVQwsEiULMFih5ScCJ4/iqDzDq27oBfRKmlsSXmR80TYhJ5cSpxgPb4NXPLy49wHmLq31qnGJA+qvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503191; c=relaxed/simple;
	bh=uc/8NnONKrKUxjve2rABJEqCKHCs3y+XO7Ks/uWOquU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIutUuoMgYfnmgBRAKsvZ8yaIE0QnRp1fknq5Wh9bez1/I2yv7HqXEsjuysK3TUONbNrzHesoL+pgWfjud6zoIsf4LLpqaw348I41McvE0rrmQL2dR0fTx6YxmPe5XwqD3hR5hH1kLoMVYs73UJBwvh7FCPutmJsio6bibIJWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPyYroCp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPyYroCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFA81F000FF;
	Tue, 15 Sep 2026 20:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789503190;
	bh=9yc8cUIMaqEfpF7NC+KldhtyOqvSD9yCa8UuuG1fRCw=;
	h=From:To:Cc:Subject:Date;
	b=jPyYroCpMliCSAo/PySJxofxeDmBn5LJUHQHDV6jBoKdV7v+Br0Uly1XKyuXHFfbL
	 jgQe3iMn3nJm7GEOmeb1+KshbSvQcsWojvqfODJJMb2ZjneLwmBBk9YnO4dVJODe5/
	 RqHKBV6BdJChEZwVXwirSCwO3maO7vu7ZBlYGSpcvjeIp9KdAGCV0DDL+rSyT1jVqL
	 fW6D2gKux5xGc07es5tdKwAtoZil488CvhAtFu2bItRO//b0Ceof9jdwjZEpZPjE8a
	 5f3yTm+JKlOXtmgpEoGT7lVPznJysEV7TJOV7Jhq4QW9YtumH7jtjjFjLn1OoP65vg
	 Dp+IIT5ooCitA==
From: Arnd Bergmann <arnd@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Li Jun <lijun01@kylinos.cn>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: remove extraneous #ifdef
Date: Tue, 15 Sep 2026 22:12:58 +0200
Message-ID: <20260915201305.3529682-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Changing to DEFINE_SIMPLE_DEV_PM_OPS() broke here because the
tpm_inf_resume() function is hidden in an #ifdef:

drivers/char/tpm/tpm_infineon.c:615:61: error: 'tpm_inf_resume' undeclared here (not in a function); did you mean 'tpm_pm_resume'?
  615 | static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
      |                                                             ^~~~~~~~~~~~~~

Remove the #ifdef check.

Fixes: 2249200ee420 ("tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/tpm/tpm_infineon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 84a0d3e5f679..d6edd2ca39a5 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -594,7 +594,6 @@ static void tpm_inf_pnp_remove(struct pnp_dev *dev)
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tpm_inf_resume(struct device *dev)
 {
 	/* Re-configure TPM after suspending */
@@ -611,7 +610,7 @@ static int tpm_inf_resume(struct device *dev)
 	tpm_data_out(RESET_LP_IRQC_DISABLE, CMD);
 	return tpm_pm_resume(dev);
 }
-#endif
+
 static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
 
 static struct pnp_driver tpm_inf_pnp_driver = {
-- 
2.53.0

