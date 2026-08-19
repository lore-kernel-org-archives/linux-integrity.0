Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB33A1B5
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183137; cv=none; b=I9hK3o4ff/13pAZD9Y5gmBgPiMj+4iTgJhWGJWWM25hNIhIZZ65rKWPl8CFfyH0Rx14fpAZtrUqaO8cMKtG0bVWP3j4zouRP4gHzIhGsj8QB7yvVdzihaBU4BQy2otCb4Hz02SaTjPH1AZNn/J03qE5dzgE/Yek3SCvvm73S8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183137; c=relaxed/simple;
	bh=7Zx4uoiJ1ij/Pxdv2tJ7SWIfwM0No6mq3s94UjARVo0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S2YKqahZ5HpZGka6WykhA68hki2ogPNcUCMXj8l1RtKCAcNYWt3QfYUv9CaxhqvweqTIKRNydPHveHQwlw87zS1xx1EkDrx+num1sE46edwZEVsXLoLZbrpFO8PV+4jumzV61uDoCtwoOaFa5Nwu8LoawkNCAWs6egicbYdSK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=C0oGjZC1; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="C0oGjZC1"
Received: by mail-oi2-f10.google.com with SMTP id 006d021491bc7-6aae09859easo120823eaf.0
        for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 16:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787183135; x=1787787935; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jHhyVhtNxlIsSMqbpIf1kctH0cA3NnWbiCZQ2xqAP+I=;
        b=C0oGjZC1Wgcvv0l5hkqU4Iycp0J+dbOlGxrkJ49VKZtwFV2//UMMOdl1Fks8e8fdjY
         MhxnXXVgmEVMtnZQOYO2WazDSd3XL59+0dKtB3two/7VJ+mLj1eGvlCLg/Qar5R1g5l6
         Ja1KtZTj06AXuIn4ugr+KvBjaRkg/91cJQQAqLKSmFy/sO1mdf01mKsmb3GLsu48hV30
         1hQPNnzTUEu8Krjxf7w5MT2DcnA60dhoeMalVwqdIMiMBBGha89bApg80neFQ6EWFqOW
         TOdB3GXSkN2D105RHBuNLwL39noqmnYh4j0Ydk21ynrY+U0jQ8BmFYv89Mqd8N+R0zm6
         GQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787183135; x=1787787935;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jHhyVhtNxlIsSMqbpIf1kctH0cA3NnWbiCZQ2xqAP+I=;
        b=aZ7Cy5G4G8oifIfZuQ/HxwGLZND7VwkTqzW4f+/GaGgP+nz1RRWbpFUAk0a0jXejEx
         26eAZJVFmcN4TzN2fqqShnx2TS3WENwomiYKVqQcp4Whzb2XRglt9OsKdWOMrnvuJpAw
         m0EzIar62D3piALGdsDGe1Na80IQbzMHPxnW5f5Ak6jat/TIKQS8jBztuEFZUo8t+FHT
         jiH0BORv5sPKn7T5/kZA0+FVrdrnTf/6LdlbVvDH9OiixpDzDl2LWkTl5RIzg3CUWdNU
         /oT0XYnZJ+ZZxH5oyfsBooDSvB01Mn7IlhzU7UlUlbU1M4LEO6PmdiKOEJrzeVgOQvqX
         YcsA==
X-Forwarded-Encrypted: i=1; AHgh+RrfSj9uVzmJf/7xHVh58SOoCOOI8pxH0USgYbKPHXZVg+cpbocdDb1xQwpkH5jYtSMSLaAY9L29FaUirkXFaoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAD7dsMqOc05EVn4cZe/abSKIVVlyLqU5vvVXzcLF5lcFEqq4Z
	mmaQsjiTDP0Pv7/9Z0qE7Qhxt5syGMctXD96ApWLubtiR9yI5lqb+uqrfLX05Ew6Q/I=
X-Gm-Gg: AR+sD13Ew5nKnOgj1K+NN31xedEaRdlRgOiyGB2efDHE7VN6O2k+z588HNSxuf3qgpj
	+SZyPovd/YnJAshtxG7iW1RVmr9Wxa3kGjL4Ax6q2VdMCesqfnRXR5y358iJxzHV9ky2a4dXUCu
	pxUDmh02sHx5WpIevUx5O9cRPdQY0yrzUJySGAy9l1uRmMZlW2vngOmil1h08WraquxWfs0J2hG
	OMu+A39Rv+naPXaSBNLoz7GZn3bf4mPfWyEnvd6JR5hA12awrmOqgImq2Av35jV8vqIVtQXZVND
	GJo6Fq8ARkottUonppNGnvLYIkK3FrwbiPdiO3Mr5Y11ME9pBn9cCyFxf4BeyvNw8uMNhvIxY1H
	SGFXWS0hVMjp+cDPrpaaGxJ+Msqhr77ajEhGvkPwUCzu46THjK59uvDojVH5ZS87VEjek4Cznoq
	NhAxxcMaQ1sgL1GpPNPiY8kxTw5dxL5KrLnNrBWFjzI23LziK8tYdBAuo=
