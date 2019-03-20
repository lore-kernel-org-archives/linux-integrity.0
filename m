Return-Path: <SRS0=28DF=RX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECEAC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Mar 2019 09:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88E92184E
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Mar 2019 09:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfCTJ6W (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:58:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:15765 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfCTJ6W (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Mar 2019 05:58:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 02:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="scan'208";a="153385271"
Received: from tfkristx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.211])
  by fmsmga002.fm.intel.com with ESMTP; 20 Mar 2019 02:58:16 -0700
Date:   Wed, 20 Mar 2019 11:58:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: Kernel 5.0 regression in /dev/tpm0 access
Message-ID: <20190320095816.GA17554@linux.intel.com>
References: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
 <1552168908.3442.5.camel@HansenPartnership.com>
 <1552171467.3442.13.camel@HansenPartnership.com>
 <20190311130908.GA7264@linux.intel.com>
 <14297706-74ef-f178-3b65-e63289919117@intel.com>
 <20190313135926.GA6862@linux.intel.com>
 <20190317132218.GA29643@linux.intel.com>
 <204b7a87-2c99-35aa-9a18-6fdfb5169c8d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204b7a87-2c99-35aa-9a18-6fdfb5169c8d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 18, 2019 at 08:50:30AM -0700, Tadeusz Struk wrote:
> On 3/17/19 6:22 AM, Jarkko Sakkinen wrote:
> > Are you planning to submit a fix for this?
> 
> Yes, sorry for the delay. I will send something soon.
> Thanks,

Thank you.

/Jarkko
