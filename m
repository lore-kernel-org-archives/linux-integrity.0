Return-Path: <SRS0=hrhM=YE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD6BC47404
	for <linux-integrity@archiver.kernel.org>; Fri, 11 Oct 2019 12:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD955206CD
	for <linux-integrity@archiver.kernel.org>; Fri, 11 Oct 2019 12:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfJKMeZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:34:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:26391 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfJKMeZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 08:34:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 05:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="197567595"
Received: from mkaltenb-mobl.ger.corp.intel.com (HELO localhost) ([10.251.83.92])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2019 05:34:21 -0700
Date:   Fri, 11 Oct 2019 15:34:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20191011123415.GA25688@linux.intel.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 10, 2019 at 07:18:31PM -0400, Mimi Zohar wrote:
> Create, save and load trusted keys test
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

I'm sorry. I have forgot this one! Can you send this linux-integrity
and kselftest? On surface looks somewhat appropriate.

/Jarkko
