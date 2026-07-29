Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8213806BD
	for <linux-integrity@vger.kernel.org>; Wed, 29 Jul 2026 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785308063; cv=none; b=gVN563sAJoI5OKeg2Hzz4moZpgfmHQ7y5W/Sizfi1Zgnv0Hn9s1c375oDvemdXhbph0FgaAW7U/npmpApQI4hAD4cEiiM0HMzr3xnIyaxuaBLdN0FzEI9eQSuXqRjMfBdcZJSsEN75zzqeioXokzXV0atTNZ+TjQ0boUm4+2iI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785308063; c=relaxed/simple;
	bh=ANKyctcOgwa2WBltXNXle8ZCvqV2C1821WIGH9X8vj8=;
	h=Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type:Date; b=IDY3XPxW5o7JLsAQg5ooepvilQnX3jRfoiBhpy0Wvi4+it+Ecw4Rf7YuvFvS+IvZBWHMXmLhns2adCQ9En/Q34+3PJ5BqGp19HZIJCWtVmVndG1zxrIVzztFzDaYjYgQhmF2wpYHe7c0qG2yJFbrY73tO+w8VC3wFo83fTqP5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oxn+umYy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oxn+umYy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so5814335e9.2
        for <linux-integrity@vger.kernel.org>; Tue, 28 Jul 2026 23:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785308060; x=1785912860; darn=vger.kernel.org;
        h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
         :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vOVaTFLPgv6tfcUdgXRDjI2ELjjUlEnRiyMnzNz27o=;
        b=Oxn+umYyg0PSjR0RZ++4FqAQveNCj2Z8K6l2LCmkv6NeSrBWBgyn8SoE/evbAiHc6l
         GOdleADEvrVk7+ihPOl892CYk71lKCgqbclMV5wD1oYBbfVlK+FE1kPhhSWrNLGLLHu5
         JCnSYlG9xGeJvQqhL6bIFKPL1ya6fr2haIVjMe7nI98bEdrrn3yFKy9EX1lonQEQWyfd
         ONlkS1PIzqE730axPh9++YJb2NBXWq2rnfs9I37wWfMov+2bpkSOstJOGPANTVV4d9Fm
         ZACCtMVpYkDXZ4eBVI0BUsTMjuOY0helhTknskpctLghqKgOcrm2lZxHaUEmF4AVq82O
         AC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785308060; x=1785912860;
        h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
         :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4vOVaTFLPgv6tfcUdgXRDjI2ELjjUlEnRiyMnzNz27o=;
        b=IgQ3Anhm7JxPL0JOg19zLz+mq/moWQ6wCTC8uVwkC+fatRWHb1xc9Ms0yHTIu22L0O
         2edRK5g2LfNSK0a1VOdoaslAbQ7zYGCDF5W9uO2EgWkvXaHiEwgO6cZAq2UtFgV0T/WG
         qPIdWiglBaPspiFyc7QpTgXrRL/DH9WWRrP7NugqtxKykEsivrI9AnHO8er+KI76KjU6
         tik+lCPV7xUJ0KP1mkKiiPe99egQit1CJEfDyzfOFtTDFT830iv5qdRhJM4RPnjhLAfJ
         EZAWRQRYQ3tYifeTY37YA5qY0OgVi8ubvkSRB12/tspE/Op7aQ2G1KF+t1HGUcaUs2l1
         MM7w==
X-Forwarded-Encrypted: i=1; AHgh+RqM7kvz4ibA9fQJ8VxUzeOZmzFji7TtwkIPvXDVdnJHf+zglQ9sGA7MFDRbo0Md/l98uFeKNDNGRvtq0Dtd7Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHy8EBNyXF4Z6vxiWhaQW5mY6+zm46YDZde/uDcW5RBtt1b5z
	YroMt6Oea62atHsn0lLTN1m2iScOJyqkcBzJQBjSDiWiiTN68KhkAoqSUJycvu7sA2I=
X-Gm-Gg: AR+sD138wN9wy8CMy9j72BRFg9GlC5GWHBBADqvyUkOCmTbF84fwTHAB2xZ5MPrHRCS
	tgwKgBFpupTWuc+jM2LNt7Zm7+isFA05pIgaL6hod9yNS23rZH+W/jqsdLptCs26omdTH/lM7k3
	CO8syvwJy//im7Xq8+xqprYrrmsvPJWOWxeHhzh+xvfkCLO3giaUCciXrvkwXqK+nLjpzGXa56a
	nJn+wb1leCSGlLzJdfvoPZs4x1zJPVwZonSNqTc9PCHgCKZia4SNtSx6IFGfbXCZzzd4DaS/x9o
	u/qAiA2v9iHaTGIUOoC6TnKhZVkgIahVs35Pw4im2sUKKUJ6+FVnbtj7n6hs9/sPbLbMVCFxJfx
	hJ15SnbNT6eBx8VFvFY8EAXhB3eykLeiFcntxzeiHzS1BsOYsEsUXfeWSP9qbtCz+BmycfId5D+
	7YvMaIi931gVwlzKCDLxWQdP95Vzw+Z+mPnTHAu7DX35Ci7A4LLYt9Fdw+K2h4EesV6vTFRglyU
	jFG6mLYcW3m/oqRsoMRBWZiwzHqntx61md6d9b3LiPNC7YPQv8v
X-Received: by 2002:a05:600c:154b:b0:495:5eca:f9b3 with SMTP id 5b1f17b1804b1-496c6574846mr58541475e9.26.1785308060217;
        Tue, 28 Jul 2026 23:54:20 -0700 (PDT)
Received: from localhost.localdomain (ip-109-40-50-253.web.vodafone.de. [109.40.50.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb647a8d4sm5339974f8f.0.2026.07.28.23.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 23:54:19 -0700 (PDT)
Message-ID: <6a69a39b.a148a86f.57214.897a@mx.google.com>
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
Cc: linuxtestproject.agent@gmail.com, linux-integrity@vger.kernel.org, ltp@lists.linux.it
In-Reply-To: <20260728133556.GA1128467@pevik>
Subject: Re: [LTP] ima_setup.sh: Fix check_policy_writable() for kernel <
 4.5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 06:54:17 +0000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Hi Petr,

> > - "log" is created in the test working directory by
> >   check_policy_writable() and load_ima_policy() and is never removed.
> False positive - file is removed during cleanup of the temporary directory
> because all tests use TST_NEEDS_TMPDIR=3D1.
>=20
> > - $IMA_POLICY is expanded unquoted throughout ima_setup.sh.
> False positive - /sys/kernel/security/ima/policy does not need to be quot=
ed.

this is kinda normal (unfortunately). As you can see the amount of rules
for shell tests is really basic and it doesn't cover many cases:

https://github.com/linux-test-project/ltp-agent/blob/master/rules/shell-tes=
ts.md

Feel free to create a PR to avoid these false positive.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com
