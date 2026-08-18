Received: from mail-yx2-f9.google.com (mail-yx2-f9.google.com [74.125.224.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AA37204C
	for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2026 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081733; cv=none; b=QZVXyAhVJnLAs5XBSSxq1+7TLwWWKCePNdFh8MuWwPOIiNNVbXi2VEidyxNmcd6uPvIyg8/P0oE3zmV5tst9pbnJ6pP4d2eGgmJv2JTuCw1qBhEqtDrUwwOYL0UQgfs3+IOPDGK2wtMXGkBRcv1TDwI2gEDTBV1PtaHjNPYnyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081733; c=relaxed/simple;
	bh=7LZjP32jUfaZ5RKmBNaB9NcgyxlHRwbSA/1nT2Radhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0st8cQM5KlVzPsEwTH242HbBo878Kvc/FGJzqjk07VH8pfE+Ehw2GKn+IZyQajeYHOZ3WAG+pfU2CexULbK7jiOK2KtRpu84h+ua5Mv8g8zPzo47eQNhuKtQFrV/dXqxvCZnV+cv6RYkEujcuYG8jbi7PRrb6SA2XDZ0wN1Uqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HXaYmoUt; arc=none smtp.client-ip=74.125.224.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HXaYmoUt"
Received: by mail-yx2-f9.google.com with SMTP id 956f58d0204a3-66c711552ccso409570d50.1
        for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2026 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787081731; x=1787686531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3UXJUp6qjJ2HIYsQIMwEd5fSfbeRNaFsH8a8Xw28Ey4=;
        b=HXaYmoUtBoAj1nnNe0YyIgi7sRHAU31p9sq6rkC8N4iIBoSfZD/vFRG33g0Tio3fIb
         KErGPdd1qvTTHtwWmPr+cYPVt/KkA3WVDscLQzGeP6X0Zj7ZV85vEmGiWz8SsAlJJNvv
         Yh17WFGug6XbGqFODcskEj0pSav6OA7xpUkOfR9FymM+z6JEphP/e4WE7j4XunJ8sCQw
         r2TmqVUOqds1Po05fylbua3tbob6tslUAvE6/heU2EvkRuKH8plQlWgHxdnJT+fmAoMH
         b2hobCtE3bHMuQBFTUnlFguTV6aBcUgBEAAdoewoG8beIMlTQcG70qF1MOusxrytrhdH
         d36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081731; x=1787686531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UXJUp6qjJ2HIYsQIMwEd5fSfbeRNaFsH8a8Xw28Ey4=;
        b=gB1K82fY+TDa6YrKTX1TK7MeZDRB/zI/hfTWR/ojYo7vtOmzaegH566dL8jtPmCDVb
         uRwf6s7DJy/nAE/iD4ahlvpN6trQtCg0NCHFGht54Bfi/cSC0cJ0dVsZHyf7br5Eo/cO
         xDjUEo1CXmeqDu2cUROQVHxH90oLKd+jLTg7JyObWKvd+2zIpSnHjsdxOicYnYNW0FwL
         JapiKtnRq34Rb6cPAg0CMwvsMFmLfSugSVAdz6zLQkHFsziahYy3aQhlicCz4V4px8Ob
         /N3HyahkAnNwA5oR2mp1c4BuV43IHxCgbZpY+5cotP+yVWe47m2L+RKdXSxKSJE+8N66
         jsqg==
X-Forwarded-Encrypted: i=1; AHgh+RrkOJZ0yt+GNL0VT/mjADuGpUqbpry5pK5qU8hf1IqA815v+rt5zrCY74IZUrCy763A9ni4l30KeAZA87TwWf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSNWM42yagA8bdGxdrjAd5Oj8YAX5WoONTHewm9Neh3kaOx1O
	scHcD5oGQjghBOovWtF5P6sd167NFw8Us5IusYlwFbnYmXkxGtByxL4qWLzcNh+/aFH85GuVBXs
	2oDdfqRYAZ/60
X-Gm-Gg: AR+sD13AVOBXpLQCqAswcyww22VzYl7ovG3hWJs5DHJVesHov64hCT5zM4uinsMSJvD
	uJ8ta0oEoSg+dFo+0sRY8CqPtxSJjb9JsNaWi1++QXV1VsW5ThShU4z7Yblms1JPt5N6Kp9Thug
	xqQwcmQ2zXgpuk7axfKy5Zccjd3w3JFt5i7IWRy7B/0u4uuOm5Z113p3b7Lsxw9ES+5nxlZtRhn
	hqdY+udomzVxMlC4XV7hcaNQH/ebBf9qZQsyv1RasPvhnwuHo/itp6M5L5jA7okUHvzhJbsvaRR
	I0TvVpRcUH4aMKB5YG7Fj5wf57t3fGA3MEatdD1osXvAd6jrwluEL5voQWedA/+NwXNsEuqXDeq
	vNf5fyasDnohos6uBQRPwKOb5RPZ2nyKJYUDgonaGFYNJwyQBGfxneMBdhMP1truGObBcLcD2Q3
	k+T0MTpEbjnYdjcVVQqBDbgjjDu57RpBMyVVaatGqr9inh0tVdTuRgZ+4=
X-Received: by 2002:a53:bc0c:0:b0:66b:3c40:17e0 with SMTP id 956f58d0204a3-66cca5db977mr58091d50.43.1787081730600;
        Tue, 18 Aug 2026 12:35:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:52])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb47809c6sm2795622d50.11.2026.08.18.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:35:29 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Tue, 18 Aug 2026 14:35:16 -0500
