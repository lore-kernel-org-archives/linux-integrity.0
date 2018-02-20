Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31167 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbeBTRKX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 12:10:23 -0500
Message-ID: <1519146619.6941.0.camel@linux.intel.com>
Subject: Re: [PATCH v2] tpm: fix intermittent failure with self tests
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org
Date: Tue, 20 Feb 2018 19:10:19 +0200
In-Reply-To: <1519044991.4721.7.camel@HansenPartnership.com>
References: <1518813108.4419.3.camel@HansenPartnership.com>
         <20180219123244.ucno7eaqupwko6ff@linux.intel.com>
         <1519044991.4721.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-19 at 07:56 -0500, James Bottomley wrote:
> On Mon, 2018-02-19 at 14:32 +0200, Jarkko Sakkinen wrote:
> > Trying to figure out how this was never merged. Sorry about that.
> > I'll take the blame from this :-( I'll test this commit ASAP.
> 
> Actually, could you test v3 (just posted).  Also, I'm going to have
> someone run v3 on another failing TPM today (the ST Micro) so I
> should
> get a tested-by as well if it works.
> 
> Thanks,
> 
> James

Yes.

/Jarkko
