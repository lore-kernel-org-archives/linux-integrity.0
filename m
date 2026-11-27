Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756452;
	b=msxqzQb47CiOcXRG3VoIeTGUIfv2DdfmnqJaB0nJZYT+1+db1HQNnt6YphdYCBfI145x
	 ciBwNt/KiBQo+JUeTDABpBUOfKB7u4xADa8DMO1iDe/hlF60nYT6QMvcLB2iSgYu6eLPs
	 t0YspCfNjXr4khheVquO8D4IVIqovaqAcBecu+QAuqzELQfq8J7aszbTmCX72luUAuu/n
	 mlj2sd0L98VAQOTgYILDRPbAwyFa+dnWhN1QSY/z7oeI3E/4HgcejNDrNndZ64Ytxh1y2
	 LrcfHHTROvnf6ZGT7oIGgxpfG3k7y7dgp/I1MKNtthScIE91aXdpa6IShaCAKF6Q6Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jKPPhHAxB9p6FLiS97eRH3zn7f+B3nbBCbyzaA3weeA=;
	b=m6apWGovsKnlEBRtBAeIa9mQ9Jua0INZNrO14ilehNSi6Y+TN7cV8mj+iN+99OWUY2L5
	 4XfQ0sjg/jWjMbsDHyhJ+Yy5VnvjgNOvb+HGQOZzoWGbgWuLwO7H6wQbRFeiQfFCg7Zcy
	 SJvwqXdTUDfULwD/77uQZGF8wAd5FHpalc+0gn4+GPWOdJgeIkquWtWZdUX76oCiKQrZx
	 +d0WGsSeTio+rIB3YkgYodzAI4+XHlsQP7yCQJfGI+cEmsPZkf48atnbhE8n6aoFMbCmY
	 c2Exo0mgjtMCc86J5RFY2U1mvvr6ze+25D3wdSTB9fQb2CINU6ORAGDN2aYVUCUm6dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6qGceGi;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5F606A31E
	for <linux-integrity@vger.kernel.org>; Fri, 27 Nov 2026 05:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC5F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6qGceGi
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc147d86bebso4757468a12.0
        for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 21:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795756452; x=1796361252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKPPhHAxB9p6FLiS97eRH3zn7f+B3nbBCbyzaA3weeA=;
        b=X6qGceGik8K1B+sdebWjo6QYDZdtRBH8f9kD0l2ExGbqj+2BBH8BTehYcNL2j1FUbL
         uKg3xdmwP39gMtBJtww3IPnTCP08QxBtJdIGE94klor0k2fjeeFpeMVrtukhvf1wIPsL
         lByxhb4xM0rKEwneGl0KUBxjTguv++tY4cC1gY7Z8WkUtkv0+3Z8jdufEmNZ+/JMFU+4
         f/wqMaCbHDgdKkKzBIZ01RNLyDG59Z19NZvDXIzkfSvd+7iL7mRB7+k0WRxJQu6Ov0RO
         uoNXMUUi5JxbwmUbrfsX4y75qFE2zs/rK7rr9FqcfSFUffNJ2gZEjyAdTC1l6d3mdIJY
         yuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795756452; x=1796361252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKPPhHAxB9p6FLiS97eRH3zn7f+B3nbBCbyzaA3weeA=;
        b=X6gUDupKeon3sFWp0Fs2jkmtvaoNZivCh0fiuWt7PM1+QB8Y2LMkrD5PrSkFCOhPOc
         R4sSlQRW35LDMcx48TDHF0knuvBewqXak0MaO5i5hZvOBBa1j4OJJQGVBbjWtRqY19qB
         8WanqbYIGevgR1H7+Tzi5LdWg+edvVdH02z72NUDBZqPrpNCt9PvGoz/ZCuO6Nl8I+r7
         POfxcf88R0ZiANXfoIJRgzXfzU8sHv3DnqRxbxh4RH6dvt9TbBAj/ebnOhLVvMr+lKxe
         Wm9r6NGO8HJaj742MbgnOP9nt0ftH0ueOE2ozll4aND+RTTRsRfG6+KwoR9G2P9RK2vf
         lchA==
X-Forwarded-Encrypted: i=1; AL+hErH/cZLKrHUgY25dF671I5Q7azh8j6G4v7jDK0yCCtRsIbcGptV8X1VljbibF3rgS+NGd4gZizkGtlELpeUnaYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HMHYd8gFQIPBO5nekZvik3mqVBDdRSs2Hi+u+GW+ijUzhAeBg
	AsDlNUo7wiYtY0dTGAhtlDH8pGUmqLZ4/z49WsZspPz60JgxwVITWpET
