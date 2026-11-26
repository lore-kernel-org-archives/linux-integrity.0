Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723267;
	b=h4fcHLRmVc0nGHbWu2+jkAytwiDiI1mkoAXZsbabMz9hYHnME87Ss+8iWKJ0gjhgsV0a
	 Rd7bRbbeZm/KDpNUsI1CSyUWbPeS2W9PqsxnOIo+4ONUGk6xWdbj19UKh3Nadmxm8RTJk
	 8RKhcTQU3PLT6g+9f1iFSFeFjEPnyWUbdD7cS56bRS+hk7mCBObGZlI9F7FlEnmSPtasJ
	 jw0GGl9XkO6kot6uxB0G1mGzNcMPPJJxVyk2LV96phL42OWESaeZiInMu+Zxf7u9DGpaI
	 SopgKA8dbkhazmoTfmvK6HKqZPNGhQJJGMpugdXeDPXjvH1YG+JfV9BJdX396w7SrFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kKU5kDELcUiOnw7qyXB+3obc1U1FqLt22qXXOmqTd2I=;
	b=V6pyKTXL1+pYibmVzB4itJXyayqgjJMLIzOqr7z21TTIeyK30Dh0S3mh9mHvH3H0hZFu
	 FAm0Pdm/CqG+ut8vlSblC+3gilxQFzak7+lPX4AIhcywY8VK6THzwyTbAi4aC8fhviXTx
	 aj/maAiB1MCHHGR/K2X8cblPn7vIskEFxFnoQua0aLTr+HaRdzPoX1LkYjZzvn7DfoS44
	 gQQOPHzDtymjmHpU9zKPoSkUoxJzFzr27Lt4IHSLy34YY8BrzljnNfzzUwQ8n2f7ZZw0d
	 hvNKKl/yINfu8VmsDeibfq9KQFyT7y3GplyignBKJITWuPf0hSbI1Kvv6LmoximtCMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=muQBTpP7;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826CE606A330
	for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 20:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 826CE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=muQBTpP7
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-54dbbf252cdso7299125b6e.2
        for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 12:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795723266; x=1796328066; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kKU5kDELcUiOnw7qyXB+3obc1U1FqLt22qXXOmqTd2I=;
        b=muQBTpP7/q1RlO+sE7lY+7jkO7y0hqz4OGsjZPnNcQ/yjEBfeYM2sTVT2u10XnEFdS
         C3ozy7zFIaCMCnElGo3uRFQNyERgFWFoNvQCfQ3CgTZFgMqdumfK5JEkZFTdjTI/+if0
         NKvr+nc7h3vQ1l/LB7Y6yB/+kjHcybOxzVGci3wzIYophJ8eGcs+FCsgIJW2hA2zF80s
         PTjeGgJ79obZcHmlmBl5uyhCitx0dnQB8IQcVdxvg8rz4HrgRzkuULok3Ibhgjs0iF5e
         qj1bZR/R066fwW/Q3YGmFuyMfb6LbSa1JAMWdr2++uUgoISb4+nrUcDIHdu5Ray7lBTC
         sfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723266; x=1796328066;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kKU5kDELcUiOnw7qyXB+3obc1U1FqLt22qXXOmqTd2I=;
        b=mHTMDLAxuKpayUA5+MoH5DAsPV5yS9y738Xi94PW+sUq+m7rKYjExfhkVx9zMA6oX7
         xvyQJvgb1gpWglSza/R8x7GT5IQRdw4XBKzJQAPHiA+pAsVCkolASLrqN70dgv7hgruE
         fOU2+CIhaMLeobK2jDWLr61Qy1dRceo2jL2skwUoRLKv2SWYW9bQKmTGqraa+Vo2KJFy
         dYhKfZnJ6TocNNmVH0xMo3Dq+mGPdLilhMGxErioqFmlHs2xICNXPfI4g4js83OAb3vA
         FUKq/n2O7VeuLkB4i9WLcJDGBgdNLkQPODrJ1ilgjydyjmdlBaXY1Ppb425kL+qVQP7h
         RthQ==
X-Forwarded-Encrypted: i=1; AL+hErGvKAwUPNFLX3QV3W1nIlsBNrng4/fOppWR27GQUCzqKzLBDhcZy4OcaVqdO0TGv3i2UsY6RDhDEp9poAglsmU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8olm69WM4s9DlnD/YkkGM0VlHPRIVIWPQZrdq/YdEscMsLk1R7
	FmvOpuYlTOiNzDEZyldmet1rNnsKUj/3rUizcp1A2j7vFbICGgkeptozGK9vank2OoO//Gk2LVj
	2ZL9l559ORUEtUHAxpwJ6IS6e8LLl4w==
X-Received: from iowb19.prod.google.com ([2002:a05:6602:14d3:b0:9c7:bd0f:3947])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2208:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-57a0dd479f9mr27505393b6e.67.1795723266322;
 Thu, 26 Nov 2026 12:01:06 -0800 (PST)
Date: Thu, 26 Nov 2026 20:01:03 +0000
In-Reply-To: <20261126200103.2806716-1-zhenwenliang@google.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126200103.2806716-1-zhenwenliang@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126200103.2806716-2-zhenwenliang@google.com>
Subject: [PATCH 2/2] KEYS: trusted: Wait for RCU callbacks before module unload
From: Zhenwen Liang <zhenwenliang@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, 
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

trusted_update() frees the old payload with call_rcu(), and the
callback, trusted_rcu_free(), is part of trusted.ko. cleanup_trusted()
calls the trust source's exit callback, which unregisters the key type,
but nothing waits for callbacks that are already queued, so the module
can be freed while a trusted_rcu_free() callback is still pending.

Add an rcu_barrier() after the exit callback. As for encrypted keys, no
new callback can be queued once unregister_key_type() has returned. If
no trust source was found, the key type was never registered and
trusted_key_exit is NULL; the barrier is then harmless.

Tested in QEMU (x86_64, TCG) without a trust source, so only the
trusted_key_exit == NULL case ran: trusted.ko loads and unloads cleanly
with this patch (5 runs). The trusted_update() path itself was not run,
because no TPM was available.

The problem was found, and this patch prepared, with the help of a
formal analysis tool we are developing that uses AI assistance; I have
reviewed the analysis and the patch.

Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
Link: https://lore.kernel.org/all/20261126023538.4160950-1-zhenwenliang@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
 security/keys/trusted-keys/trusted_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 0509d9955f2a..5efd1e6ef111 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -401,6 +401,7 @@ static void __exit cleanup_trusted(void)
 {
 	if (trusted_key_exit)
 		(*trusted_key_exit)();
+	rcu_barrier();
 }
 
 late_initcall(init_trusted);
