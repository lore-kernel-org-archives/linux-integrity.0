Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE0418345;
	Thu, 20 Aug 2026 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223051; cv=none; b=WHI9FKlYwDcWqecvJMOWVduvpSf4kniMTr6NXM40zhmySS3+5MP0Zulrs9vSHJsznp1N6z0e/wUPPopMFeAHPuh8y9HFXtZWdHOOt8hOtxqJ5V69ZN2Gk+mvo+M0fiqRQKK9kwAgex1cwNSScwSBKU9d5+6UzQyKNPnr8P01Lxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223051; c=relaxed/simple;
	bh=5aFu6oCN6OQDkASUv+ZN5Sjl4MRZf3xhGIQ/IpmHLwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FFdY83OCCZV+hYvS2oiv//jMnbO4QJqcgLBbwHV5gsmO4qQY3cfd4vDI8dVIZowhKvP/bLYGZKwFtGvY9AKR4Eoe2mL37fdU1PCht5ooUi21Oj1WAe8po1OHKCwM3hwHc9/3jfg6wDAFTpyj8tnsMyKJ40YQz8na3Cy/evJXSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI3kseND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI3kseND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623C11F000E9;
	Thu, 20 Aug 2026 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787223050;
	bh=zU5n+kNLqqBfz0t/1Iz1opd/lp7GqY7caNJTBxL5yhg=;
	h=From:To:Cc:Subject:Date;
	b=BI3kseNDAvBOy7i0yUHBnf22QZUWqTAhrnTsQzAGCJMiHNbPJCTNMNtLHDKJHcABC
	 qxsL1V0PoHZ2ul/QsyRUBeBDlz/8KwYyz9CUlLjN7zSVk9aKzu4pfbaDdixs8yHJAj
	 1sIa12o7PvGExfAYbt4n4vNgkvUdQ7b7rhl5OW8T7IUvyJqa8qUcVlYaf0lVjNiYPs
	 ANmWamPYqqMhuNHSrmWs0k09/oCCR/+GbydNBQXzjXJVJrBLQTZlkHrF1/ou6Pbh7j
	 zgZ/NtghOSn2cm6Q2anZ+SwD7UsWggDRKZesvvL7IFofdjXXSX0Qd0SO3hcAYRAe4i
	 RcIbc0yhdmGxQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Julien <julien82453@gmail.com>, jarkko@kernel.org,
 linux-integrity@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject:
 [PATCH v1] ACPI: scan: Do not combine resources that overlap completely
Date: Thu, 20 Aug 2026 12:50:46 +0200
Message-ID: <12956979.O9o76ZdvQC@rafael.j.wysocki>
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

Address this issue by adding a check for completely overlapping
resources to acpi_platform_adjust_resources() and add a comment
explaining what is done there.

Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices with resource overlaps")
Reported-by: Nathan Chancellor <nathan@kernel.org> 
Tested-by: Nathan Chancellor <nathan@kernel.org> 
Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@ax162/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

@Julien: I would appreciate testing this on the machine that needed
commit f234fdaae1ca.

---
 drivers/acpi/acpi_platform.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust
 	for (i = 0; i < count; ) {
 		struct resource *res = &resources[i];
 
-		if (resource_type(new_res) != resource_type(res) ||
+		/*
+		 * Look for overlaps of resources of the same type that would
+		 * cause resource insertion to fail down the road.
+		 */
+		if (__resource_contains_unbound(res, new_res) ||
+		    resource_type(new_res) != resource_type(res) ||
 		    !resource_union(new_res, res, new_res)) {
 			i++;
 			continue;



