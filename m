Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D212C169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7F221B18
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfBKPyr (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:54:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:37155 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbfBKOfb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 06:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="133360882"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.142])
  by orsmga002.jf.intel.com with ESMTP; 11 Feb 2019 06:35:28 -0800
Date:   Mon, 11 Feb 2019 16:35:27 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V2 1/4] tpm: Abstract crypto agile event size calculations
Message-ID: <20190211143527.GA12051@linux.intel.com>
References: <20190204213303.131064-1-matthewgarrett@google.com>
 <20190204213303.131064-2-matthewgarrett@google.com>
 <20190211142800.GE8431@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211142800.GE8431@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 11, 2019 at 04:28:00PM +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 04, 2019 at 01:33:00PM -0800, Matthew Garrett wrote:
> > +static inline int _calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> > +					struct tcg_pcr_event *event_header)
> 
> Maybe __calc_tpm2_event_size().

Nice to have: add a kdoc since the function is now public e.g. a brief
description how the event size is calculated.

/Jarkko
