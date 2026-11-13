Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566370;
	b=47AJ82gB5U7sIIOXQ7caDDIDr4rhBZexDlyjSmzXiTgfsvbKBmXl+BIPWvYSU+xWPSmT
	 pYOIcDL7YMLIKI2TZl5a3s/Kt+R1YQhWpZXvpo1RAl10AyN0HcS4jFKIR1ersw6I3JPxV
	 mjpJep4gNM8ZK9nyNkOxpPcaggfrMhAhWCEGtiFPrQ93mgVlG667FLg3pFoGbCiSOlpdx
	 iFq8zykOvWxjFYzaJDIXzBHsM5a2aIHW6IjSYaV/W+F54Y+X/BkBhfqU3xzTAqDqfzzX8
	 QzVhiazilJbWWsB0oCcMmb0lK/g4Tsniif6JT5rj4TkubOl8gCprMyTmbIlrknvqIDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566370;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=9ZUAowP2fy9INAg84Ut9Hv51u1Z3Zuobmrp2q0z200s=;
	b=3vLOye2Qivgh4IUFk+i/qang4gvQ+TEqjLrXTGWmCgwiHk9zKDKIse2ti5n1XHzDb/GV
	 C7jQCKMMvqfh9HhK6qIBdiDxhSrMYGYW1T57HqlUDw6xwyCOHjDRAzbE4kSDAa2E2OhEI
	 YghdP3RRG3UPm/JjvAwlWOyr99s3yJND0T2m+AxXoHJsZt6HXEkZhCNU4CAuP+UEI3Tb1
	 c5NnzSA1D/l4iwVY4GsasRRexyE1jfw8gH/p7iixwynWQZ0pWRg0nAQZagbFCd1KMkECr
	 AeOFCXbq1Gms6V3BqIEmnDQ1P8R9oHeg+0zFBWff7TXC9Rx+gcpGc3NwBJ+z3M4etug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=OmU6Yxz+;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECB606A32E;
	Fri, 13 Nov 2026 10:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BECB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=OmU6Yxz+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=9ZUAowP2fy9INAg84Ut9Hv51u1Z3Zuobmrp2q0z200s=; b=OmU6Yxz+cq22/tix3LaKaixp+w
	HoQFQix1I/BaCqAwMXDVowe/5b0Wh5ikRuSq5LLt/mASaDopAK9NweEkvOeDQ2y/BYmqMcweGdHrZ
	f2+eV+hHB3pk8t8r6z3tL8pqLU0bhGsslsoq2FvIXUhzbK4Zj7EEgpamt6zsKUk9JY7PAcfGrGHqj
	pIt+QglFPnyzDJoM4/l8BMFKb+DdA+0Q8w1mXihCmtTrBp/QT2JYqyABC4iD97nHOOwy9MhrtiQTF
	IW4UEtI9fTOnIahvYb/RyarQy2Lc6jgbiGgEXF2QsrjsbEUAPluKmzTLPomiACN3tmJVBoS5flLOi
	YEqw+KjQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRogp-00Eh0l-28;
	Fri, 13 Nov 2026 10:39:27 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Nov 2026 02:38:58 -0800
