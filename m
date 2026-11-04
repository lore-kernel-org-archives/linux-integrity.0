Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790144;
	b=VS6BBEjKWfbrrColzJmF+lGqabxSyfKT+3UFvzBbas4dQAxBICyOcZKunDCtU+70Mu5y
	 Jdx0guTVcC2CfULgP2V/WFrTOkZM8mptgRxV3RrcukeP3nM/uuYBjLHRQBeqBE2ZwcUGF
	 m+woVe2ASlsmOblSIYYAwSayNb2ueci+6ghmb7pIRfuV41xsWocsNcKo1xnlOR5j6ET+v
	 yRKyLgWP23fE7hUcCOhjC1kPyXX15Sw11AD4ncc7ep+CavCScNIQhIb38RAL/M7xNPSFT
	 pvvhcKq2ig+jqGQwns46tZYl3f7h6OadkahBlCuK6fxPW6wjjmwYal+CPj+EuFj87lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790144;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cEVR4bOY4D+puDxbxymd8sWII3mVG3OtcBxnbLeMyo0=;
	b=Cdat9orkiM4zAj5KUV3qAiJDj7ph6IDqSwGCKeuI9Y4tynEeuXtDvhacptH72OUsFC5s
	 jBFIU1zzw8F5gMRaOvVVYW4i6VMSZkZtzLArrBl9kr6HMmX9mhGgWwCQIq3flpE+8Qnis
	 PhjQdSG6+jpnTLdHlHYpN/jXPMIFHY8H+D40OE8T5PsZzI+yL3cKidN6c6reDA63A09EA
	 QwZUR8mE5UDyrMw9NrMcLePvwjTVhTu2rZc2cBOqTKgb3xdQyasqf34mWdCHS6ghC6Ab9
	 lE6o+6oqVzRVNmEmmANz0XqHX4d/bo5dDUW5PvEaP0ECKWCBS05tDcXuBcQE3nAl8jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VMbuu/Kw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DAE05606A31B;
	Wed,  4 Nov 2026 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMbuu/Kw
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E9B481F000C1;
	Wed,  4 Nov 2026 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793790143;
	bh=cEVR4bOY4D+puDxbxymd8sWII3mVG3OtcBxnbLeMyo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VMbuu/KwSeMgvNc499NJoBnUuPcxauEXI7R+lrYexJkaEtROnKZdMbeg3xvVnugEz
	 NM/ExuC4YOjv3Iazr8QvH9M2WTrLQeyDb2XIG/PeGhFkpolO/jBO/rb6UWBH/ZS7GT
	 sWaAcCutg+uloXxCdAAaY1/GK6ff3n6PdYVrIlPB4CwJ3JS1twC/wrKV/GvC7iNrbt
	 N4ADxNOA6BGPYR3r6/VoMpZUs63m44Hv/KeY1SbHglA6oQfQxrwDXf6NKUxhuFX/UO
	 pd2EWPjk+7HU3zPPjQv4Nl2v0npJBicwhN09ID4fXxXTtSBIk8+27Y8jZY9Hi33IEI
	 eR8NgnHngufvA==
Date: Wed, 4 Nov 2026 13:02:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuc63@xiaopeng.com
Subject: Re: [PATCH] tpm: eventlog: check the payload size before reading tag
 events
Message-ID: <ausQu4DY8WARe_2j@kernel.org>
References: <aunbAIcxu8XTW0Ph@kernel.org>
 <20261104025809.787723-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261104025809.787723-1-zhugl3@xiaopeng.com>

On Wed, Nov 04, 2026 at 10:58:09AM +0800, Guanglei Zhu wrote:
> The legacy PC Client spec defines the EV_EVENT_TAG payload as a
> TCPA_PC_EVENT: event_id, event_size and event-type-specific data.
> A conformant entry carries the 8-byte header, and the hash-type
> ids carry a full digest.
> 
> The catch is that the log is an ACPI table the firmware leaves in
> memory: the TPM never measures the log itself, so the kernel cannot
> tell a conformant log from a corrupted one.  The iterators already
> work on that assumption - they stop once the declared event_size
> runs past the buffer end - and this check applies the same rule to
> what the EVENT_TAG branch reads off the payload.

Yeah, this is exactly what I wanted to know. Could you refine the
patch and send a new version with this?

It's really good stuff to have in the commit log when looking back
at old changes.


Br, Jarkko
