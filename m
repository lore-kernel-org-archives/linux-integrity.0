Return-Path: <SRS0=sWjp=PY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29EFC43387
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF9C20840
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 18:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfAPSrZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:47:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:9915 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbfAPSrZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Jan 2019 13:47:25 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 10:47:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="119032689"
Received: from lhaqq1-mobl2.amr.corp.intel.com (HELO localhost) ([10.249.254.231])
  by orsmga003.jf.intel.com with ESMTP; 16 Jan 2019 10:47:21 -0800
Date:   Wed, 16 Jan 2019 20:47:19 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 1/5] tpm: Abstract crypto agile event size calculations
Message-ID: <20190116184719.GA8626@linux.intel.com>
References: <20190109014847.39980-1-matthewgarrett@google.com>
 <20190109014847.39980-2-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109014847.39980-2-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 08, 2019 at 05:48:43PM -0800, Matthew Garrett wrote:
> +static inline int _calc_tpm2_event_size(struct tcg_pcr_event2 *event,
> +					struct tcg_pcr_event *event_header)

I'm more used to having two underscores i.e. __calc_tpm2_event_size()
for functions that are wrapped. Otherwise, looks good to me.

/Jarkko
