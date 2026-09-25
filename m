Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA915479870;
	Fri, 25 Sep 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327072; cv=none; b=jtObOaAxXINi/2HKbagHsflXqiMGEmElWOUn6VFZ7BGppJkInVkd53jdw9rQ0Ch2jijQ3ktHXhLl+BNn/92mbgJ3Ne0DLr8M4PBeNqw0TK5nwEBlBDil2uRNOyJx6lGn0yNbtse8IyfJc1aps4Bn5spa9JLhBjFDy/bnGUkzLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327072; c=relaxed/simple;
	bh=/ziPnqu1H4E0CuBH4wml/LZRn7O1jowDghjO3sZzJQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpGKie1gBPl17glpeGnp7Bks5hI8B7KDh5JlbXnZcKQjcRefB3/H1xlCvUjOMTa/05QnxZMD9LrFRnMH0AU9Vhi85/ip08kJ4lvmp/HZwcN0oV2Nb/TFmP8V9TFNugQUe2ZE6vUECcuUzMpAnaYyOOwUnTFlTqxMVLo/6thnMro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=K3vS/br4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="K3vS/br4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MvTRbaXru2O74ZwFiMWvfQTvdbBiOWYcp54wMU1JIlA=; b=K3vS/br4fDSRbWWrqh/f02O09P
	RuONxZp64kmPLPTmsFlfdPeX8TZhqD5FZYpyFSC0SIxt6jDg20AxinjDe3l4DR/52JConAy/+6tl2
	YdsuIKOSG7p2OMjqL/KFcczRR21RiXQzcdK+HabIZ9OuvewZ4FC9/3/2Y8KVuWtipL33x/Ozs32jN
	B7QFyWD3Pn908WrTdlI6LWlVkM1t67Z+xq8kCNmM7x4DvV61aDf5XVav4aK8pExp/3bzrPIo8VXun
	qMBKvry/E17fZN9mxbQSEs0TpiCTbQhGeyFx4FSpOkf3SCzKEpBFzrV9fQgUfz4lP6OyL6//f6Z+/
	+gvUgItQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA1qy-005BzG-2i;
	Fri, 25 Sep 2026 09:04:25 +0000
Date: Fri, 25 Sep 2026 02:04:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com, Alexander Graf <graf@amazon.de>, 
	Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson <joshlev@amazon.com>
Subject: Re: [PATCH 1/2] tpm: Add per-chip timeout for transient
 unavailability
Message-ID: <arY2qHhjv97W7WvK@gmail.com>
References: <20260923142834.16786-1-surenkj@amazon.com>
 <20260923142834.16786-2-surenkj@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923142834.16786-2-surenkj@amazon.com>
X-Debian-User: leitao

On Wed, Sep 23, 2026 at 02:28:33PM +0000, Surendran Kanagaraj wrote:
> Devices that have different timeout requirements than the TPM2 spec

Can you help us understand why this device doesn't follow the spec,
and why the quirk belongs in the kernel rather than being fixed in
the TPM2 itself?

Is NitroTPM a virtual TPM? If so, could the virtualization software
be fixed instead to follow the spec?

> @@ -241,6 +243,9 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  	 */
>  	memcpy(save, buf, save_size);
>
> +	if (chip->busy_timeout_ms > max_delay_msec)
> +		max_delay_msec = chip->busy_timeout_ms;

nit: this could use max() instead:
	max_delay_msec = max(chip->busy_timeout_ms, max_delay_msec).

Also, should there be an upper bound?

> +	if (duration < chip->busy_timeout_ms)
> +		duration = chip->busy_timeout_ms;
>
> -	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
> +	return msecs_to_jiffies(duration);


What about something like this instead?

      return msecs_to_jiffies(max_t(unsigned long, duration,
                                    chip->busy_timeout_ms));

Thanks,
--breno
