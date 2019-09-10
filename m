Return-Path: <SRS0=Ztmh=XF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1277CC4740A
	for <linux-integrity@archiver.kernel.org>; Tue, 10 Sep 2019 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CDD20863
	for <linux-integrity@archiver.kernel.org>; Tue, 10 Sep 2019 14:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfIJOV3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:21:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:41438 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730779AbfIJOV3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 10:21:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 07:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="185520736"
Received: from agreppma-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.7])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2019 07:21:26 -0700
Date:   Tue, 10 Sep 2019 15:21:25 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        sumit.garg@linaro.org
Subject: Re: KEYS-TRUSTED git
Message-ID: <20190910142114.GA8682@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com>
 <20190909165200.npxq3hkft4bddv6v@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909165200.npxq3hkft4bddv6v@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 05:52:00PM +0100, Jarkko Sakkinen wrote:
> On Sun, Sep 08, 2019 at 10:20:31AM -0400, Mimi Zohar wrote:
> > Thanks, Jarkko.  Agreed, trusted keys is becoming more than just TPM
> > based keys.  Now would be a good time to set up at least a separate
> > branch or GIT repo.
> 
> I created a tree for trusted keys:
> 
> http://git.infradead.org/users/jjs/linux-trusted-keys.git
> 
> The remaining issue before I send a patch to update MAINTAINERS is whether
> the flow goes through David to Linus or directly to Linus.

I use my tpmdd tree for trusted-keys changes too. For me managing two
trees is only adds to work and probably does not add that much value to
anyone else. The only glitch is the tree's name...

/Jarkko
