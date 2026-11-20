Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167116;
	b=1drYatmpxF8uPhO73ZJ7xkMsKhlCWhczYVZq9KRX4lik2SdAclRFPseEOOAgXoyQP4Ks
	 GhF+OnWKHrT6IvUj8GiUH8ka8P1aK4CECPix4qbXnudZvNd0MCro14OBr0OtvadSu075+
	 Ue3ul1CRXJ3DVm6JMUDm7YSWqVHrVADv/NgL/8umynQarAiCvbLcmRw3t4tWiDR9EAKky
	 u/IrbQ5L64J1tbL+sk7fvu5R2X+S2iexViEEVmFZohFaJw4jY0xpx7Axfy917ZZK4UoN8
	 aCDUGwfie8rG+h44N8DcdhE/a/S9U8+t1bdsaK2q5h68bWZ+nPe+4xbMIx1Gxz5DPkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Zn4lAoghu5jQhcYe+1nVRr6HSJgIEjuvXu7xfOq1cUI=;
	b=vVLtcuCRkAHhxerun/XhKo8OUc58mmqFUD9YMw1I0lrGKuX4fLX/NIuAwtss5UaOrAWk
	 cVfxBSLb4lQMN0w6GTRalqXj8SXxr7+cU0n3wvwIUjlGZo6Z7fN3LjdFhCb/cq3HZp3nB
	 f+QgFcFLb78MvTvCjFzCCksWuvnbO5KH+Z8ofIfv2HUNRLkzFMrQR351108GbyzXo23m8
	 iW5FTJVmWUbCgrJbsJS77GaYEPkvhHv+/QG8haYPeoKde7FqSIDzVzOqISVw9BWrpD6Mk
	 NbPrsrxzCX4wcVvVVkTweBMvgNXQwjw1jdZUTjZV7ICD/Fmr8R2Bi4xad+wknDiiQ1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zow7pfvy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D46606A325
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 09:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9D46606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zow7pfvy
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so560501f8f.1
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 01:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795167114; cv=none;
        d=google.com; s=arc-20260327;
        b=ZLezp5guTAIiqeM3jqgYXZwlZg+r1pg1516x6EClSUMhh/neDRm5i0Nz7QrZtWQRJB
         u/DzgK8QWUoV2BZ96RgTCoJUr7CT9VSPkFzorCWKpJvMiwIhqF9oG4dyRUbFQbxb9TAx
         lxM6ALyd/CphFd4cuh/hA1PP+KJzMyphQOGT8j4C//AzU8nwzKCCUt2ikn4UGxPVajur
         kGVVUKRrKyID0ROIc+wg8A66eiEb1KeNvuNa6wyRB2qh3iNNKiNDsIlW9i6393lMzz+w
         s/FvA5davDshzk3lLgVrXgI8pi4GTGWrDNCymhj+9c1mJGjkMJQhUgFE6uuw9yw4j3hf
         1r8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zn4lAoghu5jQhcYe+1nVRr6HSJgIEjuvXu7xfOq1cUI=;
        fh=f+UA4U+IZPpk17vcE3CeSHGSfRWhawIFETqOD40XBU8=;
        b=IHoH5Jp8+GZBqbgtygQOrdhWICK5UGj1st/LrBrsRHJwI1v2hNlaTkwiRxKVp0Z674
         lyLD2/NtLcVkYFqz4C7GNOGEL+I8ng5DqZbGUNKM402DP6/sYKojHrc25ZqDBF0JGWuC
         NnodeApfpCqqbGgdd29C7Lv0rW+Sy/RuJ2MxSSH1VFSDduuNseGPq6QLah/pN5ZRaokA
         xGDz1MmWD2NJXtDfA9+rQZ2waQcrgn6bn0qT+LUXymjLjw5xKL9cV2T7kxH3hf28nLYA
         xkouD4s+Dk+1gwFnVGYBZmMlHA+EcfLmLnHsm1j/u4RE60QpYQRM+dLGPQSTjnXteN8k
         YP1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795167114; x=1795771914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zn4lAoghu5jQhcYe+1nVRr6HSJgIEjuvXu7xfOq1cUI=;
        b=Zow7pfvyM3IOra8rNj/NxUPatXWX8aoqZA1fBUrTcWZx7ri0NFe1p2Sz7jPB8rzpPy
         0ek6V+i67Oz5sPzhLnjb9lMZg3erdZZsgjAWk82tpe0PlFg/gfCU7kHH//aMFhVv6/Zy
         5NBuvU4AEB7S8j1QkpcLuRadAskdCwDzfGfPl1gBQ60v5i/d/kYT8IlafhKsRvKTkQ8d
         pS/ii1oUp/uGUvccuUa5BZrNqLwaQckass+fjiE5kzF05BwWPrhTQzLEu7AfOXvt96+6
         nAzhkWJ8LKSt9TBl3LwRwa1vmJBIHrhRQ9A4qj/zmo2UNxBAiNFPBqLsSyyoxuTSTiZD
         s6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795167114; x=1795771914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zn4lAoghu5jQhcYe+1nVRr6HSJgIEjuvXu7xfOq1cUI=;
        b=nuU7fUzCIH6IZQqTA4RLsztaH95fUDIzWOogqJrZfZEu80QH8aneitgdqghpJjKsha
         TFbzVgeqWFrpUlixLk6RB6w+KJEZoZDXhmJ2nc9Kj2yrE/ZHQiVkzGJyfuGAacxqxyBp
         VxpG65kyaXPw16ri9MTSofVZ2A+eVX4ZGX0HVxY3Xj79XcFvRqpysa6SjG+Q5UiCPzKJ
         WXoUOU5AXLUgfM3P2oef/JoYNSMbiWiBocATI5oHj1FneWCsoH+wQN2RJDLaONu4tcyY
         00/EYy3YYg/Zjn5YKwh9Bin3yLb5sxojZkEzrJSuka7Dht6PRH1gZxPG5Z8AOyJamSFX
         67Vg==
