Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B67391E64
	for <linux-integrity@vger.kernel.org>; Mon, 10 Aug 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358486; cv=none; b=Ab9DZ2IKOZbqW6FZpU91W0YJU2nC5dqSbNygGc6zwcAB4UN/Ghof36fZUVRRx2uIHlzVV7cOLnD/p4oDtmqU5w+TuNxiet/Ozv3Lbdo3r2zSvU6faLWg+x4IecyckLo2G6D52r+BY/Fiev9P9rDXrzTFYTZ6xbZJb7VHuBWNNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358486; c=relaxed/simple;
	bh=9wnlQnJJ7hDZhpxdk7RUjsy1hENqx1ebxmy3r7nboY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFbepF9bNT5fWwz9Vx/klVr+NpWVw5TpocY3ts6yAuMYrdHEm9DWZvtkKjZVaoTO1r2kzEVVxC8Ad4P8RIj50lD8hZS3cOchgU0j02PL+q+anUzSMHPn/dSjdUWP3thABXUgGIYKDczxfVbNvl6ThFNY71YIDrO03PvKgzKoWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHT/mErv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHT/mErv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334471F00A3F
	for <linux-integrity@vger.kernel.org>; Mon, 10 Aug 2026 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358484;
	bh=q15jjbmDW34zu/RivPzqTaotKSxhJriggh8tOa2uyyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HHT/mErvbmNesLE5r2O2J/nJOLIO6Zdet560i5YArdZCcBw5lIFFG8C8STFNz3Y53
	 fW0d9qSgdOZELerNGokrW87A7WyKss/YpIJWHNv5vnN03XYUiZzYrXFn1OokmOC4rt
	 AnVnxFBbLCWSEHoL3Xv7dIax57Z8xiwhICV3wbPGBiXSLeJ2GlnwJLu2sqwzGV4t0X
	 3mnSjV8gS3P9Ph0Ob1mySgd3R8UhujcNGJ0mqEX0JAu/GOgYNtO531OIMEqgzz917/
	 54+6h7+tv6dO5y4Ru0yVBWosRjRqGZNNlxMuA68ewj+lCPbVHEKuhzH/IH+oOuC1+q
	 zqghkO9V1JGEQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so13921571fa.3
        for <linux-integrity@vger.kernel.org>; Mon, 10 Aug 2026 03:41:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr6OANe4y8rxLxKZ205XANG8GQ8My0ZvHJ4LGxdDDWHXIgNdPcXQnmUJCgGGtw9DZ4wqNAC1CMnZybZIEUQaro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfsftpI0VMjBipej/f4aOL3Dett91WTexEKm2pVRSVIH+cxSNo
	QITbMoirNposkFkhXk5qqVAdwKxtLD6UM64VoSdiU7Yjc+u2RtxY+8WmZxuWPTEz1n8pVMdshMi
	8nZ6Z8ezTmA+ZRcJlkbEv0M9F37onV1k=
X-Received: by 2002:a05:651c:198c:b0:39c:6f75:2eea with SMTP id
 38308e7fff4ca-39fdf42ae01mr26818281fa.11.1786358482614; Mon, 10 Aug 2026
 03:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955541.O9o76ZdvQC@rafael.j.wysocki> <aneLtz6TERcU41ur@ashevche-desk.local>
In-Reply-To: <aneLtz6TERcU41ur@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 10 Aug 2026 12:41:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0itYEMDyzkYdPApQXMVu06-jVpZs4qWrw2SnYLLHzthpw@mail.gmail.com>
X-Gm-Features: AUfX_mz0pC53X5nfN3yzCJEnvv5VUJvBqft3DTZpoCwxFTZNVDzDNmv79-6Ixf4
Message-ID: <CAJZ5v0itYEMDyzkYdPApQXMVu06-jVpZs4qWrw2SnYLLHzthpw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 10:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 07, 2026 at 12:22:37PM +0200, Rafael J. Wysocki wrote:
>
> > If acpi_dev_get_resources() returns overlapping I/O or memory resources=
,
> > the subsequent registration of a platform device will fail with -EBUSY
> > due to a resource conflict.  This is reported to happen on Acer Aspire
> > ES1-572 [1].
> >
> > Avoid that by adjusting resources returned by acpi_dev_get_resources()
> > to eliminate partial overlaps between them.
> >
> > This has not been regarded as necessary before because putting
> > overlapping resources into the _CRS of one device is really pointless,
> > but now that the issue has been reported to actually happen in the
> > field, it needs to be done.
>
> ...
>
> >    * Use resource_union() and adjust code and comment (Andy)
>
> Thanks, LGTM now,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> > +static unsigned int acpi_platform_adjust_resources(struct acpi_device =
*adev,
> > +                                                struct resource *new_r=
es,
> > +                                                struct resource *resou=
rces,
> > +                                                unsigned int count)
> > +{
> > +     unsigned int i;
> > +
> > +     if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
>
> Can also be
>
>         if (!(resource_type(new_res) & (IORESOURCE_IO | IORESOURCE_MEM)))

It could, but it would add a redundant "bitwise and" with the type mask.

I guess the compiler can be expected to optimize it away, but if it
doesn't get optimized away, it's just pure useless overhead.

> > +             return count;
> > +
> > +     for (i =3D 0; i < count; ) {
> > +             struct resource *res =3D &resources[i];
>
> > +             if (resource_type(new_res) !=3D resource_type(res) ||
> > +                 !resource_union(new_res, res, new_res)) {
>
> Wondering why we don't have the resource type checks in resource_overlaps=
(),

Yeah, it looks like a missing piece.

> but we have in resource_contains(). Ilpo, do you know?
