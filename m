Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4036F433
	for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081731; cv=none; b=Z5GbA6zsHR4nRei3rILT6To3XqAUvkjaNx0GpwC02twiHyoMu/z9PPROB5r2eA3+PNjdLRlYjyG5/rExR446FbChtLafoluhiG66Ifq2dMiNG/YsaVhV0g8qfLaOVz3coRDoOlJd2cuk7UZDPR/1EmPZTacTDcOpMKO+OKTjh3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081731; c=relaxed/simple;
	bh=4Dr8FUckZZs6x07b+xsKvc6HgeTnce7Z1vxgvZfvoJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivI4PTkxTSyJ6NSoekf6WNUZcxcOtpER2KpDxAJuR0dN4I8fLDWaIfcIfuKZLpfyQUixVFnNKpF/+C9kQAQ/xohOmDDd0gvrYE1A5Tt3RhnSacPptITSxVJbCD40sQ/ow3i903kEPMN7+5rbpVeQp9P3Qf2R5HZb2SoRlPLZu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZFAwIJUX; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZFAwIJUX"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66c7e3a2332so296368d50.2
        for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2026 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787081729; x=1787686529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rXoczBGO5I6N9TIC59uDIKSOp13YmyqaSWTBgCd4pCI=;
        b=ZFAwIJUXkjrCH8wddjUm4XfqvqvcqX9lsBKwOOmSsaNqTECOTB04LXgF4WbHbpfMWI
         QxeGH1aXcpi+um7atjAIOZcx3uAzeePU02P6WBSocdCKRRZ9TS8cd7Qcyr/T8UeB/JRL
         rwe0q4dsZqeYFFMg2r/YjFmmw83WPZ8whBw/Yw6V3zHB/HWRGUEu9e9BHm1SCGoT58ds
         Z3IRAgaUOyEjb3VAfZUA4jJJE0Bg+TJRMT0F1mmVAYwi9iAKmFM2PR+qnMiaHQYRPvJl
         WuXs8uFsUJTlr28hZnU/9GGCNzWzlcQLqZpaYngpiEmZ98tw/UGBTHAuYFThldRjINYS
         vSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081729; x=1787686529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXoczBGO5I6N9TIC59uDIKSOp13YmyqaSWTBgCd4pCI=;
        b=b8n4EwQBhwDBZbqZ8QSDOAErLMF63J1ZpDwNoIq5YHrcwuS2NJ9vd/wkWz8i19VoAb
         Jy4dhBTif/QkjKr4s/qiyfqa2wYYukHBR9GPzQJSu8Pj/QaSa7sgQJFGmYErNJTEPhYw
         HD97I4PaG4YjWc0u8X+X3ZcjsRFAweSEawbrLWWBtmv/4jaGV7zHHId9VFX1wdYMspzu
         dLcbaYWQOXrmVXXJqln1HupMLFIC6YKGC93sccyfhJIMbX1SBEKLV+cLfCInu0tz5by8
         Q6kzAqgyreS1lfGj5Iu9R5o0QFwV9h1q7W2UxLS86unrD4uVcT18CNGLvM4m0JBrQP/l
         mgfQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0UCaPVYEldla6gQi+yC84CwqkJ8aX+LICcoYU3evxGpKmUkmgstyUblX406ffFvrJpWvr1ujcYetVz8UA/xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRnXMHu4Pl3KzEJydqujPgPt2giNH4g7WXjVaupMkNnmAAeYnb
	USuugMlnhxSdZoPKJQga9/dfHhjUWDSViPzQXIYMuJABm5vsoME9GRuW6kmUa0wZWPWpnnWVRVP
	v76JLUEEqqw==
X-Gm-Gg: AR+sD13bYcoJ5sV1EIZqAHeN+Um/UGw6hekl++/oGskwt7IpygApPM75siYFs+IGjaQ
	47nNqPhcRDv5IdlS4HCv2YcUN++jROfC9kh21QFKfynr5nO6zTSHBu6fCtgERBgFwqWa1RjqC/F
	SdQjG0jGmoLl84YBSJJy3CvGEPHhExWw2jvQk8cb382VwxU363uw4XrEZqJCelduXUvoG6i6ZnF
	/jmf0f9rOK7B8NxGZ8MBX2GQEyxSueF5giwqL9JbgWuFwXm804UrDmt5XmVeoEzf1YR9Ek1K3pK
	iwKhaE74wT6hrBpBf+DAID8IkLS8l0v4YNa2h8OMTF2QXqYKryxSG3QPUfi6vSUUgKVGZiijfe6
	sitXSboUyThKPfuAZaeUDn4F4xCSPEQdG0fctmXipHoDRBPHTV7BDMExx6sCYfbL9azhT961guG
	lRsdJuQgnnJRmYt8cfy9Fxbls+mX+1ltz8P6gY0YyVgmq2
