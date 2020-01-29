Return-Path: <SRS0=+18Y=3S=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9745BC2D0DB
	for <linux-integrity@archiver.kernel.org>; Wed, 29 Jan 2020 13:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786A5207FD
	for <linux-integrity@archiver.kernel.org>; Wed, 29 Jan 2020 13:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgA2N0C (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:26:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:26418 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgA2N0B (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jan 2020 08:26:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 05:26:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="261801390"
Received: from ckelly-mobl.ger.corp.intel.com ([10.252.25.54])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2020 05:25:58 -0800
Message-ID: <e72b6fda6c4ff0d54af37d064d66b883d7ea48e7.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] tpm1_bios_measurements_next should increase
 position index
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>, linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Wed, 29 Jan 2020 15:25:57 +0200
In-Reply-To: <2377039f3fd8cd1eb3ff12616cb4f82afdf4a632.camel@linux.intel.com>
References: <3b24cec6-efb9-8dd4-fa1e-19e04798b067@virtuozzo.com>
         <2377039f3fd8cd1eb3ff12616cb4f82afdf4a632.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-29 at 15:23 +0200, Jarkko Sakkinen wrote:
> On Thu, 2020-01-23 at 10:48 +0300, Vasily Averin wrote:
> > if seq_file .next fuction does not change position index,
> > read after non-zero llseek can generate unexpected output.
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=206283
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> * Should be "tpm: tpm1_bios_measurements_next should increase position index"
> * Sentences in English start with a capital letter.
> * Should probably have Fixes tag.
> * Shoud have "Cc: stable@vger.kernel.org" tag.
> 
> Same remarks for TPM2 patch.

* Shoud have explanation what kind of output is generated
  without the fix. "Unexpected output" is does not document
  the regression.

/Jarkko

