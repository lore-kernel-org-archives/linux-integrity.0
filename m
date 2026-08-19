Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313623D092F
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166044; cv=none; b=EBskkV5olNY13zbRmVyVq5uYoiRyVFSOtK180/XMeYAhkY8EMTGM3hDACobpX1Mql+kINiuIf9/I8jATeuFa2vqxxVZ9/1xWHDo0rb4NAhQj2Xq+F0/BYwWOw8nsrKBkgm9+IOCWhNK1H9dvpAUkhEjEjsIg3BiDXQCC3pJM58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166044; c=relaxed/simple;
	bh=7ST1pzdMeqFCXvUol6O+skJ17EbR02PO7/zLshO4f/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wu9AAlEqUd3CI6eUL1C9HUIWHXENnRioEIVjq1JzxjtQqQ1xEzKe7+IcqmSDdGpPIMYUw3fAA64puMQBWyd3JH7V4fXSO6VNs9aPVnOEIc0PS++ymk5m7uiiZClmg/xuapq+Ym0F+EVPbbKwJTySo6F8UCAFX5VicHXuU4akaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9CMc5bJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9CMc5bJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9BA1F00A3E
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 19:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166042;
	bh=7PHTDX2cm6TadDO+qQYQKo3kvTt5BeipwD+qdBuwy4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T9CMc5bJ6B6NRUhlJU75add5uqmxrHdD7ecQWwB71TyA8+BIX7E6K+TcFQnKZO9EK
	 lBZl6j0CdUcEygpCS7Jfs5HYijxHJA/kJFDUpfv/nRDA0wgnyHdhZ/oc2aHiIUnHWg
	 5r0aonAaHlGYj1t6Gz0iWCPgGK9J8CdTKSpeLrHmapnlNEV9ZF/Y/fHI6T7behAIi3
	 /CB0RfLw+/TRdE/fBFGJasxQxnQkkY4Jj+FNPjPkZoksYndqWnETV1pFsJt8pEA0BK
	 0f6JTXOuTrD+tzo0LCWDYDnc1K4aNJOJoDmtpVUVI/1+XAAD5/aAs0o7uSmz/xv3+B
	 b5vRMo2cTv+KA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39ca300db70so14871121fa.2
        for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 12:00:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp8WZOA8NoSX899DS+y9WL0AXmPnq5aXq2o7vPrieesmfHuqJDjh9LXZmAUGVV8Jhgu3RctbF7kvzKhYV0PLeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXfaMd1nm/1BsQn/pCwa8LMxbH2TKjGMNq6+fNbLiz/bxkWdMZ
	woEWJSRwaPU5HLDURMzHICNZ4T1UkBayaeYqpQk+dbmMyDm+0hAm++8AcmPswg5i3KGqhktJA0P
	wAVH2r6TmpY2WlOgD0el310MU9AGDcxE=
X-Received: by 2002:a05:651c:1542:b0:3a1:12e6:bbae with SMTP id
 38308e7fff4ca-3a18945ccb5mr17398381fa.0.1787166041297; Wed, 19 Aug 2026
 12:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955541.O9o76ZdvQC@rafael.j.wysocki> <CAJZ5v0j0mgTRjwrHbzTPwycuktDRahoexCdzbcNsRh7f8GKPDw@mail.gmail.com>
 <CAJZ5v0i59XtzNTepjb_hh=93E5Cy6pVZmkssKVOoLZL7nvpW0Q@mail.gmail.com>
 <12952304.O9o76ZdvQC@rafael.j.wysocki> <20260819173157.GB3138944@ax162>
In-Reply-To: <20260819173157.GB3138944@ax162>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 19 Aug 2026 21:00:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpBNEjQqbJq3hrNqCAG_TWkv8SikWB9c8i_V5xZS9Q7Q@mail.gmail.com>
X-Gm-Features: AcwNN1WlUJt0TJJs1tLJi3UzBJZwQj7oGogqZsJHriBf929kFY1tsyNFoJGzG-g
Message-ID: <CAJZ5v0jpBNEjQqbJq3hrNqCAG_TWkv8SikWB9c8i_V5xZS9Q7Q@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 7:32=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Wed, Aug 19, 2026 at 03:55:43PM +0200, Rafael J. Wysocki wrote:
> > And below is one to try.
> >
> > ---
> >  drivers/acpi/acpi_platform.c |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust
> >       for (i =3D 0; i < count; ) {
> >               struct resource *res =3D &resources[i];
> >
> > -             if (resource_type(new_res) !=3D resource_type(res) ||
> > +             /*
> > +              * Look for overlaps of resources of the same type that
> > +              * would cause resource insertion to fail.
> > +              */
> > +             if (__resource_contains_unbound(new_res, res) ||
> > +                 resource_type(new_res) !=3D resource_type(res) ||
> >                   !resource_union(new_res, res, new_res)) {
> >                       i++;
> >                       continue;
> >
> >
> >
>
> This does not appear to resolve the probe failure for me.

So can you please try to reverse new_res and res in the
__resource_contains_unbound() check in the patch and try again?

> Attached are the output of dmesg from a boot with that patch (let me know=
 if you want
> a clean one) and the output of acpidump.

I'll get to the acpidump next, but I'm not sure if I can do it today.
