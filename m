Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B51DA57;
	Sat, 17 Oct 2026 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196925; cv=none; b=QUSCrFeNg22gYBxQ2OKEJ0e4G5fIjmcn8I6KY1qP9fuAueyq/jmL7cWy9Hy6HlHj1JOwAJEcgtZWztzxJlDNYOCC3VU64Paik1vNW5IEe5E6wxcjD4WqKZg9tOmoz8iO4E0yPfzOHs7WKI+RVQht7EfOyENi6qOiPHsE3C/heBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196925; c=relaxed/simple;
	bh=HLwSUli3ko11EJAMrWagoL7m8dMM3cBydyu3zRY0p1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr6y8x9sBsX2zXvDAsGAaOguV0rpUafwRE9glWZx7HjIPbQ0FCGLmmaN08AanCI9i/2Ec3husqEJO0eNUvTyymX+KsbR+f6Z6ovNgpZx1QyjNoKUby+pov0oIQYyqmiIfB089IDCEf54iSkvroC9ubtTHjefq237asl+4ehfIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fenrt9GG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fenrt9GG"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BD0221F000C4;
	Sat, 17 Oct 2026 00:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196924;
	bh=uATyO7MiIGWt7kzsKD5f1kNMJ+/WpMh6uWwZOEVGvWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fenrt9GGV4jHs6Q9s+ulzazdaZqcBr3RqaegLANIBNUyyVfMx3qgEk0zyNarXo+qi
	 L7i2FcTy2LP81zNql7jP0rEO9XR3gPb/3CMyWcc9NXkor1hvCKpx0Vv/nNS9vd1RF/
	 8wY2s0Vq5sAqVolLswCI40P2qcwiV+61A04+gZAWBdtMaEk2Y/hcAm0PkqsBmncZtd
	 QPuW2SEIOhciBFp1Mfv4URXsVsLikHTu6FVQHibbLevtahG6ZWGCTriQblQcSTt8Ws
	 dzSwc2g5AaxLXZ1je3IKuPSGHhWjtykEIu+zdF+qlayE7sD+2kAHKoLraPysWluv9u
	 5pHUEMlhLIV0w==
Date: Sat, 17 Oct 2026 03:28:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Graf (AWS), Alexander" <graf@amazon.de>
Cc: Jonathan McDowell <noodles@earth.li>,
	"Kanagaraj, Surendran" <surenkj@amazon.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"Kudrjavets, Gunnar" <gunnarku@amazon.com>,
	"Levinson, Josh" <joshlev@amazon.com>
Subject: Re: [PATCH v2 2/2] tpm_crb: Raise durations for Amazon NitroTPM
Message-ID: <atLBOMd22_lMJH4K@kernel.org>
References: <20261016043733.30589-1-surenkj@amazon.com>
 <20261016043733.30589-3-surenkj@amazon.com>
 <atJQgXYkFjcQROb6@earth.li>
 <56bd8d2f-bf22-4a56-a845-674377b086fa@amazon.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bd8d2f-bf22-4a56-a845-674377b086fa@amazon.de>

On Fri, Oct 16, 2026 at 04:38:56PM +0000, Graf (AWS), Alexander wrote:
> 
> On 16.10.26 18:27, Jonathan McDowell wrote:
> > On Fri, Oct 16, 2026 at 04:37:33AM +0000, Surendran Kanagaraj wrote:
> >> TPM commands need to complete within the command duration defined in
> >> the TPM2 spec or keep answering TPM2_RC_RETRY for at most
> >> TPM2_DURATION_LONG (2s).
> >>
> >> In rare scenarios NitroTPM can enter a mode where it either sends
> >> TPM2_RC_RETRY for more than 2s or delays command completion. When
> >> this happens during auth session start, the driver disables the chip
> >> and every subsequent request fails:
> >>
> >>      tpm tpm0: in retry loop
> >>      tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922
> >>
> >> Add support for vendor duration overrides to the CRB driver, based on
> >> the vendor ID read from the interface ID register. For NitroTPM, raise
> >> TPM_SHORT, TPM_MEDIUM and TPM_LONG to 30s which covers the longest
> >> unavailability time along with some headroom.
> > Bumping all of these to 30s seems excessive. Is it really the case that
> > all commands can potentially take this long? Is that because of
> > non-TPM-related operations Nitro might be doing behind the scenes?
> 
> 
> We won't reach the 30s, which is exactly why it's a safe default for the 
> safety net that these timeouts are :).

To be exact, durations. In the context of TPMs, timeouts are the
latency between the requested state changes.

> 
> 
> Alex

Br, Jarkko
