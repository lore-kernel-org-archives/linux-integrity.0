Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486712;
	b=KG5KIjK8IJ6JWHscPQgKTdzP52K0eb1MSWlHms/oUz6gdtPUcoifV2G60y5Pzxad1x6L
	 lZxv+cgiZy8vlCduv5eX71on7B06FQrWINQSWMt6k4WQoHNYHqYpUuhlXObIZEyhP1om2
	 GkYz9ntZWIuJxlifQDDD0KmPLqGcyhghYDJdUnd5uORbUnIwDRkubv3Xc62vVl7lclH14
	 3clwZHhxNQMRdutePVEZZ4kNnqK9OgrJBv+CcR/svacmRJeP0bW2GmwQkY2rZcQdcNRgu
	 HX7TL5Zh2SYO9w5EMJ8sThQmnhuKmaFnVQDZRi3hDnYT0HU8Vg/bvSdYkt3kNyFE2WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486712;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=M33ptlYq/wRIIxDWa10zRdP+rs2Bk1wjfkkG/z3Cth0=;
	b=pFGScn18+mIKtku7aWsuj8ek3pdtUz3F+LwKwiCV3ZjuOWJHBJWOMfTyDzC+XNUPqr5G
	 MGvtwpGpPWJ86Q4bP+2j6KiVHZDvyvvU5+8MvirWk3Rq1JX1dcjb1QnKsZ9HX25ze6rpb
	 1v80wOLmcKIvbBWQLlrJum0RVzfkaVq/N2vfOMj76t9Jb0+Yk5Bgeq5yC8MDwLk7dp4Wb
	 jnrY1knPbclJ4aT+oks8KAa+ZRpvIGTzVvsHEVrjJvGGCFeuJB+P+4S8GP288pDFeO+o6
	 7o+euPAJ8pfhtby3p6UuJjFxuNp5IeSieb3EBXxGOjgSvuMPJP8GjU4MY25fZqQRHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=eCb4lUiz;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A96606A31C;
	Thu, 12 Nov 2026 12:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A96606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=eCb4lUiz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=M33ptlYq/wRIIxDWa10zRdP+rs2Bk1wjfkkG/z3Cth0=; b=eCb4lUizdyuU6b+lkv3dVTXFNQ
	4UPxRVi1iv6GrzxVL3cCdC5B18VBpY4h2/Q0zi25002YNA2ln6izK6pYlyFh5U9XdBDoYYQsMIVC6
	2AND7G7fgMgnEVC617Hct7IhEwuYgk2JNqJVhnlF940vtvS31c0igomOaboOu/Mb7oEijteDxrRSk
	Pr0BW6s+TxNLzgYx2V4dkExrtaw4cUdbd7s1DMXPN05X9of2N7Ifyy4BwZjrshUSSjDUDJbt7FYOk
	NZXEAxsr4Pf9Z6qVXZFqDehpGiZyepV+W/zRzAtsgpWYFP1Oy6Nq1voCgYhO2nqIPyBm2fMLOZITy
	9FzgymmQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRTy0-00DyD1-0J;
	Thu, 12 Nov 2026 12:31:48 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 0/2] tpm: Stop retrying TPMs that have stopped working
Date: Thu, 12 Nov 2026 04:30:16 -0800
Message-Id: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
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
X-B4-Tracking: v=1; b=H4sIAF2x9WoC/2XNQQrCMBBA0auEWTeSCTbSrryHFEmaaTsLk5LUo
 JTcXSy4cvsX7++QKTFl6MUOiQpnjgF6oRsB42LDTJI99AK00gYRldzWx/0ZEuU1hsyFpG2nC47
 ondIGGgFroolfB3kbGgEL5y2m93Eo+K0/DP+xglLJs7Yjus605LqrJ8c2nGKaYai1fgArDhUfs
 QAAAA==
