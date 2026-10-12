Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F6415B7A
	for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2026 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800608; cv=none; b=DmZ6IJxlSjGyWtfI10mPD/gFh3cvl+cJKC3tmzf0kLyDoO1tu98YU6PjDkiG9cnzWyLWsLJ+rZW85zAeC7lQe+qvX4mBvKkWuh1VqiMytTfpv6TYnpx2k9XQRHcC2eesUYte4ten+5CfAS32mYknBVMb4z3fWPKlni+ne2jLXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800608; c=relaxed/simple;
	bh=IDdwL67v4rO6QNqOopp6U+IZA+rvoQANyZigLVP0fvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1O+5JboSPryyZ76eVvH1mn6CWtwZ0iX3pwPrwGEuopRco2X7PmR1YQDdW/+0mnOF3KuGZZ89ISFdBAuy7lffX8b74OTbcO87rFBUhfcS/yzK0gZvFep5qmbsxlT+uv7HZndE9DriW//Lwqq+G9EGv/fz+1hQIq+dpH6YpmvCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbabI0s6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j+fOKiZn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbabI0s6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j+fOKiZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791800595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/WMJvh9lEGijqsZWjeO3+cIRaZLpMo9guCvUBFf/dck=;
	b=EbabI0s6L7sEQpdIthr1fI4eHYOBDKXi3TG486UyOZiq5i7oRBHCR9QrrI/AwaUkE0i30B
	Kx/MCCK6g+iUtC9cP1cMBY5Hj6fojqJQWqZQ+0QmyvsO+aH6IVPSsRzyPlpSLpS9hw3eMt
	PC3M/1YDynn5/aJ1N7pxtTjwmMvkIqY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-NAu0WXTlO0eNQrlWFTZ0jQ-1; Mon, 12 Oct 2026 10:23:13 +0000
X-MC-Unique: NAu0WXTlO0eNQrlWFTZ0jQ-1
X-Mimecast-MFC-AGG-ID: NAu0WXTlO0eNQrlWFTZ0jQ_1791800592
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so11275605e9.3
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2026 03:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791800592; x=1792405392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/WMJvh9lEGijqsZWjeO3+cIRaZLpMo9guCvUBFf/dck=;
        b=j+fOKiZnWEKD88knmSCo9aTIJR57UE664UchP/D85fFhRnEDFo8sXuoAv+KKywjeFB
         qeaaSqevLw4dy/sC/NCnyT781EiYsDmgv5KXKd0KzetVt9XbBGKnTqNDrU+jObMzaqv+
         4EJXQ7x/7riB8vA7i4+x7iL7H1iDWixzAeDwBHbzcGXJfXO3CJUglTte7i4gmi41MMRL
         hhojaTOOtuJOEN1QPfGeEG90P/jWYl3lt9LORR+5oOSWKzuT+5lkv/ZPYxeIYesVA8aR
         SHUvdSoC3cbDC/xSAWqnlQbzPU1S/X26wWdQ+8BwhGfO3sIgLyUcjqv0joO0N/Fg/a8V
         qPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791800592; x=1792405392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WMJvh9lEGijqsZWjeO3+cIRaZLpMo9guCvUBFf/dck=;
        b=Ja3rqwZMdxYxLcNnGKVYwxu9yEfPi7wGjR6L3LZHGIA+CAsZDPZz/Hb0iN4cgYfXJp
         MdXkheE0ggr5P2rFsTaL+ATKJUAKFmeekRxBpKAEOpf/rl45odXKu+8bIcxLAf3/dGOz
         JAtA5TezkN+j8niT8NrJpMZvrgbbxYat+1wPlyawEnwsrFOqXabUMxuI9GG9cDKN7m/9
         IJ1gEBkvHzlatuf3dISSPmXOoB2bu+cIyBcOS8RMXaGhxM+s4oXJnzXolDHzdnJ847RT
         l2RTdJ9vB2yexGeCrXSq5fRLlvYzayYbYmNZRrnl+NoRLra4AdTKbE+lsnXqyfswRiKF
         kn1w==
