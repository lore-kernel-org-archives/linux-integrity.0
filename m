Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7632F616A;
	Mon, 10 Aug 2026 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376143; cv=none; b=p5quS4bckFBtK8I3FnQoQhSV51w57uqtVwzLVXXLnRtYShhdJt/3wDST1ic2sHnyR+WhTmr85C/fmoO1b+VD2nHC/SmafYyn1sT6XQNtLDstozrT+uH0jsq+aH84cpcWgDG1NvmNN7xvz5MtynA+iC3UI62UZFCk4XZ1pcaiqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376143; c=relaxed/simple;
	bh=5XxmMIFn4Af/OFqmT/PGjRd/0zLw9ldLbsCCU3/nmCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIanox9jwmi8ei2Lua4Sa8kwusg73Xj9m3iNBaDQtj5zdQS+LqPjgSt14IuhlEI74RZ5MTq8j3f5GQRXF6hGBhqzuq4u3ZDUwtyjNZqz/46kMPJC8r0jKR19gSmXLEHosApvcfNY8LWf6e/BgZY1gKZzlCCJOENqg889gKhgZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyAJzAw7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyAJzAw7"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 703C31F000E9;
	Mon, 10 Aug 2026 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376142;
	bh=aczLzN+0x2c8FkCGS2gEFsCS2C6r++0q6AJ0OfptsXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cyAJzAw7exubwk7sZiObJmRVCk5PrtY82DgNN2zoIPjWI/JpDv0gDHC7np6dkpILK
	 sna26698jsYCsYu+hfkI8fmS0/JmlKDSTsC+glNvpl2oxAy/4IdTJVOn4gNH2aix5S
	 BNzBTC3fYqW/8uOfRSmvc8sQrLZfXhJZwEjMT7YUqLp2jZh4uIvqC5nJIkHJpgEcHm
	 j3/9QBOiMj2eLvzSSd6mmUzQVNXg5TTIg3YUsCJ7J2BGfmQARo2vW4QTM6AfWW8WPJ
	 tPWPI91TKQ2VL2SyjPe15N7IKBzlRUiKRfzy+VWN2+9CdzkaAaFpzprbfHORlpwUu3
	 ceZvjHf4ZrpmA==
Date: Mon, 10 Aug 2026 18:35:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Julien <julien82453@gmail.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
Message-ID: <annvyrUCmqOxW7-o@kernel.org>
References: <12955541.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12955541.O9o76ZdvQC@rafael.j.wysocki>

On Fri, Aug 07, 2026 at 12:22:37PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> If acpi_dev_get_resources() returns overlapping I/O or memory resources,
> the subsequent registration of a platform device will fail with -EBUSY
> due to a resource conflict.  This is reported to happen on Acer Aspire
> ES1-572 [1].
> 
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
>    * Use resource_union() and adjust code and comment (Andy)
>    * Include ioport.h directly
> 
> v1 -> v2:
>    * Add the expanded resource instead of and not in addition to the other
>      overlapping one (Sashiko)
> 
> ---
>  drivers/acpi/acpi_platform.c |   39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -12,6 +12,7 @@
>  #include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/ioport.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/dma-mapping.h>
> @@ -71,6 +72,36 @@ static struct notifier_block acpi_platfo
>  	.notifier_call = acpi_platform_device_remove_notify,
>  };
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
>  static void acpi_platform_fill_resource(struct acpi_device *adev,
>  	const struct resource *src, struct resource *dest)
>  {
> @@ -151,10 +182,14 @@ struct platform_device *acpi_create_plat
>  				return ERR_PTR(-ENOMEM);
>  			}
>  			count = 0;
> -			list_for_each_entry(rentry, &resource_list, node)
> +			list_for_each_entry(rentry, &resource_list, node) {
> +				count = acpi_platform_adjust_resources(adev,
> +								       rentry->res,
> +								       resources,
> +								       count);
>  				acpi_platform_fill_resource(adev, rentry->res,
>  							    &resources[count++]);
> -
> +			}
>  			acpi_dev_free_resource_list(&resource_list);
>  		}
>  	}
> 
> 
> 

Applied to my tree I'll just run some tests.

BR, Jarkko
