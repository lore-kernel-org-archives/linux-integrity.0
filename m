Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566370;
	b=CcLmEHkj2/NH9+JsugEurYMPrn6dsXUtc4Hh4b1uRlZc/fhdOM+coN0WZBn49m0FA404
	 SD6f2XhoAJMmUNX2nQ/55ANzWd0V6YS1Amix7acskWKPojTA4og8FmJjLYvZWd3QIaJY0
	 ClOzb3PmqPDmfFyokYE3Sb1MspfjB1glULNYFNRMyQfwo3M92NSNdjahblFw7MoyxycWc
	 PWBvuZZ5YCxhZ2U3auiUhZrcL3nl0ZPlTghZvrF/vjonEfdPLvFpyBNDhZspis7+HtI57
	 Pxa+2O0kGBVi9P0Jn6eGH3FJ0Jgp6k4xqpGgRfpUwbmMOcGT5zzqr1FSfM3MJw7FV5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566370;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=4P9FswYUYTXejRyRkW+uu2wcwxGHTX/Xsk5fqbZVmRI=;
	b=Si5fFS/oiZ3qe/GZSaw7gvwcHEukMadF9A7rrRfX0/o1nlWtuzJYxDJ2v9stsxBehywp
	 Kyxuy1XGaThOqv4nSWb4wz8cSPOabgIl+Z1sBPhxmp4Ohj00UKSqKAJqHtJ06mP2s5LMi
	 S4ijM+dQYJjtYrU67qXykRHKqv69Y7w4KqH9u7/Uv4bjpexrSQmX+88Ow0mMR6kSe5HBP
	 LwtdRNMnwfyLb1nBHmnyEzKRHWysHjed6IrS8C+bET56b1csPIAQhkqV+x9OZm6tK+0+8
	 hJKVh405IgKIiIx73im0sNk5ckUzLeVUeKXnY66VfrtWyjwHnhB3XIRMIe4fxvdTZKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SwujO3aG;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD20606A32D;
	Fri, 13 Nov 2026 10:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BD20606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SwujO3aG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=4P9FswYUYTXejRyRkW+uu2wcwxGHTX/Xsk5fqbZVmRI=; b=SwujO3aGqCCul3BEv5pB3DOs2d
	FxvWa5p5GoGQbDrIX/aN8EuUUqFxYsbrV3xMGA+8pileuD+cMCWEaWC0jHp9spyga5LXsosjNWeBL
	tAh7U7vpMV1FqM5MhX9Sa0KRdrVbTWYsphwaAtDon3jJE1V5s6cqNekdqLJquWO4HDOrH72qxj+lf
	COEKfJASr4SIbDkyLDraXKHOGrpYuf5RraLXVx0u/9MsPZ3tYV6RjNyUB+UFXzlnoxdC9UhH2gmnl
	9CtO3IuHIIB1+EYCidi1RH8ZdTtQrLowI6l+/Tln6Z5B2/HhMRcEQ86pEsTKiRl88eQmKnXMZlsgv
	nuufkaYQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRogk-00Eh0c-0o;
	Fri, 13 Nov 2026 10:39:23 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v3 0/2] tpm: Stop retrying TPMs that have stopped working
Date: Fri, 13 Nov 2026 02:38:57 -0800
Message-Id: <20261113-tpm_unresponsive-v3-0-8138c8e283b8@debian.org>
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
X-B4-Tracking: v=1; b=H4sIAMfo9moC/23NywrCMBBA0V8Js24kE/uwXfkfIpLHtGZhUpIal
 NJ/lxYERbd3ce4MiaKjBB2bIVJ2yQUPHdsXDMxV+YG4s9AxkELWiCj4NN4udx8pjcEnl4mrqm/
 QoNVC1lAwGCP17rGRp3PB4OrSFOJzO2Rc6xvDXywjF7yUyqBu64p0e7SknfK7EAdYtSw/BflHk
 FzwpqxKK82hban/EpZleQEyuttg8wAAAA==
X-Change-ID: 20261110-tpm_unresponsive-a5f71c1db026
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 surenkj@amazon.com, noodles@meta.com, linux-doc@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3080; i=leitao@debian.org;
 h=from:subject:message-id; bh=dByAsDyd2d+cLgVqzlzYvzXhZNqDmowoUO+KmCuDgWA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9ujVDsknbf6I3kNpheouZAELSUbZEHa7KG4CY
 D9czZ6O8YuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavbo1QAKCRA1o5Of/Hh3
 bXe0EACfqmB/MZxk5E65A1vKbVR9y4E5AHNdqnPkIkmsHtYiaw9VSn0WAAw6bR6jFbtNn91yHDW
 90A8+hWSpmmxpgxC/B93IA8iz17elVqJwDQMKeo7ArdeTFVM5Onb9UujObsSq82ZNK4WvNLakl0
 LkxK2ZYK4L02xgvehYECrOPzTl9r2SFAqYdZ60FMY+FEG622+p4GsNljRhfUAROo7M1W1TCEvJT
 iHHN7yBQdw7YwA882EI6xxZq4HCsKR+koD+AEQX5L41FlKl1zGakmjWag8S4e40xIRVQt0efeXw
 ziUta12XnFYXel46A0rr6js1Ej0cuV6Ajtg1xhWNkw1lZodeFmEsgKf9aSZxG+bzYeiJiDiFIlK
 ESOVLgJ6/bUTZ4787Twby2COyWThI3KN39ZiBGOvUoDy02xDjZgDjbG1fg4Me47egIHykjwYAbG
 wmTWvC7DDIoz9yWjzoW1rBnDSwnhxLcsMjhHAQ8dTqWM1eXKl+Pi6ZYKd5rt4GwABOCHLbAU6Qb
 JCOthe655ijGX2IGxVDPXyLi+g1ljflAqlBfOB0njGnz9PozZPEJdEyF8r3cVdyvMp9X0FP+IwA
 Hpr202m9GXMxZcBiLX2zyVlD7+ITs0eXauVv9mP9EXaYd6/rI7LFVHVfoAv5fzLaP4dGPMv2H4C
 +G03LTPodMISZxA==
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

 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 drivers/char/tpm/tpm-interface.c                | 19 +++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c                     |  2 ++
 include/linux/tpm.h                             |  1 +
 4 files changed, 30 insertions(+)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-tpm_unresponsive-a5f71c1db026

Best regards,
--  
Breno Leitao <leitao@debian.org>

