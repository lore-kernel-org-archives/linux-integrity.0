Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207885;
	b=rNS5ezoKMJdTr+zsZMhvgv+A8ibvLppQx1LLAdDsFU5mpwinRVAM+FAuf7tY+vfuZQbd
	 n3E88OOHr3bk7z0YyDxJw7qLc0C0tYZIlAJys7A2Cd3+oYszgOPmCgPAtfnxDrTGjhiDM
	 tmFIeaZERynwk1fJxQEPqhN8zki5zpHMHbZCI3VJe1vmXNKDb4EsCyxtbUL3corxCqHpP
	 vwffhxxC/CFWABLkTYaRjo5Z6x/60rmltG+7lZK+fps+PxmO734P13KohFsHSGKb026tj
	 f2C1wWjFMRy08g+/gZTSwYOqQE2QMmU9imhmoUkbLFt4ICXVd6Kn4NYrNbXIYv7ImMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207885;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=n/QkqJaxPpC6HIbdsizS1hB7R07q4e4wqRqCMqZNcAE=;
	b=jzKdThXtgvJu7+cm6UJhSSm4PRv8HPr3Mg+ZPg8Tou4yaVSbQc1UGDEPBoxx0nHZ8fN1
	 hqGl8CJ/CNmwk4GyJ0H6hJNjWymzcl+LEq/Vqe3LJ3nZpgElOlDKtbkcZnCZWASYmtrSJ
	 R98bxkKmugX17jdUFFgcBnROZso4BIzs7K60yKCh5kNz/4QvEysJmGPHrlMhwqrE/l7gs
	 8mA9r+1qOOQVqgAoWorvdfXC+qQaz21UWzZujP3kMjFICzGwO9BL1CMIlfOXG88/qDv23
	 KkM/YvC0nE4FdHj4Hl8W1NKgIrQsv/kGTrxTvWMqftFC0w+8eXwpvqGhfw2MPbhQ5kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Yh8G46O1;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C6606A68E;
	Fri, 20 Nov 2026 20:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E3C6606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Yh8G46O1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=n/QkqJaxPpC6HIbdsizS1hB7R07q4e4wqRqCMqZNcAE=; b=Yh8G46O1FLiwtYDskzsQvUO6rf
	3puwqPkHiZkNfSX0vuyU9vY/FBv4A2MYa0rQQ8Edc5qoAyGYOVgU0PcXG+evK90MqYlZruNB4+SZO
	nH18CF8dmzwdL2cEaleYNSYo28O47mKoWaEdyn3FYb6D5aHTV6OeWjcuZjzT0tWnhBTco03c7wR/a
	Pd9ceKKAm4jqaQI/L9jXhxigiuxOHttzxvJDxzdfx7tcdURpudTllgGfsP2VRhUqZWySXqOsTL/u3
	me0v6C4vjsEqgNyV7RPBRb0hW8AQRraKVIbilqeEuDPWqLj/SJAc6QZHlpW1CDPGUmy8twhE/6KgN
	FljwQimA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xUVZn-0038tx-3B;
	Fri, 20 Nov 2026 20:51:21 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v4 0/2] tpm: Stop retrying TPMs that have stopped working
Date: Fri, 20 Nov 2026 12:47:06 -0800
Message-Id: <20261120-tpm_unresponsive-v4-0-b9043735ec1b@debian.org>
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
X-B4-Tracking: v=1; b=H4sIANCxAGsC/23NQWrDMBBA0auIWXuKZmQ7sle9RwnBkseJFpWNl
 IqG4LsHGwopyfYv3r9DlhQkQ6/ukKSEHOYIvaorBf4yxLNgGKFXwJpbItJ4Xb5PPzFJXuaYQxE
 cmulAnkanuYVKwZJkCr87+XWsFFxCvs7pth8KbfUPo1esEGqsefDkurYR132O4sIQP+Z0hk0r/
 CzwG4FR46Fu6pG97TqZXgTzLJg3gkGNloz1VtgaZ/8J67o+APthgL41AQAA
