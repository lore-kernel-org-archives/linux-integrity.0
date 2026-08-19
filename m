Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8D3B100A;
	Wed, 19 Aug 2026 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168444; cv=none; b=CTgYvGoXxt+dqDyY0at6xGXHuPPPBZFIZP4BcS9iEh2scil2rDqBX2urE0oMuKIm4gme0kT0LJWwD5gxcCiYeapKLimih5RVrfzTbHUM3Q1csYrw5QbbSG8HFjNB7+SQAUE1rgX3NACY+PqRIKA/5EEO1eGeZSXyEl85bwT9V5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168444; c=relaxed/simple;
	bh=U71RtYsCf0tIrLIEcgCuj/oDZe+TvsDzzKKFuun8LiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrG1WBNwf8LhQjTuyZqr9oQPstLiDjF/skSreVFDz4QpxKL22tzSpBvJ/59+gn5drwKNy1PQs1ZCPBXom6u8VgpZwStA/ooejlT/tMaJJGj1qHu6mJB4EbhoF4gvepeesGFHdyvVWb9qzHrwYTxYIn5MrUOtU/8cdOrVAw1EOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUtfD9Ll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUtfD9Ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CF41F000E9;
	Wed, 19 Aug 2026 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787168443;
	bh=rKfRBawe28Wb4AU37lQ8HR/IQhw8QCuwKZ8921fQAtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oUtfD9LlAGbedOrxQ5ukLMrMUje2wIH8eTAn8w2tDopBLvjn/QrfuiljyYE+WvFuI
	 ddo3kXWIS6AUkmORAhYARlTb7kHMKPy/AK6OSP9ixpSlbzjv9kJxQ6BibqCtB+K12L
	 3sqLD7UgiHt/A9CqqOinGsZovREiiBC6t6KydPSvkbKFoRWjna8viAWMDwRk/xT1AC
	 CTTBH/GW3a/7iel8QU7xnxU7dCmjaJnrjfUXIBVceRO2r0JxfzTmn2ZaUQ2ugjqo9b
	 yBESBCj/oee4Kz1j0hJO72JAkYAYhJHfh7iKPNdtDmjEdSn2X3lYuXOdKDoM0xEcO1
	 scLxbNvGJu2Tw==
Date: Wed, 19 Aug 2026 12:40:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Julien <julien82453@gmail.com>, jarkko@kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
Message-ID: <20260819194039.GA3686901@ax162>
References: <12955541.O9o76ZdvQC@rafael.j.wysocki>
 <CAJZ5v0j0mgTRjwrHbzTPwycuktDRahoexCdzbcNsRh7f8GKPDw@mail.gmail.com>
 <CAJZ5v0i59XtzNTepjb_hh=93E5Cy6pVZmkssKVOoLZL7nvpW0Q@mail.gmail.com>
 <12952304.O9o76ZdvQC@rafael.j.wysocki>
 <20260819173157.GB3138944@ax162>
 <CAJZ5v0jpBNEjQqbJq3hrNqCAG_TWkv8SikWB9c8i_V5xZS9Q7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jpBNEjQqbJq3hrNqCAG_TWkv8SikWB9c8i_V5xZS9Q7Q@mail.gmail.com>

On Wed, Aug 19, 2026 at 09:00:09PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Aug 19, 2026 at 7:32 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Wed, Aug 19, 2026 at 03:55:43PM +0200, Rafael J. Wysocki wrote:
> > > And below is one to try.
> > >
> > > ---
> > >  drivers/acpi/acpi_platform.c |    7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > --- a/drivers/acpi/acpi_platform.c
> > > +++ b/drivers/acpi/acpi_platform.c
> > > @@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust
> > >       for (i = 0; i < count; ) {
> > >               struct resource *res = &resources[i];
> > >
> > > -             if (resource_type(new_res) != resource_type(res) ||
> > > +             /*
> > > +              * Look for overlaps of resources of the same type that
> > > +              * would cause resource insertion to fail.
> > > +              */
> > > +             if (__resource_contains_unbound(new_res, res) ||
> > > +                 resource_type(new_res) != resource_type(res) ||
> > >                   !resource_union(new_res, res, new_res)) {
> > >                       i++;
> > >                       continue;
> > >
> > >
> > >
> >
> > This does not appear to resolve the probe failure for me.
> 
> So can you please try to reverse new_res and res in the
> __resource_contains_unbound() check in the patch and try again?

Can confirm that

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index fffdd4f011b2..ea3b2e03ebae 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
 	for (i = 0; i < count; ) {
 		struct resource *res = &resources[i];
 
-		if (resource_type(new_res) != resource_type(res) ||
+		/*
+		 * Look for overlaps of resources of the same type that
+		 * would cause resource insertion to fail.
+		 */
+		if (__resource_contains_unbound(res, new_res) ||
+		    resource_type(new_res) != resource_type(res) ||
 		    !resource_union(new_res, res, new_res)) {
 			i++;
 			continue;
--

resolves the probe failure for me.

-- 
Cheers,
Nathan
