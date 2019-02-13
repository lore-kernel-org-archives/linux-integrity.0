Return-Path: <SRS0=kHfr=QU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C8C282C2
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 10:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FC82190A
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 10:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbfBMKhH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:37:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:9514 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbfBMKhH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Feb 2019 05:37:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 02:37:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="274708039"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 02:37:02 -0800
Date:   Wed, 13 Feb 2019 12:37:02 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V3 4/4] efi: Attempt to get the TCG2 event log in the
 boot stub
Message-ID: <20190213103702.GB7087@linux.intel.com>
References: <20190211215518.81419-1-matthewgarrett@google.com>
 <20190211215518.81419-5-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211215518.81419-5-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 11, 2019 at 01:55:18PM -0800, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@google.com>
> 
> Right now we only attempt to obtain the SHA1-only event log. The
> protocol also supports a crypto agile log format, which contains digests
> for all algorithms in use. Attempt to obtain this first, and fall back
> to obtaining the older format if the system doesn't support it. This is
> lightly complicated by the event sizes being variable (as we don't know
> in advance which algorithms are in use), and the interface giving us
> back a pointer to the start of the final entry rather than a pointer to
> the end of the log - as a result, we need to parse the final entry to
> figure out its length in order to know how much data to copy up to the
> OS.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
