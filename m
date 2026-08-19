Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA81455161
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134765; cv=none; b=F1LNtviWULJ2fkjcxpFbcWNkyBufGcwe0WDBhKB1vEiUIddJpU39LuJgCtWMqgPyIDbEC+Xwd7X7H5drbAD1pX/rHwpcNMpU0ss7tQMsEmvLMqk/ixVhnH13rfNhY9xPGN57nYALo5Q1K/Finw9UeRWT+mhMEpz1ylGIBsD0LM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134765; c=relaxed/simple;
	bh=ezAQgcfpty6rQZcFbSEnOKREefmHBWAn5dLSUAH+8kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuk7UbbgJvRrj7A53lmMBGTNxrabvF/HgMv100jFxjol+TUJ9qW4L8bJKWzlTPpdr3O2En8Wf9D1iOOVhDVuAWijZjvWh7mihuhyMs6BBCPaLD74RtH+EG1zTA65jasDUpV47yBBkf7PIAy/GMO3geMc6W01D/7LYEhrezhUbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK8kXHcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK8kXHcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E461F00ACF
	for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 10:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787134763;
	bh=Dui/XpE1nkZGrWlULtEiu5x4VGETHu4ZzmEusfW+p/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EK8kXHclbEwObriminlZCOQ+okWWKHYCo3FsrERoyhTOWm3Lfl51UwyZT9MnMtA26
	 r5v3w/wq+OJiXKQpftAxTtP5R3akeao3w5fC5zQSCfd/BBfdeya+BBHkGx7ZYmXgtK
	 6fLpA3v+vB58Y6Z73TIT7TNqsdqRSy6E6Lf7UJo0FCiZOA210RKthwD32a5KzEByGP
	 Y9ocw76sQWBZh5Hhk1OkJJSICOyjQ1JhjhQCvVtOb8VyZFGsye/vB5s50nd078r8N0
	 +RuohMgkG8A2rcYcMUocc+1RSFPs+6wNsP4JcT3Z9RVTfOdy9g9NlS3WuxBUwg0+Lp
	 CNXmP1JjA2HRg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39f927721f2so6133901fa.0
        for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2026 03:19:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrsAkVyX3yGYilnACzJWpcvB49fDbIthdaFOyQnc1ciHaOTBkuOZRMLtGQ6dN4gnTyRh/983zxTjp+7kaaDW6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJB1YsrMEiOA8sGutZP4+B/XdLKgkDAtz6pOWX1Kb2PHy5VJD
	WvHskhpN4pnKhfX0QjoJ/RvEcYYKol8BvfM32EW41MJzaDIHnPykJ4r+EwlL46UT5nOqqwiGUcS
	qVFdLIQ3kSp9xX9Ysm6exqqNncSyMyd0=
X-Received: by 2002:a05:651c:b24:b0:3a1:30c4:d95 with SMTP id
 38308e7fff4ca-3a18974b1bamr7979881fa.5.1787134762304; Wed, 19 Aug 2026
 03:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955541.O9o76ZdvQC@rafael.j.wysocki> <20260819003752.GA3063251@ax162>
In-Reply-To: <20260819003752.GA3063251@ax162>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 19 Aug 2026 12:18:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j0mgTRjwrHbzTPwycuktDRahoexCdzbcNsRh7f8GKPDw@mail.gmail.com>
X-Gm-Features: AcwNN1Xs4Z70NNmyWdp29r-zj5lDZTzseHDuFrydz95gXaIR-tArVdDEosJr7VM
Message-ID: <CAJZ5v0j0mgTRjwrHbzTPwycuktDRahoexCdzbcNsRh7f8GKPDw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Wed, Aug 19, 2026 at 2:37=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Rafael,
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
>
> I bisected the following kernel message that I see on one of my aarch64
> test machines to this change in -next as commit f234fdaae1ca ("ACPI:
> scan: Avoid registering platform devices with resource overlaps"):
>
>   arm-cmn ARMHC600:00: probe with driver arm-cmn failed with error -22
>
> Is this expected? If not, what information would be helpful for debugging=
 this?

No, it is not.

First, please send a boot log from the failing machine.

Second, I think we may need the acpidump output from it.
