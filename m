Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF832488229
	for <linux-integrity@vger.kernel.org>; Wed, 16 Sep 2026 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594623; cv=none; b=evGZhOZS2S+YsaW0JYOOzEkO8QND6VL2+b1NdHOF5y0DdOpbIdn/uFwAOUiCyh4TZVtsTSrnRN4NLcda8RE9mN7ZB5V1T+jQmwKpq4aOo6VgMqZZQEvvH+fpm6s1fTgf3KUgRvLAS+Uju4iFjubb6WZ9hjYyeATeGIUaIuDoZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594623; c=relaxed/simple;
	bh=IyuajYzPnmD3io9Y6axVM5mE4O2sgF3cAAOwkQSlc8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uBiJtMHBeTTCEQ8V4A0ebkXB9swr9NUgGHG/PX88OLoAXiKEk4LY72oEZYE0wmYy6gBVDXqlCERUa4LVAoKt6F1n88Hiaz1K3joflEZS34XMmFWsMKuRlgzVxkC2cM3yS5hXtel5Eq0tvHVy/sLosSgY925pArKmvp9Xzh341RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cpDtbHpE; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cpDtbHpE"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4b94bb43008so35209b6e.0
        for <linux-integrity@vger.kernel.org>; Wed, 16 Sep 2026 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789594606; x=1790199406; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NLbXNfixPvdVNUANDYuEZ718E2/Tpe1XaOhwQtbxwPU=;
        b=cpDtbHpEJwR7gpRgwVHreVgTdmJBBhBI+wBIZ6sGTepgmt38lQc+imlFToKILs8xMW
         cyzXl3z7d5ZUgOngTV7fL07Opfw+J3bEl6LcHEiqE59ctzpKSXmibU/lf5dYyayy9Dym
         HWMngn528aNQL6Z0dJO//8zyyhH0TtKKJEviVnQr0V00AxTs/HYM+pnfhGc9nIaROExP
         76yxHUaH+G43VuFLJTy8+zvxVYDu/sPKRqweltvwfkW8DK5JsOqgqNPrEEosdd/6Omua
         ZJApwaa2eIYC+c5i/+p7PlO6OwL01InJ2qu/N+1KW0/QTAYTFiednKlRGpAzJxZwzOVZ
         Bu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594606; x=1790199406;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NLbXNfixPvdVNUANDYuEZ718E2/Tpe1XaOhwQtbxwPU=;
        b=qLkJFXIOURS32pTHM8h4e8MW1N6IdDd8G6CMGtH6Ts2ECtYqHQtpeg/yr0bbp2HXo2
         fxh8LoT/EKpN6a3MfKKbJ0YJ6aLcEcIFty5TCK+Sjt88IfDJvhiEc9PaRHwDtcVGxXp/
         m1HX30pVjVY6j4R8abW4F3BUMT/7gbueiaJ37XhF1ohKIu89Z4qIYfnUdkyr8adycBYG
         JsHkIJ6DvDNh6/GwlGncSZfVia+q/OluqjH4y0u7wIHpiH41rWjB32f6XS8Wp911hL2H
         31gfA4nyr17eyoKLGiKKQ9h0fcR8y7T31XBhGHFbLwD9nECzMydgfH+HjLWFkfnZha6K
         LZuA==
X-Gm-Message-State: AFuF++kst+Wt1+DfnoHycg5AxIH4jAtuJtd+KWFWt2mwTaKNt14/whVT
	gkM7NaQb2IwM4VM/ChQfneY9qeGtXS3mHnKdSefFxArOPACND4ltoJldZzx3P1QdHqE=
X-Gm-Gg: AYBFou30gLI+eiVo616vO6AxW2W1qDVWqoRQ6gnmzfw+O18GHV8B+zwDkG1P3GUCGJ2
	7kCAszKw7MRut2T3MoCreA22w9mhP0Nf/Cv/mZMSkqt8G0d755whTOLybEJs8/7MX6aYZgduq2n
	ITizjNyMiwVKLNY+/+h5BZjzdMA3e4mnG4iGBeqgxsD05CCh6gaZOwGz2dUNJkKuPBEcaAElYms
	vuB4KVNjRCFwwuPQvtM9ZdKKHyWXy8FWa1TlPquxOR3K9kZMCh1qt8mAgM0qzxhjJWLRm3ZUpAp
	cQaAkIKLRyBGgk57FPHI2uUJcdVmD9xQwxL628solDaUM67P4caL6BrNqaTpelinemaZRVoX5eQ
	VRFeyeEHo0CtlF86zQDvlBmOCVfoy0w2LE3bov3N36eL3e/L+c8NX/4pPNGQRjnmn9YajylUcqy
	dSSKSvX6Msgd2TxwxB7wG52c5lv1bftRt0qYSJKIkak+uw8OxDnbQPdlUSSQ7mJjZ4r4VI
