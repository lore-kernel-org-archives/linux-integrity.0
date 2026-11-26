Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660541;
	b=WMYi3ObQS2pvuLfI2qXv7j26VuniLPz/SD1msOVt+2cEAYVDUBPz3m8J9alzcHZJHMFu
	 Riwfj28/0B6FgXKyezwLcitupkuR8HEeNSgWlVc+pBC4uSbz74nOEQ8v5R5PbVvCaKQai
	 c+D5UbN1x5GHBqFJYXdC+5mZKDSTguvaPTVpujwGDG/Q3BJ0G/HZylMhZnbsOg5usJw87
	 4aEDIQfiEj3PNXUY56UrRRjb90ZVh37yIoijL68jOgr4Wum/VYa1PaaPsCMGLj4m1Ei8j
	 xRzqgdJO7M2xMC3Gz+p+OLhy0BnXBsIBKt+kG0TCLeDSrdoQwqNosp65WE4zIyBPI5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=g3rQYEqeb9KItcfmF0Y01uIIXY4X06TFOeBbAGovoNY=;
	b=EdhGN4F/xkeWj1XyDUhwehybt5GkkoT9krWzcV7i2/EMEUeipVZYcFCJ0QrYJl0aHobJ
	 JkBbB5yaJ5wmormK3vIOcM7EXv9ZRw6uv/efW9uwmVqRtfJQE1CHyXTNra2eWadwKKm+v
	 aquScPN/hZSlileeoepok1LhZO4HtGr/urFXkUIljII7DGQ7iBxHYjznoHY+tt9tcwqkp
	 rbvhycpfpC4Xg/VyxE4GNKRZsAUot8w5g9+6nbHM7x5+nH+lTZzqYbC5OKWncCuF3dlu3
	 8AUX4mDJUUwugP61gmSOuevkpykR1nP/zkrPggqAC4VDs+5GlwKWfecaIjdVdSRd6xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="X0uaxh/Y";
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C27606A326
	for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 02:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C27606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X0uaxh/Y
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-85c1135c289so4284914a34.3
        for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 18:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795660540; x=1796265340; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3rQYEqeb9KItcfmF0Y01uIIXY4X06TFOeBbAGovoNY=;
        b=X0uaxh/Y6FfGkSOerIan92Tqs5wCFuIdc1o5XtL4Lp9SJebTXEDKfoYaT0d1mgLGfJ
         uoAVeT8sSBexKcX+QGe9G42pp0CRDiIJhSP3qZA2f/FOsb082jGJIvvEV3P7BXZs8ZeB
         Ress+qPpeZPkiXc03IVbd3m5MIzK0IHO7sS+usV1OTXA6oqQ2Ej/nERYkA7FBbeJdmJJ
         GkzFKj6LmZxnkM7Ihigc758BKD76oTQ3eoHpo54UdpLrp4Bia8DJcl2pH1ff1HLjzcqW
         0ymVp0eXrXOb07GAQsN5oJws8pLnn8QStbpGHlQTZ18RhJzXyqUORM5q5q8E3lVOrr3u
         O39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660540; x=1796265340;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g3rQYEqeb9KItcfmF0Y01uIIXY4X06TFOeBbAGovoNY=;
        b=x1yoq68+myeMDWlwW+NgyF85euVz+4xqC6qnroZ/vxDdvkxPP8vfH6yXDy8K3BaVAO
         hegb7nR0JAUU7K+vjtPMCzO1p9TPhJrR9xABjmO+NtuWQ1pwGcScWNFBxg6I1he6mM3g
         gu61Vrupg1Hz0XmEubj/c/10jmRYr7c+5mlj/zkLTnppZcUk3ecPMM3SjiBF/0Ax72GT
         ubjCKH/6Fs5za4iGlHKzoCtOkQv+Ogig2r5bWRiFKkkcQb0vSyBufytXjXiEbdOA0kVl
         80wg5kxe+TsZ2CeGuHDjaKChWl/5rq8QDZQuon15f2y438CEznLchufM0PUfaTzlMRPn
         cILQ==
X-Forwarded-Encrypted: i=1; AL+hErEH6MHZea1pyKLZPpAdjDnM2MaXnIjnudsO8cR/9JV2zdGngfmReBEP6JPT6cHIAEyivlV8tsJLlPs1HzSh5og=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H9cOUSLX9BQ8ckZks2RwAsxVrVG14CAxGHsHXZoi/i0gXwxci
	kPU9y6wj96m9Oyl+40xdXHPLHOpmSIzHhQqLOu5sJIZZBetU/mg7Q+YFe2LlPKZosluk2l/Mlt4
	b4xHAJEpx3z71E9yYwtkhEf4J1XU8Lw==
X-Received: from jaac8-n2.prod.google.com ([2002:a05:6638:c748:20b0:620:5ab5:d384])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f49:b0:4c3:db9b:3ead with SMTP id 5614622812f47-57a06b1eaddmr21898545b6e.3.1795660540254;
 Wed, 25 Nov 2026 18:35:40 -0800 (PST)
Date: Thu, 26 Nov 2026 02:35:38 +0000
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126023538.4160950-1-zhenwenliang@google.com>
Subject: KEYS: encrypted: encrypted_rcu_free() callbacks can outlive the module
From: Zhenwen Liang <zhenwenliang@google.com>
To: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

encrypted_update() replaces the payload and frees the old one with

    rcu_assign_keypointer(key, new_epayload);
    call_rcu(&epayload->rcu, encrypted_rcu_free);

(security/keys/encrypted-keys/encrypted.c:898-899 on mainline
ebb7a8dc1e74), but the module exit path does not wait for those
callbacks:

    static void __exit cleanup_encrypted(void)
    {
            unregister_key_type(&key_type_encrypted);
    }

When ENCRYPTED_KEYS=m, an encrypted_rcu_free() callback queued by a
recent KEYCTL_UPDATE can therefore still be pending when
encrypted-keys.ko is unloaded. The RCU core later calls a function in
freed module text. unregister_key_type() garbage-collects the keys of
the type but, as far as I can see, nothing on that path waits for
already-queued call_rcu() callbacks (synchronize_rcu() is not enough for
that).

Sequence:
  1. a user who owns an encrypted key runs KEYCTL_UPDATE
     ("update <new master>"), which queues encrypted_rcu_free();
  2. before a grace period ends and the callback runs, root removes the
     module (no dependent module loaded);
  3. the callback runs from freed module memory.

The usual fix for this pattern is an rcu_barrier() in
cleanup_encrypted() after unregister_key_type(). trusted_core.c uses the
same call_rcu() pattern in trusted_update(); I have not checked its exit
path in detail.

Affected: the call_rcu() in encrypted_update() has been there since the
encrypted-keys code was moved to its own directory (61cf45d01990, 2011);
the code is unchanged in mainline ebb7a8dc1e74 and next-20261125.
Trigger: needs root to unload the module; queueing the callback needs
only a key owner. Impact: use-after-free of module text, i.e. a crash or
execution of reused memory, in a narrow window after the unload.

Found by a formal analysis tool we are developing that uses AI
assistance; I have reviewed the analysis and this report. The tool runs
verbatim copies of the kernel functions with stubs for the rest of the
kernel; it found the interleaving above, and the interleaving was
replayed natively on that harness under the tool's schedule. Functions
involved: encrypted_update(), encrypted_rcu_free(), cleanup_encrypted()
(RCU core and module unloading stubbed). It has not been reproduced on a
booted kernel.

Thanks,
Zhenwen Liang
