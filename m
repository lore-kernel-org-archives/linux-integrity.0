Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363A6443307
	for <linux-integrity@vger.kernel.org>; Thu, 16 Jul 2026 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229062; cv=none; b=SNGXnsa4mXVlQunUHoajlAv02Rq66XVCevDQf1LgYC1DcjEUe1u2GD+eetch8rFIPbPQB/Xff6Xk/yqsl+c+0/RpaUTq+lQJXl2Y+0oeDqMmncddHyv6URo4xQVQpAyaDiKjW/PcAbrf82Zx+9KOyr6RKrSUEdjoNNGYyENSJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229062; c=relaxed/simple;
	bh=6rQO5dLbgGRQ+1ZAuu7llJFe1zRdMpO/COtyJ3jbmRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OuVVXd2Weyomb9UvqtHa/Q1U/oK03JECqACNZpPlxAR61tLOskli8ehAc40heHdWFKBORXE6TVxDY3rhhYyDFv920jwFZnCrZQZ+4QPhfotqZKopBrjCgbKOuSvVGySkfa84sutdP3yMggivsZS/pGvZn1AgEUKdU2+Li8w/sMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aL4NfT/w; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aL4NfT/w"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ec29f1d07so38766517b3.1
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jul 2026 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784229060; x=1784833860; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R6zePSti7ASS1ok69EYQ+PkxSi0XpyrM1Y8fQpPG17Q=;
        b=aL4NfT/w2DTQM/eRc8mJt1DiZrPKt36EYfo8Vf8TvmSlrntB7TA9Za6CfURrW75Hqs
         dHnueMjIl+6wRJf4EuwEOvWLxdiKLU3ZUW30rQb3d023/0N5htfodWORkSIVFgCMEf2g
         xt2DP2eA6kVu8iJOlLj5WaS+JH9m/teMe3Y0VqN3Cu5yXHgkYw4Ek7SSza5eeOXbwDy7
         AUsEH9Dl7HNYg2KBW7AcBjr/S39Pt9x5t5sWcZddhxpORtd2ouvVU/wLhQrMeqlZv2Gb
         Bmh03fFkjJcc2Bxjw67RHpclI414TP5QSxlrbppijIcmqnnT40HCZlCtahscI4snjuPG
         bP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784229060; x=1784833860;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=R6zePSti7ASS1ok69EYQ+PkxSi0XpyrM1Y8fQpPG17Q=;
        b=UuB6zKB0vG+ZDWdSEhMVITaJ/aVKi9/pfHA4uLZMZZH5/TDQdWC1ezr4M/BZo3AR89
         84Tv7SmQUmjBNDcNlKBZzP7SPj5Ry9ZmQmeZ1ygYmRu2JCGjExyobRYYc8BGxOzDgJjg
         8cwGIBjgu6r+3uN+Yhjxyhf//m4kZEMpq2a4p03dmt+yU/b1CvekKBE4cjGx1woq9Gaj
         npZ3VrW4F37yagiSCAfv4R/hdBjRFrgtpUlKr774zaTh/45/Tyzn6F4tZ6Iop0dyi8t/
         fSBNCB0FvHtTiLm0TVQ3tCKZGk54PB2hcwzlnhRYqtLOyAsdlwc98jX5BjHyPrUkKJ20
         QRTw==
X-Gm-Message-State: AOJu0Yy3RhHVtdQ1z2E7N3J1KkFhGBMRfh6GQUu2OAm60nZ1JgkYDdUU
	p78m9uaj7cg27P7XMNNPquuL2KndNFSakjZwvYyLqr0ICSPU6v4CDJS9rLlfYqZe2uA=
X-Gm-Gg: AfdE7cm6sjeeklSezn+bkFnP9Jvk3rEMQ9EGtmCYhUsEF/GZKEJze2rDVltBSEVMbdi
	v9qZAEmXvpspxfiUS/4Ru4YbmIU7dD+p7RK97OpN4v7okp2DyrOxSzBBZM30hWT9mcfAqKaV/Vo
	R+MCCnpg+FGl96XrU/C+js8aAjD45I1Pqdyuj/cwRgqavP0dPxHJlotUG+VlwNjrvvejzaAw9xR
	ocqDEeJN1Abwt50VHXnaGaFQw4KojkNzHYvt82bGRT5PfnPUNlPwOZkQVTe+zio1onW247fB8NB
	vjZnkLycK1UIzpsmruVzEq68NXEUz96H5mhxcVHa7+QZJAi0497OQMFLmtca3OM9d2ZoTw1VGxY
	3QSmVdM19dnhTU/WQIfH3DGx5S7W3Oj0advMBJxvu27CWdTvlzfAhgIpLDyUJxA==
