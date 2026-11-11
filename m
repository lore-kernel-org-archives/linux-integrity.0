Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391106;
	b=Ln6795qMJoPO2TOa6/Mc6j4eFn32h+09uC3qcAjMKY1Jhuh0EG66baybLOkSTU3W/jCL
	 EMC+TaDJ1y/KPLr3D+RRdO8mE8HVWIJ+hV/s43iJ7QlY6E4Z05wa0aVO4CGtyn8LsgRP6
	 5nkMFb51D8lZ/TZpZLLX3ysYLHTOb39WpcDF85yUXU4b5sdLPgeYZFtX3reh9kcQLvVki
	 j0/tDcbePU2lhqKd4sSZHYzZEmP3BsIRUL5+7vvTpk5dY3Yooxsr3/PRrItI7M/X23+4Y
	 izxu5rjDDxeOZ9/tVwyB7EbqLd//SyhCOaNtokibMktL3crYkv72sPyeuNQ2vrhvExA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391106;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=Clvj5Hyc4zBPwDkLYEyBKubkzR2DqJyqapS5Up8ur/4=;
	b=foX/q3KzctV6ttbkuMOYpUxbzeGAbLodSxxYO+vzH/7J7i3AkjMQS3yTohGPDDYeU8cJ
	 u+gNTFkO0vDLFj8IscVjP7qFnKY9P+ZCxEKWb+Xgr7CPb2gOx2qkgFBz1J5xBLITigphs
	 akXnaPZl1mnQoG/kRwE7ppa3F1i7qXtyvQmp909spEukAIBZGW6+aZBd9h6a1Dr+kerpK
	 8aZOhkS20Jo6jZp8/XYkPHwBeHm2XutVKydaVnv1DZLHbBTALyWtqEQlCvK6chH/ifRaW
	 8uNIjA0ddHDxDEciMr8lr4NE8FaWS1oytcXX4Nf9BtJSzmLALg4WpI/SAATngDsNBaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=AFP69gaF;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BD606A31C;
	Wed, 11 Nov 2026 09:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A6BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=AFP69gaF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Clvj5Hyc4zBPwDkLYEyBKubkzR2DqJyqapS5Up8ur/4=; b=AFP69gaFLgMajUhNH3SzpRi7Ob
	1Oc8Xh5UoI0eQM5P9lHWDEvj+nOFqX+v48dJ7gHcImJvT28XOuuJU/kzsnmJa63IELYcFp5u2r+sC
	ACyq0SDstSAfQizJaY7ef2LBvPc+hYx37bvMXvXmJoGJi19qopyeKhZK33EtM4w+3LFS0yGvbVMjU
	8jhaPBmxYuOHFegb2jGYnnhFd56xHYLlQsvMDFJG3hZM3Biz10CHNZ3+8DETXyC2slujiCVsn92rm
	rYYTtNggBDSrWurI66Yt0YShFQzIe9hknrLetwL/ouU/nnsXSft7Oq4s/hnU/GBmUYB7AXmRLyup5
	KkJ2EkJg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xR55y-00D6Ad-0q;
	Wed, 11 Nov 2026 09:58:22 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] tpm: Stop retrying TPMs that have stopped working
Date: Wed, 11 Nov 2026 01:57:32 -0800
Message-Id: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABI89GoC/x3MWwqDMBAF0K0M99tAJmAK2UoR8THa+WgMmVaE4
 N4LPQs4DSZVxZCoocqppkdGIu4Iy2vKuzhdkQjBh8jM3n3Ke/zmKlaObHqKm/rtwQuvsw8RHaF
 U2fT6l8/hvn+6C4KlYgAAAA==
X-Change-ID: 20261110-tpm_unresponsive-a5f71c1db026
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=leitao@debian.org;
 h=from:subject:message-id; bh=j8ZEhGfWHCEfTefPlCbyaYx1dtDsWXhXn5PyttH9TG0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9Dw6OqEQdrFruxgvP7o27tWo7iOTK2tPdEOgV
 WXxQbltV5aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavQ8OgAKCRA1o5Of/Hh3
 begOD/49YbiY0hfbVzY7xRJxJDJBTPb3zVyoMOuqVqZSS5ZysNFmL8XeuLhjELyLkcDhgUUM4oX
 r1/L2QLHJBBHOugjC1Jry0g65iYIHWgVkM2CRhjsbfSCOot/tSrk5c9U+4sRR1671hEYJeB6/sm
 ktDwwaNeZjXrj2N2HDpNqTryXj03AA8N9hx5bhZLu7pNtDUgZkYIp17BFy/zydpVHzUgy9Uy3hS
 FI3PCuiEoyIAZrsWxhKXdSca4wuSVAzr2dLYKpyJwldjkivez5FgvEO10tfXv6a1/DlRTBZhqI/
 5Enc2mCl5dnLGwggJVC02maQMUKcHaDVXR30H1trcFGBtZfvvvwlFJnNu2jAI72XHm+fRLWwo2f
 3efLBEvJLEjdIwRG4QqTKjIs/yqeu2O8R2qeHZPI2QYMRQ/zCNyrj3RTkCt8oy2qO/3hUNUcDLW
 4KwReu6iGFOB2ic/CLQN3nX5Yy+RQKQs/36ZX8WYL0uCi5usn6vonlamWVyvXAr7KVsK1etorpY
 xHCy5tWioAN+rknCFe+GMXfoWVXGSlDShxYixD8mIxWSNXULWe2hkGB/ZEBD+LjOX7tsY432DHW
 Os5Y7C/SucIxXHEjicUUH4edfDgH/gHAW748SSnD7oDM5npTeqtmbeKNq5A4Y8LfzNNR6zeydve
 FB2LCFfLgFLnDSg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

On Meta's datacenter, given the size, TPMs that stop working write about
54 million lines a day to the kernel log, because nothing in the kernel
gives up on them.

Two cases make up nearly all of it.

Some TPMs stop responding. Every command then fails only after the
transport timeout, while the hwrng thread and userspace keep sending
more.

The goal is to retire TPM that are not properly working, similarly to
what was done for EFI in commit 4b2c033b5bc971 ("efi/runtime-wrappers:
retire the worker if a wedged call ever returns")

This feature aim to disable the chip once its commands have kept timing,
instead of keeping it in this desolate state.

Disabling the chip makes the failure explicit: the log gets one line
saying the TPM is disabled, and every later command fails at once
instead of timing out. 

A health-check daemon, such as machine checker, can then detect
the broken hardware and send the machine to repair.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      tpm: Disable a TPM that stops responding
      tpm: Disable a TPM whose hwrng reads keep failing

 drivers/char/tpm/tpm-chip.c      | 20 +++++++++++++++++++-
 drivers/char/tpm/tpm-interface.c | 29 +++++++++++++++++++++++++++++
 include/linux/tpm.h              |  3 +++
 3 files changed, 51 insertions(+), 1 deletion(-)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-tpm_unresponsive-a5f71c1db026

Best regards,
--  
Breno Leitao <leitao@debian.org>

