Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651D4398EE;
	Thu,  6 Aug 2026 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044489; cv=none; b=l/RekgrTm9fOYEgKBc+h0yTJjOYv7BodYIIf+lSnQxMQHCpVdMte8RkApSaiKx2OceRLs4OsvgFiwK0RiNcDgVRitnb+C63KL3umFWgDXBLsrNl0haiT0h0RAoZ514rZ818jXCPruI4lHx6fx0hMn53ouNuP4hVPCZI+PSTSKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044489; c=relaxed/simple;
	bh=hh3slZGCVOwhYFQQX7XfPsM3g6I+9pUWaD2+LP14Xlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VWklBd2URlewGJ+eOeo1C0V0TT6NQiLN2dsQrhR8TgTm5wDx7hSMg5IhjNbHK2vB4t0cm8JTLIIdtQ39uARFvZRCeCsp/cp32slRmaDtyc8rFC6R3Dzv0bN4IaWFjczbdoDiKiC++xKAFozUhTSLiHZ6YMoyuc8GvUJMaA0PzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjFS7Y7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjFS7Y7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178121F000E9;
	Thu,  6 Aug 2026 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786044487;
	bh=E8McGfwKVFv6NIPStPE5Lsp91pW0uEuT9+GZaIGGYhc=;
	h=From:To:Cc:Subject:Date;
	b=VjFS7Y7eon43QFcP9OG0GAG4kMNnB9ubff5OLM+kfEjTwEP19xcIalZGdKyGc4AJH
	 YWZFS4mf7nOpnQirLYJVfu2RUFDJtDXmCNULFo7iEq7nIb0gV0W5E7t3kEyM3zeVF8
	 7uNk3B/QLPYQgzX7xaI44b/j2xaW0eG1hOBGw3WSGo33t1BmqmByuvp/xUrBq9xW0x
	 JGURoBvkeTXSjmGP3ZekhQb8qWsU37Y1kodg51xB9krBqXlPiiRF4P7LLB+g0CtcXb
	 mbWg9Hiy1SL8h3h1OhGfgMMT7czhddZPgb6/5T179bBksoqAtnfY+QUMoYbLAVSfn5
	 51t3Re5exyiXw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Julien <julien82453@gmail.com>, jarkko@kernel.org,
 linux-integrity@vger.kernel.org
Subject:
 [PATCH v2] ACPI: scan: Avoid registering platform devices with resource
 overlaps
Date: Thu, 06 Aug 2026 21:28:03 +0200
Message-ID: <12954206.O9o76ZdvQC@rafael.j.wysocki>
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

If acpi_dev_get_resources() returns overlapping I/O or memory resources,
the subsequent registration of a platform device will fail with -EBUSY
due to a resource conflict.  This is reported to happen on Acer Aspire
ES1-572 [1].

Avoid that by adjusting resources returned by acpi_dev_get_resources()
to eliminate partial overlaps between them.

This has not been regarded as necessary before because putting
overlapping resources into the _CRS of one device is really pointless,
but now that the issue has been reported to actually happen in the
field, it needs to be done.

Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed event buttons")
Reported-by: Julien <julien82453@gmail.com>
Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Add the expanded resource instead of and not in addition to the other
     overlapping one (Sashiko)

---
 drivers/acpi/acpi_platform.c |   49 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -71,6 +71,47 @@ static struct notifier_block acpi_platfo
 	.notifier_call = acpi_platform_device_remove_notify,
 };
 
+static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
+						   struct resource *new_res,
+						   struct resource *resources,
+						   unsigned int count)
+{
+	unsigned int i;
+
+	if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+		return count;
+
+	for (i = 0; i < count; ) {
+		struct resource *res = &resources[i];
+
+		if (resource_type(new_res) != resource_type(res) ||
+		    !resource_overlaps(new_res, res)) {
+			i++;
+			continue;
+		}
+
+		dev_info(&adev->dev, "Adjusting %pR for %pR\n", new_res, res);
+		/*
+		 * Extend the new resource to include the one that has been processed
+		 * already.
+		 */
+		if (res->start < new_res->start)
+			new_res->start = res->start;
+
+		if (res->end > new_res->end)
+			new_res->end = res->end;
+
+		/*
+		 * Eliminate the previously processed resource that has
+		 * triggered the adjustment because it is not necessary any
+		 * more.
+		 */
+		memmove(res, res + 1, (--count - i) * sizeof(*res));
+	}
+
+	return count;
+}
+
 static void acpi_platform_fill_resource(struct acpi_device *adev,
 	const struct resource *src, struct resource *dest)
 {
@@ -151,10 +192,14 @@ struct platform_device *acpi_create_plat
 				return ERR_PTR(-ENOMEM);
 			}
 			count = 0;
-			list_for_each_entry(rentry, &resource_list, node)
+			list_for_each_entry(rentry, &resource_list, node) {
+				count = acpi_platform_adjust_resources(adev,
+								       rentry->res,
+								       resources,
+								       count);
 				acpi_platform_fill_resource(adev, rentry->res,
 							    &resources[count++]);
-
+			}
 			acpi_dev_free_resource_list(&resource_list);
 		}
 	}



