Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B913AFAED;
	Wed, 19 Aug 2026 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147750; cv=none; b=Ujj0Pp/6TNwUREk81qF1v0CEpSh4aXjU7PlMbZ8ucjYfTPO4osACmcDW/K0I7GIXgGr2zLqNuC7cjnmrYOfJHJUdim7G/dgVdt+YetolObjQ0pc+Y3P60+keEY7hnIFhTjEbV67tIsfeUR21f8J9gItmSRqZDRVArXJUwLk2GHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147750; c=relaxed/simple;
	bh=i1sWUAp5nUBwkDAC+9rZ+YjSM8HTwrXiTDFAujrlt/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhtlSrIoGWovDoMjYl6r3QLWdw/fQEI9M6W+ENDxXo/aQ3rGt+RI9s3Toy68uSSKGYf7YzThfPfRxbY1M3mEO5tVVNnq4Wl/hOLmRo80u59/mrsE2gKMi5R0hNWEFFLKCJ62tz9LPeKT3PpkN5XRXQrp7MxpnBHy3orXcrIu04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogAqz/5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogAqz/5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2F51F000E9;
	Wed, 19 Aug 2026 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787147747;
	bh=XXPEaKaBCmUIc2gdcMgX8u1uAE9AEIpvboFwez8gU/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ogAqz/5ffmAPIuLzcnKD/7gKDT2V4jWxRrmzyPnjglAPFfNLMR8xHithP1IY7JhsN
	 Xc8lt+rs8TMu+rSoqYh0CYlT94UY1NRSaw8ERllE8uekT6+LZeMdxv2dQs+cJAJAEY
	 3XwZ/kWFS7C6dO1g0WKf2UcY5PzCUjwa5ZcqUwcf70NF4kbIt3yLoKJjNnvWesHZuJ
	 a5g+kXgb/9YyM0AWu81zSSPAqHvQzozeXWs3VLwsw0jLejAtHzmXCkTAk7pQcRVEQS
	 x29zlVZqzHlaLFC5UCN3zjYEAF+/lJwo2gj9KghBJdiY64stvPpqFbSMBksgd2zR1Q
	 TBs6lV58bA3wA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Julien <julien82453@gmail.com>, jarkko@kernel.org,
 linux-integrity@vger.kernel.org
Subject:
 Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with resource
 overlaps
Date: Wed, 19 Aug 2026 15:55:43 +0200
Message-ID: <12952304.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To:
 <CAJZ5v0i59XtzNTepjb_hh=93E5Cy6pVZmkssKVOoLZL7nvpW0Q@mail.gmail.com>
References:
 <12955541.O9o76ZdvQC@rafael.j.wysocki>
 <CAJZ5v0j0mgTRjwrHbzTPwycuktDRahoexCdzbcNsRh7f8GKPDw@mail.gmail.com>
 <CAJZ5v0i59XtzNTepjb_hh=93E5Cy6pVZmkssKVOoLZL7nvpW0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, August 19, 2026 1:06:50 PM CEST Rafael J. Wysocki (Intel) wro=
te:
> On Wed, Aug 19, 2026 at 12:18=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > Hi Nathan,
> >
> > On Wed, Aug 19, 2026 at 2:37=E2=80=AFAM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Fri, Aug 07, 2026 at 12:22:37PM +0200, Rafael J. Wysocki wrote:
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > >
> > > > If acpi_dev_get_resources() returns overlapping I/O or memory resou=
rces,
> > > > the subsequent registration of a platform device will fail with -EB=
USY
> > > > due to a resource conflict.  This is reported to happen on Acer Asp=
ire
> > > > ES1-572 [1].
> > > >
> > > > Avoid that by adjusting resources returned by acpi_dev_get_resource=
s()
> > > > to eliminate partial overlaps between them.
> > > >
> > > > This has not been regarded as necessary before because putting
> > > > overlapping resources into the _CRS of one device is really pointle=
ss,
> > > > but now that the issue has been reported to actually happen in the
> > > > field, it needs to be done.
> > > >
> > > > Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fix=
ed event buttons")
> > > > Reported-by: Julien <julien82453@gmail.com>
> > > > Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBx=
ajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
> > > > Cc: All applicable <stable@vger.kernel.org>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > I bisected the following kernel message that I see on one of my aarch=
64
> > > test machines to this change in -next as commit f234fdaae1ca ("ACPI:
> > > scan: Avoid registering platform devices with resource overlaps"):
> > >
> > >   arm-cmn ARMHC600:00: probe with driver arm-cmn failed with error -22
> > >
> > > Is this expected? If not, what information would be helpful for debug=
ging this?
> >
> > No, it is not.
> >
> > First, please send a boot log from the failing machine.
> >
> > Second, I think we may need the acpidump output from it.
>=20
> So looking at the driver code, it expects to get two resources and it
> is confused when it gets just one, so most likely arm_cmn_get_root()
> fails.
>=20
> I guess what happens is that originally one of the resources is within
> the other one completely (or the creation of the platform device would
> fail), which is kind of valid, so resource_overlaps() returns true for
> them, and they get merged.  This means that
> acpi_platform_adjust_resources() needs to look for partial overlaps
> only.
>=20
> I'll send a patch to adjust it later today.

And below is one to try.

=2D--
 drivers/acpi/acpi_platform.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

=2D-- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust
 	for (i =3D 0; i < count; ) {
 		struct resource *res =3D &resources[i];
=20
=2D		if (resource_type(new_res) !=3D resource_type(res) ||
+		/*
+		 * Look for overlaps of resources of the same type that
+		 * would cause resource insertion to fail.
+		 */
+		if (__resource_contains_unbound(new_res, res) ||
+		    resource_type(new_res) !=3D resource_type(res) ||
 		    !resource_union(new_res, res, new_res)) {
 			i++;
 			continue;



