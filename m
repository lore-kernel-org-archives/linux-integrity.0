Return-Path: <SRS0=kHfr=QU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8196FC282C2
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 10:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5331520842
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 10:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfBMK50 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:57:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:19655 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfBMK50 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Feb 2019 05:57:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 02:57:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="117558187"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Feb 2019 02:57:22 -0800
Date:   Wed, 13 Feb 2019 12:57:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V3 2/4] tpm: Reserve the TPM final events table
Message-ID: <20190213105722.GD7087@linux.intel.com>
References: <20190211215518.81419-1-matthewgarrett@google.com>
 <20190211215518.81419-3-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211215518.81419-3-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 11, 2019 at 01:55:16PM -0800, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@google.com>
> 
> UEFI systems provide a boot services protocol for obtaining the TPM
> event log, but this is unusable after ExitBootServices() is called.
> Unfortunately ExitBootServices() itself triggers additional TPM events
> that then can't be obtained using this protocol. The platform provides a
> mechanism for the OS to obtain these events by recording them to a
> separate UEFI configuration table which the OS can then map.
> 
> Unfortunately this table isn't self describing in terms of providing its
> length, so we need to parse the events inside it to figure out how long
> it is. Since the table isn't mapped at this point, we need to extend the
> length calculation function to be able to map the event as it goes
> along.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
