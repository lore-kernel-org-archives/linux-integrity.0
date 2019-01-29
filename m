Return-Path: <SRS0=yJTw=QF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C287C169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 18:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A812080F
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 18:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfA2Sbv (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:31:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:26229 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfA2Sbv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jan 2019 13:31:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 10:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="118420833"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jan 2019 10:31:49 -0800
Date:   Tue, 29 Jan 2019 20:31:51 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] tpm: don't return bool from update_timeouts
Message-ID: <20190129183151.GB11288@linux.intel.com>
References: <20190129174145.1482-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129174145.1482-1-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 29, 2019 at 10:41:44AM -0700, Jerry Snitselaar wrote:
> Sorry, I've been tied up tracking down some iommu issues. I just took
> a quick stab at this. It looks like the only failure case is the tpm
> read of the did/vid failing for the spi driver. My question is do we
> want to fail the probe in that case, spit out a message, or just
> continue on? Thoughts?
> 
> Regards,
> Jerry

Probably printing warning would be enough. I mean do selftests and
everything.

/Jarkko
