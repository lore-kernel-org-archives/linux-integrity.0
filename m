Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075747125E
	for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550355; cv=none; b=tyhsd72jj6/nm9JRXktN3YlYLrFRxpTdxZHCBZr5UY5mYM6pkZ1svAvD47DxT8Andi0HtoF4NnTtwzj1JgBL0knZ+xi6RBVyvdJhpt724p0kqrt/oKAQN2+wknEYfg68NhuWG/V6NsupblESv0AAmkfEhBoA92khqz9kQ+hOwXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550355; c=relaxed/simple;
	bh=+JN8ouV+clhA1CXQK7QDQff/PHPSkXBvFPaY9XfXbOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEh+lcSMlwCXKAQzUMwCvPRdVXTwRqvBp5ZJWt9CdVl5sv0ysPHEx4hvs1hWBlCMQCgpu9zuhal80k2OOxm+VzMs7MNgAD2lpOJ/qcqo+BmC4KsougGueBzKfrCmWYo+w/qjsbh8nnOYMwSVD6LbyTbiEmo9oyP82OHkO8fZDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=OtDE5YZc; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=IsYwwoEP; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="OtDE5YZc";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="IsYwwoEP"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1786550138; bh=ZqWCQkJBeMKWGcx8/d0Uw/M
	E16Dl/JqvTiPHieEBqtk=; b=OtDE5YZcDUT+3Cb0zABd/RYJ9ni0I4uEOj3dw6VoEpZDjowE60
	4DHKN1jYExfZyVrGqOkYG97syeK53xdW7q7qYhtOYlqA77IOwMRXssbkh2RcG27nxW7Gt0FtuXK
	3DxpVB8snDNXYaS+PsQG64FbK7yrvdkFwENdNQjV+mdlvz9cQBkc+OU8LH/1kBEWsRn152Bmj7C
	o/RdX/d9X9awALXD6lI5TAdNiZw8uALs9QKforKCoKMs8D7DCbhkBBqm4zEPyrOnYyveM9QjIbB
	M/fPOSLDYefANCwXzv3US8b4FBEC31eGKCON+PCyvughkf988HChmyhBjsFcjF6FzhQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1786550138; bh=ZqWCQkJBeMKWGcx8/d0Uw/M
	E16Dl/JqvTiPHieEBqtk=; b=IsYwwoEPTiu67crFDiHrq4dlpZ6TPqJcQ2ExbZvAqbbNi2NPoT
	bqWPMY2IoA2ehWltyk6dic47P6x/LrfiR+Bw==;
Date: Wed, 12 Aug 2026 11:55:37 -0400
From: Daniel Hodges <daniel@danielhodges.dev>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Daniel Hodges <git@danielhodges.dev>, 
	linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] evm: check return values of crypto_shash functions
Message-ID: <srgnajphzr43h42zn5j7yjjoqm6lvxboc2sy5wwd5ixybhj6zu@moftt2zpqn4c>
References: <20260804200734.2415524-1-zohar@linux.ibm.com>
 <897aa15c24fd14a30392890ffeb5aac96409f31a.camel@huaweicloud.com>
 <469ed5e1-55dd-4aab-b374-2ac00e3ce9ab@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469ed5e1-55dd-4aab-b374-2ac00e3ce9ab@huaweicloud.com>

On Tue, Aug 11, 2026 at 09:40:36AM +0800, Roberto Sassu wrote:
> On 8/7/2026 7:42 PM, Roberto Sassu wrote:
> > On Tue, 2026-08-04 at 16:07 -0400, Mimi Zohar wrote:
> > > From: Daniel Hodges <git@danielhodges.dev>
> > > 
> > > The crypto_shash_update() and crypto_shash_final() functions can fail
> > > and return error codes, but their return values were not being checked
> > > in several places in security/integrity/evm/evm_crypto.c:
> > > 
> > > - hmac_add_misc() ignored returns from crypto_shash_update() and
> > >    crypto_shash_final()
> > > - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
> > > - evm_init_hmac() ignored returns from crypto_shash_update()
> > > 
> > > If these hash operations fail silently, the resulting HMAC could be
> > > invalid or incomplete, which could weaken the integrity verification
> > > security that EVM provides.
> > > 
> > > This patch converts hmac_add_misc() from void to int return type and
> > > adds proper error checking and propagation for all crypto_shash_*
> > > function calls. All callers are updated to handle the new return values.
> > > Additionally, error messages are logged when cryptographic operations
> > > fail to provide visibility into the failure rather than silently
> > > returning error codes.
> > > 
> > > Fixes: 66dbc325afce ("evm: re-release")
> > > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > > Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Looks good to me. I confirm the Reviewed-by.
> 
> We got a report from Sashiko. As it pointed out, we should not override the
> error when calling hmac_add_misc() if no xattr is present
> (-ENODATA).
> 
> Roberto

Looks good to me, thanks for fix!

Reviewed-by: Daniel Hodges <git@danielhodges.dev>
