Return-Path: <SRS0=CT41=YQ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523D7CA9EB6
	for <linux-integrity@archiver.kernel.org>; Wed, 23 Oct 2019 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F622084B
	for <linux-integrity@archiver.kernel.org>; Wed, 23 Oct 2019 11:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404947AbfJWLdB (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:33:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:47664 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404612AbfJWLdB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 07:33:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="398013206"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.121])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2019 04:32:48 -0700
Date:   Wed, 23 Oct 2019 14:32:48 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tpm: Switch to platform_get_irq_optional()
Message-ID: <20191023113248.GA21973@linux.intel.com>
References: <20191019094528.27850-1-hdegoede@redhat.com>
 <20191021140502.GA25178@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021140502.GA25178@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 21, 2019 at 11:05:02AM -0300, Jason Gunthorpe wrote:
> On Sat, Oct 19, 2019 at 11:45:28AM +0200, Hans de Goede wrote:
> > Since commit 7723f4c5ecdb ("driver core: platform: Add an error message to
> > platform_get_irq*()"), platform_get_irq() will call dev_err() on an error,
> > as the IRQ usage in the tpm_tis driver is optional, this is undesirable.
> 
> This should have a fixes line for the above, or maybe the commit that
> addtion the _optional version..

Is this fixing something?

/Jarkko
