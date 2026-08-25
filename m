Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1D3F12F9;
	Tue, 25 Aug 2026 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666821; cv=none; b=CWh2DPdTZvzuLfVJ7iqq5DsUbUsBz7W5bU7WAmmuI+N0yrKUQka1U9HXQ2usws8a9Z1jGTFOD7/0e3tjqG+483p2xS+B9V6Ml5isGgVPpYaITBX+OY48tt3AB0h+dEKeoeRWsq8xUqCJbWdjpmiH2DIEYJMI79t5zWBSMxcDSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666821; c=relaxed/simple;
	bh=/DCL2Wd5ABMMdfHiA5VXKmT76TcoUlejxrwEdvyMLcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiF6zgIJ2bwokRSlNunQc8KpI2qkb2zCbJpiggcYBRMvl1YghiNHvNMyW8n0YnSqiJhzBNlN9rOQeGCiIOzLhoYzGtOV1jYUFZbf8jXLriMRhjNmrf2OhEEFcUaeo3ngnAaFTcaypUokMw5nTqXD7Vg5q+dxDTmCaW6He8WPrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atNHsjr0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atNHsjr0"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7D1A31F000E9;
	Tue, 25 Aug 2026 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787666819;
	bh=zb2dR1ky3e/i5jY9uLyTx7grJbKpM/glhXzntMr7hu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=atNHsjr0X6f3Chro5uZ8uIRUeuHFeZKo7krQDdTIL2ftctr03anYju7o9PjMmroD6
	 2/Kde4GueqynQPrERRzJO0dHW/UD7F9Xh5uT3n1cgNV+CZsXpt8AmoO1GvjlXreX6s
	 ApXw7K7hyhWG2AgqRO9EWCQtx3MUZwwBousfqjTloYbacrCrNFTpsteYM7l9nFNwQn
	 rC3SjQPnGwwdeGWfmM8YNEYdgOZcuxux3sxZ5lDqng7jNkV1R1ayYdUSXXVHWqq9kD
	 2KaBIh5tSWR2t2VA8MdJcmL6+EkV8NTKzQQ9WjO/L+LuVIsrfTR6ea4rcmMkIUQUkA
	 FPhGIVp2znzQw==
Date: Tue, 25 Aug 2026 17:06:54 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Julien <julien82453@gmail.com>, linux-integrity@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2] ACPI: scan: Do not combine resources that overlap
 completely
Message-ID: <ao2hfu9ioyLSMmpg@kernel.org>
References: <12955564.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12955564.O9o76ZdvQC@rafael.j.wysocki>

On Thu, Aug 20, 2026 at 09:11:14PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
> with resource overlaps") attempted to avoid platform device registration
> errors due to overlaps of resources of the same type returned by the
> same _CRS object in the ACPI tables.  It did that by combining two or
> more overlapping resources into one, but it went too far and also
> caused resources that overlap completely to be combined which broke
> the arm-cmn driver that expects two MMIO resources to be present for
> each device it binds to and it expects those two resources to overlap
> completely.
> 
> Address this issue by adding checks for completely overlapping
> resources to acpi_platform_adjust_resources() and add a comment
> explaining what is done there.
> 
> Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices with resource overlaps")
> Reported-by: Nathan Chancellor <nathan@kernel.org> 
> Tested-by: Nathan Chancellor <nathan@kernel.org> 
> Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@ax162/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>    * It is better to check for complete overlaps both ways as suggested
>      by Sashiko.
> 
> @Julien: I would appreciate testing this on the machine that needed
> commit f234fdaae1ca.
> 
> ---
>  drivers/acpi/acpi_platform.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -85,7 +85,13 @@ static unsigned int acpi_platform_adjust
>  	for (i = 0; i < count; ) {
>  		struct resource *res = &resources[i];
>  
> -		if (resource_type(new_res) != resource_type(res) ||
> +		/*
> +		 * Look for overlaps of resources of the same type that would
> +		 * cause resource insertion to fail down the road.
> +		 */
> +		if (__resource_contains_unbound(res, new_res) ||
> +		    __resource_contains_unbound(new_res, res) ||
> +		    resource_type(new_res) != resource_type(res) ||
>  		    !resource_union(new_res, res, new_res)) {
>  			i++;
>  			continue;
> 
> 
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
