Return-Path: <SRS0=DQCd=P2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3B9C43387
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 14:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDE220883
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 14:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfARO7g (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:59:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:36249 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfARO7g (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jan 2019 09:59:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 06:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="115699920"
Received: from unknown (HELO localhost) ([10.249.254.249])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2019 06:59:33 -0800
Date:   Fri, 18 Jan 2019 16:59:30 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH REVIEW 2/2] tpm_tis: override durations for STM tpm with
 firmware 1.2.8.28
Message-ID: <20190118145930.GE4080@linux.intel.com>
References: <20181214132115.26223-1-aklimov@redhat.com>
 <20181214132115.26223-2-aklimov@redhat.com>
 <20190103131453.GC10491@linux.intel.com>
 <20190114193940.mylziev4xhidmazs@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114193940.mylziev4xhidmazs@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 14, 2019 at 12:39:40PM -0700, Jerry Snitselaar wrote:
> Alexey was following the example of tpm_tis_update_timeouts() which
> returns true if the timeouts were updated, and otherwise returns
> false. The bool here makes sense to me, but what rc would you suggest
> in this case?

Maybe the pattern used there is not that great then.

The callback should simply be update_durations(chip), and it would do
whatever updates needed and either return zero or -errno. And of course
update durations_adjusted flag because that is needed in sysfs.

/Jarkko
