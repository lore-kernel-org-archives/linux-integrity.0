Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794141150;
	b=NhWkoz8zshZa9I63mcmok+0bI0ZXcmBVAReDLkseS9y9CzSadNiE7YX2UOxOIgeg3009
	 eb1sONAN/HCfPm5s5V73cffzL+IOy0j0LdYSf7cPs5j4ldnzrHDvnMZy1YnCLgU76u+KV
	 TgmvWtd8BMlcL9LDIMqPyHyUCk5eGymDJ9Udm4Kk2gHnj+kOEkj/CzqTdAabwR6KRK51u
	 WqpVnuw+tfA7Z48g7Dn7p4VdIA5lt+Cly8JZxjdiX3PDEh/2XbueyI5MIM1MKkxIYGYd7
	 j/iFPO5OTTXcLfiv4afydAVnYLKiE1d9E48jTZRYO7sH3ybbOZ82cwKhx4b+7jIeDZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QWdpxBY5f9SrIiP9qlqTJHu1UmLoydUe6EBqvkilw3k=;
	b=OkgCYGJBsBbtgv/qPlpc60kwz3EhDfOwtLzXd/K+yDe6cUGiJ8jBRGCUOBWbD5BVVP7R
	 UBBS+3EiJa7IpHY1/1O24nn0bZgrL9GIGWO6I+xNAapBem/nwKuj8dIwG6knwTtJ6y5cZ
	 WTVdx5uXySTsYfhcx0dMQvajrBtgnyCzuaVbpyIfcrIB2XY0KcTxboKOZu3QVLYHrj7Pc
	 HQAFNPjouVOSfKURvaifitImuLTzmJC1VRu4GGkTdt4K8ZQaNZecmAwvcVFeFMzTFGjNs
	 U5mqxPWw6l4ymUgHtqlzEEiOgB8z/ZJgT8klHR4Nshxcun3fau0Lxmub3s8mmhdzqmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRwyiFCH;
	arc=fail smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A031606A321
	for <linux-integrity@vger.kernel.org>; Sun,  8 Nov 2026 12:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A031606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRwyiFCH
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so158649eec.0
        for <linux-integrity@vger.kernel.org>; Sun, 08 Nov 2026 04:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794141150; cv=none;
        d=google.com; s=arc-20260327;
        b=g8I4ipIdOrdGdQ8DIyKphmJKYD1Xb/pDEixkNgvQKGZhlPD1fI2+dKvbDcI/l9w84O
         gABl2w8we95uqI3umzsjySaEXWbflQHyz1YXuCjx37ft+k6JWswfWZ3n2sRYm6xOujbO
         V8GVDIpVYDS1R98HXuKpFYgw1aBTSn2Dzon6w5fRJ1LtOv2iGesCxgTnL3z7DEj08Rq3
         5prXyhkqcLnDHKtH33EAkB4lt1pbCIj9VbmEKt9Bwgx+gMe3/dXp5oQ7UkJMeyE0uQB2
         1An7k7LN7xVECdMaPSrgk+UOGi3BXFzpsPEWi9eGQ+qmqhgILAmTfoVHilS6omrxwss+
         Cv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QWdpxBY5f9SrIiP9qlqTJHu1UmLoydUe6EBqvkilw3k=;
        fh=tJRiGyM71ptHbSEq39ZbtHaZOx3X5PSD2YprVdHzDCg=;
        b=GDA708eJg+WXfVRM2uwjUkhsOVNPJp777WflWG43N/H4g4qAUJQcV4pspWfrk5cA16
         wuRb2lFoeEzmxdJ30n+Q8ANqRacoADmJnYvSWXqrUnri1OW/MrS4JFX1Zk0xWaeqvxVP
         sTQSacUD0ommepbPpObduxGNU8caxdu9BxWeZYAJq+0aQ0/uyrT+hVJQb6xn4LF8xH6h
         xNddV3yRjgHf4E2fAG9kPaCB7/LHyYRCoZx0SBhsYGJCa1vKtWsUuACHxPQh3kIsJW6J
         bT4oyhvuyjJLvDxNOApb6PxmMrvfiB5lrGj1jKjCxb9cbIQd5z8DGW+WgL++oHibLH7+
         bwsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794141150; x=1794745950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWdpxBY5f9SrIiP9qlqTJHu1UmLoydUe6EBqvkilw3k=;
        b=VRwyiFCHsdY3Jpa0rIAYOhJl7wrp0P3/eYwNVbjsLivYJYE3+6CsRNAdl3rZAwftQw
         l5u5RvFU0L9kJpV7mJLpNPipOqYOlPZy9OGAwPTgFBLeRPct3RnmcYf2T5qREXEtRt53
         KqfGfsgZ0EYpyDNaQ0nA/Hg5HChetXfPD//KZ57e3HLLRlRXZCqecLY/NT8LxTR1+g1T
         dsJ7Q8O4LjHuPRrUj2b8iMSNN3z/TXAgAiS3KUqSTJ0DRjLEBZ8imi9fLzKDJqLxutQt
         8rPX75rYRvq4JgfVs79jcu8mz4NFugvxaBm50cBC35I5PpaSU7Lt72XAcae+nz6v4NNQ
         6XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794141150; x=1794745950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWdpxBY5f9SrIiP9qlqTJHu1UmLoydUe6EBqvkilw3k=;
        b=NMME56maIdTj1UI6DR7DmN53JshP8BrT0EUgPplWLy6NrojApCAh5XRUvYELc2vRwk
         udH0GgLMQaQD/CHYD2aMLvnLZiHs2sGdL20PtuTh/RMm04V5rrHT438Cr3ijVrprTMpX
         1GfxB1iRReMeD6TTJAbrBPnuqXDNnYgk+K2IJX/07mz3Vzs85E5C1Ms/G6l7ggvXLLl/
         fKAYLsHJnYeJz1cqizGhZkGEYqA7OI1eiwGEjPSZ9EUXhAxb+AdT0zwvOWOVrrG4+gLN
         ukIvR1Jd6JRojQ1TM5BfNj0CS0o16lpGYS5Aeoxu+/kaqz1DeNGg6ij0j4QUvFDpAomn
         f6mg==
