Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388743A5E88;
	Tue,  1 Sep 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268380; cv=none; b=UAkMmw6GDOozTrvmKd7rdk+lKzQUrINx1aAbKKKSO3YYtDPE6C84DilBW33TkDm/rwFOubGOaDTsPUMAA8U7iOki4ySpstMl2wDXBYvgeipEGo2hWv7ZQ2W9GjBncKf0ZBeihqLuIPAJLpjLN1gj1368Kl5b4AtdUYhGVQIqVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268380; c=relaxed/simple;
	bh=IkaYiUx72Q80uuM2q5warCzyrZ/UmVdp1thB3tmv8Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4mbtPRJVxEACfMQ952IqurCiEUoEdmzqI7F/GHBlP9ZEDRKqhOKCekVh1hb9gEIlHkD5hZiN3T9y1mmaoBw+G7sGXbgH7HLJ+91Zk6yjuCvKxJpjqgy6fSSddKTqwKgjvgbvx8upRXC+t68xBNo6lencyX5piXUnsWde1AhRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH/Ad9j3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH/Ad9j3"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 810601F000E9;
	Tue,  1 Sep 2026 13:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268379;
	bh=WMHsuprLiVDuFrd3wQe0jhMTUMV9mrWR5HqMA7UxccM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VH/Ad9j3zKZGh6/YgNK0yo0Hp6nfVA91EZ9jMycoxpt6rRI+dCizPBab+Xvbg5Csp
	 SOS2DS0cxK6UzUbrEtNvgTLtl+jXZ++HAZdei5XWKJ4SPOnADt48PwoS1ixZVd97nM
	 DINBiNV2J1YeK/mwWhepphe9eBTrEHxwx1hDA++pQi43+OzR2OgMLFDNWagxmuJrrh
	 AaPPC9rVFKo7uEgwnl7Arlz3+2qdljZLikKuTJqYcSvQaGAT1EqzYBuo6BBU3fiaT0
	 WxDcmhpxpewKLSCqSOqvye4qmVPX86zzn2h+bfc9yr1l7qtS9ImrnVFmqqMWs7sSP/
	 q0ckwk5y5Q9Ag==
Date: Tue, 1 Sep 2026 16:12:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Julien <julien82453@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-integrity@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2] ACPI: scan: Do not combine resources that overlap
 completely
Message-ID: <apbPV_tsyYVzvEVt@kernel.org>
References: <12955564.O9o76ZdvQC@rafael.j.wysocki>
 <CAJOGg3x4nMtSJeiLa2nsBFFuG4GRyvj7MbErcdOgxyuXCkr_og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJOGg3x4nMtSJeiLa2nsBFFuG4GRyvj7MbErcdOgxyuXCkr_og@mail.gmail.com>

On Sat, Aug 29, 2026 at 12:43:30AM +0200, Julien wrote:
> On Thu, Aug 20, 2026 at 9:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
> > with resource overlaps") attempted to avoid platform device registration
> > errors due to overlaps of resources of the same type returned by the
> > same _CRS object in the ACPI tables.  It did that by combining two or
> > more overlapping resources into one, but it went too far and also
> > caused resources that overlap completely to be combined which broke
> > the arm-cmn driver that expects two MMIO resources to be present for
> > each device it binds to and it expects those two resources to overlap
> > completely.
> >
> > Address this issue by adding checks for completely overlapping
> > resources to acpi_platform_adjust_resources() and add a comment
> > explaining what is done there.
> >
> > Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices with resource overlaps")
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@ax162/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    * It is better to check for complete overlaps both ways as suggested
> >      by Sashiko.
> >
> > @Julien: I would appreciate testing this on the machine that needed
> > commit f234fdaae1ca.
> >
> > ---
> >  drivers/acpi/acpi_platform.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -85,7 +85,13 @@ static unsigned int acpi_platform_adjust
> >         for (i = 0; i < count; ) {
> >                 struct resource *res = &resources[i];
> >
> > -               if (resource_type(new_res) != resource_type(res) ||
> > +               /*
> > +                * Look for overlaps of resources of the same type that would
> > +                * cause resource insertion to fail down the road.
> > +                */
> > +               if (__resource_contains_unbound(res, new_res) ||
> > +                   __resource_contains_unbound(new_res, res) ||
> > +                   resource_type(new_res) != resource_type(res) ||
> >                     !resource_union(new_res, res, new_res)) {
> >                         i++;
> >                         continue;
> >
> >
> >
> 
> I have tested this on commit 1b78070aaef6. It seems the patch is
> already included in it.
> 
> TPM device still works. Here are the logs.
> acpi MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded due to overlap
> tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout
> 
> If in the future if I need to make tests again, should I do them on
> the Linus Torvalds' branch?

What was the hardware where this happens?

Sorry, if I've ignored it (if it was mentioned previously).

BR, Jarkko