X-Received: by 2002:a05:690c:b89:b0:81e:6c2e:f112 with SMTP id 00721157ae682-81ebb143827mr99516067b3.29.1784229059946;
        Thu, 16 Jul 2026 12:10:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:5d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1feb43sm203389297b3.40.2026.07.16.12.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:10:58 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Thu, 16 Jul 2026 14:10:52 -0500
Subject: [PATCH] ima: Report errno for failed hash collection to audit
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-report-hash-error-v1-1-ac19281112e4@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIALssWWoC/x3MMQqAMBAF0avI1i4kUSN4FbEQ/ZptjGxEBMndD
 ZavmHkpQQWJhuolxS1J4lFg64qWMB87WNZicsZ501vPijPqxWFOgaEalTtnmtVv8GhBpTsVmzz
 /c5xy/gA2KUeiYwAAAA==
X-Change-ID: 20260716-report-hash-error-5203d6fe6e4e
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=6rQO5dLbgGRQ+1ZAuu7llJFe1zRdMpO/COtyJ3jbmRY=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqWSzBUkGz1q/QWLeGB1fUyWH3Z64mEUvXwOwq4
 rEqWEqSD5iJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCalkswQAKCRCrJbR2A5LT
 bX1kD/0TA2W9QxMW7K02h4WlhGcpConfF15FeMjj9TZ9OPmdJk1Fes35cjdNx9np9ZH09pwiqo6
 a7kOX4Rcku9DkXALke+HytAruvoN6aKsHVsloyD4YUBHzA6dxoKnC8mKabwYk8sV2y+nU2dTFDT
 2PCFtVKCGA9yrLXi6vXOgl/+7ObSVhJPnB4A3wzamyYw9o43U6pbh6RzHbAMGuEvL1B5PnrGIgT
 Zq0tcPLTJhgK1IC2BBDHNHPvSu7Rylz2YYIMAFcvnxBlrYSADon8/pwksT4KvD5TskblzMbS6Cx
 Ef7QfFtq9+3jN72kdB2n3brzW8lupYhV+cmBSiPBOpqZBwRDfPWCklDe1AXk8KcZxmiKZRDvbk8
 Ox3OJ28L+im7SQ5fg+Za2pnxZzfGr9uBNkePSbYDGxTmF8+W/t2jdLGPK+p2R4XvghMpLTDT2el
 4DqBpN+FIcEE/7rkuomWimoxHvHb65n7LO3PQATzQdL7VZKIFF7sdjDn6AjBRgyaim/7GBB1K7N
 /v9CfdB5SpphXmglVM8yb3Ll09meRUc2S/OEAQV6LMw0QKXjEsG8e9CxLAgLJBHSAk72sJicq86
 +Jth6lPe39EkCyjsxLQP9EMsoPt4EPxAsJmLt8hUllNMIJcGH2lsX4UTicjv/V2nmWSfl8WgRUs
 dK9Z3IZjEKvyUAA==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

integrity_audit_msg() wraps integrity_audit_message() such that errno is
always set to zero. When debugging for failed hashes, it'd be nice to
understand the corresponding error code with the cause.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/ima/ima_api.c          | 6 +++---
 security/integrity/ima/ima_template_lib.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 122d127e108dcca8ddae6575c908144859783fb6..15883e4f077e0aa950f3fdd4b573873929da68aa 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -328,9 +328,9 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 
 		take_dentry_name_snapshot(&filename, file->f_path.dentry);
 
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename.name.name, "collect_data",
-				    audit_cause, result, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_DATA, inode,
+					filename.name.name, "collect_data",
+					audit_cause, result, 0, result);
 
 		release_dentry_name_snapshot(&filename);
 	}
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 8a89236f926c10af0dd2b2ef08fbe59bd8a78b66..6d163312fb4c47ce256766e997aac5f7375088a8 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -390,9 +390,9 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	    ima_hash_algo : HASH_ALGO_SHA1;
 	result = ima_calc_file_hash(event_data->file, hash_hdr);
 	if (result) {
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    event_data->filename, "collect_data",
-				    "failed", result, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_DATA, inode,
+					event_data->filename, "collect_data",
+					"failed", result, 0, result);
 		return result;
 	}
 	cur_digest = hash_hdr->digest;

---
base-commit: 1da739feb31b4fecae465ebf87ba44a97e44101b
change-id: 20260716-report-hash-error-5203d6fe6e4e

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>