Subject: [PATCH 2/2] ima: don't measure/appraise files on configfs
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-configfs-v1-2-a2329043cf86@cloudflare.com>
References: <20260818-configfs-v1-0-a2329043cf86@cloudflare.com>
In-Reply-To: <20260818-configfs-v1-0-a2329043cf86@cloudflare.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=7LZjP32jUfaZ5RKmBNaB9NcgyxlHRwbSA/1nT2Radhc=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqhLP9Vx66id6HzUGNVJl0dOeeNDs0MBZQgcfLJ
 ozGhqJGiNaJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaoSz/QAKCRCrJbR2A5LT
 bQVIEAC1Z72vgOQ5JGNsxpTTajJOI51TP6Rnol/Bx7J2tcFGgHnnHtMnf5fd/EDtCDec5qNK4cb
 rhvU/uwkK0HBll+nTe32AAgK9R7ABEF34DZPls68z5hz5cJPyNvpfDY/n6SkHkxT+DjKfgK8qPz
 oMmLJs7AgQvQRBjF/YFZbFFvWOGkz8tJ2ar1Bz1bf31+CgbqwIKakWokyp92wdjbXdCIyor5Ovo
 fOpsgCFUEZjgvovWR1w2ITdKCu6rn29UldScCH1TdpmE523wL/POA8NSV2060fEpzuLcP27mAPD
 IDes0e25PVxznRDQ0tY3foFCVaH06CZqy3sT7KkFq47z0enMvmF0nzn0LPLz0mgvjV74WkDWYay
 igd9xjoO+4W6WfzNd4FHague17tw43Gyaigmcc4PWvAZCojhOL5mf8/t8rRuBF8z/afkKdAlHCB
 VC5vtDKqpHvAobWdA7m/+hytXaS5lNB9GtQYQn4kyfdUw1m2ObL+grd22K3OgtFKFPVxbJ70Er0
 cfK8N98igspB5ILoHEIrkJ47vQBBIspKykEujbZisq2n36e7XRxC0F5ZyLWH33Hyt7hq256MJ5J
 jisxr61kCS5tdm5bGlIBi4Fb3AjSH1qVmtN29IRONnbbsuJxZl4jLxDVCn7Ukww5lQtwbN8P682
 qIzx3FXQQ1caHTw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

When IMA appraises/measures a file configfs, it has an opportunity to
hold onto the ima_iint_mutex while another file from a different file
system is attempting to appraise/measure. This may cause a cyclical
lock dependency.

Add configfs to the default don't measure/appraise lists, similarly to
other pseudo file systems.

Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a77c7cd.b50370da.49fe0.0031.GAE@google.com/
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/ima/ima_policy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f79d07bb63c6fc4ba6fe594140de8d59f57e4f0b..68d9a5e6c232ea0678e9f51f105cebecccccb43e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -165,7 +165,10 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
 	{.action = DONT_MEASURE, .fsmagic = CGROUP2_SUPER_MAGIC,
 	 .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
-	{.action = DONT_MEASURE, .fsmagic = EFIVARFS_MAGIC, .flags = IMA_FSMAGIC}
+	{.action = DONT_MEASURE, .fsmagic = EFIVARFS_MAGIC,
+	 .flags = IMA_FSMAGIC},
+	{.action = DONT_MEASURE, .fsmagic = CONFIGFS_MAGIC,
+	 .flags = IMA_FSMAGIC}
 };
 
 static struct ima_rule_entry original_measurement_rules[] __ro_after_init = {
@@ -211,6 +214,8 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 	{.action = DONT_APPRAISE, .fsmagic = EFIVARFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = CGROUP2_SUPER_MAGIC, .flags = IMA_FSMAGIC},
+	{.action = DONT_APPRAISE, .fsmagic = CONFIGFS_MAGIC,
+	 .flags = IMA_FSMAGIC},
 #ifdef CONFIG_IMA_WRITE_POLICY
 	{.action = APPRAISE, .func = POLICY_CHECK,
 	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},

-- 
2.43.0

