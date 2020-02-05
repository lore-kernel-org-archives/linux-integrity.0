Return-Path: <SRS0=tL6x=3Z=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7354C35247
	for <linux-integrity@archiver.kernel.org>; Wed,  5 Feb 2020 22:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9247E217BA
	for <linux-integrity@archiver.kernel.org>; Wed,  5 Feb 2020 22:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgBEWEC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:04:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:57820 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgBEWEB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Feb 2020 17:04:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 14:04:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="404291428"
Received: from gtobin-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.85.85])
  by orsmga005.jf.intel.com with ESMTP; 05 Feb 2020 14:04:00 -0800
Date:   Thu, 6 Feb 2020 00:03:59 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 2/2] tpm: tpm2_bios_measurements_next should increase
 position index
Message-ID: <20200205220359.GA28111@linux.intel.com>
References: <e72b6fda6c4ff0d54af37d064d66b883d7ea48e7.camel@linux.intel.com>
 <16bde2d6-4208-e478-0ac3-163b5c3a1eaa@virtuozzo.com>
 <20200201170329.GA14875@linux.intel.com>
 <3ffb8968-fccc-9f2e-7931-01c634932d5e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ffb8968-fccc-9f2e-7931-01c634932d5e@virtuozzo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 03, 2020 at 08:14:53AM +0300, Vasily Averin wrote:
> On 2/1/20 8:03 PM, Jarkko Sakkinen wrote:
> > On Thu, Jan 30, 2020 at 01:23:21PM +0300, Vasily Averin wrote:
> >> If seq_file .next function does not change position index,
> >> read after non-zero lseek can generate unexpected output.
> > 
> > Is it unwanted or unexpected? Unexpected would be mean random
> > output. I don't think that is the case. Please describe more
> > throughly.
> 
> If .next function does not change position index, 
> following .show function will repeat output related to current position index.

Thank you. That is clear and concise.

Then, please put that to the commit message instead of "unexpected
output".

/Jarkko
