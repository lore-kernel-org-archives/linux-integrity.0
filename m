Return-Path: <SRS0=sWjp=PY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C2BC43387
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 21:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D45E20866
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 21:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbfAPVme (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:42:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:38168 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfAPVme (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Jan 2019 16:42:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 13:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="117272898"
Received: from lhaqq1-mobl2.amr.corp.intel.com (HELO localhost) ([10.249.254.231])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 13:42:29 -0800
Date:   Wed, 16 Jan 2019 23:42:27 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        roberto.sassu@huawei.com
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 2/5] tpm: Fix event log types for TPM2
Message-ID: <20190116214227.GA25803@linux.intel.com>
References: <20190109014847.39980-1-matthewgarrett@google.com>
 <20190109014847.39980-3-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109014847.39980-3-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 08, 2019 at 05:48:44PM -0800, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@google.com>
> 
> These structs are defined as having variable length members, not fixed
> size ones. Fix that up and rename them to more accurately describe the
> only safe way they can be used, and fix the code that relied on having
> fixed structures.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

This collides with Roberto's work. How this must be worked out is to
first merge Roberto's patches and then this patch set should be aligned
with that baseline.

Roberto, are you ready to send soon an updated version? When you do,
please cc the patches to Matthew. Matthew, what you should do is to
review Roberto's patches and give him feedback so that his changes
will work for you. Right now the only "customer" is IMA.

So yeah, this how I would like to prioritize things. I'll hold on for
detailed review for your patches up until Roberto's patches have been
merged because there is just too much intersection.

/Jarkko
