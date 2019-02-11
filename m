Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E0DC282CE
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9507C218F0
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfBKQFC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:05:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:36600 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729800AbfBKO2F (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 06:28:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="125561676"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.142])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2019 06:28:01 -0800
Date:   Mon, 11 Feb 2019 16:28:00 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V2 1/4] tpm: Abstract crypto agile event size calculations
Message-ID: <20190211142800.GE8431@linux.intel.com>
References: <20190204213303.131064-1-matthewgarrett@google.com>
 <20190204213303.131064-2-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204213303.131064-2-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 04, 2019 at 01:33:00PM -0800, Matthew Garrett wrote:
> +static inline int _calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> +					struct tcg_pcr_event *event_header)

Maybe __calc_tpm2_event_size().

/Jarkko
