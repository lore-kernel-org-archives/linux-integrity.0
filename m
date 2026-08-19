Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CB3F3262;
	Wed, 19 Aug 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125620; cv=none; b=PoDM5dtx2hiXugb4MBnxMVnSeCJMQV7ti0E9S4WU4ZAZszrMPQbAV6gwQl2aUZGEUR8kRXpZdrbUtNkzwyNrcb23tEsE/UorK10t15NJO4w9OtaAakflSUUF3PFv8WUXcuy/9v24giCCxOosaYTbSX1EmjJDL9QBOkmRmblcUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125620; c=relaxed/simple;
	bh=n8LfMJacEywkaYRrthHNztK2HwpVY2IbyYnhhW1lsKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV6ABMWA5ROb4F2kfRqjJn58Sxu+iECd8ax9V045uqxuh9IDO7ST5nmRblyRQ6DazoYofXO+UmT8oEazbFY0BYw+PccCP/OZx8l/iumgGjxZJ6EbhA8AqRhUm1Ye0Sn/TxDv2DWgqDa4dCGGm0L7TSd/6h+9/XwieSS42ROKGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtZebJAk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtZebJAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787125618; x=1818661618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n8LfMJacEywkaYRrthHNztK2HwpVY2IbyYnhhW1lsKM=;
  b=XtZebJAkgfCNzGk60AxXQSUfzajn3Jf01S86LX/qFLPiXICySyLwvW5B
   CZ5m7slqO8VafWqtqL4tGhya5Hr8IyrSx3RmHbtSJ3gY6OBZmm22VaT+N
   dLcaEd6EOptrZG6/kd374rsIM8bJg3bKlh7HrU0mNP7bLPBOSiKbSvW2F
   375PVu7qwXco4ylSowhYSu1EkxRER122+cHcMzlrKDtGRUfSnHTTlXaS2
   Cq9hwmBi9LeBJHPLkwELrsB+BOKFvSh/4pT1n1Sos+I6q//fdFt+ncFTd
   hyWPjVWbcvDXww/sDzOeVQtrvTsi+X2raUoQTpJAWQWI9V6EQQX5QtNls
   A==;
X-CSE-ConnectionGUID: h08cjqLoTNyRfIi+fy7ShA==
X-CSE-MsgGUID: 5mlU8aeHRmu1viIUXGLqOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105011990"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105011990"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:46:55 -0700
X-CSE-ConnectionGUID: A1h8OYl6R0O6x8vjwQj/BA==
X-CSE-MsgGUID: DtyDs/Z6T8CtPrRssAK56w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="259278924"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:46:52 -0700
Date: Wed, 19 Aug 2026 10:46:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Julien <julien82453@gmail.com>, jarkko@kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
Message-ID: <aoVfapu1zv8gUmG1@ashevche-desk.local>
References: <12955541.O9o76ZdvQC@rafael.j.wysocki>
 <20260819003752.GA3063251@ax162>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819003752.GA3063251@ax162>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 05:37:52PM -0700, Nathan Chancellor wrote:
> On Fri, Aug 07, 2026 at 12:22:37PM +0200, Rafael J. Wysocki wrote:
> > 
> > If acpi_dev_get_resources() returns overlapping I/O or memory resources,
> > the subsequent registration of a platform device will fail with -EBUSY
> > due to a resource conflict.  This is reported to happen on Acer Aspire
> > ES1-572 [1].
> > 
> > Avoid that by adjusting resources returned by acpi_dev_get_resources()
> > to eliminate partial overlaps between them.
> > 
> > This has not been regarded as necessary before because putting
> > overlapping resources into the _CRS of one device is really pointless,
> > but now that the issue has been reported to actually happen in the
> > field, it needs to be done.
> > 
> > Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed event buttons")
> > Reported-by: Julien <julien82453@gmail.com>
> > Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
> 
> I bisected the following kernel message that I see on one of my aarch64
> test machines to this change in -next as commit f234fdaae1ca ("ACPI:
> scan: Avoid registering platform devices with resource overlaps"):
> 
>   arm-cmn ARMHC600:00: probe with driver arm-cmn failed with error -22
> 
> Is this expected? If not, what information would be helpful for debugging this?

Looks like a mess in _CRS. You can share dsdt.dsl to see if the resource
conflict is visible from there.

Does anything stop working?

-- 
With Best Regards,
Andy Shevchenko


