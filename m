Return-Path: <SRS0=SF38=OL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA763C04EB8
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 23:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49DB20892
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 23:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49DB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbeLBXN3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:13:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:14662 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeLBXN3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Dec 2018 18:13:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2018 15:13:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,308,1539673200"; 
   d="scan'208";a="104105473"
Received: from trhammer-mobl.amr.corp.intel.com (HELO localhost) ([10.254.49.188])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2018 15:13:27 -0800
Date:   Sun, 2 Dec 2018 15:13:27 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: TPM legacy
Message-ID: <20181202231327.GC6718@linux.intel.com>
References: <20181130233501.GA32256@linux.intel.com>
 <1543764226.4216.205.camel@linux.ibm.com>
 <1543775366.2732.24.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543775366.2732.24.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 02, 2018 at 10:29:26AM -0800, James Bottomley wrote:
> The distros won't thank you for yet another kconfig option. ,
> especially one which could cause regressions if they choose the wrong
> value. However, having a hidden one which could be activated by driver
> might work ... on the other hand almost all the current drivers support
> both 1.2 and 2.0 so they'd all need splitting.

By default on (i.e. have TPM 1.x) and with a well thought documentation
should not be too bad.

> The other thing that should give us pause is this:
> 
> jejb@jarvis:~/git/linux/drivers/char/tpm> size tpm.o
>    text	   data	    bss	    dec	    hex	
> filename
>   35247	   1120	     32	  36399	   8e2f	
> tpm.o
> 
> Currently the combined tpm subsystem (without drivers) is less than 36k
> of code, so is splitting it up valuable?  I think you're going to find
> we have a reasonable abstraction of sharing, so taking out 1.x by
> config will likely save less than 10k of code ... is that worth the
> effort?

It is not only a size question. All unused code is always potential
attack surface. If the option is by default off and properly documented,
it should be IMHO ok.

It is fairly easy to do as TPM 1.x commands have been already put into
their own file thanks to Tomas.

/Jarkko
