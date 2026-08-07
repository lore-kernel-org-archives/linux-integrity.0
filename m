Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98B463B9B;
	Fri,  7 Aug 2026 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107483; cv=none; b=tL0Z3dO6KDbP99N4GpOa83gX5ahryF/jxRFQczv9uZYPRFz3YUV2+YnX01W2gcM/lDliEZwUKXeMqNyECByIHyDcT64SHWxyAPmLrMhG965ZXSXooli78TUTPR2fay3xuJu6lMOXNMzJJWG/NUssdTkY7PDsELfqseIWu18lsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107483; c=relaxed/simple;
	bh=L2btdgXRT6gFxJ9dElHSvNE0g/xbpLJRPS8FrDxWHms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZMH2y1kgVXZBjICPJ6hNohehHd+8QuRcwE/vqpkyCw7NLAJsr0Jg16Sm4XgRfYM34xYMpyqIHHnN2jt9FQaG5NodU/JbpAhmlDrD9olQlXgwNYrR9O5WMrytZS87fzP39VNSgQUI3JiZoOnvTtRBuwBweixvVg5DDI7gVlCFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.228] (p57bd9ff3.dip0.t-ipconnect.de [87.189.159.243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 24AD84C2C37F0B;
	Fri, 07 Aug 2026 14:57:15 +0200 (CEST)
Message-ID: <c159e25b-379a-4e0d-b284-f68bcbb09c7d@molgen.mpg.de>
Date: Fri, 7 Aug 2026 14:57:11 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, julien82453@gmail.com,
 jarkko@kernel.org, linux-integrity@vger.kernel.org
References: <12955541.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <12955541.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Rafael,


Thank you for the patch.

Am 07.08.26 um 12:22 schrieb Rafael J. Wysocki:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> If acpi_dev_get_resources() returns overlapping I/O or memory resources,
> the subsequent registration of a platform device will fail with -EBUSY
> due to a resource conflict.  This is reported to happen on Acer Aspire
> ES1-572 [1].

Reading the diff, it might be useful to paste the log warning already here:

     tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout

> Avoid that by adjusting resources returned by acpi_dev_get_resources()
> to eliminate partial overlaps between them.
> 
> This has not been regarded as necessary before because putting
> overlapping resources into the _CRS of one device is really pointless,
> but now that the issue has been reported to actually happen in the
> field, it needs to be done.
> 
> Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed event buttons")
> Reported-by: Julien <julien82453@gmail.com>
> Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3:
>     * Use resource_union() and adjust code and comment (Andy)
>     * Include ioport.h directly
> 
> v1 -> v2:
>     * Add the expanded resource instead of and not in addition to the other
>       overlapping one (Sashiko)
> 
> ---
>   drivers/acpi/acpi_platform.c |   39 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
> 
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -12,6 +12,7 @@
>   #include <linux/bits.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> +#include <linux/ioport.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/dma-mapping.h>
> @@ -71,6 +72,36 @@ static struct notifier_block acpi_platfo
>   	.notifier_call = acpi_platform_device_remove_notify,
>   };
>   
> +static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
> +						   struct resource *new_res,
> +						   struct resource *resources,
> +						   unsigned int count)
> +{
> +	unsigned int i;
> +
> +	if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
> +		return count;
> +
> +	for (i = 0; i < count; ) {
> +		struct resource *res = &resources[i];
> +
> +		if (resource_type(new_res) != resource_type(res) ||
> +		    !resource_union(new_res, res, new_res)) {
> +			i++;
> +			continue;
> +		}
> +
> +		dev_info(&adev->dev, "%pR expanded to avoid overlap\n", new_res);

Maybe more normal user understandable:

     %pR expanded to fit all resources to avoid overlap

For the record, Julian reported that now the lines below are logged:

     MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded to avoid overlap
     tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout

> +		/*
> +		 * Eliminate the previously processed resource that overlapped
> +		 * with the new one because it is not necessary any more.
> +		 */
> +		memmove(res, res + 1, (--count - i) * sizeof(*res));
> +	}
> +
> +	return count;
> +}
> +
>   static void acpi_platform_fill_resource(struct acpi_device *adev,
>   	const struct resource *src, struct resource *dest)
>   {
> @@ -151,10 +182,14 @@ struct platform_device *acpi_create_plat
>   				return ERR_PTR(-ENOMEM);
>   			}
>   			count = 0;
> -			list_for_each_entry(rentry, &resource_list, node)
> +			list_for_each_entry(rentry, &resource_list, node) {
> +				count = acpi_platform_adjust_resources(adev,
> +								       rentry->res,
> +								       resources,
> +								       count);
>   				acpi_platform_fill_resource(adev, rentry->res,
>   							    &resources[count++]);
> -
> +			}
>   			acpi_dev_free_resource_list(&resource_list);
>   		}
>   	}

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
