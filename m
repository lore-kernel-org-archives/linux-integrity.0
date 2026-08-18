Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC136F8EF
	for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081734; cv=none; b=L39XgCyfuF5upjTvIybGiggHSqBoaJ9KMZZ5PK+B9CJnEsKh8J9uU56fGBbNFT1fwWxQOrJXuxZuVvOquUTt4pPMiH9XVliMg61oVJAd9rngTM58tVSkWkyN7BODvaNhVAPUEzwAFwTmjL6bolACRT2ZuGQRzmxeLr4s7pCEoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081734; c=relaxed/simple;
	bh=Z1zkBNoqlTE7TFv8YEBzTzxz0vDSaujpRw+vu4hgGrI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XYwgNvOaLwuraVwj2TjNAqLkcAEo6ibokf+tgpj3KjizVjWtlUBYnAfEgNf+Avn3srBuI+u4yDG8+Z2DkRF1GyAp9yY9b9QOoc1uZ3zmHsPaid57zYFu0kj0+IsO76le7qSpdNOBzyK2BCJMBH47BjV5RmDVvPNJWAhM5lzvuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BE/0PLna; arc=none smtp.client-ip=74.125.224.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BE/0PLna"
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-66c70f9ad8aso240889d50.1
        for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2026 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787081732; x=1787686532; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R5kxolr59Cxqsf3CsaETXDSp9QVWCGFYLmNRwAwnZ74=;
        b=BE/0PLnaoiKjs0rPeuIaJSGc+Dg1ZtO9TUljkLZ4G31EkDvP1/gJc1Rya2FoZUJ9vR
         YZjv/v5u4xeCke08tpanWQWiikmvG2zLD4rOYK7eJ8/o4oW2C7l31p67Gy8D18cy8xLk
         cCcXShxsUcRgK/mFxGrxjB2TH1jML+b96GfjJ7XmQJI/W+BiRyvM6BsL9vnSVr1R/cGB
         zI0NLiYGR1Tg4Psu+TgB7y8NiX8zrGbdOAweFuuvYBsSCT6Z7Lj28F3g3nUPMFZmWKhQ
         x9EeqbUUaAtEQYV2G3SOkMtx7nzo5sSNYRM9hiMTcFWEwzNuOCFtU/LgqGr0V8KcHJ3E
         4UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081732; x=1787686532;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R5kxolr59Cxqsf3CsaETXDSp9QVWCGFYLmNRwAwnZ74=;
        b=Juim3MscIG4+RxNszPL4T34J5nqW1uVN2RgGNTGBUQt/YNUMvsg2+8qJDWgGnbYiiV
         qLC3QXwg8bKsYz1jEbpDdSpFlwjwX6/WX7Myqm96bLR6f1Lyvnjp8grmW0PDawfJYHci
         K/IDFh3wQQNMT69jA13y5pnNRRUa55kAopsGio0gDWQPy4YvPTbG2pmCFS4M7JmRMuC+
         jgo5+4RumWzuuduIj8P4c2PAw8THpsgvM3X4mq4oX0avoOlzQg2+fuIF+qZnzy74qQ/o
         PVY2nPwTswwIu97fXMRTWuxRqwMksJX6skMiNgEnStSDuhv3dwjqmpJPx0SPiVJkYrwj
         PVug==
X-Forwarded-Encrypted: i=1; AHgh+Rq/neNeP9L57lyHoEyrlaI6p/gpIIRBE/ZNPOwfiaTYjdBHBRegSJewWKzkL7YFTCtdpTx204Re6v9SztT5Giw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71nclUWQzmbS6+m8ImPbe2pJXCHpS+ozwauEhfOAyirMM3ZT3
	pC5HD/3HMRKcqD5C8dXv9rYArryFpAAUngSMLjPv0faVWxUzUZLOyz+ZshRplui6i2EwF2+Uwyx
	ymWaURdBpusQk
