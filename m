Return-Path: <SRS0=yJTw=QF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43DAC169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 13:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0F720989
	for <linux-integrity@archiver.kernel.org>; Tue, 29 Jan 2019 13:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfA2Nsn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:48:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:61481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfA2Nsn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jan 2019 08:48:43 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 05:48:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="134091406"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.127])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2019 05:48:40 -0800
Date:   Tue, 29 Jan 2019 15:48:40 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Subject: Re: TPM2_RC_TESTING and tpm_transmit_cmd
Message-ID: <20190129134840.GA5573@linux.intel.com>
References: <20190122202159.ktlrxewwr7vryayc@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122202159.ktlrxewwr7vryayc@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 22, 2019 at 01:21:59PM -0700, Jerry Snitselaar wrote:
> Would it make sense to filter out TPM2_RC_TESTING when reporting an error
> in tpm_transmit_cmd, or possibly spitting out a follow on message in
> the selftest code that the tpm is still testing?
> 
> Had a bz opened here because someone had the error message in their logs,
> and I can see how it would be confusing. We have the intermittent selftest
> patch already so it should be functioning, but just wondering if not
> printing out that error message would make sense.
> 
> Regards,
> Jerry

Yes, I think so. The caller can decide to print something in this case.

/Jarkko
