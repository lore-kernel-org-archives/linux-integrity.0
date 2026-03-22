Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357362DA74A
	for <linux-integrity@vger.kernel.org>; Sun, 22 Mar 2026 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774177836; cv=none; b=BM3mee3gaHVhZkKY3BGM7JW3vfC8FKZ5ukldZwnzHi0R8A62vPtZ4WZDi83zg3uBFpbQSuy1SWboJF7B/E+oOT+4kMs/UoRoHYBfQD0w2eT+3ckAGaUiEec9dWKCP8eYDDe4ZpGGJ3Tphz2ZbfbPhdEcMkoAB1yGWRxyHbP3Avk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774177836; c=relaxed/simple;
	bh=NLIEw1ZR7mTPpeFnQNrEtJKL+JrWXPexTzwN4Rbrlp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6ErgmEU8doCKPbRGCBj0i7GYJ4GxyqHfMkandX/eNwLKzF944OFm7AUDOOXinKenW3pXiGaqOElO3XGZJdFLeLpPXV8QEw7wrf1kKEKng2nprnWfV6hknzcMmn0hpbxOuSbGEu+a5UjfhNVkd00Qfj7VpMUDXz2VzZeK5/d1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bg48Iizk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPn9v9Qz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bg48Iizk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPn9v9Qz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774177832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pD6rEELAAr02II5508NHP6GW7PMLu9br7i436TBlft0=;
	b=Bg48IizkNtcO1N/jMJNTV1D3XT4sVVu6grEvS0OhhKTrqCI2nb7Cq+KHopz+QBZ8CGY/a+
	MBySdybcdalUhOMrbHAzndFOBmG4hEVUwue4dcpWbDzXwdsvMvZZtIWzrRvls9Z0n6C0O5
	RcIDSz8tirLCkxJ7c68r/2Wi/SugMJ4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-3N8x4dmtOC-tpwnzKKFeIA-1; Sun, 22 Mar 2026 07:10:30 -0400
X-MC-Unique: 3N8x4dmtOC-tpwnzKKFeIA-1
X-Mimecast-MFC-AGG-ID: 3N8x4dmtOC-tpwnzKKFeIA_1774177829
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1226274a12.3
        for <linux-integrity@vger.kernel.org>; Sun, 22 Mar 2026 04:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774177829; x=1774782629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pD6rEELAAr02II5508NHP6GW7PMLu9br7i436TBlft0=;
        b=CPn9v9Qzx2MheDZQArmzhU5/2IbSYDCrWjTNyr/GBm3/8JoXnkcunbl5fPgUHE1taI
         ixOve1di3ytX3w5gB03TicDjgkAh6ySZWy3EPJTiyN+gXeipHqNGlnBwKKZNnTe7Z8xp
         eetGree4JlP2lIdVYctN2avFWsBCn6csH4T9HwadbkqwBnNKTe3d479/MAXTWNpwIT8c
         moF7C1iNS0XjeA96Dik8lDNGzFw1CvHv5n5qlQ7aYUBKFrBf/6ARKiVy1ypydflidRwM
         owcevKDIRSzK5+wwU6VkTcDKDGk+C6ge9Oewj5bnKHyczvjiGvYoNRNCLdWtpcuz2OGb
         ju4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774177829; x=1774782629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD6rEELAAr02II5508NHP6GW7PMLu9br7i436TBlft0=;
        b=rWeI5veAU72IrRY8Tjg7nQ6xY2LJ2YcGji48DE3ALVYJcwf/ajlZTGl4Lj5HeSMEVw
         UqIyxqU0Lun6NmSde0CqoVqXajT2m9fIWtU/HnC/SZT/PkWxNlTMxQmnEeJVKCun/YUg
         lZUHszUtRe7KAI8VNBWyAFEC/8SS5Icp/yq8RdZOyk4VfW9auFUm6ICmF+un2j34zPIt
         lqyUJ6BB/Kg3VsouSlOm+5fqygwRG7kbHwWnLSCALE/WNb42w05puomOOYtl6ZDDsniP
         XEOW0nZrN/eMYMsVecnkf3S11my9pZ9XlfMl/ng4xqCF0kmPAXVmC+A6Z2Ws/c5ijoTJ
         JrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnELmQxbou9bXzYwL6M2E08DuIpseDY7Qr9JsBkI5RLM2TLi0KdPRE/vVGaNSDM+nxZ+c+o8cpK6vlKWpHGXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5z4X0aNuCfdYVBcKSHoPTaFa5k+kJd0fa3EhCup1XfVBooZV
	2lgCdWjHvaazrPChfqKCf/lHKEJjvx2jGUi8OEuGtEUo0+JL/srr3XdJzqZGO8Br23Nj/SeSD8a
	NpQ3MpyH7M1+hjDojo06AbEhhXlUcLxvHcbmwlQgABuomIB6/AD2y8etjgAbTjdDXTd+zrg==
