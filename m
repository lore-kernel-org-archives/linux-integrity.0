Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBD432305
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137645; cv=none; b=FU+z6mUZyL4RgAMfsXOLERFnM0IcTe6o0wYURTaRriWD5Yp+yaslxcu0EsvWc1WrSMSivEWZ1eXpqRfR9p17fa61N/nEsqUH1S+FArG6Ww5/7SwUi9a25mUkk26EpZ93sCsdiref+JRUaYyHOF/fOD/RdM01y7DPK6p5Or2gNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137645; c=relaxed/simple;
	bh=m05T93Rv1vP5r+Ix9aeSNXtmmabXXRPjUKkLXzk0uNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3MWRU5QW3hF5iLpRh708Pytve678MVT/PxIFABeG+N1VoTAQntSTXuKCTSczGuDbJK8qgWfohFLb0VfU93/RYkqeh+ToTkr3j7kQqHBK5QeZ30e8j4MAc7TjJkc80lRnMHQJ1Rn769LtXNe6e7xNRU105E2683wv4bQRsx/MR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTjD3+I2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTjD3+I2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482B51F00A3D
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 11:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787137644;
	bh=9SMStvuXQJb5EUae02/x/ZwMVOYOdlkAvf2JMGDutD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UTjD3+I2HLCnxjWZgFaeDpthecot5bCIyo6rHUNUBngr/OTW+6mv2zq55QcFWU6ZZ
	 CXte/Qz/sqTxKu3FiuDUzkW9yaRgbfy9p56thnDbE0KQKuqdSP5Xi3rYYDRrt95NVn
	 AM+/x1fxF9tvaUSWm9etEwsW1Gc7YaiQ7ISFvYOEeMd6+jqhoN3BgUtsqUigHwM4sN
	 fLSG4i0YNLuxPksHrfXLTc0rknD+uwycKhlqctp7zbRqX00fVVpg63KFC94bFTvD/r
	 CzdRhPj3bZuyk2xoTkzIQuLoFu6XskdF/FAxhJ0oiblLDD1c5pnw364wIgfEPP5TXB
	 H1zM6xPj3Q77g==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a12ffc112cso18222991fa.0
        for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 04:07:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoN1fvwDu81EUo23gd2R+jjgwB3XNdYX/Ypzqxofp4IIoKivJHb47hDKSNcPqQi72t/8ZKErmM/tqjS+JMc010=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7lL/Q6yJslW9z/s0mErs4w0z5CHItXRx50m8mf/nXgiFMFXy
	pQ5L3CUmVbeonT2gJXNY7PUVw5U6ZxdkknP4qg+EcRf+uBM9LdmXPekbedIuZ+ZOuazmrPn7CmZ
	fBS/J4FV8Yzq5vZ00sI19hLC3kb4JBeY=
X-Received: by 2002:a2e:b8d4:0:b0:396:ade7:4153 with SMTP id
 38308e7fff4ca-3a1880c90f4mr6442811fa.0.1787137642717; Wed, 19 Aug 2026
 04:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955541.O9o76ZdvQC@rafael.j.wysocki> <20260819003752.GA3063251@ax162>
 <CAJZ5v0j0mgTRjwrHbzTPwycuktDRahoexCdzbcNsRh7f8GKPDw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j0mgTRjwrHbzTPwycuktDRahoexCdzbcNsRh7f8GKPDw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 19 Aug 2026 13:06:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i59XtzNTepjb_hh=93E5Cy6pVZmkssKVOoLZL7nvpW0Q@mail.gmail.com>
X-Gm-Features: AcwNN1WijqMSDw8R5Xc5iZqLmIb-4kkFAxYKtfLdA2XAkrOCxM2LLnNa_NvtW9Q
Message-ID: <CAJZ5v0i59XtzNTepjb_hh=93E5Cy6pVZmkssKVOoLZL7nvpW0Q@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Nathan Chancellor <nathan@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 12:18=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> Hi Nathan,
>
> On Wed, Aug 19, 2026 at 2:37=E2=80=AFAM Nathan Chancellor <nathan@kernel.=
org> wrote:
> >
> > Hi Rafael,
> >
> > On Fri, Aug 07, 2026 at 12:22:37PM +0200, Rafael J. Wysocki wrote:
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
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
> > >
> > > Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed=
 event buttons")
> > > Reported-by: Julien <julien82453@gmail.com>
> > > Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxaj=
gy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
> > > Cc: All applicable <stable@vger.kernel.org>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > I bisected the following kernel message that I see on one of my aarch64
> > test machines to this change in -next as commit f234fdaae1ca ("ACPI:
> > scan: Avoid registering platform devices with resource overlaps"):
> >
> >   arm-cmn ARMHC600:00: probe with driver arm-cmn failed with error -22
> >
> > Is this expected? If not, what information would be helpful for debuggi=
ng this?
>
> No, it is not.
>
> First, please send a boot log from the failing machine.
>
> Second, I think we may need the acpidump output from it.

So looking at the driver code, it expects to get two resources and it
is confused when it gets just one, so most likely arm_cmn_get_root()
fails.

I guess what happens is that originally one of the resources is within
the other one completely (or the creation of the platform device would
fail), which is kind of valid, so resource_overlaps() returns true for
them, and they get merged.  This means that
acpi_platform_adjust_resources() needs to look for partial overlaps
only.

I'll send a patch to adjust it later today.