X-Received: by 2002:a05:6820:3418:20b0:6b1:30fc:f284 with SMTP id 006d021491bc7-6b1491b8186mr1866346eaf.11.1787183134898;
        Wed, 19 Aug 2026 16:45:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:75])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13c90d160sm3470216eaf.0.2026.08.19.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 16:45:34 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v2 0/2] ima: don't measure/appraise files on configfs
Date: Wed, 19 Aug 2026 18:45:21 -0500
Message-Id: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJAhmoC/23MywrCMBCF4VcpszYyuVCiK99DuojTpB2oiSRal
 JJ3N3bt8j8cvg2Kz+wLnLsNsl+5cIot1KEDml2cvOCxNShUPVppBaUYeApFOGUsGYk3tBra/ZF
 94PdOXYfWM5dnyp9dXuVv/YOsUmCTtDqh0RRsf6ElvcawuOyPlO4w1Fq/CEL+SqUAAAA=
X-Change-ID: 20260818-configfs-a248c410b083
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>, 
 syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=7Zx4uoiJ1ij/Pxdv2tJ7SWIfwM0No6mq3s94UjARVo0=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqhkAb+bybkxZORMr3chLSYBm3Vw6QNOzy8a8uS
 n+pXr+JdfaJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaoZAGwAKCRCrJbR2A5LT
 bQa7D/9B4yDBOOgIxjsIeRVLNosQOAEA+K8JvTdvuwYgj0Q+GrL2uh34w4TfOWqj+Q+17L3/1JL
 ihG5ayrau0euysJKbAYUDHnYRQKIxyeh9/lcwGbYE26ma246DZDHBcEYbgBdAohi44ikymCRU9y
 69V3NNIWViWdfc/SvboN14DOy2M7Mx4iRDuQb+gPHAzXKBoYpl+jor6fCJPcInCiVQ/LCGlq1v9
 zR4ftiB7eAsgfaRb8VC3tDwGsLF46Golz+JFl7wkuQ1bv8hQQVwXZ7k5X4frG+ZwiIqR9ZQB2K8
 cmJKEW5biTuZxhaa1DaY/12WMczd56Vk2BCJvW7uPPa64ucNvPTyxOJYTQt+7x5k8Mdgerqv/BN
 cnnHuuqDmnkI6kWGDQE/A43M2VudH0xMB02nyXXdBa3hnZsE+wtk2EmkiSaY08XbY9UM1p5urzA
 4hTLtoK9Dx9k3oCzJY6PVHJCnAvU4WSdjqADI3JeT1kNLkjD817Hwd6vbiNrcXWU7Ml9F5zfoGK
 5bbGJi8s8Txk32gw29AjWP3C5Xbpo/+CRqE+gohA9J3U4zIV54foWcTBMVWXqfRuih0T27j919H
 Dmcb+ctG8mdX1svMgIhzvDXLY+UNMoAIK1CZ3X5WtVqTpNI/Cc+sz4DHemWogDNb1na2NdpawZD
 jMAEA2G3odfbfGA==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

IMA measurement of a configfs file causes process_measurement() to hold
iint->mutex while performing a kernel_read() to hash it, which re-enters
configfs's own file locking (buffer->mutex, frag_sem).

Separately, opening any file with O_TRUNC now causes ima_file_truncate()
to take iint->mutex to reset the cached action flags, while sb_writers is
already held for that mount.

When a configfs-backed nvmet namespace is involved, these two independent
lock chains combine into a cycle:

iint->mutex -> configfs locks -> subsys->lock -> sb_writers -> iint->mutex

Add configfs to the builtin don't measure/appraise rules, similarly to
other pseudo file systems, so IMA never takes iint->mutex for configfs
file in the first place. 

Link: https://lore.kernel.org/all/6a77c7cd.b50370da.49fe0.0031.GAE@google.com/#t

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Changes in v2:
- Add CONFIGFS_MAGIC to IMA documentation in patch 2 (per shashiko)
- Update cover letter + commit message as suggested
- Link to v1: https://lore.kernel.org/r/20260818-configfs-v1-0-a2329043cf86@cloudflare.com

---
Frederick Lawler (2):
      configfs: move CONFIGFS_MAGIC definition to magic.h
      ima: don't measure/appraise files on configfs

 Documentation/ABI/testing/ima_policy | 3 +++
 fs/configfs/mount.c                  | 4 +---
 include/uapi/linux/magic.h           | 1 +
 security/integrity/ima/ima_policy.c  | 7 ++++++-
 4 files changed, 11 insertions(+), 4 deletions(-)
---
base-commit: f1e10b10874051e4d99911dae0dd7b75a9f8ae66
change-id: 20260818-configfs-a248c410b083

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>

