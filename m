Return-Path: <SRS0=dywO=OM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C741DC04EB9
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFDD20848
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 17:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFDD20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeLCRzP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:55:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:23801 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeLCRzO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Dec 2018 12:55:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 09:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="115679470"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.10.74])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2018 09:55:10 -0800
Date:   Mon, 3 Dec 2018 09:55:09 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Huewe <PeterHuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: Re: TPM legacy
Message-ID: <20181203175509.GA10562@linux.intel.com>
References: <20181130233501.GA32256@linux.intel.com>
 <1543764226.4216.205.camel@linux.ibm.com>
 <1543775366.2732.24.camel@HansenPartnership.com>
 <20181202231327.GC6718@linux.intel.com>
 <trinity-c862f498-65a2-43f4-a4b3-94cc4b8e1c66-1543849298447@3c-app-gmx-bs70>
 <20181203172922.GA12237@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203172922.GA12237@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 03, 2018 at 10:29:22AM -0700, Jason Gunthorpe wrote:
> On Mon, Dec 03, 2018 at 04:01:38PM +0100, Peter Huewe wrote:
> 
> > The only thing I would want to get rid of are the *1.1b based*
> > drivers - they are probably end of life since quite some time.  The
> > TIS driver&specification has been around since 2005 if not longer...
> 
> I also wanted to do this, I feel like these drivers probably don't
> work any more after all the churn in the past few years..

I'm with you on this but yeah, better to do it now so that it gets
maximum exposure in linux-next (i.e. would land to 4.22).

/Jarkko
