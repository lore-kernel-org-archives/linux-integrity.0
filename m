Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3323DA7E3
	for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2026 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190923; cv=none; b=L/aR8Cap+vr0Cmv9c26Q2nanWRSR9SREGyDfo2bf1cRusBKqcYRchC46y5yV1PGiyO7X/gHzquhRQOpY6u68NT5BlEnrfZMCSQpPFkDv5AVa77icN5uyg/T28S7gxUnXD0IrL0le8lD1gx9Jl2YKcu9GGa8SoKIIRlWGXTqGQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190923; c=relaxed/simple;
	bh=0PCn2MpUCydMBssMbLxNjbRlB5gzYl0SeHHufrDng3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9jukjbuHSOgdMoo+wvl8JA0kZRIV7iVoTUw35rPl95tZBHTBX44Zw7gmSseWE/n3BHmSXb6icba4RgRWjE7epfRX8XKfecePiiOrWsNfNjihtoWfdiKjJna1TUIexpSLxNZbuiVoMrlFbz8VAuJL8zssyIRVcweYspVZoVQkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RX7KGCj0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RX7KGCj0"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80cebd41372so37005067b3.3
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2026 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785190921; x=1785795721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2nuYR8orZEuPtsg4qTKJhHkZ1JkdlEmSYy8R+O9Ctg=;
        b=RX7KGCj0TNyt4nD8wGABpbTiU6zupxpWpmvH2y7CueCMJPjxfx2S19kCnhTw829J9B
         aaboDygv8yzkEK2ZMVNY/jNuH4RihV/EE/9NPwYlvs+XliOR6a/JRgMt9t59LliAgtwX
         8Ec6Pui6TSmEtSUDCOlJIxZ4+I18l+0r3iXlumPpk08KNBYk2sVP6sSDgI4YQ1e+XY51
         xFVAyWQW0zl67F7oSQXFxJBdn478P+TWEZeCNDWB3SQcqfu5OJhjlBbDJODLE5LSYWOV
         KOndF/hu/t8Zad9/DYcOcGYZGmhkKhzH1vUB8jV0LWczTiCyjhTLhUCSTxRRiPIcTNmr
         lUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785190921; x=1785795721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2nuYR8orZEuPtsg4qTKJhHkZ1JkdlEmSYy8R+O9Ctg=;
        b=rT4qB48sf+5TRpnYmptpReps0y9POrHOMTIy4pwrfGfLkp/FnsUuUrahwBs9f3Ug75
         WoLSB18QYaVaFrv4pDPBdbYpcO8fFaumrkewikGL7mhxSdkVxwhe3aGRbJMJa7TItGgA
         4/zkQRRMLlk4ZoXCJrs2xl/v39b2II9TQYNdR9Aph/LaTAEt9ogPgr5FUhRc28FkkCey
         0Zqer/XzkP903vU/F2P2oPTsJ83AW9//CvEDDMQKEKkPMhHUN5y4dMNUtCqKRD+FhiLl
         9X0vZDi64MoEirkhhmlmYGKOIqFkPq9Agu2XdW45tyhHIsJPqcBRBubu1C4fcr4DHjTK
         ENtg==
X-Gm-Message-State: AOJu0Yy4lbKqBXcqIk03rt+QtER5WMPPCf+nAhr90vpGFdkgubseIvNQ
	fOYzFrT4lscMm2jfMTkZoibwPAl1KjWIyMZFxlZIAzIqVKUMkJ7QgKxmK/DmdOo4zTE=
X-Gm-Gg: AR+sD113d3/e5w4m/am6wwdWoWC7ZIrK7e+j/o09Kzj8W+Lpxr0N1h56yyTWEwIn3mx
	hn9SQkypNrcbIoSm1718Hm9GhiyX/J6Bxpo9ymIU7AvombCeoomxQOsxmfNlq6ZQighH2Irr9EH
	Uq7dmlW1uc5DqkpidD1RSFBbDv7G6Jj6YmBUm21W1lFYD9CtWH53cSHUA6aF4TUR9l/HPyx6QqA
	W2F+cGhvZ4owWu/xcZg24y20Vj3WGHeOGLnxPUV+ZrA4B+2uUICt/acfazF9oLAkxNKBzL2Z0LF
	O8+PKtYoh2qNI4/quO9KqpzcbmDLxAvPdp7y2a3iNva57wFv22Nw44IFbv8sH/CpXIH3Ba+X2Qw
	KMiOLI5lwTl6d1+aey0gG5h5pU2oc9TXUmGUWm2JoSD0UsP9RbnFEwlgGT7W6Wg==
