Return-Path: <SRS0=yJTw=QF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B44DC169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 21:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE94620881
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 21:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfA2VMX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:12:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:41467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfA2VMX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jan 2019 16:12:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 13:12:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="138956786"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2019 13:12:21 -0800
Date:   Tue, 29 Jan 2019 23:12:27 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] tpm: don't return bool from update_timeouts
Message-ID: <20190129211227.GB18819@linux.intel.com>
References: <20190129174145.1482-1-jsnitsel@redhat.com>
 <20190129174145.1482-2-jsnitsel@redhat.com>
 <20190129192205.GA14305@linux.intel.com>
 <20190129195031.7lxlj4ahbxl3d46a@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129195031.7lxlj4ahbxl3d46a@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 29, 2019 at 12:50:31PM -0700, Jerry Snitselaar wrote:
> On Tue Jan 29 19, Jarkko Sakkinen wrote:
> > On Tue, Jan 29, 2019 at 10:41:45AM -0700, Jerry Snitselaar wrote:
> > > Set tpm_chip->timeouts_adjusted directly in the update_timeouts
> > > code instead of returning bool. Return rc of tpm read instead,
> > > which can be return an error in the case of the spi driver.
> > > 
> > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > Couple of remarks:
> > 
> > 1. Shouldn't it then be just void?
> 
> Yes I think if we don't really care about the tpm read failing
> it can just be void, and print out a warning when the read fail
> occurs.

I don't think we care.

> > 2. Why do we even need timeout_adjusted in struct tpm_chip [1]?
> 
> It gets used by timeouts_show in tpm-sysfs.c as well.

Ugh, dejavu :-) I've made this same false remark at least once
before.

/Jarkko
