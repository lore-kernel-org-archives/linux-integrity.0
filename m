Return-Path: <SRS0=R1FS=25=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90603C282DD
	for <linux-integrity@archiver.kernel.org>; Wed,  8 Jan 2020 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BE520678
	for <linux-integrity@archiver.kernel.org>; Wed,  8 Jan 2020 16:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgAHQT4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:19:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:34662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgAHQT4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jan 2020 11:19:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:19:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="254272547"
Received: from dkurtaev-mobl.ccr.corp.intel.com ([10.252.22.167])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2020 08:19:53 -0800
Message-ID: <cf4a3681f3559ae73a97d10625c0535858a3c01e.camel@linux.intel.com>
Subject: Re: [PATCH v4 3/9] security: keys: trusted fix tpm2 authorizations
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Wed, 08 Jan 2020 18:19:52 +0200
In-Reply-To: <1578359313.3251.28.camel@HansenPartnership.com>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-4-James.Bottomley@HansenPartnership.com>
         <c03eb4a8aa3627f58bc45bbc23a4dcd660dc6e2f.camel@linux.intel.com>
         <1578359313.3251.28.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-06 at 17:08 -0800, James Bottomley wrote:
> > Even if for good reasons, you should be explicit when you make an API
> > change that is not backwards compatible.
> 
> This change should be backwards compatible.  I've got a set of TPMs,
> one of which works both before and after and another which doesn't work
> before but does after, so all it does is increase the set of TPMs that
> work with the authorizations i.e. if the TPM worked before, it
> continues to work after.
> 
> I think what happens in the TPMs that work before is that they
> explicily remove trailing zeros and ones that don't work before don't. 
> 
> Actually, the before form (20 hex bytes) still works in the after case
> ... I'll make that clear in the commit message.

OK, got it, thanks! Yeah, obviously would not hurt to be bit more
explicit.

/Jarkko

