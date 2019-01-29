Return-Path: <SRS0=yJTw=QF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8581C169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 19:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929CE20882
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 19:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfA2TWF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:22:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:11798 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfA2TWF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jan 2019 14:22:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 11:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="122336675"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by orsmga003.jf.intel.com with ESMTP; 29 Jan 2019 11:22:02 -0800
Date:   Tue, 29 Jan 2019 21:22:05 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] tpm: don't return bool from update_timeouts
Message-ID: <20190129192205.GA14305@linux.intel.com>
References: <20190129174145.1482-1-jsnitsel@redhat.com>
 <20190129174145.1482-2-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129174145.1482-2-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 29, 2019 at 10:41:45AM -0700, Jerry Snitselaar wrote:
> Set tpm_chip->timeouts_adjusted directly in the update_timeouts
> code instead of returning bool. Return rc of tpm read instead,
> which can be return an error in the case of the spi driver.
> 
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Couple of remarks:

1. Shouldn't it then be just void?
2. Why do we even need timeout_adjusted in struct tpm_chip [1]?

[1] Only used locally in tpm1_get_timeouts().

/Jarkko
