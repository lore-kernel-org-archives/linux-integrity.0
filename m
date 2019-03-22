Return-Path: <SRS0=JOkf=RZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F903C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39516218E2
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfCVLeI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:55384 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729978AbfCVLeG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 04:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216549901"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.199])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 04:34:02 -0700
Date:   Fri, 22 Mar 2019 13:34:01 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     grawity@gmail.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] tpm: fix an invalid condition in tpm_common_poll
Message-ID: <20190322113401.GL3122@linux.intel.com>
References: <155320933278.5015.1752135965699928631.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <155320933278.5015.1752135965699928631.stgit@tstruk-mobl1.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 21, 2019 at 04:02:12PM -0700, Tadeusz Struk wrote:
> The poll condition should only check response_length,
> because reads should only be issued if there is data to read.
> The response_read flag only prevents double writes.
> The problem was that the write set the response_read to false,
> enqued a tpm job, and returned. Then application called poll
> which checked the response_read flag and returned EPOLLIN.
> Then the application called read, but got nothing.
> After all that the async_work kicked in.
> Added also mutex_lock around the poll check to prevent
> other possible race conditions.
> 

Cc: stable@vger.kernel.org

is missing here.

> Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> Tested-by: Mantas Mikulėnas <grawity@gmail.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

/Jarkko
