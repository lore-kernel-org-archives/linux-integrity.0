Return-Path: <SRS0=3gWa=XG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6D2ECDE20
	for <linux-integrity@archiver.kernel.org>; Wed, 11 Sep 2019 09:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6266721928
	for <linux-integrity@archiver.kernel.org>; Wed, 11 Sep 2019 09:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfIKJgl (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:36:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:60647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfIKJgk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Sep 2019 05:36:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 02:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="175597588"
Received: from dgonsal1-mobl.ger.corp.intel.com (HELO localhost) ([10.249.38.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2019 02:36:38 -0700
Date:   Wed, 11 Sep 2019 10:36:37 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>, jejb@linux.ibm.com
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: KEYS-TRUSTED git
Message-ID: <20190911093637.GA21744@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com>
 <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
 <20190910114336.GA7018@linux.intel.com>
 <20190911092708.GA20023@linux.intel.com>
 <20190911092926.GA20970@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911092926.GA20970@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 11, 2019 at 10:29:26AM +0100, Jarkko Sakkinen wrote:
> On Wed, Sep 11, 2019 at 10:27:08AM +0100, Jarkko Sakkinen wrote:
> > On Tue, Sep 10, 2019 at 12:43:36PM +0100, Jarkko Sakkinen wrote:
> > > On Mon, Sep 09, 2019 at 11:57:45AM +0530, Sumit Garg wrote:
> > > > @Jarkko: No worries, I understand the situation.
> > > 
> > > I made the call to add them anyway to my TPM tree.
> > 
> > Also,
> > 
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > I think I give a shot of doing one more PR to 5.4 because that would
> > help both your and James' work because this is the kind of intersection
> > point betwen them.
> 
> Polished short summaries a bit:
> 
> 1. Start with capital letter.
> 2. s/tpm2/TPM2/g

Now also in my next branch. I wait for 24h or so and if no alarms are
rised I'll send a PR. The code changes for the most part mechanically
move stuff, which makes me confident that I can still do a PR with
these changes.

/Jarkko
