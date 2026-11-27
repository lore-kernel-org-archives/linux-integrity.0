Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764575;
	b=dE0Twf/VdLfhHR0zeowNtbfvDpiiTbdfbz281QMM9+0qgN53xjdFf2ikmmwixWgeeme/
	 IUXJY9f+uFW+UuZBkALcOLbKQ/BOCyorQB2uC1OWM2PJReh4wIYKY7sC03P4jCZdGZZtr
	 ry7OorQ6xCbYZXOwYmz7Z+z4MiCf203l9uVbASYUv+w87l/yuiH5IvDofoqiwqjbfhBv2
	 mwfWWG1RXB3Dz5wfB/F80UjsaX3vds83TpHM+NBSE4r/BDfoWcvW5WgNJ3rW505c2p12W
	 F16cEq+tP+G/9EIlHhoZ2m3sNyOEYo8b80dzTm3DVL7mJPwlc9NwAdsqMEgRL2CGiLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zBDrPtxr95uLq+wwut/I4OrBKrfga94bFFGLEETXFFA=;
	b=GwYimbV3qjHh54HJBST/G8+YS9Fs3GXBtylUf6ZXw43DF3bvZvcCL5hvQ5nlsNBXkUi9
	 RI7C6t59k3gao4c+zsALJ90hLoGRIqs2WUBkr6rcJj6GcXL8UJFY0vPoQsA0HGSh3t9yZ
	 quvxu5uyflFKxI7wDpsDOt6QrQcXdWzzS/R796ne3eX5Rrr30crfLyWCyQgYmWuPdqHT+
	 tJ8aGKUdveJfEh2uJMiXQVDHofaoGicHfCnfcLCakVOLPJ+Ng5DrrEW7t7RXkoRxuu/GC
	 ps1QNBArEpFPCWvZlygWeGxtxG8Ql97sM93wQ1ntTJfV9thWvXYfd2WMnFQgIobbh2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJPXlrX8;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFA606A326
	for <linux-integrity@vger.kernel.org>; Fri, 27 Nov 2026 07:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFFA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJPXlrX8
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1aefd1bf74aso4254021c88.1
        for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795764574; x=1796369374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zBDrPtxr95uLq+wwut/I4OrBKrfga94bFFGLEETXFFA=;
        b=lJPXlrX8owYo6OLbUTNBkyNo5jNAAPWr5aS/HRbzwEah5/mBpk2X4Dh98goKV5/GTf
         2gt1Ai6oEydB0nMvJQ6QXSz+QYwi3xJRaIQpwvY5q1Cg98OYjmwVEq3DFTdc5uq65zdW
         +116mw94N9AXqHutGfGLOUryAJt3M8Shns6h4qPmPz/edRhjrw9FV2CE4e7zGcTyUvRT
         c8IJshIvHKil6JlIfvWfQ1qpYr6/aQZCTI7cap4HNFbPKROia/4nwKVvhf7/qdwOd6A+
         qqXjxyIfqvrISjENqmrTL9tSW8ajLn7HXvT2BFlY2a6tfduAzgYU47zA/A2gni0RAX7l
         jvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795764574; x=1796369374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBDrPtxr95uLq+wwut/I4OrBKrfga94bFFGLEETXFFA=;
        b=Gh8gg5CvD2enVuet9VPSZJ9vtLDBgCWqU6e99zcC8ATYvRp/lYPedQYmTqBSHbcfUd
         wIj5i2lV3kVgF7Fc0ZQrM7HI+L5uLy3SQsFHuEVXciw8B6IpzQk0pu7LnERobYA76DC7
         RaflHPI5V1Tph4/T0zfe/Y/Qo+AwWo66y2nKOtZtgQ+8NDhYLc7dHEnIc6SKJazv8CQM
         S002oEt/cS+DEDi4qdJ0rgNLIvjw8gDw+FRG29L+cEzzJw1mhYLHu1sD7ys8doHDxNxV
         8zA17UI4m+IcOwR0y3byi5TzwYc8S+xLAYp6PcHz9IYxO9XwAMuKyBC90pXAyZXWiPRo
         +/Cg==
X-Forwarded-Encrypted: i=1; AL+hErEAuBEM5rqnVrfKTA67CxpRJ9WBTzFD8f1Kk8D38dtYDh//yzO8DG8Jwo+vf0C7oHJQIvdN8wIyX6TXN6kS/Ng=@vger.kernel.org
X-Gm-Message-State: APuU4Z/V4C7ZSJnaLJ4V1znAIv9Yy6hr/IUnTcq1ihpptffpFzsv7lsq
	4eyRJfy/zNHm324V4zBWCTandnHaVnDuThsFyoXVfbMDCculOJzjEhN/
X-Gm-Gg: AZFdTZcxFsLuXX+nkRPlNrFEbOnk3i1mzsaGKx93w6R0H5+wjq7TrAZ6v+R+k5Ykp8G
	sEFpxpIrWeVdlFq36bcRD26kI4+27OUr6eF1bPWJEfqOgqmDtywnwYdBINx3/g3PZzyafYvxag+
	48URfLuix5APWcA669e1reDu7dGsBk3vjp6k9aYDkTBa/A2HptEByRRLWqGdZnVS0TILfqM1D0d
	rETexRxa7DCSsOPPeS6+fbFl41dm6lTQ1DomqIxBFQXsobsDRRbqDcX/QYYvYR2Kn0zfA4qfUW1
	mWI3kMnpnyQL6mPeY91rj+sERWlnL2RQiKvj7fg0BlguKz+sYFRwGMiWemwodavblBeaN6A2Eoe
	FSQuUG9iQ7kCiproJtBwIDRe8eS48jplid4NXZtnmHJzx1/fkq62KSvX7GUFSKJ9Iws9r63NUoD
	Kr4Qqy3IgFIZkp0mmZO+DhQTKXV0x3ol6EJPjC83meF85ZMu/Y77B6erAUMTcZMqqb6bFzAcr+Y
	z7BN1Y2ppmn0NYjuA49ZakXm/8l6uAMUzpBvWzi2z42oD/1yhaVjfJwDyvPFx3r0cBa3Q5QRmun
	gT1p66FDb14EWvOjDTbtkihRVlT4NeLGkDGiJ9tBKWzWwv98
X-Received: by 2002:a05:7022:f90b:b0:1b2:6d4d:9d8a with SMTP id a92af1059eb24-1b56f36d5fbmr14790665c88.2.1795764573739;
        Thu, 26 Nov 2026 23:29:33 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm54799871c88.8.2026.11.26.23.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 23:29:33 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: free the rule label list in ima_free_rule()
Date: Fri, 27 Nov 2026 14:29:27 +0700
Message-Id: <20261127072927.172066-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ima_parse_rule() allocates entry->label as an option list, like
entry->keyrings, but ima_free_rule() only frees entry->keyrings. The label
list is leaked when a rule is freed, for example when a policy write
containing "label=" is rejected.

Free entry->label next to the keyrings list.

Fixes: 47d76a484050 ("IMA: limit critical data measurement based on a label")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 security/integrity/ima/ima_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2dc1d93aa768..c3c4faa99f5f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -410,6 +410,7 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	kfree(entry->fsname);
 	kfree(entry->fs_subtype);
 	ima_free_rule_opt_list(entry->keyrings);
+	ima_free_rule_opt_list(entry->label);
 	ima_lsm_free_rule(entry);
 	kfree(entry);
 }
-- 
2.25.1

