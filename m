Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDF2E401;
	Sat,  8 Aug 2026 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219454; cv=none; b=nZU+6zfYmWqmCwGofoRrVsrlAHpg9ZUXncOpSk+LWn/tKI+RXu8gCrL8yF8Nfrq9Cn8DyDOPLfYi3y/6n2eZRTyWm0OonBmqGYc1miEPS6SPjHa4zw6glYIeDTon5qmO2rcoirtxv1btNetFHpmQipJVaVxqn0L4IagNOXDRk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219454; c=relaxed/simple;
	bh=QrS0SOVuaDmJlONP+I3TppuH7JWIzbl4k4iRP5e38NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqrjbGRR4yCGlymPBjzn/obhUB02rUAzxYbQ/NBz9j/kbnoR5NQsKVb+k12NTwC3fa8yexCO8Un8XnRUwv9NBu6agLQJfYRcYI0+IWOFkn5OlbQzjCmqoIdm3vEfPkpwYiSB0/dXTVkzwL1OO0KrdobKU4knA6kWl4TqjN79VPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YY+Uasfc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YY+Uasfc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786219453; x=1817755453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QrS0SOVuaDmJlONP+I3TppuH7JWIzbl4k4iRP5e38NI=;
  b=YY+Uasfcp1twUGhpo39bAV19pgSZ2H0dCpPjty1JmP5/SJfu1G5ngewy
   6dhor2pN+rIfqF5ZkLXMIHm9mP3ph1eXq1tEiiRtCiX5db6WbRPCgu5x4
   17JQ2eRXJcOhX94eT5pfEz82xg4gv+gG4SvoEPGUGYCMb4qhhnVUk8H64
   y+XBvb+yOOvTsk7jI6jH6EyTBuewhsiEINhtJfPPQx0n+HmCJgK0XmWUp
   luL8RPbOKvNAltHjzWsHMfDBPOudW0Xnc05R8rUvYhGJiRDPcH31SuPEZ
   Qt1GBAr+BHVELQJpvnUJxIFA1o1+ixzSa2ofTCWke4kwmGq9y4sY3GCfm
   A==;
X-CSE-ConnectionGUID: N8zSTtOMRi2Rak25Qi4ukw==
X-CSE-MsgGUID: UY5u2Ze5QPCkE4+n1vnFaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="86868724"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="86868724"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:04:13 -0700
X-CSE-ConnectionGUID: VGmn2b1hTLGQBZ9v2V+a9A==
X-CSE-MsgGUID: VPiKmSoIQvi0cZJzXb2EUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="262161934"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:04:10 -0700
Date: Sat, 8 Aug 2026 23:04:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Julien <julien82453@gmail.com>, jarkko@kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
Message-ID: <aneLtz6TERcU41ur@ashevche-desk.local>
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
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 12:22:37PM +0200, Rafael J. Wysocki wrote:

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

>    * Use resource_union() and adjust code and comment (Andy)

Thanks, LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
> +						   struct resource *new_res,
> +						   struct resource *resources,
> +						   unsigned int count)
> +{
> +	unsigned int i;
> +
> +	if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))

Can also be

	if (!(resource_type(new_res) & (IORESOURCE_IO | IORESOURCE_MEM)))

> +		return count;
> +
> +	for (i = 0; i < count; ) {
> +		struct resource *res = &resources[i];

> +		if (resource_type(new_res) != resource_type(res) ||
> +		    !resource_union(new_res, res, new_res)) {

Wondering why we don't have the resource type checks in resource_overlaps(),
but we have in resource_contains(). Ilpo, do you know?

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

-- 
With Best Regards,
Andy Shevchenko


