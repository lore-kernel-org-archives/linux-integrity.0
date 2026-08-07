Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250463EDE54;
	Fri,  7 Aug 2026 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098164; cv=none; b=TFv0covsVjFSLr+DN10i9cIbbFSyrqo7PdpB2dUPeOcINYti9oVs92xm4uu61VSassWrWuC7ihTkCuGZhRYYX+u96yKNe01yNPVVb0YRfOmZEtUnHOtW0SLauircudTkCrvAy+OvaJz+uxFQ+e66ZRsXnLTUQFHx9yax5bjTTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098164; c=relaxed/simple;
	bh=lS0ZUw6zS4Mqc8q5cHFLdsz5bXvwUV7oFys/Q7ARjG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jf1Q8jm7LKUOmuvKPUVUH27fUUZ7Ox8IIjvP0KFm+R5+HnhAwHI3+AVOn27pVb49cGZa/h6XU2kPomA65YKGEhNpbMhbvK9CzfB4cpiJGT4v9v1nGlmytgHRNcNPwL7c1tg5OzgkCD3jTEm3aHzdfbEJEBwyO7FzRKs+X0hh/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Qh8eAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8Qh8eAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD3A1F000E9;
	Fri,  7 Aug 2026 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786098161;
	bh=5+DLgTOZuzGjmuD+lG4R1C5qWSNsH5B9z3tj5Q3yVN0=;
	h=From:To:Cc:Subject:Date;
	b=l8Qh8eANblIt2M0vuapnVH9nGBc5GPnpzvJaDlOGXl+dy4sESVxj7xeD+sPp/eHT6
	 iS+KlZVgyW7737iM5JAleiAjYxFhvDchsWObBlcnORHeZExxt+AYEaREK4JtK8zjDj
	 aqfb0XAxB0zSwHx/e3tc/w7mFTxOZ8dhmy9GOwBgeBg5e00aq9jC7LVokbpnU6k6QR
	 v/BTFaD/NyJNgsDCYNtz/bqEWoNH4YWTn37CtmOETzdBnKgDEUWxZbkmYV0L8rJig4
	 p+0GMMGAyjz/IdV7zN8D71Wc6iyKu0xf7qAb0JkLPMiAJKWR4Kf4nCEaL9O6t9h20q
	 doeQCsINyOFew==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Julien <julien82453@gmail.com>, jarkko@kernel.org,
 linux-integrity@vger.kernel.org
Subject:
 [PATCH v3] ACPI: scan: Avoid registering platform devices with resource
 overlaps
Date: Fri, 07 Aug 2026 12:22:37 +0200
Message-ID: <12955541.O9o76ZdvQC@rafael.j.wysocki>
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

v2 -> v3:
   * Use resource_union() and adjust code and comment (Andy)
   * Include ioport.h directly

v1 -> v2:
   * Add the expanded resource instead of and not in addition to the other
     overlapping one (Sashiko)

---
 drivers/acpi/acpi_platform.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
@@ -71,6 +72,36 @@ static struct notifier_block acpi_platfo
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
+		    !resource_union(new_res, res, new_res)) {
+			i++;
+			continue;
+		}
+
+		dev_info(&adev->dev, "%pR expanded to avoid overlap\n", new_res);
+		/*
+		 * Eliminate the previously processed resource that overlapped
+		 * with the new one because it is not necessary any more.
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
@@ -151,10 +182,14 @@ struct platform_device *acpi_create_plat
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



