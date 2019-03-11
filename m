Return-Path: <SRS0=7u+B=RO=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5DAC43381
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Mar 2019 13:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BC720657
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Mar 2019 13:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfCKNJM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:09:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:51889 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfCKNJM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Mar 2019 09:09:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 06:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,467,1544515200"; 
   d="scan'208";a="140985195"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.138])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2019 06:09:09 -0700
Date:   Mon, 11 Mar 2019 15:09:08 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: Kernel 5.0 regression in /dev/tpm0 access
Message-ID: <20190311130908.GA7264@linux.intel.com>
References: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
 <1552168908.3442.5.camel@HansenPartnership.com>
 <1552171467.3442.13.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552171467.3442.13.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Mar 09, 2019 at 02:44:27PM -0800, James Bottomley wrote:
> OK, so the polled sequence should be 
> 
> write()
> poll()
> read()
> 
> So I think this condition in tpm_common_poll is the problem:
> 
> 	if (!priv->response_read || priv->response_length)
> 		mask = EPOLLIN | EPOLLRDNORM;

Tadeusz, why on earth the code does not lock buffer_mutex?? Just noticed
when I checked the function in question. It is an awful bug alone.

Maybe I'm missing something but that is the root cause for this mess
i.e. race condition with tpm_common_write().

I'm sorry for not noticing that during the review process :-( So
obviously wrong...

/Jarkko
