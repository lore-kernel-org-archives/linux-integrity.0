Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89B435A9C
	for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535951; cv=none; b=B6DQlr+AqC2ytrDJGNkCZa8S8dtVq6KhcHULuV6BIB85Pka038zL7M4X4gqFKdbwvxZWZI5F0B62idyKSKw6Am7iJ8EMQDAjrnSjjfves24Umew8pmF16rRDlRdYwxrKotH6nOGkhZ26v0/zVlA7/LUeSZQQinzFzXRIF30GpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535951; c=relaxed/simple;
	bh=F+vfx/bAWod4tYvm8iYy+q4HPwUzzfnyWHXSyTbqXSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/DAVQU7qYFiydksh0CEpKwBV7gNbOjoktTzusZQwW28hsjfJdluFGLRBE8UjFoGp4XutvWc8WeQIeIQYy0wqIfBOghSz6QZQP4z2Vqs/zMxiel8cPDBziS8t7w7dWr1kuo3bv9fpY8b35hXzmMnZkyeDpRMZA39YPzLpIpU2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMBMHzgm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMBMHzgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A0F1F00A3D
	for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 11:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786535948;
	bh=VCQrrHOG8+geTdGCt+xFXYgWr/4kPLkDFpaLPXVMqAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hMBMHzgmWP5beDkzpRG577uYN/vnzEsEQ+ucGbLHcwfhNi1TzFbVXlYqUH4SfQFqA
	 0NksVr+QU+8V8VSfn38AE70Fha/MeGV/eTMbBmIU0SVEt4YC5o6S1050OzcvWRJ8qc
	 Dkhf3rhug78UGzxAcIWCspFjBU+ysl1kxkM5oup4/uw/T59HWUb9XR9VWLPxyUjwD6
	 CDRPXKyJF1HEbVadVGysyAIbEe3kxmbkPPFTfN6DY/P30D8GbTd0zb3VGHslUIMHLa
	 42GDv0zn6X1r9TFsJIRbY+VtBxEg7Zcu4A6/FMFu7ul40lQSTNPmiDu19TpKnobixB
	 woQOGhJlF8CvQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b01cb18515so737140e87.2
        for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 04:59:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrsU8rTtyRzDnAUj3HxJ3KwS2aOwxAXFJEAK8zI7I7mtyPOrdrc+LTEu3fu9vVWprpsfVEyCnozBK78VAT2D4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pc47GXLZcsS4kGIc+/d4Tb536Y6tBCL/ahR4plKki7Xo4qRc
	oE3ByXb5JUzvFHvXrBOJtdtcKuzcD+yXdY48JxnP7pzUywKbs2wDe+oH4oBj1BI6LmTregU04qP
	YRgOtoP4T//2K2H5Y4+MOdVn9/hwCAj8=
X-Received: by 2002:ac2:5dd2:0:b0:5ae:b75e:454d with SMTP id
 2adb3069b0e04-5b44e31f627mr501528e87.45.1786535947393; Wed, 12 Aug 2026
 04:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955541.O9o76ZdvQC@rafael.j.wysocki> <annvyrUCmqOxW7-o@kernel.org>
In-Reply-To: <annvyrUCmqOxW7-o@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 12 Aug 2026 13:58:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hrVwZYb6gHXmtGfZ9A+OA=_F4pzET=5mrb6qBF0nbGSA@mail.gmail.com>
X-Gm-Features: AUfX_mwXkn2NBFpe3-NHBBjXTDgMmsxfCDLkDeAEVQGlpLo6Jxk25CeLt0dLxAQ
Message-ID: <CAJZ5v0hrVwZYb6gHXmtGfZ9A+OA=_F4pzET=5mrb6qBF0nbGSA@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:35=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Fri, Aug 07, 2026 at 12:22:37PM +0200, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
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
> >    * Use resource_union() and adjust code and comment (Andy)
> >    * Include ioport.h directly
> >
> > v1 -> v2:
> >    * Add the expanded resource instead of and not in addition to the ot=
her
> >      overlapping one (Sashiko)
> >
> > ---
> >  drivers/acpi/acpi_platform.c |   39 ++++++++++++++++++++++++++++++++++=
+++--
> >  1 file changed, 37 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/bits.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> > +#include <linux/ioport.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/dma-mapping.h>
> > @@ -71,6 +72,36 @@ static struct notifier_block acpi_platfo
> >       .notifier_call =3D acpi_platform_device_remove_notify,
> >  };
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
> >  static void acpi_platform_fill_resource(struct acpi_device *adev,
> >       const struct resource *src, struct resource *dest)
> >  {
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
> >
> >
> >
>
> Applied to my tree I'll just run some tests.

Well, I've applied it too because I have material that depends on it.

I guess it won't be a big deal if it goes in from two different places.
