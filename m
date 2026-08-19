Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CA430CCE
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135785; cv=none; b=P96e711OEx5JJCKmWH2EZW7sXBXgaLYOUkHENhs0L7OguNbUnmkGFD8snGKAvuI+stUKF6tuWYs6VIaRLXtNOrcEVc3nEc1fdzW5FJvB26LoniVz+lbnDo0ydjHPPecQt8ckmWDrFaDJ+HeoE27tGm7KGr4GmbKAQoTxPAH5EWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135785; c=relaxed/simple;
	bh=I3Cv659lYHn1t4+35cVTlgbrLWhPT04OAsl8pKzVIoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLpJ0JDL2mytQCV/7c+Kv71xjxJKiXZNv5+eg6xSXrEA++lWZgXg8fqo5ar+9AZbG05zerMDQfjXWII37oDst5DmvkYyoeAt0VIoGqdqP+b4WA9wqYxOAb3Bh8zhI4W9OG7jMEVF9akISEIMTyQm2SF7YJmcAqf/cYnPBDcrugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmZp5YHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmZp5YHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C6E1F00AC4
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787135783;
	bh=08e/I2IqZiegXSLjlsWqyv/lRfJJZ+l5spkTfeh8lqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NmZp5YHl+KiEEtM0S3tRnf9b8ybznvqohFpr6V1zEhJ0rd5UAwKmLVtzB56d+mWFJ
	 MSRHdLsOZWQDuixR1onyLJtnV+trxsN+Gax2jxzm6og++ZU1Xvm/HKvSrLj6eWa+Wz
	 AgCZTm8U7nA+h/jcyrpAnY999pfAoUMYXX5FTglC56nMkEsJ2Co610AgQGKJN60mPU
	 OPFK9pvP1ETPazG7LoPlmFK2GXYazhy42CXbySyrtVBK0KVpWy9hKRQyFsSZtJmmNw
	 c5ru8b3NGIsQbkt16x+ciFHWAsDh7LPQCevHa2pOx/Nq8XHluuG67QBsEUR5yB20FT
	 QH9CyodOvuI7A==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39db07589caso8355141fa.2
        for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 03:36:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZovJRTq6LjLX8nhT0rnAdIb/03Ln3w/51DFOHsUbUEp3aXlJ7vFVi+71km6R1JoHhISsHhLlzuWDHlzFHoHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98Cn+M3zepa3sRPW+vBerarkm3rZ6TYLWgQFN2zHyRnWKUO3Q
	cEfIRvilND+a6E2cGFpd+0qNkCZW0wbucPVK9pzxv9jdVP6FCMYAzaKFrdsFAcO7gHnf74HkE2i
	N7H2LZIs4pbxEl+D8V7yRzGwc5uLfOqA=
X-Received: by 2002:a05:651c:a0b:b0:3a1:5cd1:9f91 with SMTP id
 38308e7fff4ca-3a18973e058mr6689411fa.1.1787135782185; Wed, 19 Aug 2026
 03:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955541.O9o76ZdvQC@rafael.j.wysocki> <20260819003752.GA3063251@ax162>
 <aoVfapu1zv8gUmG1@ashevche-desk.local>
In-Reply-To: <aoVfapu1zv8gUmG1@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 19 Aug 2026 12:35:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i7AFT-nackOXiP3j3usn5EvkhtkVYN7vmPbOV2jCodpw@mail.gmail.com>
X-Gm-Features: AcwNN1VfcixLCqhfw97jBlR5zp0-fsLIxKUvWMcI3GPv_qM5lkzXORwZmFN8mAs
Message-ID: <CAJZ5v0i7AFT-nackOXiP3j3usn5EvkhtkVYN7vmPbOV2jCodpw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 9:46=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 18, 2026 at 05:37:52PM -0700, Nathan Chancellor wrote:
> > On Fri, Aug 07, 2026 at 12:22:37PM +0200, Rafael J. Wysocki wrote:
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
> Looks like a mess in _CRS. You can share dsdt.dsl to see if the resource
> conflict is visible from there.

Well, so long as the device is defined in the DSDT.

>
> Does anything stop working?

Apparently, a driver is not probing any more ...