X-Forwarded-Encrypted: i=1; AL+hErGXOQlEBLqHouye1oyEXOZemSyhJdGA0QTSCk6UUfoD98oQd1uvWDm74wdvqqhBHnTaqc0Ttyy8F+Xlc51OGTo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gNrsvNeezAIznKmzDFCt7GTVhJfbmpq+aLief3wbxUXF9ZoV4
	MR/2fd6DQ5rP7ZnbCRVOM6hooJLLBon7CQ8o4MjK7ThyMA6d3EfWATmc1i3GsIMQbVfaJJly6Ub
	xqPqRkQXl9TuP6J5uB2MaLFHjakMPE3M=
X-Gm-Gg: AZFdTZcBjbYarHUze4rAVbjQ1/Gukp0iAnoh+4dr9SALZ4PX+BUZbHPxCdTTX5e4lL7
	a3ImTwIyZhmSGxztT6ynCLmJ+T7apvTb7c64U+lH3QZPJnWceQxPIBeMsaEsAMJ90on2WeAtlO/
	L1RlxTOT3tHyD68Iwv521cN9UsK5OkuzlJT2VhGBSYaD6fqSeG/HazI018qeslj9vR2BEdUBuQC
	mCrTsdN1Hm5UMYnnlVuQFnEdZ3ZvxLxa8Xmrhxscxs9Qqj08r4+QT6X4CzuK9W0ZhjY87+m3Pic
	6dR6Qq9kFdbi/d+IvLz2wMuWk+XYXnAIFG8I3Lw3B0kpxPt4N8Syjxt2Qo/LWcHLjOpBWKkEy73
	j0ldCknaPF9RTmVqVBTSNawl8OrmLSERpDAoaiht8gLXmg64EYwMR9PCT0JaEOQKjYnqlw5l4o/
	b4IcxW5wpr6okOloaf
X-Received: by 2002:a05:6000:2913:b0:4a7:7bec:e16d with SMTP id
 ffacd0b85a97d-4abb0c5d670mr5033398f8f.20.1795167113904; Fri, 20 Nov 2026
 01:31:53 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-xen-tpmfront-v3-1-3ea2e3fd8611@gmail.com> <awALp-m9n07zxwfj@kernel.org>
In-Reply-To: <awALp-m9n07zxwfj@kernel.org>
From: Wong Steve <shyckless@gmail.com>
Date: Fri, 20 Nov 2026 17:31:40 +0800
X-Gm-Features: Aa3M54puGGfyhs9Fb4PbPHCi2DwRGJKHVjyhAyTJ0EWTjaesj9JM_GgTWd2co1U
Message-ID: <CA+X8Sdi3CFZNDSOueF1b+C0myV5kqtwYzcxrUPx2T=8dJKyVzg@mail.gmail.com>
Subject: Re: [PATCH v3] tpm: xen-tpmfront: fix use-after-free in backend_changed()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: jgg@ziepe.ca, sstabellini@kernel.org, jgross@suse.com, 
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

On Fri, Nov 20, 2026, Jarkko Sakkinen wrote:
> There's no use-after-free to fix.

OK, with the only backend in use never closing, there is nothing to
hit here. I'll drop this patch. Thanks to you and Juergen for looking
at it.

Thanks,
Suyuan

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 16:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 20, 2026 at 04:26:16AM +0000, Suyuan Wang via B4 Relay wrote:
> > From: Suyuan Wang <stevewong@hust.edu.cn>
> >
> > When the backend moves to Closing or Closed, backend_changed()
> > unregisters the device and then keeps using it:
> >
> >       device_unregister(&dev->dev);
> >       xenbus_frontend_closed(dev);
> >
> > The xenbus watch callback that calls backend_changed() does not hold a
> > reference to the device. The tpm_chip registered by xen-tpmfront has de=
v
> > as its parent and holds a reference to it, but tpmfront_remove() drops
> > that reference when it unregisters the chip. So device_unregister() can
> > release the last reference and free the xenbus_device, and
> > xenbus_frontend_closed(dev) then accesses freed memory.
> >
> > The stubdom based vTPM backend, the only one in use today, never
> > switches to Closing or Closed, so this path is not reached with it. It
> > is reached with any backend that follows the normal xenbus state
> > machine on shutdown.
> >
> > Take a temporary reference before unregistering and drop it after
> > xenbus_frontend_closed(). This keeps dev alive for the last access and
> > keeps the existing order, in which TPM operations are stopped before
> > the frontend is marked Closed.
> >
> > Found with a static analysis tool and checked by hand.
> >
> > Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> > Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> > Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> > ---
> > Changes in v3:
> > - Drop the Fixes tag (Jarkko). No code change.
> >
> > Changes in v2:
> > - Say that the stubdom vTPM backend never reaches this path, and don't
> >   ask for a stable backport (Juergen, Jarkko). No code change.
>
> There's no use-after-free to fix.
>
> Br, Jarkko
