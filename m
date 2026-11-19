Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105831;
	b=WE1Ts3tivu2G4zRLoKAz7EuX1H+scMisl65Q0c36fWPcqO3Av5oSO9HmWLrxz1uFhoGg
	 u51UYWhSkEs8QZHM0sPL7Sj1V8El1OexsWqxuT1FZezFOENH0Yjd/LjRpGh8jU5hXssHI
	 HsOUnPUcQgrCmRwmEwPhA73SyOo/pml+K5syxpof9sWcY/1vh1rf4xH/kZYHmp6yPiksU
	 KqZCzOlptjRhUtVDlMCMCVkx7W1GRsMhtY0YOSectaYX19afJeVNF+R88jVpT5bmvfnb5
	 y4Mtbbap3xsgDVKISlFxpElpW0wEIzV//sa+L8PdpBI05X43PH4dSz6fZeD6gHsVXpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105831;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Z5ALnx+mCjWDmQkyVJCJZJkL4hw8lOcz/TYf9JnJauM=;
	b=BdZvy0qX7L7OPuZ+87fxPyoP//63lkxM9CbM8NI2BIEVMZ11DtEOsDbipIYO6ucF4T5W
	 wBIzdhBr62Np6JLdbZLjVZboSWxjZSPNSpJIuDzOwahmTcO2laVFmw5CSBrIS3ii3AjpM
	 QhrcVu5NCSfD4DrQ2hS5p60UbXoScKW4paQjWX1eETSXjNxeM1FzQ0eTFjEoXMJvJMFDA
	 h8R6iyTXf12SaJT2ZqnnSlANw78RBhnMY8rvhFmSKPQGH8/vI6Oc1TJIvAAOQqK/kUFSM
	 GeetYF1B6ME9xnlenAbtWsDjh6F3LEcojLcAbNR7FxUkQpcw5TYenZOsEv11TEzcttg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XPKsI/Zm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 15B39606A320;
	Thu, 19 Nov 2026 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPKsI/Zm
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 215A91F000C8;
	Thu, 19 Nov 2026 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795105830;
	bh=Z5ALnx+mCjWDmQkyVJCJZJkL4hw8lOcz/TYf9JnJauM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XPKsI/ZmHUUyElXZoORb7e711VheBLAms6JGdYgH0xQbJtpCXz72XHt/OwVfFv51s
	 K5Df6N53Bc3GAp+6PWEyOzQaLTUew9uQkJl+sMvv7SxSvrBVeCGG/4yvC9b+D5UvR0
	 kfSjyQMEMV2BopIRmGVuG5ruZ/xNishFkEYvl1be9Ws2e7YIFnA2Y9Wd7C2w81AR/a
	 9j96X3ROGzgJyP468ZaOmmoWtcFsBuG/E8TWsCc0ffmNOZlnTXYCbLBzy0MFs3+hzn
	 pk580VZC0zllB4V5clC8ITtdk8gHeNW3GBiWq6/bXiJzVVV2jb8DWg18ThyK+AtRuQ
	 j6QzcthVcfkvw==
Date: Thu, 19 Nov 2026 18:30:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: shyckless@gmail.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	sstabellini@kernel.org, linux-integrity@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH] tpm: xen-tpmfront: fix use-after-free in
 backend_changed()
Message-ID: <av8kIqYC04D5QdXf@kernel.org>
References: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>
 <av8Tr2jTQaOBOEid@kernel.org>
 <8c988944-34e3-4fc9-a323-daca101c1bab@suse.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c988944-34e3-4fc9-a323-daca101c1bab@suse.com>

On Thu, Nov 19, 2026 at 04:35:02PM +0100, Jürgen Groß wrote:
> On 19.11.26 16:20, Jarkko Sakkinen wrote:
> > On Thu, Nov 19, 2026 at 11:20:33AM +0000, Suyuan Wang via B4 Relay wrote:
> > > From: Suyuan Wang <stevewong@hust.edu.cn>
> > > 
> > > When the backend moves to Closing or Closed, backend_changed()
> > > unregisters the device and then keeps using it:
> > > 
> > > 	device_unregister(&dev->dev);
> > > 	xenbus_frontend_closed(dev);
> > > 
> > > The xenbus watch callback that calls backend_changed() does not hold a
> > > reference to the device. The tpm_chip registered by xen-tpmfront has dev
> > > as its parent and holds a reference to it, but tpmfront_remove() drops
> > > that reference when it unregisters the chip. So device_unregister() can
> > > release the last reference and free the xenbus_device, and
> > > xenbus_frontend_closed(dev) then accesses freed memory.
> > > 
> > > Take a temporary reference before unregistering and drop it after
> > > xenbus_frontend_closed(). This keeps dev alive for the last access and
> > > keeps the existing order, in which TPM operations are stopped before
> > > the frontend is marked Closed.
> > > 
> > > Found with a static analysis tool and checked by hand.
> > > 
> > > Fixes: e2683957fb26 ("drivers/tpm: add xen tpmfront interface")
> > > Cc: stable@vger.kernel.org
> > > Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> > > Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> > > Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> > > ---
> > > Compile tested on x86_64 (W=1, no new warnings). Not run with a Xen vTPM
> > > backend.
> > > ---
> > >   drivers/char/tpm/xen-tpmfront.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> > > index 3c0cce57c4ae..1be925cca535 100644
> > > --- a/drivers/char/tpm/xen-tpmfront.c
> > > +++ b/drivers/char/tpm/xen-tpmfront.c
> > > @@ -397,8 +397,11 @@ static void backend_changed(struct xenbus_device *dev,
> > >   	case XenbusStateClosing:
> > >   	case XenbusStateClosed:
> > > +		/* device_unregister() can drop the last reference to dev */
> > > +		get_device(&dev->dev);
> > >   		device_unregister(&dev->dev);
> > >   		xenbus_frontend_closed(dev);
> > > +		put_device(&dev->dev);
> > 
> > Not a NAK but makes me wonder why this has not hit the wall ever.
> > 
> > I.e. "feeling confused".
> Is there any vtpm backend other than the stubdom based one?
> 
> If not, then it is quite easy: this backend never switches state to
> XenbusStateClosing or XenbusStateClosed.
> 
> 
> Juergen

Should it be removed use the default-fallback?

Br, Jarkko