X-Forwarded-Encrypted: i=1; AL+hErGQOQEv1NUAM1dOimrE5gvKLpFLlxfIxTwec3KK75XXZo3VWNaLHbWASCWjLI7oq/dOtP2X/4nX80nAc7PRJG4=@vger.kernel.org
X-Gm-Message-State: APuU4Z92FFMaOBCxmNwDDzrEOfOluyG4bJBWPWc5svkyYFjbYssEQHIL
	Z/CByvagyGlrXl8r9HgbzTdw+GuilZh7ryTx9822JngrNnB7jjU0eBzy1mNoehPuK12eXdpFWCA
	w3U9tuEyV0Bz0gRlaMHgO3lcHmi7AarRRuK9D69I=
X-Gm-Gg: AYBFou1UbFTmLDqRkfKTk9oXSHAACy6QAH3+YbgQtP3t9cOosF+NTdhIs810ucfMatr
	f0ErTL/wfTLqS//ME5ajIVOBra6PBDdZSVKcPZqtR/1rF5lNS7b+PbXzsxnNy+h/zBl2haS8HX1
	3mB/kEUWz5YM2RyjWPy/AZvtY3UImFDqj2X9CAtt/jEe7ZFLOyYNackKj1bLdYl4wo5qhYeyPYv
	Ca7EIn3UsJL3QpGy2wS6gZ/LzQDtYKmARbR0+wcgMftJ/hjiXQoePiQlVngR6TDRzCM3fMVM0wh
	fWbx3OAWP6HQDn36zIldpQ2CpqL3+5BAJLcfQyWB2NawP7BtNr+8DwK94qvGTBeQCQSj2A/xjnW
	6vNJQt/h5jQnfpR3u3raaCrjxWZWGriI1xDgiUFYCUIKveJi9sn3XnxiTai4V1Nu9SayrFUvMIn
	FVQIVYmiwi3rTEyA==
X-Received: by 2002:a05:693c:62cd:b0:370:ff2:f78d with SMTP id
 5a478bee46e88-37256614c62mr2989725eec.8.1794141149593; Sun, 08 Nov 2026
 04:32:29 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108075848.257145-1-hj351016@gmail.com> <avBrPjvw_5EH_W5r@kernel.org>
