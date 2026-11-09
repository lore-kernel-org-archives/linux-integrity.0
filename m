Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242681;
	b=w6CK8EwLWU07O7a3B08kzSxe/6MBgNK24Buv0iyAnj9NbwLtqX+jXd4YRTKJr32zqXaQ
	 YNBiSw7wd4QVUQjTJLq9Yiua9kR4CNw3jGvCrqXTWEttSUGlUtTiP3O1TLGyIfNU/xuxC
	 JeCr3/NEKbokYEreFIyA+3BL4AFpK14iV+FR5Dga/wWxeCrZaO7tsvZynf8vCtvT7BvU8
	 J01HjT+/mfBr52sfDuBxiFIprWoAEgVu6/rtKkcr5Vyw/AQK+sSdg1zVg3uIEcDXsOJVj
	 mSxDjeksp1pNa9iRKLZl8WUEasmW/ZkLTeTTZk/D9oerLNl4EKvy5GXhBs3VaTRclUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242681;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3ZKKJe+TMQhqlFtkFBZY3aVq6wo+pAjEtwAbIxqWOnE=;
	b=NzCbVPAOMS1sLmGHTrssewIhDUCWMdwyez9BnP7/FeaOOAqxJaJarxy+5/4tOI8RH5mf
	 QAd0LQbxQOrMYxHxtKaqHsaxo+/dm4M8DZ748/AzqdnQUXO/bDX+47PQj5Xvu+BvAPvUJ
	 sn2kOLOXCumQ6Q+LB7xdSqZSt6cXY5ycBl48UAme8+aeLeNBTs45PcQ4DQmgK0FUVXoVd
	 +R/+oxzWOFjRc8SERP4Fi0fC3fc471bqNpou0uZEZokawkZ0efXOgisNatWFapWvOe8Mr
	 f9tIHiRl64eweY7uwFUPaIDI4T2uenLDFni4ijmwBjxZhZQ+OUw/axEisSS9gnGeDbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPvLnlKz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 38E39606EEB0;
	Mon,  9 Nov 2026 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPvLnlKz
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 85D3E1F0089F;
	Mon,  9 Nov 2026 16:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242681;
	bh=3ZKKJe+TMQhqlFtkFBZY3aVq6wo+pAjEtwAbIxqWOnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GPvLnlKzxQ/HU9hAZI8YCeXA1Ybh/kAhH78Bl+hqZQ5zqc49vibUsgIi/Fh+93w6x
	 YxXkhk97gBOtSlPoWkn2WkkkJeEiHDP7oJjR3wg8cNbCjLhxXsiwEgv0nATDcAKPV+
	 FCvmX5yfLUAX0XrlhJpN7GeEnoMOA5OL/X06d/W3IlH17GeNjk7/4NUEF6twDwm9KY
	 gY4CT0akV3KQtQqSwpargElvFNZOb7a3AK9nqhvLjA6hCS3EUJfC1hafFUnuMlUJZy
	 QjQBj/ZQUpj+Ha9bj+/sv3s771dCduYV7GG7bqLOe4D3WACCfADVhJDfvFxAlC6QnO
	 tknJNXqRiQNYA==
Date: Mon, 9 Nov 2026 18:44:37 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: acpi: Fix memory leak at tpm_read_log_acpi() error
 path
Message-ID: <avH4dX38CWW3IOAg@kernel.org>
References: <20261109082527.541901-1-tiwai@suse.de>
 <avHl-WoBP73QjInD@kernel.org>
 <87mrriuhig.wl-tiwai@suse.de>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mrriuhig.wl-tiwai@suse.de>

On Mon, Nov 09, 2026 at 04:55:03PM +0100, Takashi Iwai wrote:
> On Mon, 09 Nov 2026 16:25:45 +0100,
> Jarkko Sakkinen wrote:
> > 
> > On Mon, Nov 09, 2026 at 09:25:24AM +0100, Takashi Iwai wrote:
> > > When devm_add_action() returns an error, we do NULL-clear
> > > log->bios_event_log unnecessarily before calling tpm_bios_log_free(),
> > > and it would lead to a memory leak of the allocated log buffer.
> > 
> > I don't understand this. "NULL-clear" is gibberish when the actual
> > bug is just spurious clear of log->bios_event_log.
> 
> It's not "spurious", but rather ill-behaving.
> Because it sets NULL before calling tpm_bios_log_free(), the actually
> allocated buffer won't be freed at all.

I agree. That was wrong choice of the word from my side :-)

Since in this case it simple, I'd just want to apples and oranges
pointed out, that's all.


> 
> 
> Takashi

Br, Jarkko
