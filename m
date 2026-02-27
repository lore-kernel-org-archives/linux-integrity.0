Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A483368965;
	Fri, 27 Feb 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173475; cv=none; b=jza4kiGArSfYIYDfHBT8SyjajDqXxCFCD0NcwGmUyzHsg3XvL5aRCNwUtPbY+aU9QzDA/dUgr7xtxbfTGvty1o0xV0vJ/5T36ynaRqy27Vo5QxH3HQnim4KIJdPCS9Gf2RV4+GBYVq0pscpxNM4D8eZE8KIs8EhAzpV6qhZSCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173475; c=relaxed/simple;
	bh=qB/q0dvRcyPgB2aoF0iNa02KEJJcdeLWctI0usOtmxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OR5OWtkHKtLwrIDTHfv6/IEO2mhBCw//BiAbLbe7TkTDGgwYd2liLRqQQNWlw8LtEoQljvnmod2Ldh0I7b4EEylBOTAOvAskakH5YoJm8y0WxzG4fv0XX3w42LP4AhXqvfK3rpueNlpseRMPd1Dm9/sW/d+dS9Bs//UyLVue8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DOcxJ88d; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DOcxJ88d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yv
	zy/oMN5itcLK9YfRRAQXJRacJLzXRwn6ueq9SDyQw=; b=DOcxJ88dMw2bTx6mAJ
	sYurgfKQAouLLCTAxhdtrJunB+HDf3I2Y2kiOXJnJT38PI2opfVgd9clo/yqTGkf
	h1eZ/KikMQMyP3pvacmSYbG4R0XNRagkRsUdgjD1cbLxJpqMSpUnDqcS6+L10fpf
	SRZbFKLW6xTh7Tqd296KH52IA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXKwGBOKFp3ZNlNA--.58279S2;
	Fri, 27 Feb 2026 14:24:03 +0800 (CST)
From: Chi Wang <wangchi05@163.com>
To: trivial@kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Wang <wangchi@kylinos.cn>
Subject: [PATCH] integrity: digsig: Add blank line after declarations
Date: Fri, 27 Feb 2026 14:23:11 +0800
Message-Id: <20260227062311.140597-1-wangchi05@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXKwGBOKFp3ZNlNA--.58279S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFW7GryUKw4fCF4rGw1xXwb_yoWftwc_Ga
	s5ur4vqry3ZF1Sv3y7uF4fZr9Ygw1v9ryrXFy5Ar1vy3s0yr15Ga48JF1fJr93WFZrKFs8
	CanakFnFkw1DXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU529aDUUUUU==
X-CM-SenderInfo: 5zdqwulklqkqqrwthudrp/xtbC4gPwFGmhOIMX8AAA3R

From: Chi Wang <wangchi@kylinos.cn>

Fixes checkpatch warning:
WARNING: Missing a blank line after declarations
+                       int err = PTR_ERR(keyring[id]);
+                       pr_err("no %s keyring: %d\n", keyring_name[id], err);

Add a blank line after the variable declaration to comply with
the kernel coding style.

Signed-off-by: Chi Wang <wangchi@kylinos.cn>
---
 security/integrity/digsig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index aec350abad86..5e7ba7d3cf99 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -49,6 +49,7 @@ static struct key *integrity_keyring_from_id(const unsigned int id)
 			request_key(&key_type_keyring, keyring_name[id], NULL);
 		if (IS_ERR(keyring[id])) {
 			int err = PTR_ERR(keyring[id]);
+
 			pr_err("no %s keyring: %d\n", keyring_name[id], err);
 			keyring[id] = NULL;
 			return ERR_PTR(err);
-- 
2.25.1

