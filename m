Return-Path: <SRS0=oO8W=6G=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4146CC55185
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Apr 2020 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269D62076E
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Apr 2020 15:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDVPv5 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:51:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:32752 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgDVPv5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Apr 2020 11:51:57 -0400
IronPort-SDR: oqa3LAtCUEyWWGOrmlECQXjYM4Tz4YY8pu5aI2bNZLwvGsUbmvhd4RdCj64VppL4rvtls7sRQx
 GPu8O+6DafsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 08:51:57 -0700
IronPort-SDR: PRjeaqla8ZUiIfCJjZf9/hN1cG71MObNA/IRRJjEtpkhfw4VcT+mC7WHAYsiLjHvO9PGDqddoX
 yzDIA6sKUraQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,303,1583222400"; 
   d="scan'208";a="429963947"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2020 08:51:55 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jRHfK-002THF-JY; Wed, 22 Apr 2020 18:51:58 +0300
Date:   Wed, 22 Apr 2020 18:51:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1] tpm/tpm_ftpm_tee: Use UUID API for exporting the UUID
Message-ID: <20200422155158.GL185537@smile.fi.intel.com>
References: <20200422130135.38555-1-andriy.shevchenko@linux.intel.com>
 <20200422150742.GA89432@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422150742.GA89432@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 22, 2020 at 06:07:42PM +0300, Jarkko Sakkinen wrote:
> On Wed, Apr 22, 2020 at 04:01:35PM +0300, Andy Shevchenko wrote:
> > There is export_uuid() function which exports uuid_t to the u8 array.
> > Use it instead of open coding variant.
> > 
> > This allows to hide the uuid_t internals.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Thanks!

> I guess no need for backports?

No, the API appears in v5.7-rc1.


-- 
With Best Regards,
Andy Shevchenko


