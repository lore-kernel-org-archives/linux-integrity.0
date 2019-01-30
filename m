Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC196C282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 21:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C640218AF
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 21:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfA3VYa (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:24:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:12816 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbfA3VYa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 16:24:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 13:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,542,1539673200"; 
   d="scan'208";a="271255640"
Received: from unknown (HELO localhost) ([10.249.254.216])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2019 13:24:27 -0800
Date:   Wed, 30 Jan 2019 23:24:26 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] tpm: don't return bool from update_timeouts
Message-ID: <20190130212426.GC17308@linux.intel.com>
References: <20190129174145.1482-1-jsnitsel@redhat.com>
 <20190129201415.739-1-jsnitsel@redhat.com>
 <20190130212303.GB17308@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130212303.GB17308@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 30, 2019 at 11:23:03PM +0200, Jarkko Sakkinen wrote:
> On Tue, Jan 29, 2019 at 01:14:15PM -0700, Jerry Snitselaar wrote:
> > Set tpm_chip->timeouts_adjusted directly in the update_timeouts
> > code instead of returning bool. In case of tpm read failing
> > print warning that the read failed and continue on.
> > 
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Hey, can you-re-send this without RFC and the earlier that I already
applied to my tree, with CC to linux-kernel and linux-security-module?

Keep my reviewed-by in both.

Otherwise, I cannot include these into my next PR.

/Jarkko
