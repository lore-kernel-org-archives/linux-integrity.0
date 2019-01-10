Return-Path: <SRS0=Znl9=PS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE0C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 17:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80F220874
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 17:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfAJRQH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:16:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:4819 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbfAJRQH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jan 2019 12:16:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 09:16:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,462,1539673200"; 
   d="scan'208";a="115793012"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.152])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2019 09:16:02 -0800
Date:   Thu, 10 Jan 2019 19:16:01 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm: fix incorrect success returns from
 tpm_try_transmit()
Message-ID: <20190110171601.GA6589@linux.intel.com>
References: <1546280851.3079.2.camel@HansenPartnership.com>
 <20190103125904.GA10491@linux.intel.com>
 <1546529038.2824.6.camel@HansenPartnership.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA626D3@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA626D3@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 03, 2019 at 03:34:24PM +0000, Winkler, Tomas wrote:
> We've already fixed it, I forgot myself , we were drinking too much :)
> https://patchwork.kernel.org/patch/10643565/
> Not sure why it was dropped.
> 
> Thanks
> Tomas

LOL what. Clearly I'm coming from holidays. This fix is in my tree
and it was part of my last PR to James (for 5.0).

And James' patch applies neither my master and next braches so I
suppose he is using some old tree.

/Jarkko