X-Gm-Gg: ATEYQzyf3zVPDR6LhRfoBvN6OwEZBNImBml+oNGCcLTdYob8b2vYAjIyH3DRHuDDM90
	wyhLUsBkUMDkTX6rBzj1YHylg0ni2q845kw8E3XGrenFwDYUfQwOJVm/ngYNDVmAl2A1zjBAtOC
	uUxcpcFPJncfBuI/56AsF3WQZXC2kKJqxTxLZulyJECdIyCRlT9tTj4RqABJ2Z/FBn7Yh/fJbSS
	Ut5VY2qzlH57cffjwaKW7xjQUjcBwS0H0qkfJadsQGHXq3jn0Jprr1lWY4CbrYh40H3vhbQgPMa
	kXLWz712RAgkV45jGjNH5EA4H6lXYYhGQvxA3VttVJ7hRaWwi/zUVCTOyM6OCaHUM+D85SBk6uX
	xKsN7K6C4FeqaUBGqYbt950A9BIwS27WoY5lahDNAaoYM5g==
X-Received: by 2002:a05:6300:8b0f:b0:398:981e:2e13 with SMTP id adf61e73a8af0-39bcec310bdmr7945014637.62.1774177829510;
        Sun, 22 Mar 2026 04:10:29 -0700 (PDT)
X-Received: by 2002:a05:6300:8b0f:b0:398:981e:2e13 with SMTP id adf61e73a8af0-39bcec310bdmr7944993637.62.1774177829069;
        Sun, 22 Mar 2026 04:10:29 -0700 (PDT)
Received: from kernel-devel.tail62cea.ts.net ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a801b79sm5277794a12.3.2026.03.22.04.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 04:10:28 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: abort file hash computation on fatal signal
Date: Sun, 22 Mar 2026 20:10:19 +0900
Message-ID: <20260322111019.2815601-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ima_calc_file_hash_atfm() and ima_calc_file_hash_tfm() compute a hash
over the entire file contents without checking for pending fatal
signals. When a very large file is being hashed during mmap (via
ima_file_mmap), the computation can take an extended period. If a
coredump is initiated by another thread in the same thread group during
this time, the dumper thread waits in coredump_wait() for all other
threads to exit. However, the hashing thread cannot exit until the hash
loop completes, resulting in a hung task.

Add fatal_signal_pending() checks to both the ahash and shash file
hashing loops so that the computation is aborted promptly when SIGKILL
is received.

Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
Reported-by: syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6ed94e81a1492fe1d512
Tested-by: syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 security/integrity/ima/ima_crypto.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index aff61643415d..7b721b9c944f 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -17,6 +17,7 @@
 #include <linux/crypto.h>
 #include <linux/scatterlist.h>
 #include <linux/err.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <crypto/hash.h>
 
@@ -416,6 +417,12 @@ static int ima_calc_file_hash_atfm(struct file *file,
 
 		if (rbuf[1])
 			active = !active; /* swap buffers, if we use two */
+
+		if (fatal_signal_pending(current)) {
+			ahash_wait(ahash_rc, &wait);
+			rc = -EINTR;
+			goto out3;
+		}
 	}
 	/* wait for the last update request to complete */
 	rc = ahash_wait(ahash_rc, &wait);
@@ -491,6 +498,10 @@ static int ima_calc_file_hash_tfm(struct file *file,
 		rc = crypto_shash_update(shash, rbuf, rbuf_len);
 		if (rc)
 			break;
+		if (fatal_signal_pending(current)) {
+			rc = -EINTR;
+			break;
+		}
 	}
 	kfree(rbuf);
 out:
-- 
2.52.0