In-Reply-To: <avBrPjvw_5EH_W5r@kernel.org>
From: khj <hj351016@gmail.com>
Date: Sun, 8 Nov 2026 21:32:18 +0900
X-Gm-Features: AclHuK-wkJTST75ujvma9IGtuUWYkl4oaDisXKEz5d6-YrVvIkqMRKq-RLJUzHw
Message-ID: <CAGr5VtNphPZtGC9MSLQcMCUWBKUYPC_ufqpb1YZ=WBPm=oZb1w@mail.gmail.com>
Subject: Re: [PATCH] tpm: flush timeout work outside buffer_mutex to avoid deadlock
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Tadeusz Struk <tadeusz.struk@intel.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, renamed to 'flush' in v2.

2026=EB=85=84 11=EC=9B=94 8=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:29, J=
arkko Sakkinen <jarkko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sun, Nov 08, 2026 at 04:58:48PM +0900, hyunjungg wrote:
> > From: Hyunjung Ko <hj351016@gmail.com>
> >
> > tpm_common_read() flushes priv->timeout_work while holding
> > priv->buffer_mutex:
> >
> >       mutex_lock(&priv->buffer_mutex);
> >       ...
> >       if (!priv->response_length) {
> >               *off =3D 0;
> >               timer_delete_sync(&priv->user_read_timer);
> >               flush_work(&priv->timeout_work);
> >       }
> >       mutex_unlock(&priv->buffer_mutex);
> >
> > The flushed handler, tpm_timeout_work(), takes the same buffer_mutex at
> > its start. user_reader_timeout() schedules timeout_work from the
> > user_read_timer, which is armed while a response is pending. If that
> > timer fires and timeout_work starts running while a reader holds
> > buffer_mutex, flush_work() waits for timeout_work to finish while the
> > reader holds the mutex, and timeout_work blocks acquiring that same
> > mutex -> deadlock. lockdep would report this as a circular locking
> > dependency between buffer_mutex and the work.
> >
> > Before commit 9488585b21be ("tpm: add support for partial reads") the
> > timer deletion and the work flush ran before buffer_mutex was taken;
> > that commit moved them into the mutex-held section, introducing the
> > flush-under-lock cycle.
> >
> > Flush timeout_work after dropping buffer_mutex. The timer is still
> > deleted under the lock, so no new timeout work can be queued once the
> > mutex is released, and the flush no longer runs under the lock the work
> > needs.
> >
> > Found by static analysis (a checker for cancel/flush-sync of a work
> > performed under a lock that the work's handler also takes) and confirme=
d
> > by code inspection. Not reproduced at runtime: it requires the
> > deprecated user-space read timeout to fire while a read holds
> > buffer_mutex, so the deadlock is established by inspection rather than =
an
> > observed lockdep splat.
> >
> > Fixes: 9488585b21be ("tpm: add support for partial reads")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> > ---
> >  drivers/char/tpm/tpm-dev-common.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-d=
ev-common.c
> > index 6569212..f9b18ef 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __u=
ser *buf,
> >  {
> >       struct file_priv *priv =3D file->private_data;
> >       ssize_t ret_size =3D 0;
> > +     bool flush_timeout =3D false;
>
> Rename this as flush.
>
> >       int rc;
> >
> >       if (!size)
> > @@ -164,9 +165,19 @@ out:
> >       if (!priv->response_length) {
> >               *off =3D 0;
> >               timer_delete_sync(&priv->user_read_timer);
> > -             flush_work(&priv->timeout_work);
> > +             flush_timeout =3D true;
> >       }
> >       mutex_unlock(&priv->buffer_mutex);
> > +
> > +     /*
> > +      * tpm_timeout_work() acquires buffer_mutex, so flushing it while=
 that
> > +      * mutex is held deadlocks if the timeout work is already running=
 and
> > +      * waiting for the lock. Flush after dropping the mutex; the time=
r is
> > +      * deleted above under the lock, so no new timeout work can be qu=
eued.
> > +      */
> > +     if (flush_timeout)
> > +             flush_work(&priv->timeout_work);
> > +
> >       return ret_size;
> >  }
> >
> > --
> > 2.43.0
> >
>
> Br, Jarkko