Subject: [PATCH v3 1/2] tpm: Disable a TPM that stops responding
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
Message-Id: <20261113-tpm_unresponsive-v3-1-8138c8e283b8@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4246; i=leitao@debian.org;
 h=from:subject:message-id; bh=yxkP0tM4xtvx5hwkF+43zqqme9LaI0egFez/l/6j/YY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9ujVhAoF+E9+N7eG8ysKcInhJLh3kmdVqcant
 Yzg+Ja4OImJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavbo1QAKCRA1o5Of/Hh3
 bcilD/931VZC2dfjqiiQWVjwzoqblp+/uen7IA0/2+lFmw7WpxNFGfoMI3cM93t76W483HLEg6m
 TROMT/fbeZa1xZF2yuB60efEt5KtoHmUf3qN6gObNlJbbYGb4ZZeMLbFACGypKYJR0lVC1zcm5t
 e6c8aCr4NQRFCd1VW1C9aw/E/FLYP4g8j7aRwJ8cJzABjlGVv/0KqEnGtvRnOJrGUSIf4eCbrJr
 0qVj/9y8EJZ782+FwLto0zqGfzaEArlbJaQiv0bP07GF2E44jMiuR4yJVSWFBGox9eil7zFyzD1
 EU/Smbw2Etf/pzOCSYwFQ8f2xI/XpgKiixSeGOF/M5FuNMyQ48u1P/4tmotXJpIDesvh0o/GCwf
 Agv6fFXLJ9b5gKNvttCvti8vr/GPOXNjgEBaOVUXpvImSgUiKJWpt8d63onGfjGIb9Oap5pAnJr
 2GJx35JRhCWGzTuyJer3YC9cxX5xohxR21trVesH1RJIRMSKrSbcE0i1RBI0Tc1PnVPxsNGVWfu
 DBGx8IShSqdAbnXQDGu0dbRneadGKe38rPjuj/0k5HGaKS80G8CL9t2c2BpA8NSP1+LCbkaqQHP
 wT0BHmGkzKvkuprEFqK2MjaTgJiNtgqPm+/wV8wWNRpb2rjfNMlLnV9rYhkM6zPrUCeXtLpjwvR
 0YNs8FSAUIiio4Q==
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

The limit is the tpm.max_missed_responses boot parameter, so that slow
pre-production parts, such as FPGA prototypes, can raise it, or set it
to 0 to never disable the TPM. A disabled TPM stays disabled until the
driver is rebound or the machine reboots.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 drivers/char/tpm/tpm-interface.c                | 14 ++++++++++++++
 include/linux/tpm.h                             |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1e8317483844d9..cedea8bd468aba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7682,6 +7682,14 @@ Kernel parameters
 			causing a major performance hit, and the space where
 			machines are deployed is by other means guarded.
 
+	tpm.max_missed_responses= [HW,TPM]
+			Number of commands in a row that may time out before
+			the TPM is disabled. It stays disabled until the
+			driver is rebound or the machine reboots. Set to 0
+			to never disable the TPM.
+			Format: <unsigned int>
+			Default: 60
+
 	tpm_crb_ffa.busy_timeout_ms= [ARM64,TPM]
 			Maximum time in milliseconds to retry sending a message
 			to the TPM service before giving up. This parameter controls
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e0385b16616b46..977e205807033d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -40,6 +40,11 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
 MODULE_PARM_DESC(suspend_pcr,
 		 "PCR to use for dummy writes to facilitate flush on suspend.");
 
+static unsigned int tpm_max_missed_responses = 60;
+module_param_named(max_missed_responses, tpm_max_missed_responses, uint, 0444);
+MODULE_PARM_DESC(max_missed_responses,
+		 "Disable the TPM after this many commands in a row time out (0 = never).");
+
 /**
  * tpm_calc_ordinal_duration() - calculate the maximum command duration
  * @chip:    TPM chip to use.
@@ -268,6 +273,15 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 		delay_msec *= 2;
 		memcpy(buf, save, save_size);
 	}
+
+	if (ret >= 0) {
+		chip->nr_missed_responses = 0;
+	} else if (ret == -ETIME && tpm_max_missed_responses &&
+		   !(++chip->nr_missed_responses % tpm_max_missed_responses)) {
+		dev_err(&chip->dev, "%u commands in a row timed out, disabling the TPM\n",
+			chip->nr_missed_responses);
+		chip->flags |= TPM_CHIP_FLAG_DISABLE;
+	}
 	return ret;
 }
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c393..6ad1e254831f5f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -131,6 +131,7 @@ struct tpm_chip {
 	struct hwrng hwrng;
 
 	struct mutex tpm_mutex;	/* tpm is processing */
+	unsigned int nr_missed_responses; /* commands in a row that timed out */
 
 	unsigned long timeout_a; /* jiffies */
 	unsigned long timeout_b; /* jiffies */

-- 
2.53.1-Meta

