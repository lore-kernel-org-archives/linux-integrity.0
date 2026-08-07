Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9C3A2E36
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109486; cv=none; b=t6y48P/Yz3I6tuTe8km1o0fEV7QTQlqN/ZPaFUPYz1O6cf/oJC7KyHGWqjgn84fqstMRR+3kpazdUe1ano3mII+89yawsNpjNnW56guxlAOYdMMytkL7yb2yELsmqeLj9kAhXrTVNyRydLjfREKi4bODbK7u6tFhpli+dGF2FuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109486; c=relaxed/simple;
	bh=8eHFgMRs/ojHMFsHb9GihM4x8eJHiOPzVolhkdcd3tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlVV/uvdYDrSReFCjP63QHO6MDDJcBB7vfQ/9H/mgjKSugWJmCtfV3AQura3fFJ/NNg1HSmMQ1bmGzHvdjhcYKPxpP2uZpF+ChA9Fyh0zpCe0J7FOS/n5COXhg5/uJItGYYqfHXx9P9lEDaJsohyzniV1ofEAQ+I2idiLxL4xFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWYWeE5U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWYWeE5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8C31F00A3F
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786109476;
	bh=cr3uXUWw48oClM6s029WaH/arJdaHlup4jHlPrjw/Ho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WWYWeE5Urqipj9WvxNsF/cwMXasK60WieBhduENLM9Xp98M+aVe6iL56kD4lpZ2om
	 2TmkcGk5GDFYheXzraRLdenoXaNLhiLAI74MJZ3F3hkaAKzpFuISLkXcnrC5CrLNdE
	 +3WuTkwpReZ/P/XhJt3SmbbTsaHpC7+FQ1LX5QiSraxEbLZ5omOu5xLO64eVofTxE0
	 hRFe/uK/qea3KC8otxEaVoYk1Z0M3yhjtCBKDeeTHi7VY4V1h/OrJWS25Qly5MuSPK
	 M6l1n3ko23AaIHgrn3prPz+mzZti6PXj0s1xND17xtEJ2TB00LP4qBoAeNyq6lEpck
	 bvP+Qt33vrB0g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so2581398e87.1
        for <linux-integrity@vger.kernel.org>; Fri, 07 Aug 2026 06:31:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpD9mZbSIgn3dkIp/DwF20chKD7gOPnNM8u6VTvF5FqrDOr6qOSX6D6buUPYcjr3/klE/R7oA2PgaImv4p1ZeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH86BhWaJCMqT7DzD/OVd1g6ZY8CGzp6BjQ5qOBjHTQwDkjeBC
	8uElys+QhRJLWIIBNHgkf4hiloWBKK8D7H0wORzusAOpr/4n2TNGBLxObn9BiGfpu3GIBFvG/fh
	RxSzBYKAa4Z0khqFWiQx4iOpK7r5Peas=
X-Received: by 2002:a05:6512:6186:b0:5b0:1108:c58b with SMTP id
 2adb3069b0e04-5b3023cfe15mr2082055e87.15.1786109474938; Fri, 07 Aug 2026
 06:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955541.O9o76ZdvQC@rafael.j.wysocki> <c159e25b-379a-4e0d-b284-f68bcbb09c7d@molgen.mpg.de>
In-Reply-To: <c159e25b-379a-4e0d-b284-f68bcbb09c7d@molgen.mpg.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 15:31:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gvsnEn-ZgavT6YrWUO1GOWAri7fnT5i1KpEtdEVWSTBw@mail.gmail.com>
X-Gm-Features: AUfX_myAC2MiU57iWZ5wRgf4FuA0nrTMdzC-Pn5OmaWyEgAtqXEucqFd6Qb6_W0
Message-ID: <CAJZ5v0gvsnEn-ZgavT6YrWUO1GOWAri7fnT5i1KpEtdEVWSTBw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, julien82453@gmail.com, jarkko@kernel.org, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:57=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Rafael,
>
>
> Thank you for the patch.
>
> Am 07.08.26 um 12:22 schrieb Rafael J. Wysocki:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > If acpi_dev_get_resources() returns overlapping I/O or memory resources=
,
> > the subsequent registration of a platform device will fail with -EBUSY
> > due to a resource conflict.  This is reported to happen on Acer Aspire
> > ES1-572 [1].
>
> Reading the diff, it might be useful to paste the log warning already her=
e:
>
>      tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout

It's there in the message pointed to by the Closes: tag though.

> > Avoid that by adjusting resources returned by acpi_dev_get_resources()
> > to eliminate partial overlaps between them.
> >
> > This has not been regarded as necessary before because putting
> > overlapping resources into the _CRS of one device is really pointless,
> > but now that the issue has been reported to actually happen in the
> > field, it needs to be done.
> >
> > Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed e=
vent buttons")
> > Reported-by: Julien <julien82453@gmail.com>
> > Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy=
8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3:
> >     * Use resource_union() and adjust code and comment (Andy)
> >     * Include ioport.h directly
> >
> > v1 -> v2:
> >     * Add the expanded resource instead of and not in addition to the o=
ther
> >       overlapping one (Sashiko)
> >
> > ---
> >   drivers/acpi/acpi_platform.c |   39 +++++++++++++++++++++++++++++++++=
++++--
> >   1 file changed, 37 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/bits.h>
> >   #include <linux/device.h>
> >   #include <linux/err.h>
> > +#include <linux/ioport.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/dma-mapping.h>
> > @@ -71,6 +72,36 @@ static struct notifier_block acpi_platfo
> >       .notifier_call =3D acpi_platform_device_remove_notify,
> >   };
> >
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
> > +                 !resource_union(new_res, res, new_res)) {
> > +                     i++;
> > +                     continue;
> > +             }
> > +
> > +             dev_info(&adev->dev, "%pR expanded to avoid overlap\n", n=
ew_res);
>
> Maybe more normal user understandable:
>
>      %pR expanded to fit all resources to avoid overlap

What about "expanded due to overlap"?  I'd prefer it to be shorter
because the resource printout takes up some message space already.

> For the record, Julian reported that now the lines below are logged:
>
>      MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded to avoid overlap
>      tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout

Right, and the second one comes from the driver binding to the device.

> > +             /*
> > +              * Eliminate the previously processed resource that overl=
apped
> > +              * with the new one because it is not necessary any more.
> > +              */
> > +             memmove(res, res + 1, (--count - i) * sizeof(*res));
> > +     }
> > +
> > +     return count;
> > +}
> > +
> >   static void acpi_platform_fill_resource(struct acpi_device *adev,
> >       const struct resource *src, struct resource *dest)
> >   {
> > @@ -151,10 +182,14 @@ struct platform_device *acpi_create_plat
> >                               return ERR_PTR(-ENOMEM);
> >                       }
> >                       count =3D 0;
> > -                     list_for_each_entry(rentry, &resource_list, node)
> > +                     list_for_each_entry(rentry, &resource_list, node)=
 {
> > +                             count =3D acpi_platform_adjust_resources(=
adev,
> > +                                                                    re=
ntry->res,
> > +                                                                    re=
sources,
> > +                                                                    co=
unt);
> >                               acpi_platform_fill_resource(adev, rentry-=
>res,
> >                                                           &resources[co=
unt++]);
> > -
> > +                     }
> >                       acpi_dev_free_resource_list(&resource_list);
> >               }
> >       }
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thank you!
