Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE342F6F2
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438740; cv=none; b=ofLU+UpZ399iy9S8DspPDzMXz7PTyXBz3dceSIn63GaBj5QTM8zcrjJq64JgRWYDgS5CGhV1fA0Ak1Zqq1bzvbKvg6A1jbZpS5+YFZ8hODZMukWwRV/1xhDhGnlczsftSqgZcbWHHWj/bpkvn1M3Iv8S72tZzxAa0gQpWNodi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438740; c=relaxed/simple;
	bh=WlxI6D6l0R5RgwB+XCAILtOwfVKifVrQwkT3eMDmrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIBw5B6KZ8yxERzyRzuReQaVRcJsM6sEcQvLUP7rxeb1ek5hiPrW+/rBRpLt+cu1eBLCt60S3RIlE4cM7EJdWKF2LWEECufALWNhybGcZGnew4EIYuWh+CXhNL5DOhUNYY9rm9aRcI/C3UuXM5InkvKa6y8PfgOJJYlVf9ALzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=alxOoBbm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="alxOoBbm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b27c7451so9552285e9.0
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2026 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438737; x=1784043537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=alxOoBbm3yE7v/C/+wdfPXGx59/B9HpE2+KogRvtm514wDoSe3RvFCnpneguOgfbUy
         NOeXPe+mbwoczw8AjVGyHEeLqxeCO8pH3whmpl6Ej2kqPiH3/DoS1OKRyhxoreFsx1FJ
         ODOuzyvk0JKaT1RvQRvVeo5WB2Prc4+xxOhhvNQMCSJWKW91efoShT7RgAR97blhsn9V
         +qNTHbMl7C2b4/kUeWkGYl5RINC8oz08P+q82I6CVEF+jKUd9WIKQz1PPKUhzZ9uAYgR
         MHQNMHrvUcjZOj+xPXu4qP6j0gs2vf3d9L4IEx+XlqNJBftEp9z77m/D6ekKuGuSIPJ0
         ef3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438737; x=1784043537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=Keuh8ebSXz2AmJ27JKraaFXCWtTBFy203ceqrhK52et1yD2Pg/a8SoAcWJQCicMPKM
         H5unLx0lLZ9xcCZ9FRxjhdxHlfkgUm4rybx7mP4U1HkZyvaq92BjBGMmGY2kgfn9ux+W
         5TGrcbqlwaDjymo7/KLd+v/90KK9MesrgnKxFYqnE6QlyTQR1Xud9p8OjWNINI427Vss
         tkxHl5vDIi97+WhMbzZ7GqjHQxXbmjVnEY2cu9EWyc09y1RHm/iU+dbkoQh7kLvW9mAu
         Vyf0hCHEW+1JvZqslMy1scgidsjLPtoOxfsVhR6k9iZaG4vr9Tql0xMFcjkUHDIOgv2h
         1Vmg==
X-Forwarded-Encrypted: i=1; AHgh+RpkVOyDjGaUseHW4Q9CN3TWs+PaEb6YArYCMdOq5+wCo9DR3aiXCwcUm3FOd/F+usBcLO3Xj6wPUklmYxvv8WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAscshci8mDIakcXMlmKseigVPIHlaBXnVJXhnJ9QRtOC0FAqR
	AOOpK+v3jIQPtVao2EYRRVurhDSvm3HeLQEpF9Ef6o+vsTx0uT04ziFdnX5sCSWyR6A=
X-Gm-Gg: AfdE7ckYHoxGkhQdBuLrRcPviLCG6Vq8tPJdF05+nRv9ApKy0Q/+CWGQeA6pzoPkhgv
	yL1EtBhv/LiUBcFJ/pmFrZ0Rl6+IKJve5M+sFgc6aRrEcfGrigthUeAzsPySB+Y23jiizhrL7Tx
	PUVnFmsrv8p+8kQuHPwew1/jJxkMx/Z5+C9ogsUNhxIPOASm6S1zZqrINMZI2UL22ysk1RkbVDe
	XPSKK9lbjzKoDBK2eUKPOWTMz9oY/WBlo1LCdb7uvdQbBdjBsqJ6hRyo/QNrsWz5mIfPxhCkOYA
	FsRlwUHrLCTMHMEpJVWjXZ6aji4vmQjLxbx1HicYx9S3bTDd8DXsaqfCqcG5AxVDbJDOkEUgFd4
	+vAmtqpIueenpNHKmNnnuYvMcB+J5rm/wnSeeRckZxB/HS2fC4jPz+3C2ia0PIjN0pVpulgJHdB
	VBWXBc9myPtqOJj3iLERSBDh50h2hK6R+vhZAeZ+4vbxyw122bev8BKh72ecoPzqxlxw2gvax3s
	KjBg9qaF6km9g==
X-Received: by 2002:a05:600c:8010:b0:493:d117:18a8 with SMTP id 5b1f17b1804b1-493e1011e8bmr32534765e9.9.1783438731805;
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] module: Limit ELF includes in linux/module.h to uapi/linux/elf.h
Date: Tue,  7 Jul 2026 17:37:07 +0200
Message-ID: <20260707153819.4172541-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux/module.h header is included by every *.mod.c file to provide
`struct module` and other related definitions. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions.

The header currently includes linux/elf.h but this is largely unnecessary
because it requires only the base ELF structures, such as Elf_Ehdr and
Elf_Sym, which are declared in uapi/linux/elf.h.

Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
including linux/module.h alone results in 2.2 MB of preprocessed data. This
change reduces that to 1.5 MB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..7661faadbedd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -17,7 +17,6 @@
 #include <linux/cleanup.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
-#include <linux/elf.h>
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
@@ -29,8 +28,9 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
-
 #include <linux/percpu.h>
+
+#include <uapi/linux/elf.h>
 #include <asm/module.h>
 
 #define MODULE_NAME_LEN __MODULE_NAME_LEN
-- 
2.54.0

