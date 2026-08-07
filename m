Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B671402BB7
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097373; cv=none; b=ot8BOfuf4PtH3DrjfWUMltKHcl9yY3Uux8o1lEmZe4v8/goUcVf8nfDJDItERdPJxSX7TGwfnu2VqhJOxAu5wc3fmM+pEYQkWAN7KOFciFkXnlX2F1YpqIKHNSDxbKphrqC74a6VEWdVM2/bF7Vqm9Yz6VcaQkUVjH2cvvP4Ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097373; c=relaxed/simple;
	bh=eL9xxqWbBg6E1WKF33aoZKa8LWkNPqJ1EXzpVemKlIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzDNun8JbsaqYOjz+miIjJGlFH/UN9NLGmluHzpQFDz/WzCqIEsTOrCmwAwn4o6cSfNlPepKnhMq9z4I4rBMfFrD1rVPYwNC/WkaTqDYkaMsVumHdvJ/cZeYKQ4j1GdMs+Fr7AzIb1rcLAmBSN6zERo1lWo2bUX5Mw4mqZcxaYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3ym32t1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3ym32t1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126331F000E9
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786097372;
	bh=uitpwh1mGW8+nPuJWZff+672WHHW7Gcl+UbWcDtBwqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c3ym32t1dSLlIulo6Hvdn4Hl7XcymCFywvJcs9RCY7SnqvI496n8PkGMsLnIOqcx/
	 9baMp7u/xvy2EFI0OR/+657RnP7Hky0JSw4mTnIukmZo+HsZGKZY4OQ48UCnam2lQ6
	 JJxlUWmYBLSRYLKiIqYRKnW4D0jEdWsrQuiDi0LJo1RIetI9Nj/zsj2RqBGPqx+bwa
	 tpATx2SEmwhXoVAawluukyH6VQwUypsWishE5W5cxzXXG0TQwuIYvo/XqclCmAUMSa
	 oCVLVv/7N1nDzuX4ahdutiRSwulRfaLRzByDQyKEovWoFPb9i3uAhNSHSSjgXecSGr
	 OVIcIUfqRDIPw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b29599b81cso4061062e87.1
        for <linux-integrity@vger.kernel.org>; Fri, 07 Aug 2026 03:09:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqKhGvf40aI9rSyuUsxw/ZhEdci+FcpTXSpRbyZdAGN9rP63YmLyviOAQTdgmOxUrUz5d2nAztMR+cRFeNtmL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6ytHtPNHWSoEOpdaqWNgTroQh2Jlcm4WmJmKrz8mJxtIymvg
	NZ15+vRr9AU53Mr3b54KmA0yN4k25k73IgOukMa4fDTiLw0nQOJ6wVU6kiNu1kabt+mlRS5qvlK
	jHxLV9ax6dQyCIgXihGVe+hGlbhGQLVk=
X-Received: by 2002:a05:6512:6889:20b0:5ae:a0b4:5013 with SMTP id
 2adb3069b0e04-5b2f4affbe8mr2104923e87.0.1786097370509; Fri, 07 Aug 2026
 03:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12954206.O9o76ZdvQC@rafael.j.wysocki> <anT7YdW6b-uYwgK0@ashevche-desk.local>
 <CAJZ5v0g8nosruRFaW0=3a9dn5CgN0jAnWVxo5G8mUO07-ySbEQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g8nosruRFaW0=3a9dn5CgN0jAnWVxo5G8mUO07-ySbEQ@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 12:09:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g7nN7CKLG0h4okyWV83aR6yN-rc6gr5RGMEsSyg6FadQ@mail.gmail.com>
X-Gm-Features: AUfX_mxd_RhYngDC3ZGKgBP9hAms01CXF3nV1yld3cDCH-dmBmbK4bP87anMM_o
Message-ID: <CAJZ5v0g7nN7CKLG0h4okyWV83aR6yN-rc6gr5RGMEsSyg6FadQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:55=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 11:23=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Aug 06, 2026 at 09:28:03PM +0200, Rafael J. Wysocki wrote:
> >
> > > If acpi_dev_get_resources() returns overlapping I/O or memory resourc=
es,
> > > the subsequent registration of a platform device will fail with -EBUS=
Y
> > > due to a resource conflict.  This is reported to happen on Acer Aspir=
e
> > > ES1-572 [1].
> > >
> > > Avoid that by adjusting resources returned by acpi_dev_get_resources(=
)
> > > to eliminate partial overlaps between them.
> > >
> > > This has not been regarded as necessary before because putting
> > > overlapping resources into the _CRS of one device is really pointless=
,
> > > but now that the issue has been reported to actually happen in the
> > > field, it needs to be done.
> >
> > ...
> >
> > > +static unsigned int acpi_platform_adjust_resources(struct acpi_devic=
e *adev,
> > > +                                                struct resource *new=
_res,
> > > +                                                struct resource *res=
ources,
> > > +                                                unsigned int count)
> > > +{
> > > +     unsigned int i;
> > > +
> > > +     if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
> > > +             return count;
> > > +
> > > +     for (i =3D 0; i < count; ) {
> > > +             struct resource *res =3D &resources[i];
> > > +
> > > +             if (resource_type(new_res) !=3D resource_type(res) ||
> > > +                 !resource_overlaps(new_res, res)) {
> > > +                     i++;
> > > +                     continue;
> > > +             }
> > > +
> > > +             dev_info(&adev->dev, "Adjusting %pR for %pR\n", new_res=
, res);
> > > +             /*
> > > +              * Extend the new resource to include the one that has =
been processed
> > > +              * already.
> > > +              */
> > > +             if (res->start < new_res->start)
> > > +                     new_res->start =3D res->start;
> > > +
> > > +             if (res->end > new_res->end)
> > > +                     new_res->end =3D res->end;
> >
> > Can we use resource_union() instead?
>
> Not really.

Or maybe.

Let me see if this works.
