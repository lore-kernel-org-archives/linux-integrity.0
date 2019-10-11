Return-Path: <SRS0=hrhM=YE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC3BECE58C
	for <linux-integrity@archiver.kernel.org>; Fri, 11 Oct 2019 13:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC6C21D56
	for <linux-integrity@archiver.kernel.org>; Fri, 11 Oct 2019 13:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfJKNBg (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:01:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:59847 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfJKNBg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 09:01:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 06:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="197573788"
Received: from mkaltenb-mobl.ger.corp.intel.com (HELO localhost) ([10.251.83.92])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2019 06:01:30 -0700
Date:   Fri, 11 Oct 2019 16:01:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20191011130129.GA20277@linux.intel.com>
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

Also can be used to test Sumit's patches i.e. there is an immediate
application for this one. I'll use this check TPM 1.x and TPM 2.0
trusted keys code.

You could sanity check your script for sending with my master, which
already has those patches.

/Jarkko