X-Gm-Gg: AR+sD10QJe1D5CfQTHxnKNC7QlpqiKmPgTlJ/UJuSBSiQu0jLA7wFjzM4LWWl/obFKp
	K+83LwLOZizRItFN3NQfuEhZKmQLRKxu4N7YhyBDR/oBqnJ9GXljnjEVVoWn8E9d/QqGH5ytYfB
	xcjnFSpTrMLzFbTRXGiXHbF4fecKbeUU3ZTluf1PH67FxiAQCv1cwPdslp6DdwOSe/OozZf4roW
	J+7HwvMXH84KjuwaAevrntE6SdBcw//xNdk7OWA23XZDYGjohiw4BMp4jzPQ56EirlV8ulszR0t
	8zeoEG8KLc07aDaohvztxkMrBA/otPv8ZhsQYLkcmdIjFvRAbE1ZFZbLSu41tdcfzd56QchCfTR
	7NHmDzTVEoa7vbUG7IIoGbo09c2C/3AzWVsSbetrvH2uEf3ZbYQGEUHwI8begKtX+MVI8O+OG+W
	yjQIy2irg3dUDAGGYSWbL2uBDalVmIyzv8yDweuTSP6sux8M2OJQ==
X-Received: by 2002:a53:ca4b:0:b0:668:15aa:4f79 with SMTP id 956f58d0204a3-66cca5767bdmr67485d50.2.1787081727116;
        Tue, 18 Aug 2026 12:35:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:52])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb47809c6sm2795622d50.11.2026.08.18.12.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:35:26 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH 0/2] ima: don't measure/appraise files on configfs
Date: Tue, 18 Aug 2026 14:35:14 -0500
Message-Id: <20260818-configfs-v1-0-a2329043cf86@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPKzhGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ML3eT8vLTM9LRi3UQjE4tkE0ODJAMLYyWg8oKi1LTMCrBR0bG1tQB
 KyJxHWgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=Z1zkBNoqlTE7TFv8YEBzTzxz0vDSaujpRw+vu4hgGrI=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqhLP85sosKlBEoFU29UJl56lOKC/kkVBhV+r+9
 2q37yvmgnKJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaoSz/AAKCRCrJbR2A5LT
 bf55D/9zJDWzwTw0F8cSI2kW060svadBjhv31RuDFg0P2mYMzaWe1U7HCKOKEl4LHoVQ5+59vWB
 myjNmV9wrN0/lTnpp+vXv9FyMdiUZrYk7SR3UhHK3TKvDWyPwCs2AQ8eXQoJHfrfB72KtG1Wmwg
 kFb/3VYPiJ91mA6GST2sXPjvLpd1mvT6Ae2Cgc4gfXHZPT2CXBWIRMThY32+JRBR+o33rNIDhFS
 DMYnq0NTreBW4N7JmVGLyyMztvucHwq69d8cw0SQalS806tw32kvmLj7B01L9u/7Hs60fo6TTnY
 h7CyYFkFV2o9Am9ZyhZRHuLPMTNc+BFLM5l/aEbEzQIaKpCUeOxUHjBrQ7af+WX+tkxZWuez/xK
 BdgpIDm1Jgjx/xMMUae+T4n1+ATDfvYtfWOsvZ8P0jMJFiQsX4E/OMYMSwEB8JC50sqiMAMWTeT
 470kLx6gh13qbkh9VCA3NBiFazh9D9TR5PtgoCqwRHZHvAW5iRPL7qdlOqQd2eNiDg/HrPUT2jG
 bftQrzmWv4+4bKDvr4QVXik4VqvZwgpvZJR4x5M+bS1ljznbNBc5SnTuN7/T5SykMylVKByPeFo
 wyinR5QhYps3p1Bnfhn1T2ChRPCYtOQSr8m6nphx7RPAC1H9+AQmlVVtUwsGBvhrOnfl24tReUv
 2RJtjTyomFLfGtA==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

When IMA appraises/measures a file configfs, it has an opportunity to
hold onto the ima_iint_mutex while another file from a different file
system is attempting to appraise/measure. This may cause a cyclical
lock dependency.

Add configfs to the default don't measure/appraise lists, similarly to
other pseudo file systems.

Link: https://lore.kernel.org/all/6a77c7cd.b50370da.49fe0.0031.GAE@google.com/#t

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Frederick Lawler (2):
      configfs: move CONFIGFS_MAGIC definition to magic.h
      ima: don't measure/appraise files on configfs

 fs/configfs/mount.c                 | 4 +---
 include/uapi/linux/magic.h          | 1 +
 security/integrity/ima/ima_policy.c | 7 ++++++-
 3 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: f1e10b10874051e4d99911dae0dd7b75a9f8ae66
change-id: 20260818-configfs-a248c410b083

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>

