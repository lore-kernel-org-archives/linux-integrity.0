Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D7330D25;
	Fri, 21 Aug 2026 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275409; cv=none; b=Ry+oB5eUvUvpA9AJqcO4rAm/BoPPyjHoGX89+3bFEI24j4omOb9Mebnnq2fPv3OqRLHX3OYpbKGIP5RLuSxqeeRrMAtZFyNLx40GYL9QS723YcC8sUA67w/foD0uan/SUbQ60h6vFFWU0DVjyI1Wn8d2hU6cOwuBtvMAMSbXVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275409; c=relaxed/simple;
	bh=YK6sEgN5LpMK7rHEXt6rgH+YizM5rkhlOw4+UZsagYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1sVMmwPb5g8nWzmzGuvkrb1CM83OtnG7yffdG08150mL7FTTFZu8cWe4/Dwsf6sNL3gghrLS2MiWbGgnShH81GmrRgsGetMTrJl1qlD4RvqGl1NAWrbuBjgFbSAHKUoWS/ByCzAjcyFKda3EMvfbJUkiWfptQlMUibX+OvP58U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnDZ0rk0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnDZ0rk0"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8ACC11F000E9;
	Fri, 21 Aug 2026 01:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787275408;
	bh=yOYHfkjtPOjfTmhmui4lz1/vnrfLXtlsUp8r90T1yG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UnDZ0rk0UsZkDMAxHpJEkahAt3NJf9pmWiwSu3ybRJTUMPruHFUL3bBY78xr/9xPi
	 HK4s8LLYsOcPFlwm7uGoV+Hx4olnXcIarQudSzNY1h0cn3iK7vGv5MByEI2hPRngu6
	 40qcVDFcBnsVyuZH8/eovyqJ5bf29puRS5FYjKmIPk3c5Kqu7Y7Y3uNCM+1S/byQZ6
	 11QF7GIzRWFTSHPFU5c8FF6sRIytVsAji17O5jE3aPmTqPNmZptbQ6H2dIAfsKsT32
	 68+NZKMqn3slfwb7W+V2gexwDLz+ENr6yzoeXfLeA4sT9N7vMUSm8NCEHQsjNZ8n2z
	 G7eFqcN+uWYlA==
Date: Fri, 21 Aug 2026 04:23:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Julien <julien82453@gmail.com>, linux-integrity@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1] ACPI: scan: Do not combine resources that overlap
 completely
Message-ID: <aoeojDfTngzP1Eku@kernel.org>
References: <12956979.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12956979.O9o76ZdvQC@rafael.j.wysocki>

On Thu, Aug 20, 2026 at 12:50:46PM +0200, Rafael J. Wysocki wrote:
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
> Address this issue by adding a check for completely overlapping
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
> @Julien: I would appreciate testing this on the machine that needed
> commit f234fdaae1ca.
> 
> ---
>  drivers/acpi/acpi_platform.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust
>  	for (i = 0; i < count; ) {
>  		struct resource *res = &resources[i];
>  
> -		if (resource_type(new_res) != resource_type(res) ||
> +		/*
> +		 * Look for overlaps of resources of the same type that would
> +		 * cause resource insertion to fail down the road.
> +		 */
> +		if (__resource_contains_unbound(res, new_res) ||
> +		    resource_type(new_res) != resource_type(res) ||
>  		    !resource_union(new_res, res, new_res)) {
>  			i++;
>  			continue;
> 
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
