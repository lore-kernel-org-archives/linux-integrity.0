Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE53E556D;
	Thu,  6 Aug 2026 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051432; cv=none; b=XlT3pHSi7x/DAum9Uilsq9gLgesKfykWUNU6PrHbuE7emhlyyp31+A1jKSNgvxSHcRFWECbLQ2YY5Z8eC88by1cfm26FybAo0WPQlwRW1oReRXWHeECeDgU+iIsrIcDRWkXL+OxXiz9mhl5rVDX2YM2k+G5nStwLM4RQXUohTGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051432; c=relaxed/simple;
	bh=bA3ALD63gW685t+PI1gCCfzSab22X6sCn1t4DUkkEKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3sMX+Rn2QLs9xQ2URe2LeqZSNDF8oyiZ5ozq6k1ncrEQ06mxdwst+oGAySgrhFDiIdaSs6no2CXSdGZZYm17KkQz9y3Jg/AElB0qE21b8JGVeE1S7oiMbXWvlKHiRA5IYa1TPoJBI3xt1tDA8fF3wpaiZn8u93Dk+7YKJmiRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kA0ln7ZI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kA0ln7ZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786051431; x=1817587431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bA3ALD63gW685t+PI1gCCfzSab22X6sCn1t4DUkkEKA=;
  b=kA0ln7ZIX888banILKTjVV3hbyTxPJMuAKf3348jLcZXF2BUpqHKfthw
   VOcnjZWJAuANR3d4lD1jZXtosW6p4035rzM+XyxnEQTS9HSDJRwntpeZh
   wrsYClMSK29nM3vNFLwRztsZ4pCSxQx5LjduHpqpvQ4EmvvqS/xGbcyHB
   X9t+AUnFbyUFrQg+du/kKn3OU/EApTmOUFx6qrFRY/MDXP1ElZOz7LQ1Q
   jcViC/lkHruQ6DMsrHQ5S7w9N9S+TloSU9keM4JSpd+AhJ50Zm9vCavaW
   +hhDPjOyFTWF5maUuuaZ4Rf+FhVU7PiDllL79CS5StrROpTuW+KDJ6Uc1
   w==;
X-CSE-ConnectionGUID: PUSgITpUSkK/osnKlygBpA==
X-CSE-MsgGUID: vXjmWTBKTq2jY9SYbLnW+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86425754"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86425754"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:23:50 -0700
X-CSE-ConnectionGUID: fBNz+2nGQYi/rPgs9adqvA==
X-CSE-MsgGUID: zsWofeD/SMKFxThXxXMZBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="266058014"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:23:48 -0700
Date: Fri, 7 Aug 2026 00:23:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Julien <julien82453@gmail.com>, jarkko@kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: scan: Avoid registering platform devices with
 resource overlaps
Message-ID: <anT7YdW6b-uYwgK0@ashevche-desk.local>
References: <12954206.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12954206.O9o76ZdvQC@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 09:28:03PM +0200, Rafael J. Wysocki wrote:

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

...

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
> +		    !resource_overlaps(new_res, res)) {
> +			i++;
> +			continue;
> +		}
> +
> +		dev_info(&adev->dev, "Adjusting %pR for %pR\n", new_res, res);
> +		/*
> +		 * Extend the new resource to include the one that has been processed
> +		 * already.
> +		 */
> +		if (res->start < new_res->start)
> +			new_res->start = res->start;
> +
> +		if (res->end > new_res->end)
> +			new_res->end = res->end;

Can we use resource_union() instead?

> +		/*
> +		 * Eliminate the previously processed resource that has
> +		 * triggered the adjustment because it is not necessary any
> +		 * more.
> +		 */
> +		memmove(res, res + 1, (--count - i) * sizeof(*res));
> +	}
> +
> +	return count;
> +}

-- 
With Best Regards,
Andy Shevchenko


