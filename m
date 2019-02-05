Return-Path: <SRS0=fuDz=QM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8561BC282CB
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 09:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCEE2080F
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 09:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfBEJ1h (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:27:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:57498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbfBEJ1h (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Feb 2019 04:27:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 01:27:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,562,1539673200"; 
   d="scan'208";a="131640006"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2019 01:27:34 -0800
Date:   Tue, 5 Feb 2019 11:27:32 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com
Subject: Re: your mail
Message-ID: <20190205092732.GC7427@linux.intel.com>
References: <20190204213303.131064-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204213303.131064-1-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 04, 2019 at 01:32:59PM -0800, Matthew Garrett wrote:
> V2: Rebased on top of Roberto's patches, no other changes. Tested on an
> Intel NUC using PTT-based TPM2, binary_bios_measurements contains boot
> events.

Thank you. Looking forward to review this. I'll land Roberto's patches
and then this would be next in the queue.

/Jarkko