X-Received: by 2002:a05:6870:5ba3:b0:457:4470:96e2 with SMTP id 586e51a60fabf-48475e836bemr4313868fac.12.1789594605928;
        Wed, 16 Sep 2026 14:36:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:31f5::4fa:4b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4842a23e310sm3387557fac.12.2026.09.16.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:36:45 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v3 0/2] integrity: Return error codes in audit messages
Date: Wed, 16 Sep 2026 16:36:36 -0500
Message-Id: <20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQLq2oC/33NTQrCMBCG4auUrB3JTPqjrryHuCjpxARqUya1K
 KV3t+1KUFy+H8wzk0osgZM6ZZMSHkMKsVvC7DJlfd3dGEKztCJNpa6wBOE+ygC+Th5YJAoUpE1
 TOi45Z7Xc9cIuPDfzcl3ahzREeW0vRlzXf9qIgFBbPNIBEYnzs23jo3FtLby38a5WcqQPhqpfD
 IEGo9kcc1dQ7uwXM8/zG9kvSCH+AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=IyuajYzPnmD3io9Y6axVM5mE4O2sgF3cAAOwkQSlc8s=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqqwvq9XE9AKDW+jkDoMPrQsp+EEVhR+0vyyfSE
 YsH584XbHKJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaqsL6gAKCRCrJbR2A5LT
 bfd/D/9DyM794xZCuCYiEp8E5G2ZlX/+MtkM8PpZR9/dOjmllI/84wOLM7fbud6MxqB0sFqJ1qc
 iQfPLsd+8PaifD4msMqMG0phYciWNwaJsRzCafsPv1++FbcNW8UxkY8ToRHztgTlPxbCkmaBC0Z
 6pqBl04uIPonxe5C72WGGTLRkz+aXEO7I38ySL9ez+ZyP5Fs7pGKUzIwYZEj+SqbtexLQpcfjXI
 91damz+0ON/kswGm1HNvnpy480xhISbK13hxvZoumQfkOwcrp1DfZreUjRjEZ6Cp0LFxLnhr135
 LrRyY5+UnySsfVyfoWnhZku2sVnzASQLAeDxBW8Yn4w98JI+PNRucWA4J2OGb0Z95uvLtJet/S/
 +3RklEagyndq4uDeftKt+SZYAgr2Uo2MCM9mvlTNlAntjjxeESypLO/94JlVGYMDl6Lvu+e/oyP
 crNS9NjS7SMdGFyAMm+L7ud1licAoctohOUa146AKksNJznngrSF6eoYBAQE8x6N1YS3kLUJ3bJ
 Dro/dhx9K0dyuY32ihvbcOmZ17pxs3CAiHttYSPNzCxLDzV0oIx04ug6CFUkeS2o7+AfMQZDLG2
 x5Qwm+bHSuH1GkhMQXsM6YOQImjxWAr5PEfIaDfmoD5BUe0IlMaMbNm7QUwEeNo3eZFowa7PMvu
 F7VT2pXl6cmquMg==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Commit 2f845882ecd2 ("integrity: Add errno field in audit message")
introduced an audit log function that can take an error code. It is
wrapped by integrity_audit_msg() that implicitly sets the error code
argument to zero. The problem is that there are uses of integrity_audit_msg()
such as ima_collect_measurement() that hide the failure cause for
the message.

This series aims to clarify error reasons for failures, and then expose
error codes based on the following criteria:

    1. The log depends on a result from earlier callee, and/or
    2. The caller function itself returns with that result

ima_release_policy() is the only caller I thought made sense to keep as
is. The message doesn't correlate with a return code, nor does it
depend on a result from an earlier callee in the function.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Changes in v3:
- Condense series to two commits.
- Reduce review churn by adding error code to integrity_audit_msg().
- ima_write_policy() to report -EINVAL instead of result.
- Link to v2: https://lore.kernel.org/r/20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com

Changes in v2:
- Changes from v1 are now reflected in patch 3.
- Replace all instances of integrity_audit_msg().
- Convert to patch series.
- Link to v1: https://lore.kernel.org/r/20260716-report-hash-error-v1-1-ac19281112e4@cloudflare.com

---
Frederick Lawler (2):
      integrity: Report error code in integrity_audit_msg() call sites
      integrity: Replace integrity_audit_message() with integrity_audit_msg()

 security/integrity/evm/evm_main.c         |  9 +++++----
 security/integrity/ima/ima_api.c          |  8 ++++----
 security/integrity/ima/ima_appraise.c     |  6 +++---
 security/integrity/ima/ima_fs.c           |  4 ++--
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         | 13 +++++++------
 security/integrity/ima/ima_policy.c       | 11 ++++++-----
 security/integrity/ima/ima_queue.c        |  2 +-
 security/integrity/ima/ima_queue_keys.c   |  8 ++++----
 security/integrity/ima/ima_template_lib.c |  2 +-
 security/integrity/integrity.h            | 18 +++---------------
 security/integrity/integrity_audit.c      | 12 ++----------
 12 files changed, 39 insertions(+), 56 deletions(-)
---
base-commit: 6903878d4654bdef4e08e38cdf1ae306ce7de5f9
change-id: 20260716-report-hash-error-5203d6fe6e4e

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>

