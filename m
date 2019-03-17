Return-Path: <SRS0=1gI3=RU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01511C43381
	for <linux-integrity@archiver.kernel.org>; Sun, 17 Mar 2019 13:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D420828
	for <linux-integrity@archiver.kernel.org>; Sun, 17 Mar 2019 13:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfCQNWy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 17 Mar 2019 09:22:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:12625 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfCQNWy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Mar 2019 09:22:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Mar 2019 06:22:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,489,1544515200"; 
   d="scan'208";a="132323648"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.203])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2019 06:22:30 -0700
Date:   Sun, 17 Mar 2019 15:22:18 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: Kernel 5.0 regression in /dev/tpm0 access
Message-ID: <20190317132218.GA29643@linux.intel.com>
References: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
 <1552168908.3442.5.camel@HansenPartnership.com>
 <1552171467.3442.13.camel@HansenPartnership.com>
 <20190311130908.GA7264@linux.intel.com>
 <14297706-74ef-f178-3b65-e63289919117@intel.com>
 <20190313135926.GA6862@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313135926.GA6862@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 13, 2019 at 03:59:26PM +0200, Jarkko Sakkinen wrote:
> On Tue, Mar 12, 2019 at 03:42:00PM -0700, Tadeusz Struk wrote:
> > Hi Jarkko,
> > On 3/11/19 6:09 AM, Jarkko Sakkinen wrote:
> > > Tadeusz, why on earth the code does not lock buffer_mutex?? Just noticed
> > > when I checked the function in question. It is an awful bug alone.
> > 
> > Because the tpm_common_poll() just reads the flags and doesn't modify
> > them, so the logic was that if the response_length is not 0 or
> > response_read is flase then the first poll should return EPOLLIN
> > and if not, the application should call the poll again and only call read
> > if the EPOLLIN is set in the mask. It looks like the tpm_timeout_work()
> > kicks in and messes things out.
> 
> 1. You have *two* variables that you read, which can lead up reading
>    a partial state.
> 2. You are not using atomic_t even if there was one variable.
> 
> > Looking at it again I think the response_read flag is redundant
> > and only the response_length should be used.
> 
> Please provide a minimal fix to the issue. Only the fix for lock is
> needed and send a proper patch (did not read the code below).

Are you planning to submit a fix for this?

/Jarkko
