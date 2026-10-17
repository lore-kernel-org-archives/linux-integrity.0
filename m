Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4919B3CB;
	Sat, 17 Oct 2026 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196368; cv=none; b=n8ZBcIZZ0J2bKevB5OmXApnFpMof5ds037nqG7vxivQYh19MgoJB2u/FoEWnXnMglwDnV2L5+wGcluTFwhvr5+6370ONbAieRYYL9N32QX96tT4DSJ8ug4AtpmJWh1hz/Vw42mz/wxfuhul/1eIBBltPdcIeVUBTi7c5GAoM2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196368; c=relaxed/simple;
	bh=VQMzbEsOXG/d8fnyJNH+Bj2M7bkanTsEL4qMOa5I31M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnAB06F/Kew2O9eQHEhk18PVN9W7OD9MK+D5wjoI9qoyXduBi2v/FUSmXzd68yQW2FC3IxMVpAmb9RSOH8a1/eylYQjNBTytZBN4MF14LbbRDBHWBWDF07fXAoIAij7MegbFRLRtCRiZTNeXPOD6lyui4XOVj4R04B1t7NTUbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1XSgdJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1XSgdJ2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8BB421F000C4;
	Sat, 17 Oct 2026 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196367;
	bh=zl49qWlw9Jmlgrrsax6/pTs84JUC+oMwmtix/l3TlAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I1XSgdJ2+g4oV4ltdShGQDQJB/LSZqWhUXyYvwYzP00iWQSd8d57iplmg9HL3L3eM
	 VXo9RapBNBpDZ4ed6uPxk8bcyT3iJt+xROPWpZUR7SK+Z5i+v5/5lYA79/ACpky1Lx
	 CzT1omYXEVnQmzwR579XJINInc7BgpImzRDuz0Y5lha2dFz1Su9JY/lJD8Hayb/ki4
	 R6lIrKvP0wnbYU9jQnqSVkxU785sKe9XrVKcyVcPfmyeIVsnnWMZM2Jx/CB6PA5Q2P
	 2LCFww8DdMfqEu8y3YI6BkNxCelBY3E7QZy1LMktCklN8xmyOfsR2qLdMmdj8+qxxs
	 1i/gPaOwwcpfg==
Date: Sat, 17 Oct 2026 03:19:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, nh-open-source@amazon.com,
	Alexander Graf <graf@amazon.de>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [PATCH v2 1/2] tpm: Add support for updating TPM2 durations
Message-ID: <atK_CxpdR-h_DIn6@kernel.org>
References: <20261016043733.30589-1-surenkj@amazon.com>
 <20261016043733.30589-2-surenkj@amazon.com>
 <atK9VuMmeD3njBsz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atK9VuMmeD3njBsz@kernel.org>

On Sat, Oct 17, 2026 at 03:12:10AM +0300, Jarkko Sakkinen wrote:
> On Fri, Oct 16, 2026 at 04:37:32AM +0000, Surendran Kanagaraj wrote:
> > TPM commands need to complete within the command duration defined
> > in the TPM2 spec or keep answering TPM2_RC_RETRY for at most
> > TPM2_DURATION_LONG (2s).
> > 
> > Devices that have different timeout requirements than the TPM2 spec
> > could exhaust the retry budget or exceed the command duration. These
> > failures disable the device during an auth session, failing all
> > subsequent TPM requests. Worse, when a TPM2_CC_FLUSH_CONTEXT command
> > fails, it leaks the TPM's transient memory:
> > 
> >     tpm tpm0: in retry loop
> >     tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922
> >     ...
> >     tpm tpm0: A TPM error (2338) occurred flushing context
> > 
> > Fix this by overriding the command durations and retry budget
> > based on chip->duration and letting the driver modify the durations
> > during tpm2_get_timeouts() as TPM 1.x does. Chips without
> > the override keep the current durations.
> > 
> > Tested in QEMU with swtpm on tpm_crb, tpm_tis, tpm_tis_i2c, tpm_ibmvtpm
> > and tpm_vtpm_proxy.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
> > ---
> > V1 -> V2:
> > - Drop chip->busy_timeout_ms. TPM2 durations and the TPM2_RC_RETRY
> >   budget now come from chip->duration, which drivers adjust through
> >   ->update_durations() as TPM 1.x does.
> > - Map TPM2_CC_SELF_TEST and TPM2_CC_VERIFY_SIGNATURE to TPM_LONG with
> >   floors of 3s and 30s since their durations do not fit SHORT, MEDIUM,
> >   LONG durations.
> > - Keep the TPM2 defaults for commands sent before tpm2_get_timeouts()
> >   has run such as the one in tpm2_probe() and keep the 2s retry
> >   budget for TPM 1.x chips.
> > - Keep the first TPM2_RC_RETRY wait at TPM2_DURATION_SHORT instead of
> >   chip->duration[TPM_SHORT].
> > - Return early from tpm_tis_update_durations() for TPM2 chips, since
> >   its overrides are for TPM 1.x.
> > - Rename from "tpm: Add per-chip timeout for transient unavailability".
> > 
> > v1: https://lore.kernel.org/linux-integrity/20260923142834.16786-2-surenkj@amazon.com/
> 
> While the issue does get addressed the patch also makes the code
> base worse. What would be more feasible would be to address the
> architectural issue.
> 
> We absolutely do not want a new special to tpm_transmit().

I.e. unifying and adding coherency would be what I would emphasize
here not shortcircuiting the actual issues and adding special
conditions.

I think this change is optimizing for being non-distruptive as an
optimal goals e.g., by not reconsidering TPM ops etc. and like
the bird eye picture. I think this would be a good chance to
do something much more long term than this.

This is BTW something to look up for with LLM generated changes: LLMs
often optimize towards a bug fix type of minimum side-effect change. It
is probably good to make this type of reflection when pre-checking any
feature patch. I'm not complaining, this isjust something that I just
realized. Just another way to look up whether LLM generated result is
"good" or "bad" because it is very easy to get a blind eye for this.

Br, Jarkko
