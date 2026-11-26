Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723262;
	b=NPeG65VPFq9D3Zoo3sr1O7S5YvyxtRQQQsilTXE5awoZHS+U91qDyWlRBTzQZ/hz25Eq
	 yZEwAftQtwEqz4n6YOqwXUrofI2a56nLMMljPWalQBhyJaMesGYzBWu8XMLFg899fehaG
	 0vbt9gPbn0okylWAEYbvmqZsqP/OkQLrXJW+kXLfkpBqcjMxgHnoGNDZW1hkXoSOrtcMv
	 6V34wFB2M6zQNGzEUBMChdHAmJ8oN56M9VuBvNtUwjWvzMqEcwAnsBLMqW7BKA0who+d1
	 e66qInDkxVWvAh+mNF2uyWfC1EiygW2OUjMkZIiB8oxV4mDy3XSh1PTC171yQm8SLww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6kyFcKzeGDxm7QHLL2jhZm3kVHS8REfuYCj505/rh+w=;
	b=PK0uGSc0dbp1GunHVrpc8cVZq94T3kbFxlpblf9l4TlWTgm7oe9ym7IkANN9gB7nr2Kf
	 +U9OoZcHwr3BhI3pUb2eWGSqcPasqRETWjAel78Oh8N9wFs1U7kPU/KZf8XmygF3cn8RA
	 R75fuipKr0YQwvJW0JagbX2Kph1au4jU/8YKj+oL++QQtsG8Ecf9c0Ge+7V+ra8hiGrwq
	 3AjcKR/1amc29Z4gCXsmzlYVDBZX1aUxB9VacUDHl+Cvuwe6f3V/5YmHQiun+Imex56cr
	 lmEgwOc3/i+ab+SjLku17ICcJ1xnyz6y0L6z9Qdb0z/oFzVmiTszIxf92//u8PKQojA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DWn5Adbn;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A2606A323
	for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 20:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 002A2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DWn5Adbn
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c467e19391so10132087b6e.3
        for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795723260; x=1796328060; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kyFcKzeGDxm7QHLL2jhZm3kVHS8REfuYCj505/rh+w=;
        b=DWn5Adbn/TnNY1xH6jgc26TeZjfcHBww+a2kKpHR/5eZOfNI4t4Z8aZ+omqwN2qsgm
         yCCY+enUXphkASUrR2TQTtRUsbfdpo/dOnwNQidEPIzUBdvoLll/U7bOMSQrkFBhmlgC
         LFdps5bXzAbXF8KyZGclTM8zxvQawERuH7hjUYr8k8TiLMccakam0RxJTH5Ras1LDvAU
         tqiDFp4hF8T13krvROhq/XaDdR0fXEqWiqmsuLW5RV0vKZWaPH9gnzcEwwXLg0rLFctj
         ZGkqJQtLYChkZZAgCZjAT1GFaA/XkgDu+1xVJ/ICK7iYXkodppDvgxd5LykFlB9tdHlW
         VOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723260; x=1796328060;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kyFcKzeGDxm7QHLL2jhZm3kVHS8REfuYCj505/rh+w=;
        b=yEtyoAmtRYvXjdLdC2P9T82MtCIbaD8002u8syUOB1NS9BSzVYlkSR+ps8sndeDE7l
         IqWvLosYS68dy7TFcBXSTXHzwR/6AXWae/qgVkff+KPbtMn/nWVpPHVt1q3e/CG+8+UF
         gHhfT7P6WJHdbjo9vwFPbqIGXpvk6fGDhtEWZP41bt910hnV57GqadjydRB2E4RTMHO+
         Mmwm8naNpzE9w1nnmgwXw3t+CWMTB1NkjtO4WYR8GWaFkIv+17J2q8F4115RGDkA9mq6
         KM98mqTOvdPerhjopXRFZTks3rR9FOnkSot8M8hCoDQn/gyBUKzfD6i5qifE7ZVHtohg
         CmdQ==
X-Forwarded-Encrypted: i=1; AL+hErFS0uG1A/1ZnsxLWbDCTMRFvG+90KReu6UxBSNTr2E0AmH0yMGt7TCbkvc64FzySaJGNXQCUK3FjMoDgwWvof8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LlvW5byi1nGBhsTek9MzejzOiCdKp2LUDK7r1K2MytlciVS8N
	92wcbqObrpyrG8hp46Yo2FVF4u35Gam96S4TzFP7XZJuAoV3YSygjIjt3GHwW6T5OTcj0SSQoxp
	HFvfWFqOP8UDsphBe/320rrSp7j4YQQ==
X-Received: from ilbdv4-n1.prod.google.com ([2002:a05:6e02:4004:10b0:53b:d747:38b5])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4fe7:b0:4f6:5279:5c75 with SMTP id 5614622812f47-57a0a50337emr26068171b6e.28.1795723260332;
 Thu, 26 Nov 2026 12:01:00 -0800 (PST)
Date: Thu, 26 Nov 2026 20:00:58 +0000
In-Reply-To: <awiDY0d9pRUzkV4Z@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <awiDY0d9pRUzkV4Z@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126200058.2806412-1-zhenwenliang@google.com>
Subject: Re: KEYS: encrypted: encrypted_rcu_free() callbacks can outlive the module
From: Zhenwen Liang <zhenwenliang@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 09:07:15PM +0200, Jarkko Sakkinen wrote:
> This will be ultimately addressed by:
[...]
> As then operations will be always drained.
>
> It's actually somewhat tedious to address this particular issue
> without this type of architectural change but I'm open for fixes.

Thanks. For trees that will not get the series, I think a minimal fix
is possible here, because unregister_key_type() already guarantees that
no new ->update() can run once it returns: key_create_or_update() holds
key_types_sem across __key_update(), key_update() checks
key->type->update under key->sem, and the dead-type GC pass retypes
each remaining key to key_type_dead under key->sem before
unregister_key_type() returns. So every encrypted_rcu_free() has been
queued by then, and an rcu_barrier() after unregister_key_type() in
cleanup_encrypted() waits for all of them. trusted.ko has the same
pattern (trusted_update() uses call_rcu(), and none of the exit paths
waits for pending callbacks), so cleanup_trusted() needs the same.

I reproduced it in QEMU with KASAN and CONFIG_RCU_LAZY=y: add an
encrypted key, update it 20 times, and unload the module right away.
The rcuop kthread hit int3 at encrypted_rcu_free+0x1 in the freed
module text in 5 of 5 runs. With the barrier, 5 of 5 runs were clean.

With your series applied, the barrier is still needed as far as I can
see: the GC calls synchronize_rcu() before the module_put() in
key_gc_unused_keys(), and key_gc_flush() is only used by dns_resolver,
NFS idmap, the SMB client and rxrpc. On top of the series, the barrier
could become a key_gc_flush() call.

I will send two small patches (encrypted, trusted) with Fixes: tags and
Cc: stable; feel free to drop the stable tag if you think it is not
worth it.

Thanks,
Zhenwen Liang
