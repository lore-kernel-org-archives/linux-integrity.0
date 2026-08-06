Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB6477295;
	Thu,  6 Aug 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027519; cv=none; b=MaWE+F+Ph42y/f4F8VenBLpxKEN68sYrgp86M5GPXUlVLc1b0ptnZvvyg1wAlkjuk5oxhCulGgIow05w+/Zc33OGD5G6lMnooKgtYnhZJ7z8cATA+kw31T2pvWT3bDGG33TFWpJmgYhg+pL5FZUAjI1OUp/5RK0BGRNGne5/CCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027519; c=relaxed/simple;
	bh=gVu96IuS3Y2OpP5+Z97dgvDA/7UJAFvQqzWgEJhsW/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPpejB85BW8HwQkmLetuJAM/0KJWLqjZpoEIW0I77kCotWzQ3NNlgio2FTMv3mwumZrJaH3rP5nO2i0cG6uOZT34R11VFo1FBpvol+aqjrDfJPKKwA2YyodLK7/t66014TTYdYNDUQ7Cj0z5ylrtGsMz7IvqC1Q4UpEQBZxgnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXlc8zGY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXlc8zGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042811F000E9;
	Thu,  6 Aug 2026 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786027517;
	bh=RkUNu3dD9YnIDjUZJ3FwPH5jDFShA5DHY9gf7smCC9M=;
	h=From:To:Cc:Subject:Date;
	b=PXlc8zGYx8NntRxtRWt7m2ldzN6ZkeeU07VkpSaJ1w+y2TemZp8PHtbQNKcDaqoPT
	 Y/JbUt+/XLjQCVTfTA2G7ZZGicCxpLIIjlBuagonCDPwHjZ6nMp7nyMZc0IWCa8Ep9
	 CGv0tpiHDmPTjnKVLY5SrzV8trHetgHQrt/jaDvWg9Ji02xq1dANUbD249n2tM3Ic/
	 EJCmhpqpPmSLIfatKIhX7iSRvBw6cgW7ajUTMISHW/FHS7JR9PZh6DMeDwFz9JdXKc
	 n+DinyLElliPOBWkEqumNxeeYOkTgdsJCIq0RvhB9O1fh4JC3nAihdymsYu+REPwjX
	 tzxbNxkemk1Ig==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Julien <julien82453@gmail.com>, jarkko@kernel.org,
 linux-integrity@vger.kernel.org
Subject:
 [PATCH v1] ACPI: scan: Avoid registering platform devices with resource
 overlaps
Date: Thu, 06 Aug 2026 16:45:13 +0200
Message-ID: <6299389.lOV4Wx5bFT@rafael.j.wysocki>
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
the subsequent registration of a platform devices will fail with -EBUSY
due to a resource conflict.  This is reported to happen on Acer Aspire
ES1-572 [1].

Avoid that by adjusting resources returned by acpi_dev_get_resources()
to eliminate partial overlaps between them.

This has not been regarded as necessary before because putting
overlapping resources into the _CRS of one device is really pointless,
but now that the issue has been reported to actually happen in the
field, it needs to be done.

Fixes: 8e345c991c8c ("ACPI: Centralized processing of ACPI device resources")
Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")
Reported-by: Julien <julien82453@gmail.com>
Tested-by: Julien <julien82453@gmail.com>
Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_platform.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -71,6 +71,39 @@ static struct notifier_block acpi_platfo
 	.notifier_call = acpi_platform_device_remove_notify,
 };
 
+static void acpi_platform_adjust_resource(struct acpi_device *adev,
+					  struct resource *new_res,
+					  const struct resource *resources,
+					  unsigned int count)
+{
+	unsigned int i;
+
+	if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+		return;
+
+	for (i = 0; i < count; i++) {
+		const struct resource *res = &resources[i];
+
+		if (resource_type(new_res) != resource_type(res))
+			continue;
+
+		if (!resource_overlaps(new_res, res))
+			continue;
+
+		dev_info(&adev->dev, "Adjusting %pR for %pR\n", new_res, res);
+		/*
+		 * Extend the new resource to include the one that has been
+		 * processed already to avoid resource insertion failures during
+		 * platform device registration.
+		 */
+		if (res->start < new_res->start)
+			new_res->start = res->start;
+
+		if (res->end > new_res->end)
+			new_res->end = res->end;
+	}
+}
+
 static void acpi_platform_fill_resource(struct acpi_device *adev,
 	const struct resource *src, struct resource *dest)
 {
@@ -151,10 +184,12 @@ struct platform_device *acpi_create_plat
 				return ERR_PTR(-ENOMEM);
 			}
 			count = 0;
-			list_for_each_entry(rentry, &resource_list, node)
+			list_for_each_entry(rentry, &resource_list, node) {
+				acpi_platform_adjust_resource(adev, rentry->res,
+							      resources, count);
 				acpi_platform_fill_resource(adev, rentry->res,
 							    &resources[count++]);
-
+			}
 			acpi_dev_free_resource_list(&resource_list);
 		}
 	}



