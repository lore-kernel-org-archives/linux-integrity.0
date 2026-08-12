Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E325B08A
	for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544340; cv=none; b=XqHxYuXB71p4vJ2PylOeSXbJVPuzDJAzQZGzhI5w5d371fcx+o/Lz7Ko2WUOVNMeQ+FDmWm3OwQTuVA9XVXbwGG/zF313NMwluUSUrRZTO6HfS/0+7asYN0kOo1GiRFn7shZIfrVjggA801qi0fzoCxnTz30dODqbVjkf4AsI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544340; c=relaxed/simple;
	bh=cO4Pj9HJvXCrtKDWlg8BCMRgxRtBdS4Ni/h9SSOUwWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prqZ3P0T3wS+bFpTyn8GkPpAnfjhQ7jWDtQajfZhhQyac1N9f1iy1jd9nQZesrAhGxzo9A+9KMXKj7zOhSizqsKepw+eVi6t916XA8ko460ca6q4f8IfdzdCbvVBvR3Wx460vaH0+9hQM1MRBsODfNJlprHmSNHuMOGAfReEIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CSkouF3c; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="CSkouF3c"
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DE80F3F620
	for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 14:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786544334;
	bh=ziTqEENmhcZwJoI7CW+xasRu/XWt1NvwONmfzBdAPeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=CSkouF3cwL8xsterUNLCTdLVv69S3SY6bCVZ40y/hbDr8GTsqMinjtXkf5rrSxENs
	 kKnEbFxgq4LCUaam2s5qvPO9Dx63n39wDHFB0LqBYk6xMTLBfgnx3hZV/ahDnXZc+b
	 WY5jXtnsSKd//pJJpnqDeQGMFHDtQx4rMoT48pL3dmkXA16u7RJxBbdahhfwoeeeH9
	 SEk5Yggq/7wtpW4t9gYJJaVr0vAAVg1ZRBWLUUyJh1YnqIoS9ijUfNG4xlgdWhvxPz
	 CA//8n0ORpSL2C3k+ivuXruVKQ9yVCOKSCdQNQjU0HgRAqkoJVS0eAmvoBUKUSEAf/
	 tZd7/wFX6afpo2mY4FpITDEHZI4+05BW9Z6l19r/Q6FiKHov7XYbwQpqWCahR8kRoA
	 BFbwLDmlEcG5SzPpQjMddQaDV54l0v7jtuX6o/QxcXnVvrWRHFRhy+QVizyqpdNSbe
	 hxvCfUElJlTk3UkzF4/ZyIg+E8739kp6BXUovyfEsrc4ey5QaYhRE/KmiLkQbdzS12
	 R74Dx+6ke7hZhfaixIYqEVOwZJxWNljS7kRenknM+z5dybqf5exkINJSaUjzZTnyun
	 hmdyHA0cJlpd8iIW5zBdmNvdjwTn99hBPSnLjhPPQ6FVuFMnmHW4V+YKXNGaDd3r+d
	 lHcAf1lwZFnlh9qiF75mbFmA=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso9532995e9.1
        for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 07:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544334; x=1787149134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziTqEENmhcZwJoI7CW+xasRu/XWt1NvwONmfzBdAPeA=;
        b=QU0AkHIwl2rslR7gYVdv1I7XjBMTJPrmXQpnlNCwmGvr5qncEHTOYuX+OqmiyAfp9j
         wBwd/7x5M1NZbDFkM9gaysRi+oMokLcfXADFmjl52F08cx2djbGUqkxUB/qslcaXkpx9
         QGHff0GO63JL1Oz2ZnNQMdOS5CPg6OkR4MYiYlLsrjD6DpFQtCh9laWsGmc6zSNrCa4b
         Dkq0tB7x9qOeXGTGSC9AdFQnmiXBnQw4hKXOa53byMQszYW4SY8gdbrcV5tIlN3GS3eY
         Fyd3L9YXE+9+7RFcKzIw64JAfjg9DVbjQSpSTNVt0S39X1wxyEVCjNLm8+oDxfELFJ+W
         zVsg==
X-Forwarded-Encrypted: i=1; AHgh+RqlowFgzJdW4UKpJpBj49TYO/bG6Iwz8fpwMuoqG27O6KDQsAB/KmZA0bJJDTUoBCsd3eq4aos7aIHZDuRCLsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwktRj6i6LJHTvtehEJhjsaLys/RpkIfwZ1S+diUXA2+fRFbLy
	UKMCTcb+hfAIJC3OLdx+plV8JziqX4YaTxNOXDXTedkF96GBfMvVj1YgsOJZBSiI7OQ/2F/PB0e
	dusRFAEYKaD/ivO+I5B1pyTuQmmzCyEjo9wzXahshWKeFQHX+m7W4ZG6aQtA/OGMN9210awHxmv
	KtQSnbogKiXA==