X-Change-ID: 20261110-tpm_unresponsive-a5f71c1db026
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, 
 David Laight <david.laight.linux@gmail.com>, 
 Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3663; i=leitao@debian.org;
 h=from:subject:message-id; bh=+KlZ+aXV4QgLBod+JFmIykA+2spLaT648FF467Lmwz0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBrALLEQwOnnMJ88SDDLcYV1vMkWXpIWUApTl3p7
 b9bVOWkuxOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCawCyxAAKCRA1o5Of/Hh3
 bYxyEACQqxe5GPLLoJUB2ZW/A7st5DwBMdkFPqsOUGP00itJ3U+IB4S/oD9gUy5FtHpFj/CfGje
 mcAk4CiTYb/fQILXFwXp5NdPfVHmkSIAJvs6fIKafqTfbsBTDNQnw5KbZPlDKzSvavJc3G2TQXm
 6unrUgm50JTQgiwVpWLSFoUvEdmCyY7rLycEjaBFHeHS50TGF3wfd2GwCrD2PmC48OCzy3eFPBH
 G77YKe/vFNgrsAVaP52ks1/MWXohPo5jaPOaaHyWxKjgS3ZAJFx9NrELWA2Wa0TOrSKZf/QRHGM
 9zp2rpNse0gbHuvrhR46NquCxUH1b5tyomSINa4ZYeALpUdusbqCoVNOLF7yEQPs0nxeYzgLW6O
 Hbdg1b/mMDRgRAz2ja6PzvaeLfyHEhN7LN3Nw+LYRgqowcoRXA406bc5BUdfWX0VkOl3TVEi6dT
 Z+PRJ0DQdDnI9xqRqs9vQcD9x4QFR7nMB7EO6DjjvcsjAwjD5x1hd/GgQs199eparCfKs9pYFIx
 ppflVQ7maXdU/FrF4gtBbyqHBBFjHxl5Qtxn1Q73esj3JPPCExQGB9V81xwvAlR3Qhn+BL9J6lw
 IskazqjgNmqDkXywScv5veh5tqJ0tSfWxO9r8Lv9xpPrfEefBZfNXqFdE+wd4dWE1n1eFBPWGTK
 DigIVprrm9Klj4A==
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

Patch 1 disables the chip once two commands in a row have timed out,
instead of keeping it in this desolate state. Patch 2, from Jarkko,
disables it once it answers TPM_RC_INITIALIZE to anything but
TPM2_Startup.

Disabling the chip makes the failure explicit: every later command
fails at once instead of timing out.

A health-check daemon, such as machine checker, can then detect
the broken hardware and send the machine to repair.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v4:
- Replace the count of timeouts and the tpm.max_missed_responses
  parameter with TPM_CHIP_FLAG_MISSED_RESPONSE: one timeout is
  tolerated, and a second one in a row disables the TPM (Jarkko)
- Say in patch 1 when TPMs stop responding (Jarkko), and drop the
  claim that some of them recover
- Fix sashiko findings:
  - A timeout while a signal is pending no longer counts, since some
    drivers return -ETIME when a signal interrupts the wait
  - tpm1_do_selftest() clears the flag on the timeouts it expects from
    TPM 1.2 chips that block during the self test
- Link to v3: https://patch.msgid.link/20261113-tpm_unresponsive-v3-0-8138c8e283b8@debian.org

Changes in v3:
- Rename tpm.max_unanswered to tpm.max_missed_responses and
  nr_unanswered to nr_missed_responses, and drop a redundant comment
  (Jarkko)
- Document tpm.max_missed_responses in kernel-parameters.txt (Jarkko)
- Check the limit with a modulo (Jarkko), guarded so that 0 still
  means never
- Link to v2: https://patch.msgid.link/20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org

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
 drivers/char/tpm/tpm1-cmd.c      |  1 +
 drivers/char/tpm/tpm2-cmd.c      |  2 ++
 include/linux/tpm.h              |  1 +
 4 files changed, 24 insertions(+)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-tpm_unresponsive-a5f71c1db026

Best regards,
--  
Breno Leitao <leitao@debian.org>

