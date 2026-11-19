Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101619;
	b=RTEdCHjEUk1nFzd+oNLPtx2g94/ILnO9xzvh6EBqVaUxo5uDrw/iVaN8ILh3XAnbMVAD
	 SUWrHg7Netj/+POxDXKUbLkM8LzRrChoTjt1k6LwzIsAmJkqSOJenl2Pa7vbYAxzcmH90
	 MM+VLoCw2iuazBWCf6o5X61fK7gKt/jQby/pSu/AoXeY+OiUVzM3NE9HeCjaEOrY0iYsr
	 AmOzRqT7y58Un85Xkvctq+qF07j4B+XHV+ZwCopt+DCngpaEZYTAbLX5HdwiXuDPbtZvB
	 b9YarLDgjEqoxTT+ZAfv0OpQ3eDAMw1NXYHs1/qFz1ANcVxku/Jy/Js4fD1Dur5MGPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101619;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=abJ833XNl5Tm7eTC3UbhmlX0wfMyPK48RvyobAGfFA0=;
	b=QUuX5dFpG4EC35B1pfE7/55Eqon1c65D687Trb29dRdr5BeXjjqj+HwtupLD6HMQIrci
	 H0kIlwYdGZfQ0f1zrJveRlmZElEsvMKqvf6lVH5xpzsP8dqLP+IsuAmRw6/3rJqa7/+Cw
	 wSmB6SWa1EsexMozBhWFOzvx5DuVelWfxaxcShmDmWNmAZxgRnmtoCYQW8MKybJ+PkbG2
	 nkUuvi7tr2ppp2LCKybPkoWaXTe3T1c76yVJvye+/AYpGN4q05sxVUK3NcZmPNQzALNnq
	 qcMPIGXl4crh5LmatLwrWx0RN1OJxK5dMHR+wYaMXD0Iwv0BlGjaKgGly5IYIkQCZbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GLFkaO/q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 764F1606A324;
	Thu, 19 Nov 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLFkaO/q
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 820291F000C4;
	Thu, 19 Nov 2026 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795101619;
	bh=abJ833XNl5Tm7eTC3UbhmlX0wfMyPK48RvyobAGfFA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GLFkaO/qNHENindxN6Px7vrTI8+fFJuptpAumsnSZgz5Q1gtuZqbozN28Hhu15NOp
	 wpO5Q3mYrgFBmtzMhFUJUSjx0YdBwmQVyT2yKKiPni2M2kBfeqhL3Uz93qAkrskM7K
	 v+3JjyvQ//2hT9An9+AFuxJuKUsb4/+tAGL4/liv1zsZ2jAQfrRoUo958ghaNv/4VB
	 OouzqD0e16KqxcmadySNQz/WEwW3uKCvhp7N7ym8R8OuMeMjHzwJwBq/4O+w+N/kVJ
	 WUTlXuNmuscOggAZLWCZJ5KwzO6P2tUKli4kE93mdFhRxlVJl6k5uc3Xby/Xfrsc61
	 z90wz32u0fspA==
Date: Thu, 19 Nov 2026 17:20:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: shyckless@gmail.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, jgross@suse.com,
	sstabellini@kernel.org, linux-integrity@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH] tpm: xen-tpmfront: fix use-after-free in
 backend_changed()
Message-ID: <av8Tr2jTQaOBOEid@kernel.org>
References: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>
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
In-Reply-To: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>

On Thu, Nov 19, 2026 at 11:20:33AM +0000, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> When the backend moves to Closing or Closed, backend_changed()
> unregisters the device and then keeps using it:
> 
> 	device_unregister(&dev->dev);
> 	xenbus_frontend_closed(dev);
> 
> The xenbus watch callback that calls backend_changed() does not hold a
> reference to the device. The tpm_chip registered by xen-tpmfront has dev
> as its parent and holds a reference to it, but tpmfront_remove() drops
> that reference when it unregisters the chip. So device_unregister() can
> release the last reference and free the xenbus_device, and
> xenbus_frontend_closed(dev) then accesses freed memory.
> 
> Take a temporary reference before unregistering and drop it after
> xenbus_frontend_closed(). This keeps dev alive for the last access and
> keeps the existing order, in which TPM operations are stopped before
> the frontend is marked Closed.
> 
> Found with a static analysis tool and checked by hand.
> 
> Fixes: e2683957fb26 ("drivers/tpm: add xen tpmfront interface")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> ---
> Compile tested on x86_64 (W=1, no new warnings). Not run with a Xen vTPM
> backend.
> ---
>  drivers/char/tpm/xen-tpmfront.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index 3c0cce57c4ae..1be925cca535 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -397,8 +397,11 @@ static void backend_changed(struct xenbus_device *dev,
>  
>  	case XenbusStateClosing:
>  	case XenbusStateClosed:
> +		/* device_unregister() can drop the last reference to dev */
> +		get_device(&dev->dev);
>  		device_unregister(&dev->dev);
>  		xenbus_frontend_closed(dev);
> +		put_device(&dev->dev);

Not a NAK but makes me wonder why this has not hit the wall ever.

I.e. "feeling confused".

>  		break;
>  	default:
>  		break;
> 
> 
> 
> 

Br, Jarkko
