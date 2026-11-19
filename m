Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795116728;
	b=Gwi56h+LCivIEwRINyZJBhzHHOhvSdIoOBOzakCv26Tg0YElNsE4gdDu4vj7euj94Wv3
	 pvktzxEjg8w0YFjSF7+S9sPuadzswALMYDWeoZ3Ti+ID2/Vg7Ujai0yxVDNflb3JbY15g
	 o196F/bNZVJYcrPz4h7Q9gMDNr3wjXcTrayv0/qH1XWdd0z24PFhtJQecPgDxNqLSeHuT
	 M6hD/MvGoHdM2CTz57UFQdUQlwT8r8tynsMC0Sr+wS+nO40ZmXSI0SlpMumEKCorG4aMR
	 /5TreiUK9+dBkF9V/c7G38tAOKaOO/fxVjDUOSKX2TOfRWV3uOJxZ/JSdzlo8yaH6jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zHELh1wvQ9nrwWZUArifTWwLGXrX5lfqWf4Gv/ulNME=;
	b=3P6NZKE/r6/glpKJzZBfYHjX6IY2uittZ6kMmdyX7rGBrfUT+DpXcuK0G3M2Rdob1Bb8
	 xEV/uLSxw4hg62Pg6HLGlNbN7gPv0hZZEr05dg1Rxx++u5Z21Bj2FZUjVjDzoAdozS7xI
	 woycWJAOu3BNK7Xb2bjn/+zUq5hZiepcqHF+8u5Mrpw9wrAVQoLEcCRnq/MreEfy8LSqT
	 FQTYuL2/H34hIBu3FiLQQfT6ZJPihVAN6X0YRLmEerOqUkJgHucIL22PO1J4dbSw89oDo
	 1/fxdtyN7aJsERUOQ6WB5zlLkKDAuZBebjgK2JbbrJLnoqSImW8cI7NRZugue8bFVdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gf8E0pgs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1B606A320
	for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2026 19:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD1B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gf8E0pgs
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4aa5833c263so47776f8f.2
        for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2026 11:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795116726; cv=none;
        d=google.com; s=arc-20260327;
        b=gKGwuMhETAshp8QEQkotAsAn72OfGdn7IiYdISPkY2uVtaEFSwiWVFGj6WFdUpspGi
         pZ6Pn3LK2yHO5ao25NlIoYxNP2Bn9Otn6BLkXM+Lpbiuym8kxz8piNFPbFMvq2juVH20
         wWbzGxoJYXy12RD2vLsdDuFxP5Lf/qMttMrvjl2qJoPiltKKp5j3ZrMj8JHByB2G23gV
         hQBolqcqetcNP7EVaQNwSzsw0IIvceIlyINMsx8vweCC6Ka7GXVKq1qSzA7hfkxfZpEN
         3XHngKI4mfI1kh6UrX0RvT0PdWp1gYtvtqSpqvO2zHxXaMLO/tHl/yDz/CipamVvMEXl
         FsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zHELh1wvQ9nrwWZUArifTWwLGXrX5lfqWf4Gv/ulNME=;
        fh=peNVsWcdXkk6+1Gl+5bi3PfgVS2q1iatRFK0P555ASQ=;
        b=ljzp6aWKPXtbeTaMd54Wc+LLHyqK9+iTY6nVfygp5lt9d4jx6OIAFihA7FtFEema7I
         Hnigh8SIOWOn8mrH5zJu/v9JIM4NpX2yaFt4IHGdkA1HaujZE/SCxfN17AtH2iDE4ZC3
         B+Np+8uZYrrANiM/sXCvzAsQbAMElx0NfKH/ZYVkIoiTp6eQGN57IwuFyPAXhqdFxL/J
         fZEWIEI/0US47oF7Uh5jbkJ+kjdRxQ7OwdPjMy7I/Q1dzVZ0JvKtsZOX54CK7msC9wRJ
         mgzb0PLMmZkuo2ducUdYiSxvnPmZW4YiI/HCZ8FhK10tZzoCK+rqu4+Dg8hhzqdahooY
         eEcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795116726; x=1795721526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zHELh1wvQ9nrwWZUArifTWwLGXrX5lfqWf4Gv/ulNME=;
        b=gf8E0pgsBCakh+RaKRNl5kfZ3LadJYShkWMrSvwNKqL9DjvTTKfUAHqf/Scj+ECM6+
         4fDHsNlwDZOzszeFotiMZ7hhGlGNw/n64Rs+Z0ChI9ZlX3OG8+qk3N+kPPb7mRIbqcxo
         48RXRdEfskAy4Q49gbdmzOC9QcPdfUwP7d/RvvPmbFr1UtESCC4to3f30byog+CeuGOp
         1CjbdhHEV0VFhs4ZHVK6kFdm6Ui4ZkX23fCs50hAv55BeOmCKU9okgR2OfQ+1q2heFFe
         Iqz+gZsYOmErZOpCgQCRfVrJ4D6ILJabmo020sr/hI0MdRB7bHmOHnn3wlCZxeXEH7Ma
         ppyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116726; x=1795721526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zHELh1wvQ9nrwWZUArifTWwLGXrX5lfqWf4Gv/ulNME=;
        b=RY/JnwxDgQd3Us2Ggvl+b0ia9cYDBicQkgqI1Xk4q7oPwYBUfxzkDIoEbgYy9B4xLd
         5rZ19C1vOsjEUx48hHR69XPZx1hXveNVuhOUtFDH6YXY5EnUGTjZ9NCc3WI3/+4gqcCR
         8osWqH35Qm1wz8Bsoe++wf1V06cWnPfa0ccVBNgYOaxxRtDHrRKr34i92I8m6W7kDeSc
         j0ZO0Y5dzAxFFwAL+Smiclwgy6SFvdA3CfZSa/QJWKj7aBO/BVNkJE7tOXWBARnV6qNV
         +U4dYK8SmDXKuL2ELBgic+ZbEePlgxs9br5+zIz1Nz1ZxkwMY1mZzLbj7GJlv6SEY3Gv
         j95g==
