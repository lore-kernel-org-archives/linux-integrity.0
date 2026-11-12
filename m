Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448649;
	b=RSrwTAQgN5ZgN9ySk5E3235XpMebjy+BCZAON6U9EWVmrd1eeJaICNy3RvMctb35V5KI
	 8X+j9A2boFNTaBszIS8EsqtrtMpgfIkBZmKM3Lb1PClV/fN1mlHc5Qcrv6hnrJqPC5fXP
	 qpDo+nfcBzM3mL5DpHib2OhpPq+vt7cmqHn6xOhbYevBtdzCnxlZsU8iu7rUFbpbxqb+4
	 Nq/tkNUlQotEESnt8qXrX/iVO7lxNC8ilpdRkqq5QM5Iv98t7WTu6JyX0sHvzmPIl3kIu
	 rK7Z2aOkRhCEaphJaeFzeMg5qP6W0ybqyU3xlZLvH8Kou5Dgm6P1NQ0nHFFSMs2qxXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448649;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DvHekcPAuyK9riJrTTvp6Jq4YnII5Pm7qYzhV4GA2QA=;
	b=J+JqobvpLHFfxixFOxSXhjD3GRH2hDptS3imjAd3vsXn9tP+s9ESk2v6pDm+LdDsGqhJ
	 i3BIMp6+iGWBat+IiSROjECznhRAaE8AuLeBa180PceuaWASzorfPTi3XxMfMyX9ELRW8
	 tXx04He8F75C2CGOz7Mj5ueFjdKaVjeKjKEMBz+IO+KVPTGkNuNFgnewXfUx2hthJG1c3
	 Sbmc1PygMjwBvvYMX3Oy1J8vX6bcBjB4CdMZ5L7yi7EQskRcJqUfqUBu+2kgIuTZKo/BV
	 bZ7d6AXyVGJo4VzE0YWAyBqEHoT2lVkDv75Fe+pQ1ZzN4Pnpu0KxNIBizYZYcTEsdcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQC+Fw+W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 97710606A8AD;
	Thu, 12 Nov 2026 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQC+Fw+W
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 983CE1F00A0C;
	Thu, 12 Nov 2026 01:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448649;
	bh=DvHekcPAuyK9riJrTTvp6Jq4YnII5Pm7qYzhV4GA2QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AQC+Fw+WdBagmIKqA7KwNIImUFooelRxjp0dG+L5qn9utfkGi61FHJ4DWCTi6p18+
	 YCC3oCGDeeSJaBgd9G9bIZO2noek+2uuAMrpOqJ465CtS39MmuXQE8LcZ7/2NTAGXb
	 UTyJ0TgR9nq+FPxH6WrzDTaPS/nDkqbGspayna1WLETJRuSmI7W9mYP8UfiwTJ4Mlq
	 GUk4WIxZ3/4WTv31LstUweO2VMH8eu7oeAbSXSW+m8wqd95uwO8UePngaSTRQU20H6
	 wWuoFldk6h5IXuCMhTJQdgph0dcduEHbhPkw1RU0eBp6gLGefMGY+8btFEG16TlaHC
	 whBGRmNae8Bfg==
Date: Thu, 12 Nov 2026 03:57:25 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 0/2] tpm: Stop retrying TPMs that have stopped working
Message-ID: <avUdBbvxxFgXkUJI@kernel.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
 <avTsh6pCI-sRGAJp@kernel.org>
 <avTvq4VaYbxMnZl9@kernel.org>
 <avTwXhEGwVj71VmH@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Hx+xmU6F5MTkrZNe"
Content-Disposition: inline
In-Reply-To: <avTwXhEGwVj71VmH@kernel.org>


--Hx+xmU6F5MTkrZNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2026 at 12:46:57AM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 12, 2026 at 12:43:59AM +0200, Jarkko Sakkinen wrote:
> > $ tpm2sh return-code 256
> > TPM_RC_INITIALIZE
> > 
> > I.e. TPM has not been properly initialized by TPM2_Startup().
> > 
> > I.e. TPM is also saying that it is *disabled*.
> > 
> > So acting on this proven fact  makes most sense to me.
> 
> 
> Actually, should we even disable TPM if it returns this error code
> already at the level of tpm_transmit(). It is a guaranteed dead-end
> to any possible TPM operation.
> 
> I.e. while this fixes hwrng issue I think it might be addressing the
> issue at a wrong level.

I leave room for figuring out 1/2 but for the second issue I would just
do what the attached patch does and call it a day.

Br, Jarkko

--Hx+xmU6F5MTkrZNe
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-tpm-Disable-TPM-on-TPM_RC_INITIALIZE.patch"

From 093124e51a26de8191e21ce41988532ea7e0bc8a Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Thu, 12 Nov 2026 03:55:00 +0200
Subject: [PATCH] tpm: Disable TPM on TPM_RC_INITIALIZE

If the TPM has been spuriously disabled, the game is over. Let's reflect
this truth with TPM_CHIP_FLAG_DISABLE.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-interface.c | 5 +++++
 drivers/char/tpm/tpm2-cmd.c      | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 470b2da3234e..1f1e22341155 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -256,6 +256,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
 			break;
 
+		if (rc == TPM_RC_INITIALIZE) {
+			chip->flag |= TPM_CHIP_FLAG_DISABLE;
+			break;
+		}
+
 		if (delay_msec > TPM2_DURATION_LONG) {
 			if (rc == TPM2_RC_RETRY)
 				dev_err(&chip->dev, "in retry loop\n");
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 7fe00b4f8e7d..8d76e78cd92e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -1021,6 +1021,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	if (rc == TPM2_RC_INITIALIZE) {
+		chip->flags &= ~TPM_CHIP_FLAG_DISABLE;
+
 		rc = tpm2_startup(chip);
 		if (rc)
 			goto out;
-- 
2.47.3


--Hx+xmU6F5MTkrZNe--
