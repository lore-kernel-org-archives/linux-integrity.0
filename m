Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D03F6C5F
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096524; cv=none; b=db6IjSwwc5HeGbCu7UG+3qnoKPA9BVMitN4ofFbW0PQF5zgbnjBOsJfSbUFXvr3ILJOi6RDX+lGelKf2QqMPHR9RcUPLI10I/5ll+gwv/FuUObcIVfoEccvskVMhGte3k6rD12twY8jPh8f/z5lC+m64/YOlPTTak9t+4IP53O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096524; c=relaxed/simple;
	bh=pAMShBbeL/LXeK6LYx/7OUn4ao0TfEwcnJJteDvjFw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O66qKj7NrOcxKmcvNN7FatppyiZ+L+h2QjJrVMTZmrxV7i7WxUp/hLgjcdtMY3jOlvVWVwlEh5tra8BJH/UE3aMteRjv4kOKPk31+zQnB3aJMf7U5JRYrG9qZxmeCSv5WIXHleEKs2H3WT723uj+L1JzKI/vBqxQ1qx8h74zcfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtTvZoIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtTvZoIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8401F00A3E
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096519;
	bh=ajbcmwetteag6axiqXY+j1rrylv2rbkrWGVfqCPIim0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NtTvZoIRm0Mvya1w4mVnhPHV2WQsDl+vV8wFmgFDSSE2fNTPtSWbeiWP3Q18dl+n6
	 vsvtImnmTojewGmH187qiEMI/kqA5V3GwlFY8kz+zrCDLJYbGl3/0WHJEZQCnj2Yec
	 xzEvVCUajtIcmG6yRg12KCo4cnExzzBwRxPtQxBBTydyDF8ui1Upzvnof6pf+DelLB
	 JYYAKSpFpy+d3nSswBl7HYEgi/iwwWzyIATFvznacpBlmY3PxfixVXmWavUGIKMCJB
	 64RSJRsuHtHfAw1Zktldly0nXR7cel5nx2n6gD/hrScqf6QOR/LMlysjwKuiF/Feyi
	 1rs3nTRKp9t3Q==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39f1ac13687so21285551fa.0
        for <linux-integrity@vger.kernel.org>; Fri, 07 Aug 2026 02:55:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoGMPAetjOJJATHYxWpiDBY1mWXOByocw8UX6wLyEfxx/dZrf/OwpN9JcAWAhRzly28zsLCgHvaKto7f8rgzZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lVCJZqNqugtYMvEik4rhAqXAs/GLjDnz+s/aHJxbIPCflIhH
	+oso22C1qzBxzM7fSuN/VPjV2mpNgHX3gPHiOk4LyAflknUgvAx4hCeGDurJQ7ZDWMeqMxLQn1J
	6hJ5ZosDmNX8OmhfO8VJCbe5JzfZCWCQ=
X-Received: by 2002:a2e:be94:0:b0:39d:ba1e:aaf4 with SMTP id
 38308e7fff4ca-39fd687d311mr8492761fa.24.1786096517738; Fri, 07 Aug 2026
 02:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12954206.O9o76ZdvQC@rafael.j.wysocki> <anT7YdW6b-uYwgK0@ashevche-desk.local>
In-Reply-To: <anT7YdW6b-uYwgK0@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 11:55:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8nosruRFaW0=3a9dn5CgN0jAnWVxo5G8mUO07-ySbEQ@mail.gmail.com>
X-Gm-Features: AUfX_mzK6Z3ez91JktrWRbYQHB8bAxrRih24jOI-J5c8nTSfIS6eODpaeg1qk9M
Message-ID: <CAJZ5v0g8nosruRFaW0=3a9dn5CgN0jAnWVxo5G8mUO07-ySbEQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 06, 2026 at 09:28:03PM +0200, Rafael J. Wysocki wrote:
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
> > +             return count;
> > +
> > +     for (i =3D 0; i < count; ) {
> > +             struct resource *res =3D &resources[i];
> > +
> > +             if (resource_type(new_res) !=3D resource_type(res) ||
> > +                 !resource_overlaps(new_res, res)) {
> > +                     i++;
> > +                     continue;
> > +             }
> > +
> > +             dev_info(&adev->dev, "Adjusting %pR for %pR\n", new_res, =
res);
> > +             /*
> > +              * Extend the new resource to include the one that has be=
en processed
> > +              * already.
> > +              */
> > +             if (res->start < new_res->start)
> > +                     new_res->start =3D res->start;
> > +
> > +             if (res->end > new_res->end)
> > +                     new_res->end =3D res->end;
>
> Can we use resource_union() instead?

Not really.

> > +             /*
> > +              * Eliminate the previously processed resource that has
> > +              * triggered the adjustment because it is not necessary a=
ny
> > +              * more.
> > +              */
> > +             memmove(res, res + 1, (--count - i) * sizeof(*res));
> > +     }
> > +
> > +     return count;
> > +}
>
> --