X-Forwarded-Encrypted: i=1; AL+hErEYaHafO0Jozzb/DydU+dxN5gU40jnhBUZVdcp01XnXnPASmJ6PK1WB1Rds+XV24vCLljF0imZzYwM2aYHDbqQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z84K5diw8Zv0MrHe7K9V8nzkCrtuwpzPbxiaY59xYWeWn9uAIqI
	4yshHXDyx0fUkBfc6OxwkDejWx1tRbiJEYyXXn+kplpq+Ge+H11YsoDsecRk+ODeUgo7irK7TN5
	xEJ2YcOdJ5tH2dfXb7pfGVuy6iUuMbqw=
X-Gm-Gg: AZFdTZcTYtoqvECuJmQ/rY266gMaEBlOF0aeRlmO8CaoOZ3I/+JSFUhHFrRdr6SusJj
	TCHjBNgTd3G7k0F1iSYxnseXJXKTGTsKgkWkRPapUUJ1LAm0wfatuiy5lAZzMWayZxBpBewKUsi
	npp4uHD/BLXkbGekb4JyewOoDGzfX3g4Tbt3L7iPBdy0AOZcrGWG2Yx6OlWmMuJd4uhD6vk8JOh
	0CV1wBjziGXh7GJvdE2X0kKhT7rFTUUoxq8fm42+KwGsR76jAQ4aNSsj3OTVR7xasYSa4VhE4LG
	lOKGapV6WHTHiEOkAbu6j+h1lXD7768M0Y6AZ489bEe12bG/Cw8a4pf+OWnLzZZA6I2q1NUHUiz
	dizinJH8f2E9hVuA3VYBuoBpcPZgj0wJqFw==
X-Received: by 2002:a05:6000:4705:b0:48f:cb37:3ec3 with SMTP id
 ffacd0b85a97d-4abb400c591mr853280f8f.41.1795116726352; Thu, 19 Nov 2026
 11:32:06 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>
 <av8Tr2jTQaOBOEid@kernel.org> <8c988944-34e3-4fc9-a323-daca101c1bab@suse.com>
 <av8kIqYC04D5QdXf@kernel.org> <3b37565a-4dd7-454d-99b7-108b8e4e7133@suse.com>
