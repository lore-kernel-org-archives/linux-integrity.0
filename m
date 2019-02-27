Return-Path: <SRS0=nfu5=RC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7682BC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1E220643
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfB0RZt (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:25:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:45742 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbfB0RZj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 12:25:39 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="278328615"
Received: from unknown (HELO localhost) ([10.249.254.142])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2019 09:25:37 -0800
Date:   Wed, 27 Feb 2019 19:25:35 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: About PureBoot and TPM based DRM's
Message-ID: <20190227172535.GA3848@linux.intel.com>
References: <20190227155611.GA7434@linux.intel.com>
 <1551286651.3105.11.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551286651.3105.11.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 27, 2019 at 08:57:31AM -0800, James Bottomley wrote:
> On Wed, 2019-02-27 at 17:56 +0200, Jarkko Sakkinen wrote:
> > Just read this:
> > 
> > https://puri.sm/posts/pureboot-the-high-security-boot-process/
> > 
> > Makes me ask: where are these TPM based DRM's? Never seen one but I
> > assume they exist. Anyway cool work otherwise.
> 
> Actually, they don't, the article is just restating a common
> misconception that the TPM is used to enforce DRM and then saying
> they've found a non-evil use for it which, apparently, is using the TPM
> for standard key storage and measurement.  Apparently this means we're
> also all working on non-evil uses ...

*Might* be that Palladium that was canceled from Windows Vista might be
the seed of this misconception. It seems to have spread about somewhat
similar discussions when it still was coming.

/Jarkko