X-Gm-Message-State: AFq9FYIM1uli5yDfN5XvD3O9JpyvDFL/Xtz78ax5ILQdKml5pXFJVmMO
	Icn9FyNFhiT5HHELf4IpAQ92qNUsDHwWgU6CbT3XrD4Bt/R3VlXMN3RFlgzmQmYWVCjP6mjgc6n
	r7swtVXy1atlZLXCiYcG8/4JZ5ICyX000NmcJgmVh6mFACOjCl8EpvPa1oKCYTipMki+NRg==
X-Gm-Gg: AYBFou0dMNmqq9Xd0hxmB591F1HNK7XhdOA8jBmtVXhqzPI0FSVoJzc5Q7uzWHKGEu3
	WyWL9sVmyf0Swf+SOQHvBXbFr8yV/jAPdpMC6wINv3cFcY7zQC47KZs5zC4lXZkoY7iDwDePei1
	A9nqKw8BvhUiIMrmsODewatoeYbp3m4VWQ91FUy9n6pbSmgNIYoqlXZj6Jve4GDiYqBMUXULdCZ
	WFkB3zzLV8L+aL+Wp64B2YY8YEk1aWxYyzvqlqzCtnRiTmAH2QqlIY553BRnK1BQeckh1HAkaa+
	w74YKX9xGp2q2beRf/Ca6KDh/0+Cbu6buquhH/4WVyVv0Bxx4c7Gf32A/fGwk77tTJx+j0EH5ct
	wsg==
X-Received: by 2002:a05:600c:c167:b0:4a1:a3cc:3c5c with SMTP id 5b1f17b1804b1-4a1a3cc3c71mr12614585e9.16.1791800592178;
        Mon, 12 Oct 2026 03:23:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c167:b0:4a1:a3cc:3c5c with SMTP id 5b1f17b1804b1-4a1a3cc3c71mr12613895e9.16.1791800591497;
        Mon, 12 Oct 2026 03:23:11 -0700 (PDT)
Received: from sgarzare-redhat ([94.32.38.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19c8244edsm109697305e9.2.2026.10.12.03.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:23:10 -0700 (PDT)
Date: Mon, 12 Oct 2026 12:23:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Stuart Yoder <stuart.yoder@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chu Guangqing <chuguangqing@inspur.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_crb: Remove dead code from crb_map_res()
Message-ID: <asy0K_6VkuAn9rTB@sgarzare-redhat>
References: <20261010235500.2915629-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010235500.2915629-1-jarkko@kernel.org>

On Sun, Oct 11, 2026 at 02:54:57AM +0300, Jarkko Sakkinen wrote:
> In all the pre-existing call sites both @iomem and @iobase_ptr are either

Do you mean @iores ?

> both NULL or have a valid address.
> 
> Add an invariant for the expeced conditions and remove a dead basic block.
> The second block is dead given that if @iomem turns out not to be NULL,
> neither can't be @iobase_ptr.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Updated the commit message in order to clarify things better.
> - Updated the invariant in order to address checkpatch.pl --strict
>   errors.
>  drivers/char/tpm/tpm_crb.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index ceb4100ba400..833226966fa2 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -570,15 +570,12 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
>  	if (start != new_res.start)
>  		return IOMEM_ERR_PTR(-EINVAL);
> 
> +	if (!iores != !iobase_ptr)
> +		return IOMEM_ERR_PTR(-EINVAL);
> +
>  	if (!iores)
>  		return devm_ioremap_resource(dev, &new_res);
> 
> -	if (!*iobase_ptr) {

Sorry to insist, but in the commit description we talk about @iobase_ptr 
can't be null, and I agree, but here we were checking the value of the 
pointer, so IMO this code was not dead.

But again, I know nothing on this code. So, if you think it's correct go 
head, I'm surely missing something.

Thanks,
Stefano

> -		*iobase_ptr = devm_ioremap_resource(dev, iores);
> -		if (IS_ERR(*iobase_ptr))
> -			return *iobase_ptr;
> -	}
> -
>  	return *iobase_ptr + (new_res.start - iores->start);
>  }
> 
> --
> 2.47.3
> 

