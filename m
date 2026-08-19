Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D873D301A
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169250; cv=none; b=fHiqly30LImBTn/CJcvzpsSo93vHo4bVp3RXZBlx+bjmkYqS4bSU6MwI7Ti/zDJE4vhyqVPR0PRl7Vo3m4PZ3dreEIVlw1W39PWnERsnPE0k6q2CtDCz5j1avx72YTqITcqFKCaTI7RoRxZnZ7QIVXnWODCYok4xV7ynXkBuBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169250; c=relaxed/simple;
	bh=aXwgRC1w0nDHn2XY8PIVkmDjVpqm3lDO8yUnLqwO79o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2dImND5SefGcntybwc2y6NtsedX49/tac8edYwOTDe5tRu8BFdXghYXZuAoJYHBZf6+FDBT94K+omfpYjyGlpQm3bF4hcaLvfeU9XkGoEvYM1vFpvwGKZ85pqiQRgXH1JIuoh6jlm+2h+3q0nxIMPqieqJuLycORqrALysKNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjshCy06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjshCy06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9471F00ADF
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 19:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787169249;
	bh=vXsmmJ0PeYlY9D1AVjw84jzsQ7K1JZcENXFwbh/3+jM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bjshCy06zxrg1/eEi2xcS5JgNz+UjOv3wPQTw3EJsXtO+HDlwisA5rgi1FbmpUGPb
	 NqTS69QaCTIe5zTQm2WyNJu6cfIvE3Uzq/PQ+W23OdItHJp/9JO0lS9wv3RaoSdvtj
	 RVh0Ox7nC/M+7IxFXKZJp/rTCsrkPVnrPVJl31UFbYQDz1J9f+mKfCEaUScdVTQ1og
	 vsVH9q8NtplZ14TTf8BGjCqNvAINzpkx+jCOPYNF+c4tmsftFHeB1rNjBAh4kjvjKB
	 suUHDp4+tEtN9oausiXPdSGX2wVolje1SYvHaMgNuxYMBDNTCQer5jgD5vBRsAyjM2
	 51J+TzF7eT4Iw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so17897711fa.1
        for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 12:54:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ror9wbmdTv5bWna683M0pxF7WlD3p1C9vWxov7Sz8v56NBJnVYa5nJknAb+mjTQNfulPKgQa2mMmK6zBAZFdog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHCvL2bDdqKfER3at7/lTGvnxesteO48MO/rPhXzUFoBbM1Fe
	wM5iK7wVEPm6f9F+RndeCMwh6oh5niIvn4oGvsP21ALIY4UNgQsXqMGTehYZh0mCMIaxTOEGv5w
	Yoqo7Y86YMI6W+PsTEpmj3PnR8DjMmPE=
X-Received: by 2002:a05:651c:19a9:b0:39b:a75:e8da with SMTP id
 38308e7fff4ca-3a189746de6mr18004911fa.3.1787169247885; Wed, 19 Aug 2026
 12:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955541.O9o76ZdvQC@rafael.j.wysocki> <CAJZ5v0j0mgTRjwrHbzTPwycuktDRahoexCdzbcNsRh7f8GKPDw@mail.gmail.com>
 <CAJZ5v0i59XtzNTepjb_hh=93E5Cy6pVZmkssKVOoLZL7nvpW0Q@mail.gmail.com>
 <12952304.O9o76ZdvQC@rafael.j.wysocki> <20260819173157.GB3138944@ax162>
 <CAJZ5v0jpBNEjQqbJq3hrNqCAG_TWkv8SikWB9c8i_V5xZS9Q7Q@mail.gmail.com> <20260819194039.GA3686901@ax162>
In-Reply-To: <20260819194039.GA3686901@ax162>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 19 Aug 2026 21:53:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPmwL2etkQs67u3kpyUvEwG32yGD533pDemWuwaOKn0Q@mail.gmail.com>
X-Gm-Features: AcwNN1WGoqFBVMPBqyGn_AcKYJVzOY6H73-6J-N4BlzHrn57UcmKiRWANOrKpro
Message-ID: <CAJZ5v0gPmwL2etkQs67u3kpyUvEwG32yGD533pDemWuwaOKn0Q@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 9:40=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Wed, Aug 19, 2026 at 09:00:09PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Wed, Aug 19, 2026 at 7:32=E2=80=AFPM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > >
> > > On Wed, Aug 19, 2026 at 03:55:43PM +0200, Rafael J. Wysocki wrote:
> > > > And below is one to try.
> > > >
> > > > ---
> > > >  drivers/acpi/acpi_platform.c |    7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > --- a/drivers/acpi/acpi_platform.c
> > > > +++ b/drivers/acpi/acpi_platform.c
> > > > @@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust
> > > >       for (i =3D 0; i < count; ) {
> > > >               struct resource *res =3D &resources[i];
> > > >
> > > > -             if (resource_type(new_res) !=3D resource_type(res) ||
> > > > +             /*
> > > > +              * Look for overlaps of resources of the same type th=
at
> > > > +              * would cause resource insertion to fail.
> > > > +              */
> > > > +             if (__resource_contains_unbound(new_res, res) ||
> > > > +                 resource_type(new_res) !=3D resource_type(res) ||
> > > >                   !resource_union(new_res, res, new_res)) {
> > > >                       i++;
> > > >                       continue;
> > > >
> > > >
> > > >
> > >
> > > This does not appear to resolve the probe failure for me.
> >
> > So can you please try to reverse new_res and res in the
> > __resource_contains_unbound() check in the patch and try again?
>
> Can confirm that
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index fffdd4f011b2..ea3b2e03ebae 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust_resources(str=
uct acpi_device *adev,
>         for (i =3D 0; i < count; ) {
>                 struct resource *res =3D &resources[i];
>
> -               if (resource_type(new_res) !=3D resource_type(res) ||
> +               /*
> +                * Look for overlaps of resources of the same type that
> +                * would cause resource insertion to fail.
> +                */
> +               if (__resource_contains_unbound(res, new_res) ||
> +                   resource_type(new_res) !=3D resource_type(res) ||
>                     !resource_union(new_res, res, new_res)) {
>                         i++;
>                         continue;
> --
>
> resolves the probe failure for me.

Great, thanks for testing!

I'll send a proper patch tomorrow.