X-Received: by 2002:a05:690c:4b0b:b0:81f:650c:98cd with SMTP id 00721157ae682-81f69d434f2mr36442277b3.28.1785190921027;
        Mon, 27 Jul 2026 15:22:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:7e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65774b02sm38756017b3.5.2026.07.27.15.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 15:22:00 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 27 Jul 2026 17:21:48 -0500
Subject: [PATCH v2 2/3] integrity: Remove integrity_audit_msg()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-report-hash-error-v2-2-30e394f524fc@cloudflare.com>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
In-Reply-To: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2315; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=0PCn2MpUCydMBssMbLxNjbRlB5gzYl0SeHHufrDng3E=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqZ9oE4VqDkyNYae2DqILNMi/RlCrjtOrbwEDV+
 vQiCtf5dJOJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCamfaBAAKCRCrJbR2A5LT
 bVjLEAC6SXXHUnvSgu8uyB8POWrQLY91wyO1aDDhBgRMhj5o3+sF4XN9qLrZvtvNC1et2koo5Q1
 JOB94wFD3x0oRZEB1STtFPVKcVizX3SxkLB19gL1FORQK8HpIpA2cORumTFtXgMwaXLdLu0vm8P
 Kp1t5vqoJc5xXbd8T3nekK1vQEaXMYj167LNOd1YgCmlEJ8WlY84dWwdzVYd6ps8jGNNK5VBI92
 UuuHAJkrF+dbDjsFG0vUByGsB+JeHCQ77H5vl829F68t2uzQJ2LjSpdQc11HYdeRnhtrTyUehXY
 2eCjRItGnI3AwX8ck6aShnjkIq40UPEaJL5nLnRzN3opBWtUQliVQ7wRljMbxkJomao6TSygsWL
 jwy8Y4vXjZkbFV5CkOKLpISO8j0Xt4TmXQnB0amFqwIYpwFU+3L7cnuDa4wltszOu2plUuPpf1N
 uO6RtYEPb8DntQZ4WioJm1J/C6o4yh+IiTmCbfwFLa/OHEcliLFn7t5aJhSnUy/l6h0MQ2wVCS+
 BhFcg8bIXO5r4bME1W0VEtXt6MOcua5Am3ufE1XSJlQxh//uSLTIQw5uZISDjjux0ya2biqrH7j
 Uadnwv8RzxFvnEmKjG/fP8EtSNGKLeIAzVXeDojTgG3r7+MtCKo0LpS+h//EXn1K4P8iW5YA8pI
 qK/mjFQAHgY09nA==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

There are no more users of integrity_audit_msg(). Remove it.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/integrity.h       | 11 -----------
 security/integrity/integrity_audit.c |  8 --------
 2 files changed, 19 deletions(-)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 0c581c03c5da72d80e9c352a7adff1fb89628644..1a88c245f3dde01ceb759383ef870c16de80626a 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -216,10 +216,6 @@ static inline void evm_load_x509(void)
 
 #ifdef CONFIG_INTEGRITY_AUDIT
 /* declarations */
-void integrity_audit_msg(int audit_msgno, struct inode *inode,
-			 const unsigned char *fname, const char *op,
-			 const char *cause, int result, int info);
-
 void integrity_audit_message(int audit_msgno, struct inode *inode,
 			     const unsigned char *fname, const char *op,
 			     const char *cause, int result, int info,
@@ -232,13 +228,6 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 }
 
 #else
-static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
-				       const unsigned char *fname,
-				       const char *op, const char *cause,
-				       int result, int info)
-{
-}
-
 static inline void integrity_audit_message(int audit_msgno,
 					   struct inode *inode,
 					   const unsigned char *fname,
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index d8d9e5ff1cd22b091f462d1e83d28d2d6bd983e9..cf98d00f1a1681ff738763d5c4d95c025f7d9ca5 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -25,14 +25,6 @@ static int __init integrity_audit_setup(char *str)
 }
 __setup("integrity_audit=", integrity_audit_setup);
 
-void integrity_audit_msg(int audit_msgno, struct inode *inode,
-			 const unsigned char *fname, const char *op,
-			 const char *cause, int result, int audit_info)
-{
-	integrity_audit_message(audit_msgno, inode, fname, op, cause,
-				result, audit_info, 0);
-}
-
 void integrity_audit_message(int audit_msgno, struct inode *inode,
 			     const unsigned char *fname, const char *op,
 			     const char *cause, int result, int audit_info,

-- 
2.43.0

