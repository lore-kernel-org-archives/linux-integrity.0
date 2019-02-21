Return-Path: <SRS0=/8cw=Q4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34046C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Feb 2019 12:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B98420880
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Feb 2019 12:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfBUMQi (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:16:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:47193 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfBUMQi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Feb 2019 07:16:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 04:16:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="145352083"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.169])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2019 04:16:35 -0800
Date:   Thu, 21 Feb 2019 14:16:35 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH V3] Add support for TPM2 event logs on EFI systems
Message-ID: <20190221121635.GC7918@linux.intel.com>
References: <20190211215518.81419-1-matthewgarrett@google.com>
 <20190219115652.GA29454@linux.intel.com>
 <CACdnJus0nkTtYyVsb71_nN11Oazj2xyR8WoMs6+r+jN=RYos8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJus0nkTtYyVsb71_nN11Oazj2xyR8WoMs6+r+jN=RYos8g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 20, 2019 at 11:28:13AM -0800, Matthew Garrett wrote:
> On Tue, Feb 19, 2019 at 3:56 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > Tried to test with a Geminilake NUC but for some reason do not see the log
> > file with this machine.
> 
> I'll retest a rebased tree on my NUC on Friday - just ran out of time
> to get a build done before I had to leave for a trip.

Great, thanks. I'm in process of getting v19 of SGX patch set out
hopefully next week so probably won't have time to look at this
before latter part of that week.

/Jarkko