X-Gm-Gg: AZFdTZfnbic7HQ8KzN0KQkZBNdwKuhAxC4d00ugOXTMFDy5wQ6ieSzUauiK161ziWph
	7TmClDT2FkAmFwDWeiFzrWUPDwsvJxXBljYBwzohFiQCdalRKJZ2uzTFS1Y5IbVnLcnBa86Qcje
	GSHy9L2WOWpfUrul0oZR2XMzG37pqCKjK+cQURhA7s61izKfrMTUg7AjNRR0XtFoUKylHU8EEbr
	uW1UAtzPE8fFTDZKsRBQhh9GVqVtu0oStPMH8VaIJ01SS3kocBUI3G3L0q7apNwo7lZmhC8fxZW
	MDjWNeHYvUXpu1LeUKnEvZpPB/vlrGv/c/T+4Ng7a+2wDj+CX0dYB6UaZZiASiDt+jX2QnQCNWE
	Ail2cyrVw5lf5LgYfAI/carVg16pFu7eqFKBtA21Z8yDHS7/LnKSbE7n5eEfmfslMRp1KoJJG6p
	pT6wt8jUmBMKTx6GngZrtoK9u7jGxTTuw/emCBGybASps3YQvXPsmXC25c80KWx1TprD4pE/oWi
	WOuAwUtZaoSb8uxiEvMPAikxlZYaucnC5Yq/GQtVd6ipGybJWrm05RQeTg1WxW6KtyA0XPim3NL
	tNciaSiZyFsExxUfwnygWfOwotkjqo/x9mXM3pRMh8JoqsW3HD/hfDE0IY3bE4P67MwGf/mZhDY
	k
X-Received: by 2002:a17:90a:e710:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3b41c96151cmr15079773a91.38.1795756451942;
        Thu, 26 Nov 2026 21:14:11 -0800 (PST)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm26265061a91.9.2026.11.26.21.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:14:11 -0800 (PST)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: jarkko@kernel.org,
	peterhuewe@gmx.de
Cc: lance@osuosl.org,
	rcu@vger.kernel.org,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org,
	Li Jun <lijun01@kylinos.cn>
Subject: [PATCH v2] tpm: ibmvtpm: Fix unused suspend callback with CONFIG_PM_SLEEP=n
Date: Fri, 27 Nov 2026 05:13:59 +0000
Message-Id: <20261127051359.852628-1-zhouzhouyi@gmail.com>
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

Discovered in the Open Source Lab of Oregon State University when running
RCU torture.sh on a ppc64le VM.

With CONFIG_TCG_IBMVTPM=y and CONFIG_PM_SLEEP disabled, SIMPLE_DEV_PM_OPS()
omits the references to the system sleep callbacks. This leaves
tpm_ibmvtpm_suspend() unused and produces the following warning:

  warning: 'tpm_ibmvtpm_suspend' defined but not used [-Wunused-function]

Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so that the compiler
sees the callback references and can discard the unused PM code when
system sleep is disabled. Preserve tpm_ibmvtpm_resume(), which is also
called directly from tpm_ibmvtpm_send().

Tested on PPC VM of the Open Source Lab
of Oregon State University.

Fixes: fc0ddb3174b0 ("char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management")
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Changes in v2:
- Remove the blank line between Fixes: and Signed-off-by:.
- Keep DEFINE_SIMPLE_DEV_PM_OPS() and its arguments on one line.
  Both changes address Jarkko Sakkinen's review comments.

Only a targeted compile check was performed; the full RCU torture test
was not run because it takes too long.

 drivers/char/tpm/tpm_ibmvtpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 51c7e2add3d2..dd577f075c57 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -462,7 +462,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
 
-static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
 
 /**
  * ibmvtpm_crq_get_next - Get next responded crq
@@ -714,7 +714,7 @@ static struct vio_driver ibmvtpm_driver = {
 	.remove		 = tpm_ibmvtpm_remove,
 	.get_desired_dma = tpm_ibmvtpm_get_desired_dma,
 	.name		 = tpm_ibmvtpm_driver_name,
-	.pm		 = &tpm_ibmvtpm_pm_ops,
+	.pm		 = pm_sleep_ptr(&tpm_ibmvtpm_pm_ops),
 };
 
 /**

base-commit: 5f22fb20497f4983094131f00a734362300d22d2
