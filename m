Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CE379EFF
	for <linux-integrity@vger.kernel.org>; Fri, 21 Aug 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311936; cv=none; b=VR1foPdAtxxtlpehGmCk42uQCoL/q37UH7ruGYy9TS+zuIxzWtsEApfMmClOURln5tAmfRZaWfE4tPAyWv2D5ezW3rhkx0yZLf1xum4K5XuwdHBFQXyMEtcDroktZEIVLyxwzv+0xNEsyUK918MIP2AvIetQYZGVO1ciB7mnjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311936; c=relaxed/simple;
	bh=l/B+Md1W1jiZxRBO5PV+SOyAVru4gPNS253mLqdvSK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUKed2VCpjcbqXsqlGT1WJ59HWD1GlsO+7BlXDAA7w6rvnOd88QjjYKfvRZbNB67NqULSlh/ltOZBQ6ft689iueLRZu2bTWRhI4KeclakURhrsWMI8Vo1N/CrjQtxn4a9YTr5wv1shOozojYxDDnlxRIjqFbKUh7y1cLafm6vXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdEMJ4LD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdEMJ4LD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E071F00ACF
	for <linux-integrity@vger.kernel.org>; Fri, 21 Aug 2026 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787311935;
	bh=AEcGi7SmslsDrHx9u5V+f5rOPm6DBZ+8VubAfvuWq3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IdEMJ4LDdXBgMlLWteXIwUZJzVSUTQIHQe6focJ1xL3BBdrdWZ8tPCW8e2jd4Jwmw
	 g2jXsBq1n/Zufyrb18hefM/3Mf5V3qP8Mo9776C0cGUgqIrmZ4w2tnYxzc6KJ8s/J2
	 yvtFJK0jiTef78A801NJCXJZQLHhmPtDKHTZyldaVZg421a+GpLPOHZZ4/48Vcl4Ay
	 kAizT1IS/ghC0G2BAjUXwSQiEq3WRZ1vmWEMBtTVvudo7ZOedgYAkI4kFFdCmI7n5T
	 i3yBRNuLQUmZTy0QTIpsmoyt0rNuOtAl0O61Gy0eh0FTV0Dk0PFaagdDBug9cvBA3A
	 KnW01npQ+22BQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b00d083818so2116937e87.1
        for <linux-integrity@vger.kernel.org>; Fri, 21 Aug 2026 04:32:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqtN6JS2aATpom3m0VHsgolsDRVH+aPh0+F3xYp7ZZKHo0qPRxrk+NU4tRKg9Ucp78dsDToRvEDYDsamkqJTZA=@vger.kernel.org
X-Gm-Message-State: AFuF++kXPZqFTH680ojjZdDzyQXivgoHPuHgQg9s+rmd0unnGqVZ+SdO
	Ux9xWVk0ZBTY+yQjfLT/Juqf/lYMzpS0OAA1ss0okhPbPYWTlPgwXHbMcVWXeDPkK/3WyGmH7iL
	0KBqEPJnO4r6gVP9U4oltafmca1r5bSw=
X-Received: by 2002:a05:6512:3d0d:b0:5ad:68aa:8a78 with SMTP id
 2adb3069b0e04-5b47d4c95a6mr3379111e87.5.1787311933534; Fri, 21 Aug 2026
 04:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12956979.O9o76ZdvQC@rafael.j.wysocki> <aoeojDfTngzP1Eku@kernel.org>
In-Reply-To: <aoeojDfTngzP1Eku@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 21 Aug 2026 13:31:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gE_7T9=20qG6+YZp-9Q9FRcUtgbi5h+2axzp_xaZEyXA@mail.gmail.com>
X-Gm-Features: AcwNN1UAxC4YxFmLKTw5USh-GVvkygTQq5R5KEwZH81RzR2X_j9xUYvsQ6WVsHo
Message-ID: <CAJZ5v0gE_7T9=20qG6+YZp-9Q9FRcUtgbi5h+2axzp_xaZEyXA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: scan: Do not combine resources that overlap completely
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	linux-integrity@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 3:23=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Thu, Aug 20, 2026 at 12:50:46PM +0200, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
> > with resource overlaps") attempted to avoid platform device registratio=
n
> > errors due to overlaps of resources of the same type returned by the
> > same _CRS object in the ACPI tables.  It did that by combining two or
> > more overlapping resources into one, but it went too far and also
> > caused resources that overlap completely to be combined which broke
> > the arm-cmn driver that expects two MMIO resources to be present for
> > each device it binds to and it expects those two resources to overlap
> > completely.
> >
> > Address this issue by adding a check for completely overlapping
> > resources to acpi_platform_adjust_resources() and add a comment
> > explaining what is done there.
> >
> > Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices wi=
th resource overlaps")
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@ax1=
62/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > @Julien: I would appreciate testing this on the machine that needed
> > commit f234fdaae1ca.
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
> > +              * Look for overlaps of resources of the same type that w=
ould
> > +              * cause resource insertion to fail down the road.
> > +              */
> > +             if (__resource_contains_unbound(res, new_res) ||
> > +                 resource_type(new_res) !=3D resource_type(res) ||
> >                   !resource_union(new_res, res, new_res)) {
> >                       i++;
> >                       continue;
> >
> >
> >
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks!

I'm assuming that the tag also applies to the v2 of the patch

https://lore.kernel.org/linux-acpi/12955564.O9o76ZdvQC@rafael.j.wysocki/

so please let me know if that's not the case.
