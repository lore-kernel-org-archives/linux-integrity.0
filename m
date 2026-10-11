Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FE2E7185;
	Sun, 11 Oct 2026 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742563; cv=none; b=c3k8oVm8i2MiVibNZZngcJSFrUgz/9Cmn7yfgFUAc7haBnwvoej0QyzLYL/bstp2grOB6i2OIRUSye/oM0GGOvYEoIHye90KYsx/UFMonWNFco8t1D9FcoRCSe6sO+ZB2ovxVvx7psq/U+0DIJzzUURklX5boC28VrWb6ENDP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742563; c=relaxed/simple;
	bh=JNQPz0An7gY4u/uWmT33dW6bJsZ9FjHuHTe4otE5eQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTyAQ9sDUki3Vt6cr/6U8I4rg7emdocqOCtXlj1BjpnLowfCRGgiKlgZ+N1RKNAEP/4ZKx3JJa/5JdUA4n/Lc6mtd04lMvRAnaHKvacxkIcdOYp/i+KXJWpRCEYVvC+bc6tKp+M4Su4dbVYtrOTYD0GrJNcgcTUpF++xA1w28Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/DG3FRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/DG3FRT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9FB361F0089B;
	Sun, 11 Oct 2026 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742562;
	bh=KyNI9zYP9RZu+/Mg+SREr8t6XcjtR27Kpffa8V9RMns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C/DG3FRTVFRKp55gNDscDCPOVqo5NMpTZhhNOIR6r73Zr+HNjXR/W+rWBzwru9Pz/
	 pxdYDMtjPalYvjEQ83EAOTFJ5E+GOs4l4lUZhrOrDrY9KcZvyAXZml8n7r/R8eC1AH
	 pxLk9vLOlewdwkYcQ/6pTh/wOnWv3EW/xZky40kC/C5Rt4Qf+E7A2CO9/YLuNAA+Xg
	 sin+fERmzkq6qqNlXwyzo5vBr6RAwK03a+nPSHBjLDq0W24s21ArpQsobIU8pU//yE
	 gwslu584vw1XOEXBkukEQK9QEm5uA2vUasFLjGjcMvUMfb6AtwFmWXmwmFtZtNcKY7
	 kaVU7TdlThSGw==
Date: Sun, 11 Oct 2026 21:15:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dan Carpenter <error27@gmail.com>, kernel-janitors@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Peter =?iso-8859-1?Q?H=FCwe?= <peterhuewe@gmx.de>,
	LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm: clean up error checking in setup_ring()
Message-ID: <asvSXjQQ0vEvF7yL@kernel.org>
References: <ar_DUjuGv-9vPzga@stanley.mountain>
 <74850205-dba2-4a97-951d-cda28be129c9@web.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74850205-dba2-4a97-951d-cda28be129c9@web.de>

On Sun, Oct 11, 2026 at 11:30:13AM +0200, Markus Elfring wrote:
> > The bind_evtchn_to_irqhandler() function can never return 0.
> …
> 
> I suggest to reconsider information once more also according to the probability
> of return values from such a function.
> https://elixir.bootlin.com/linux/v7.3-rc6/source/drivers/xen/events/events_base.c#L1453-L1461
> 
> bind_evtchn_to_irqhandler_chip()
> https://elixir.bootlin.com/linux/v7.3-rc6/source/drivers/xen/events/events_base.c#L1432-L1451


I'm not sure what you are trying to exactly or have hard time following
this response but if there is a problem it can be investigated. All I'm
seeing now is a collection of links and abstract statements.

I guess this is the function that picks the IRQ number:

static struct irq_info *xen_allocate_irq_dynamic(void)
{
	int irq = irq_alloc_desc_from(0, -1);
	struct irq_info *info = NULL;

	if (irq >= 0) {
		info = xen_irq_init(irq);
		if (!info)
			xen_irq_free_desc(irq);
	}

	return info;
}

And if I did not get loss while scavenging the call hierachy it ends
up to:

static int irq_find_free_area(unsigned int from, unsigned int cnt)
{
	MA_STATE(mas, &sparse_irqs, 0, 0);

	if (mas_empty_area(&mas, from, MAX_SPARSE_IRQS, cnt))
		return -ENOSPC;
	return mas.index;
}

And if I looked it up right @from == -1 and @cnt == 1 when
irq_find_free_area is reached.

I'm not IRQ code expert per se but in order to this never return zero,
sparse_irqs should not have it available?

I do agree that something in this patch does not appear right, or 
at least not very well explained so it is a good catch anyhow.

My decision on this is that:

1. I'll drop the current patch as it actually does not make a case
   why zero could not possibly happen. I spent 45 minutes browsing
   because commit message did not have any technical details.
2. Even if it was legit it is hard to see that the change is high
   priority for anyone.
3. However, I'm open for v2 with better tecnical backing if there
   is any.

Br, Jarkko