In-Reply-To: <3b37565a-4dd7-454d-99b7-108b8e4e7133@suse.com>
From: Wong Steve <shyckless@gmail.com>
Date: Fri, 20 Nov 2026 03:31:53 +0800
X-Gm-Features: Aa3M54rJ-G9ninS-5Hi_IFXsKYFH3S7hyehBNAqEoZNCg_X0cyVis4rAtusXM0A
Message-ID: <CA+X8Sdj4KRfJagaKHkcXrv370Si_WktanBqRN-SrB7qOMH=FAg@mail.gmail.com>
Subject: Re: [PATCH] tpm: xen-tpmfront: fix use-after-free in backend_changed()
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	sstabellini@kernel.org, linux-integrity@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Juergen, Jarkko,

Thanks Juergen, that explains why nobody has run into it: with the
stubdom backend the frontend never sees Closing or Closed, so this
path is only reached with a backend that does close. I agree the
normal state machine should stay.

So with today's backend this is latent. Jarkko, if you prefer, I can
send a v2 that says so in the commit message and drops the
Cc: stable.

Thanks,
Suyuan

J=C3=BCrgen Gro=C3=9F <jgross@suse.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=BA=94 00:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 19.11.26 17:30, Jarkko Sakkinen wrote:
> > On Thu, Nov 19, 2026 at 04:35:02PM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> >> On 19.11.26 16:20, Jarkko Sakkinen wrote:
> >>> On Thu, Nov 19, 2026 at 11:20:33AM +0000, Suyuan Wang via B4 Relay wr=
ote:
> >>>> From: Suyuan Wang <stevewong@hust.edu.cn>
> >>>>
> >>>> When the backend moves to Closing or Closed, backend_changed()
> >>>> unregisters the device and then keeps using it:
> >>>>
> >>>>    device_unregister(&dev->dev);
> >>>>    xenbus_frontend_closed(dev);
> >>>>
> >>>> The xenbus watch callback that calls backend_changed() does not hold=
 a
> >>>> reference to the device. The tpm_chip registered by xen-tpmfront has=
 dev
> >>>> as its parent and holds a reference to it, but tpmfront_remove() dro=
ps
> >>>> that reference when it unregisters the chip. So device_unregister() =
can
> >>>> release the last reference and free the xenbus_device, and
> >>>> xenbus_frontend_closed(dev) then accesses freed memory.
> >>>>
> >>>> Take a temporary reference before unregistering and drop it after
> >>>> xenbus_frontend_closed(). This keeps dev alive for the last access a=
nd
> >>>> keeps the existing order, in which TPM operations are stopped before
> >>>> the frontend is marked Closed.
> >>>>
> >>>> Found with a static analysis tool and checked by hand.
> >>>>
> >>>> Fixes: e2683957fb26 ("drivers/tpm: add xen tpmfront interface")
> >>>> Cc: stable@vger.kernel.org
> >>>> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> >>>> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> >>>> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> >>>> ---
> >>>> Compile tested on x86_64 (W=3D1, no new warnings). Not run with a Xe=
n vTPM
> >>>> backend.
> >>>> ---
> >>>>    drivers/char/tpm/xen-tpmfront.c | 3 +++
> >>>>    1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-=
tpmfront.c
> >>>> index 3c0cce57c4ae..1be925cca535 100644
> >>>> --- a/drivers/char/tpm/xen-tpmfront.c
> >>>> +++ b/drivers/char/tpm/xen-tpmfront.c
> >>>> @@ -397,8 +397,11 @@ static void backend_changed(struct xenbus_devic=
e *dev,
> >>>>            case XenbusStateClosing:
> >>>>            case XenbusStateClosed:
> >>>> +          /* device_unregister() can drop the last reference to dev=
 */
> >>>> +          get_device(&dev->dev);
> >>>>                    device_unregister(&dev->dev);
> >>>>                    xenbus_frontend_closed(dev);
> >>>> +          put_device(&dev->dev);
> >>>
> >>> Not a NAK but makes me wonder why this has not hit the wall ever.
> >>>
> >>> I.e. "feeling confused".
> >> Is there any vtpm backend other than the stubdom based one?
> >>
> >> If not, then it is quite easy: this backend never switches state to
> >> XenbusStateClosing or XenbusStateClosed.
> >>
> >>
> >> Juergen
> >
> > Should it be removed use the default-fallback?
> I don't think so.
>
> There might be other backends in future, so following the normal Xen PV-d=
evice
> state machine should be kept.
>
>
> Juergen
