Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722703A59BC;
	Thu, 20 Aug 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253088; cv=none; b=ZwejAE43inBA+jyqh5P4mNO6O43kYkKBPlWkkcY/c4i1pcwoHjZLPOT4g4t5i8pVLJBACOkhDkEOoC9xK9S8Pc/cB/Y9i15PrrrqsvbaEtpjsbsea328ee8r7lZ1UdkVMQO7VLsXqeYyNB2a2XKk4cGH/ALy9URuLiNeS3c+YcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253088; c=relaxed/simple;
	bh=is7ePBSYfYl6E96f5l6TzMhjVVZEeQrQb75gOh4yxYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpoWPBSuz7fv7PCzkPm9CxdZodu7+VWM/qMMtU80jpunHJDvRGVWDiKqMawPFd/h1gMJpxv7BHtKSASmYMKjFHMicNF0TgmnSRqB3/VnjmlCJ+j75TeaPqtuEM2lUQ263uDR5bGHBblW9Ro2Jz/0emT4W781rP3/sP711tyE/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEw02xS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEw02xS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9D01F000E9;
	Thu, 20 Aug 2026 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787253079;
	bh=SkedE21eSHc27MEfbUiBIt+aSu+3u8FkcAX9kiJtHOw=;
	h=From:To:Cc:Subject:Date;
	b=IEw02xS/ZWLIA3BZuISd3geZb6RKDhe+738mnOoALpK+RiisrtkBuYoFc3NR3c1id
	 8jrRbFXkqGx/WFVc7syy9Xfx7WU2P9oezv7MCO5NXG/YIQbYhAyzBUNDiny4b0RiYp
	 AyohuPIpaYLE5Xu6EFeuRQQYkiIHOzfSLP4Aau0s0x2O9YygwzYr52hslZTlnXTDuy
	 6NCJSZi3xJpCaT7QChrH0xQ41j/UmDsSLtFI4r5kn6cZDjyJkPkW0EzNfD+GIH0wPf
	 wHJMwdm8h03Qpj4LRmiuNyuhzQxVKXGPKeE2CiP4zepH+L94ruiyzqplaT5aDbJE4H
	 +OBQM/rUFtp2g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Julien <julien82453@gmail.com>, jarkko@kernel.org,
 linux-integrity@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject:
 [PATCH v2] ACPI: scan: Do not combine resources that overlap completely
Date: Thu, 20 Aug 2026 21:11:14 +0200
Message-ID: <12955564.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
with resource overlaps") attempted to avoid platform device registration
errors due to overlaps of resources of the same type returned by the
same _CRS object in the ACPI tables.  It did that by combining two or
more overlapping resources into one, but it went too far and also
caused resources that overlap completely to be combined which broke
the arm-cmn driver that expects two MMIO resources to be present for
each device it binds to and it expects those two resources to overlap
completely.

Address this issue by adding checks for completely overlapping
resources to acpi_platform_adjust_resources() and add a comment
explaining what is done there.

Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices with resource overlaps")
Reported-by: Nathan Chancellor <nathan@kernel.org> 
Tested-by: Nathan Chancellor <nathan@kernel.org> 
Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@ax162/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * It is better to check for complete overlaps both ways as suggested
     by Sashiko.

@Julien: I would appreciate testing this on the machine that needed
commit f234fdaae1ca.

---
 drivers/acpi/acpi_platform.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -85,7 +85,13 @@ static unsigned int acpi_platform_adjust
 	for (i = 0; i < count; ) {
 		struct resource *res = &resources[i];
 
-		if (resource_type(new_res) != resource_type(res) ||
+		/*
+		 * Look for overlaps of resources of the same type that would
+		 * cause resource insertion to fail down the road.
+		 */
+		if (__resource_contains_unbound(res, new_res) ||
+		    __resource_contains_unbound(new_res, res) ||
+		    resource_type(new_res) != resource_type(res) ||
 		    !resource_union(new_res, res, new_res)) {
 			i++;
 			continue;