X-Change-ID: 20261110-tpm_unresponsive-a5f71c1db026
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2563; i=leitao@debian.org;
 h=from:subject:message-id; bh=j2zx3gRlKutJqDelq8IqpNKDMv6HF9dJNyCQwT0iGCs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9bGw+eohE4rUkLi34fRYlIf20Z49EdWTZ4v97
 tUHKX5Uev6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavWxsAAKCRA1o5Of/Hh3
 bY71D/9FiolP/YFrRlA29rR7n0kz9H+sHIM1VtOPhPjCaS+ueQyiTWhh5VIe4aNgLPyEt5nJcAJ
 ljUFE4UKZ1N+GYEuHKRoii+PtRSR1S3j0SLJSh35Ahz2/sq8xxFquTJyodHxg7ps24JZeSV4A9W
 0v7vDKgvlDpMXXovujaUW0n/YVjdugvdmJkbEsDaOVoOvEAKSBjLrC207zgy2/0r/VoBwXB/Ig8
 ZrWqqP2XkOA4rd77Ye4G2uxIRbvsfwp/ZQQJOTZ5M9PsMBaqBANON03dDpJ9s6tZlZSySgcdmWV
 LAzlBVGYS7iyslXU6FJj3dIEseQKV8Lkeki+IYn1Qg/JL4OquFx03FvjJtYagna/n4a8I/Z2YDE
 f3THZTBGHxEyZk3lxG1ZzXt0CRiAkNzX9+bZafHIscps2ehrCYIAAPuSm4ean0YpuM/xkuvxHA5
 4iCUP+F0Il4E2iEo0WqABdTaxdQi2wLUxi4gdFbhGhF+XQ2UpSTNKaHsVVcfSfAGIe38vLR1hH8
 0EWuwBhs6DCjbNnz/MsZNbpnpCRN9grK5sP7BB+f4MdPOaDbZKBpu/5Qy/0kZ9ze/gpO9v6wJze
 vLVGTghK7K8Ax7oGaJ2CDQoBPqNyO7m+R1aL5poPSWSO7DCCmXX7TKKCuefuLLWpdLdL7F8EF6e
 gBTatrxGZ4pVATw==
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

Other TPMs get reset under the running OS, and answer every command with
TPM_RC_INITIALIZE (256) from then on, while the hwrng thread retries
every 10 seconds:

  tpm tpm0: A TPM error (256) occurred attempting get random

The goal is to retire TPMs that are not properly working, similarly to
what was done for EFI in commit 4b2c033b5bc971 ("efi/runtime-wrappers:
retire the worker if a wedged call ever returns")

Patch 1 disables the chip once 60 commands in a row have timed out,
instead of keeping it in this desolate state. Patch 2, from Jarkko,
disables it once it answers TPM_RC_INITIALIZE to anything but
TPM2_Startup.

Disabling the chip makes the failure explicit: the log gets one last
line about it, and every later command fails at once instead of timing
out.

A health-check daemon, such as machine checker, can then detect
the broken hardware and send the machine to repair.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Disable the TPM after 60 commands in a row time out, instead of after
  ten minutes of timeouts, and make the limit the tpm.max_unanswered
  boot parameter (Jarkko)
- Open-code the check in tpm_transmit() and drop the "timeout" field
  names (Jarkko)
- Replace the hwrng failure counter with Jarkko's patch, which disables
  the TPM on TPM_RC_INITIALIZE
- In that patch, move the check ahead of the RETRY/TESTING break, where
  it never ran, and skip TPM2_Startup, which a TPM that is already
  started fails with TPM_RC_INITIALIZE
- Fix sashiko findings:
  - Two timeouts ten minutes apart no longer disable an idle TPM
- Link to v1: https://patch.msgid.link/20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org

---
Breno Leitao (1):
      tpm: Disable a TPM that stops responding

Jarkko Sakkinen (1):
      tpm: Disable TPM on TPM_RC_INITIALIZE

 drivers/char/tpm/tpm-interface.c | 20 ++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c      |  2 ++
 include/linux/tpm.h              |  1 +
 3 files changed, 23 insertions(+)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-tpm_unresponsive-a5f71c1db026

Best regards,
--  
Breno Leitao <leitao@debian.org>

