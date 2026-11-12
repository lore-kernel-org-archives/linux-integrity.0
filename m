Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486714;
	b=vAcze/KQDldexGg+WIe1r9ejw+Qak/xfg8DShWxo1nde63/9paWz5TtzNIrkaNxbTg9E
	 qMi7gXBlnRsQMu3K7/E8IRoxZ38JJBH+OkeIFafibjARz+u9IIbjCr6G8cUjdpd+d5lks
	 dDKgOqhBYJC7qBv9Z1Ev3WxBdf6vJE12LLw5IegD9Pg6YiO7yzmgi0K9yUgVIxkBs3P2J
	 zTlDUE1olxSuuoVGJSMtP7wWKm8px4gn1ivCuhYrysq44d3anPSOaFS4iKK0n+TTBzLbI
	 8v520nd99AULfn3YXDpE6UKLo6Mv6HaIop3UKwqjNJgAVeDiYMZdTWm9n3sESYo5g2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486714;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=zqdkTJnLLRVHqzymtxi4ag9i/Zyn88Bu/jHNWO7k3iY=;
	b=twA4N5NZR8vDjduXnnDcqED0RN0Na4ByO5OIJrrRVDKFWiGEGcP7Cz6Ub5Iuk2pVLzF4
	 ZOSP4OYgkVEfKTw/yza+7uZfOwTXfvgp9dwE4e8VT9HnfYJoFoFDiRMjSOqfBdFcRuRF+
	 dyFy2KCw/s2T3y/5iSxNi9+KoLH4+TJrphB0XGG3VjznArIUURnXj77bs9JD77gGFkC9r
	 I/9yuJVPX01780ZkSlPzC1QZAAuHvffFYdewu+x+GGmFrOsW2CX86rG3Jl0fm1uimwOei
	 9t/9PhN8quuNgap/7B1qdmiKWcW5VI7K4W3mE7xlnK5PaUiHfU7afqrkl6stEHj9rhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=iqYhpoNa;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C41606A338;
	Thu, 12 Nov 2026 12:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C41606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=iqYhpoNa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=zqdkTJnLLRVHqzymtxi4ag9i/Zyn88Bu/jHNWO7k3iY=; b=iqYhpoNaxyIu/72MUlOeanxVKV
	CNCVMMoZqQCAlHUOPOBSfl5IZ7Jvj7Ch70fCLpPreBtsF4rdljeRVx6PFKHxbQTW6ZaaNZUXtRk5Z
	rqdXA/hGmCFjQHy5fWnAnI0QcQzreJXwhiQLP793EjKELMBSrFG2UfE2F9p2XvuJeODi3kupV1hNO
	Tyb8rwyArNTzVLy0oOXXgUgl2hUpohUqk8B1kDkrrtdWYuZh7ppjJlw70MWMJeuCfH281V4qjis1I
	LhlzFf1M2u+c8ppApskIWjqj4NSfWpO/7OPccMPVe5Oj8S8hzOh89TViQsC/sgQ+4ptUaR9GEFCqO
	Hx++ErJA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRTy4-00DyDA-0z;
	Thu, 12 Nov 2026 12:31:52 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 12 Nov 2026 04:30:17 -0800
Subject: [PATCH v2 1/2] tpm: Disable a TPM that stops responding
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
Message-Id: <20261112-tpm_unresponsive-v2-1-7454d2c899ef@debian.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
In-Reply-To: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; i=leitao@debian.org;
 h=from:subject:message-id; bh=LZISX2BSPEGQAo2UtLJTF39lzk7RskU0tpXXGGUqmmk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9bGwoaNeOJRFKG7goXJlb2SC7xRBXPLE0Twb/
 p039DfUuY6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavWxsAAKCRA1o5Of/Hh3
 bVC8D/0dNZP0vmWeMowkFDTWX2LZyflTut5gyLzgsvV1TFN2thr5B7ObBmT73AZKeRMbtZzTOYi
 ZyuwRib9NioHVBC5Gh6XtCwoqmW7jG2XmgXE8Y/Gej6vhzI6MBRhtwaEsxLqaTiKou4npjjjNqA
 ibZrQvQul5BTk6XWDYP402y8HIRTwP10QPZ2iAAb4YvZpkapvVIHAYOARoN5mu9cZ6x0m72If9m
 92g9qbX0HphgvFMXFfRS8AfDsp/2bMHBinb2Vbtb21BrnVoud64LHxY90fqTfFQxN99ETby8opr
 oTO5bLIeK6hnCsECZLIwz2tOU4AhSF1cinagVdJFYldZSeCbqT4cV2HhGJVVmO1emm1TiuT0q5W
 M/HfC4FHSt7tz+cvSzcafA7a8CJxDSEj7acehKUJZz5hejxxTZLSYS5gP3o5nWtasXOFwdaeqhf
 u4c8BWuw2n6jQgz9te9tMLbfvXhPdB+ce9iJdtAHZ/aRRE8Kkh7ZjVihmrbbXiF5G9Jl+ev2YOa
 NQcm6xplr+MacKK9Pf70BFWT8Z5U/LfHIjfju+82nwYL9PF8MgkpWiCn4vn5k+VOyRLphXW7zLG
 oQYWvwxasTJblLk2bkaeYE1bIrldcnQCODtQ/EGSGm7zGXXbNKRkpNUN5VN/br6pDOIwBDt29bf
 zKPjZO5fGJfkJBg==
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
flag once 60 commands in a row have timed out.

A completed command, whatever its TPM return code, resets the count.
Some TPMs stall for half a minute, time out a handful of commands, and
then recover, so a short streak must not disable them.

With only the hwrng retrying every 10 seconds, 60 timeouts take more
than ten minutes. A userspace poller gets there sooner, but each of its
commands still waits out the transport timeout.

The limit is the tpm.max_unanswered boot parameter, so that slow
pre-production parts, such as FPGA prototypes, can raise it, or set it
to 0 to never disable the TPM. A disabled TPM stays disabled until the
driver is rebound or the machine reboots.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
 include/linux/tpm.h              |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e0385b16616b46..b7865ccb799289 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -40,6 +40,11 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
 MODULE_PARM_DESC(suspend_pcr,
 		 "PCR to use for dummy writes to facilitate flush on suspend.");
 
+static unsigned int tpm_max_unanswered = 60;
+module_param_named(max_unanswered, tpm_max_unanswered, uint, 0444);
+MODULE_PARM_DESC(max_unanswered,
+		 "Disable the TPM after this many commands in a row time out (0 = never).");
+
 /**
  * tpm_calc_ordinal_duration() - calculate the maximum command duration
  * @chip:    TPM chip to use.
@@ -268,6 +273,16 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 		delay_msec *= 2;
 		memcpy(buf, save, save_size);
 	}
+
+	if (ret >= 0) {
+		/* we are good, reset nr_unanswered */
+		chip->nr_unanswered = 0;
+	} else if (ret == -ETIME &&
+		   ++chip->nr_unanswered == tpm_max_unanswered) {
+		dev_err(&chip->dev, "%u commands in a row timed out, disabling the TPM\n",
+			chip->nr_unanswered);
+		chip->flags |= TPM_CHIP_FLAG_DISABLE;
+	}
 	return ret;
 }
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c393..e8191585a68e7a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -131,6 +131,7 @@ struct tpm_chip {
 	struct hwrng hwrng;
 
 	struct mutex tpm_mutex;	/* tpm is processing */
+	unsigned int nr_unanswered;	/* commands in a row that timed out */
 
 	unsigned long timeout_a; /* jiffies */
 	unsigned long timeout_b; /* jiffies */

-- 
2.53.0-Meta

