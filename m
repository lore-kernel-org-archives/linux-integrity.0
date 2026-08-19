Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72A3B05B4;
	Wed, 19 Aug 2026 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146598; cv=none; b=sFi4fB7jvMEXy6jEpV1aWpaz0UBFFeu2aBkKDZKaST9whCF0dphiU6BW3aUIyZn3eWhjbi+bMeUAJEeXRXXV3hrw9mLJkEVybYs0fNfODqy/Iixs+rZ1/0q2N32+EOnIxGzmxYs8kqJtMPrhMhFhm+67k6+jlkyAnygYp7AnJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146598; c=relaxed/simple;
	bh=I9mLhMJ8owyNKD5c0C9jUzDrNUbpaeN13kKnb2UbGMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjEbLMpPzpE+kItcwfBNJ9Qy9Wm4o8QOqfAUSMBtnlSWIVknkFDlI+Zbzlzr73EUji2qO0BC614A4TMZxBMvTWPVM8q08UpQQxZJ6mUQFeBxcgSvFFPjvPIrXAXsNmooqV+DzV01FH8W7oX6/+qbtTx1b5hAbhbULcBLXRBVFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XK4YF4hi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XK4YF4hi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787146596; x=1818682596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I9mLhMJ8owyNKD5c0C9jUzDrNUbpaeN13kKnb2UbGMc=;
  b=XK4YF4hi5j9fskcsIIXTVKTnl5W3TYPs9ymXP7gbOC4Gy9iA+JwpAJs7
   KN3nhU3/zakNv1prcNgDKEu6RcPFe+tHFRguESnvGJTmg4AzaPyRqNfmH
   SRCbaoZeejsu7g6SokOPo8AWjcV5/A1jFHyMLcWxeTbU1gwHbtJSVlisl
   vCS1oxtzG0r+RkPhE2PQ4FH8Ceg+cKamq2eS8v42LY/Qkmwi5VL4yFIyf
   GkIFGd9nxFhMhqM8RjWHw0g+jxuPKJvB4MYO6PZm/w+PFNtyFRSurDEPz
   wpozF/nQY95JiRKuQVR/z0sojethn17cWwX7RzZ0G3rr3iEejoIy0RiUg
   Q==;
X-CSE-ConnectionGUID: W2OzQu1hTNa1LUTOc000HQ==
X-CSE-MsgGUID: kz2FZzGOTbKjdK5vP9Olgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87578542"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87578542"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:36:36 -0700
X-CSE-ConnectionGUID: AA/eEztlQ3i33akx06r5hQ==
X-CSE-MsgGUID: M8ZoZi+8RTa6vOug68psdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="263811465"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:36:33 -0700
Date: Wed, 19 Aug 2026 16:36:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Julien <julien82453@gmail.com>, jarkko@kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
Message-ID: <aoWxXqJmts-aUNxL@ashevche-desk.local>
References: <12955541.O9o76ZdvQC@rafael.j.wysocki>
 <20260819003752.GA3063251@ax162>
 <aoVfapu1zv8gUmG1@ashevche-desk.local>
 <CAJZ5v0i7AFT-nackOXiP3j3usn5EvkhtkVYN7vmPbOV2jCodpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i7AFT-nackOXiP3j3usn5EvkhtkVYN7vmPbOV2jCodpw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 12:35:50PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Aug 19, 2026 at 9:46 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 18, 2026 at 05:37:52PM -0700, Nathan Chancellor wrote:

...

> > Does anything stop working?
> 
> Apparently, a driver is not probing any more ...

Yes, but it might be (however quite unlikely) the new message of the same
state of affairs (for example, driver wasn't probed, but silently).
Nevertheless, I assume that this driver is kinda critical and this is not
just a message.

-- 
With Best Regards,
Andy Shevchenko


