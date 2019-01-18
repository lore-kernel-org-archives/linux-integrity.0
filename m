Return-Path: <SRS0=DQCd=P2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD3AC43387
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 15:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAC52086D
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 15:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfARPPs (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:15:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:37484 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfARPPs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jan 2019 10:15:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 07:15:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="139411596"
Received: from unknown (HELO localhost) ([10.249.254.249])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2019 07:15:44 -0800
Date:   Fri, 18 Jan 2019 17:15:41 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 2/5] tpm: Fix event log types for TPM2
Message-ID: <20190118151541.GJ4080@linux.intel.com>
References: <20190109014847.39980-1-matthewgarrett@google.com>
 <20190109014847.39980-3-matthewgarrett@google.com>
 <20190116214227.GA25803@linux.intel.com>
 <9f794f5f-e596-6b0d-563e-a6c7f16f9b6a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f794f5f-e596-6b0d-563e-a6c7f16f9b6a@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 17, 2019 at 08:53:18AM +0100, Roberto Sassu wrote:
> On 1/16/2019 10:42 PM, Jarkko Sakkinen wrote:
> > On Tue, Jan 08, 2019 at 05:48:44PM -0800, Matthew Garrett wrote:
> > > From: Matthew Garrett <mjg59@google.com>
> > > 
> > > These structs are defined as having variable length members, not fixed
> > > size ones. Fix that up and rename them to more accurately describe the
> > > only safe way they can be used, and fix the code that relied on having
> > > fixed structures.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > 
> > This collides with Roberto's work. How this must be worked out is to
> > first merge Roberto's patches and then this patch set should be aligned
> > with that baseline.
> > 
> > Roberto, are you ready to send soon an updated version? When you do,
> > please cc the patches to Matthew. Matthew, what you should do is to
> > review Roberto's patches and give him feedback so that his changes
> > will work for you. Right now the only "customer" is IMA.
> 
> I will check your comment about patch 5/5 and reply.

Great, thank you. And CC everything to Matthew.

/Jarkko