X-Received: by 2002:a53:a60b:0:b0:66c:85e3:7f45 with SMTP id 956f58d0204a3-66cca5a58bbmr59786d50.49.1787081728671;
        Tue, 18 Aug 2026 12:35:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:52])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb47809c6sm2795622d50.11.2026.08.18.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:35:28 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Tue, 18 Aug 2026 14:35:15 -0500
Subject: [PATCH 1/2] configfs: move CONFIGFS_MAGIC definition to magic.h
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-configfs-v1-1-a2329043cf86@cloudflare.com>
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
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=4Dr8FUckZZs6x07b+xsKvc6HgeTnce7Z1vxgvZfvoJU=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqhLP9geiL+zExdgGlu6I2vB3H1Nmq+DpnXKnnD
 iOAuL1cpp2JAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaoSz/QAKCRCrJbR2A5LT
 bdKiEADoWx9BRs0O46WPuq+MDXdp1N3M3QreUWuMnNAVw4Ky/3IG8DmWgIoGxMzcRZomE4vNk8t
 MGT3K7t6DZ4x6Yvd4gbP0pgLdrUnWzXfFrThoa3SW2icHYtdAwW8DbK5IWIob7zTAmVqLXRYiOe
 UmZRlFjAnTzu0uthejnbCkoFxy08oiO7aOx4pVVCbFD3PgAhvEzfLO5BW9UGncde9eNlzzeNRr/
 MVB+F71zPn+88yiYeEvTPydnRUss7ODtt+vXaAIhMjrSgQOSmiyvCzUAD7bUuws3JD5yT/V89v+
 s2CvnIv/9Tr0MUxfBLsPuXTskoiMzGTDcm445BkW/66k4SmpJts/a+7Mz3GW3P5jA/NMFsTPZ9l
 QNcMit0wuUw9vwZbF8CC+g0StQgmzHoYMqrLRB2+fJIA5iRUi+7pu8pgY6DqJeGVmLfC1BjwX8f
 yd/prGfsdrQj/HFoSQH+fQPYDhtOu0m1Hxn09ZC9Be7m712GPcCI36GwplkjO2wMCbuPvAflmNR
 cw4xKhMkoCpBBQAlKCwf36L3j8lnGjPjqtRdmohqkDic0w50IKG9dEhRGbl+XNlXFxj5OGzz+uL
 yKq8Oyr1hgRj8eQVketEXTF6LXlW7Y3IylTPq3JgT3PV3BsRxqrqLlDYZnHcegUJBZWRg2HQ3l/
 bW+kURz9M4JVg4g==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

IMA shouldn't measure or appraise configfs, but currently does because
it's missing from the default exclusion policies. Move CONFIGFS_MAGIC to
magic.h to expose the file system's magic to IMA, as well as other userland
applications.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 fs/configfs/mount.c        | 4 +---
 include/uapi/linux/magic.h | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 4929f343118946eaa55a539db4192e9c6621a8dc..d8cac1cbf3bd573a0549f2f044714c9d669205a4 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/magic.h>
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
@@ -19,9 +20,6 @@
 #include <linux/configfs.h>
 #include "configfs_internal.h"
 
-/* Random magic number */
-#define CONFIGFS_MAGIC 0x62656570
-
 static struct vfsmount *configfs_mount = NULL;
 struct kmem_cache *configfs_dir_cachep;
 static int configfs_mnt_count = 0;
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76ccae6e1c3310b2fae5379186548b8..d5b9958ddfaae90b270b66fe7853c5a3d49ce739 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -8,6 +8,7 @@
 #define AUTOFS_SUPER_MAGIC	0x0187
 #define CEPH_SUPER_MAGIC	0x00c36400
 #define CODA_SUPER_MAGIC	0x73757245
+#define CONFIGFS_MAGIC		0x62656570	/* some random number */
 #define CRAMFS_MAGIC		0x28cd3d45	/* some random number */
 #define CRAMFS_MAGIC_WEND	0x453dcd28	/* magic number with the wrong endianess */
 #define DEBUGFS_MAGIC          0x64626720

-- 
2.43.0