X-Gm-Gg: AR+sD13W4Et+f/Dhjnf7YiFLuzUEN6whEyqMMgTIkfMuYAJ7G3DETb8mBSUe1ZVIxjR
	SgbTsktvo6koZI/61mrBmexYggxdWdnq/PvbB+In/To3Bfgz7S2wG0by3oSD3vC/Lmam7dHuKJ5
	II/bPC7vNv6owJ6ehi6/+7T99gTd3Nt1Ui3jQjkdocixanhDUe9GgEvmeMk3SQRKkSastllup3l
	Cizf3PJpVy2w35bDe2RequWBMa6S6F1hCFPR1XXxj9LvR8DbNtnCo5nthgzR749cx4ODu4shEmA
	ltkTmPNrHYl/9A9rIZHTA55oIGEXgJov6F7dURaSD7TI870qdZwndO9WdrCFSoBwUPhD8ETzlDS
	s1B+yOmoB/fSLxE6wVvokisIOGigGaPYT8ECX+EcPWMbB8gsGWe35p3tjw+6Aq0yxxVFTfkyvcH
	HtKHApaHzywhFOzdXjPY9smM3n
X-Received: by 2002:a05:600c:35c1:b0:499:811b:dfed with SMTP id 5b1f17b1804b1-499811be003mr10736345e9.5.1786544334094;
        Wed, 12 Aug 2026 07:18:54 -0700 (PDT)
X-Received: by 2002:a05:600c:35c1:b0:499:811b:dfed with SMTP id 5b1f17b1804b1-499811be003mr10735465e9.5.1786544333585;
        Wed, 12 Aug 2026 07:18:53 -0700 (PDT)
Received: from t-14 (2a01cb00088323003ba1cc9bdc9c322c.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:3ba1:cc9b:dc9c:322c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c8fa1c7sm71800405e9.0.2026.08.12.07.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:18:53 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: reject a kexec buffer whose declared size exceeds the buffer
Date: Wed, 12 Aug 2026 16:18:40 +0200
Message-ID: <20260812141842.2319635-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ima_restore_measurement_list() parses the measurement list persisted across
kexec.  It computes the parse end directly from the blob:

	bufendp = buf + khdr->buffer_size;

khdr->buffer_size is a u64 read straight from the persisted buffer.  The
only length checks in the function are size >= sizeof(*khdr), version == 1
and count -- none relates buffer_size to size, the actual buffer size the
caller (ima_load_kexec_buffer()) obtained from the ima-kexec-buffer region.
ima_parse_buf() bounds every field read to bufendp, so a blob whose
internal buffer_size exceeds the real size makes the parse loop read past
the end of the buffer (CWE-125).

The buffer's memory range is validated against addressable RAM by
commit cbf9c4b9617b ("of: check previous kernel's ima-kexec-buffer
against memory bounds") and commit c5489d04337b ("x86/kexec: add a
sanity check on previous kernel's ima kexec buffer"), but the blob's
own declared size is never clamped to it.  Reject a buffer_size larger
than size before the loop.

This is on the boot-time kexec-restore path (__init) and the buffer comes
from the previous kernel, so triggering it requires control of the
persisted buffer; it is an out-of-bounds read only.

Fixes: 94c3aac567a9 ("ima: on soft reboot, restore the measurement list")
Assisted-by: copilot-cli:claude-opus-4-6 frama-c
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
Tested under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case that calls
ima_restore_measurement_list() on a 24-byte buffer whose header declares
buffer_size = 0x1000.  On an unpatched kernel this takes a slab-out-of-bounds
read of size 4 in ima_parse_buf() from ima_restore_measurement_list(); with
this patch the buffer is rejected and the case passes with no KASAN report.
The test is not included here (there is no upstream IMA KUnit suite yet); I'm
happy to submit it separately if useful.

 security/integrity/ima/ima_template.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7034573..2467cae 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -450,6 +450,11 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		return -EINVAL;
 	}
 
+	if (khdr->buffer_size > size) {
+		pr_err("attempting to restore a corrupted measurement list");
+		return -EINVAL;
+	}
+
 	bitmap_zero(hdr_mask, HDR__LAST);
 	bitmap_set(hdr_mask, HDR_PCR, 1);
 	bitmap_set(hdr_mask, HDR_DIGEST, 1);
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.53.0

