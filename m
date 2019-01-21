Return-Path: <SRS0=c8Vu=P5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C73DC7113B
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 12:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFAF2085A
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 12:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfAUM3Q (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:29:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:3025 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbfAUM3P (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jan 2019 07:29:15 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 04:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="127656994"
Received: from vkunnari-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.163])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2019 04:29:12 -0800
Date:   Mon, 21 Jan 2019 14:29:11 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH REVIEW 2/2] tpm_tis: override durations for STM tpm with
 firmware 1.2.8.28
Message-ID: <20190121122911.GB9423@linux.intel.com>
References: <20181214132115.26223-1-aklimov@redhat.com>
 <20181214132115.26223-2-aklimov@redhat.com>
 <20190103131453.GC10491@linux.intel.com>
 <20190114193940.mylziev4xhidmazs@cantor>
 <20190118145930.GE4080@linux.intel.com>
 <20190120213012.w2iyc26dcjk53g42@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120213012.w2iyc26dcjk53g42@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jan 20, 2019 at 02:30:12PM -0700, Jerry Snitselaar wrote:
> On Fri Jan 18 19, Jarkko Sakkinen wrote:
> > On Mon, Jan 14, 2019 at 12:39:40PM -0700, Jerry Snitselaar wrote:
> > > Alexey was following the example of tpm_tis_update_timeouts() which
> > > returns true if the timeouts were updated, and otherwise returns
> > > false. The bool here makes sense to me, but what rc would you suggest
> > > in this case?
> > 
> > Maybe the pattern used there is not that great then.
> > 
> > The callback should simply be update_durations(chip), and it would do
> > whatever updates needed and either return zero or -errno. And of course
> > update durations_adjusted flag because that is needed in sysfs.
> > 
> > /Jarkko
> 
> Taking a quick look, they already track whether the adjustment
> occurred in the tpm_chip struct, so that could be used instead for
> what the bool return was being used for. I'll post a patch for the
> timeout updates code, and work with Alexey to rework his patchset.

Awesome, thank you!

/Jarkko
