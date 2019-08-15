Return-Path: <SRS0=aKvA=WL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A92C3A589
	for <linux-integrity@archiver.kernel.org>; Thu, 15 Aug 2019 21:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806CA2063F
	for <linux-integrity@archiver.kernel.org>; Thu, 15 Aug 2019 21:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfHOVCH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:02:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:49995 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfHOVCG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Aug 2019 17:02:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 14:02:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="176987523"
Received: from schuberw-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.145])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2019 14:02:02 -0700
Date:   Fri, 16 Aug 2019 00:02:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, mark.rutland@arm.com, robh+dt@kernel.org,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: trivial checkpatch fixes
Message-ID: <20190815210201.yhc7dosvnafcayfu@linux.intel.com>
References: <20190813130559.16936-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813130559.16936-1-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 13, 2019 at 09:05:59AM -0400, Sasha Levin wrote:
> Fixes a few checkpatch warnings (and ignores some), mostly around
> spaces/tabs and documentation.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thank you!

I'll squash these to the existing patches.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
