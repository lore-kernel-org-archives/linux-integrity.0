Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516055;
	b=0wa+06BWrWzkuVUu7R7G1oci6g8x8MyA2Bu4LgFYXDPRPv2NWeP0nPaZiSZ1LWBVQ8CN
	 66iXv3sKVcXgB9GGb4yx3ddF2Aehb8qkdlPIHIA+cVaKJmvLSup6d71gjH0uCpjePwkLz
	 QP15N+fGWF6VskLXYT5giwWIClG/0plBtYKXUMfjjrUQeleMvvwpbncywID5aX1VJcJ6B
	 WPzhDY6JGyKNNU4IjpMkUnGDhNnHy/SlvivgT29EK+4SktuxC8KY7eYEmlP069I+Irkne
	 a95DEWz576FjjUZ/+p/VX6xZ/0kX1jqyrnfTjkvMT2QMALO7UkrfgBVog7+tHqQQjXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516055;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=HoUj100xVXp9w0NlB0KHpj4mLYgFrevwp4PKDUO8Ljw=;
	b=qe66Ql/CyTG1+6JHPZ/LYCmEdILnmPnORx+G0DtOj6QERKTkh3THHLceD1dr9CBxiGOq
	 Y2OPiz6+6is12Z/u2zsTHd4pYLzaZ9BqLarrx4stSQ582hBy7m1+mhZijNuFDND5miiwV
	 UimdHTU+nHDPi3o/FkFKeFIHLIMcD/zqGHXgSSS4tAuiCbB1+A4EmFRMVn0wwi9H67tgR
	 S/dfe/gbwNv1uC45m7vn13anJAcZgangH3k9Of/pYB6Ue91Fw3WBrfQow5aw/GYFmXXUE
	 E+FRawx0JVGvZCWVoqV7hDKI41sL+PQ09XWMbk16q8iIH+XrGibBaWKyjxHW/cG997A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GZvVDKfy;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C459606A31C;
	Thu, 12 Nov 2026 20:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C459606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GZvVDKfy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HoUj100xVXp9w0NlB0KHpj4mLYgFrevwp4PKDUO8Ljw=; b=GZvVDKfyq/0ANVxSJqdFOzba60
	3FhMuG8fW/DvxmH7LJFdbwEqEOOer41UJLBxXxWFAY7X/704kC7yXE0sSRDoYo6yLp9dh1Z63KYVv
	z4nP6Bxo8qJBCJai4Nt6PICYEAhx6ZAPjSqLRm8S9yZ00XY1BaALwc5K6xxqK9tbStrhB5UznLLtD
	HOSC2nPIndcGM+4su4SxIF1wKl97THMdyTblYpyUpYyjiSZ6i1nzy0iZUkfbiZEGAgPHuctHklada
	hbEI7GhcVzmD5Dh63HsWWdpBJUU/J8EsjLTTC+AWNX4PW/efKvj0uOt0mRMx8sSsDDZgFOzunnIK1
	LlpHhKlg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRbbG-00EEio-2D;
	Thu, 12 Nov 2026 20:40:50 +0000
Date: Thu, 12 Nov 2026 12:40:45 -0800
From: Breno Leitao <leitao@debian.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, surenkj@amazon.com, 
	noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avYkGKXOP2-hhewz@gmail.com>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
 <20261112-tpm_unresponsive-v2-1-7454d2c899ef@debian.org>
 <avXGjiejK2ZlldKs@kernel.org>
 <avXHGmmdY-CVgxEf@kernel.org>
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
In-Reply-To: <avXHGmmdY-CVgxEf@kernel.org>
X-Debian-User: leitao

On Thu, Nov 12, 2026 at 04:03:06PM +0200, Jarkko Sakkinen wrote:
> > 
> > This would be then nr_lost_responses.
> 
> Oops sorry.
> 
> I mean nr_missed_responses (and I would prefer "missed" over "lost").

Would you hate if I go with max_missed_responses?
