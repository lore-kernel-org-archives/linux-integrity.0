Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48594 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbeFBMcy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 2 Jun 2018 08:32:54 -0400
Date: Sat, 2 Jun 2018 15:32:49 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Morris <jmorris@namei.org>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: fix race condition in tpm_common_write()
Message-ID: <20180602123249.GA2939@linux.intel.com>
References: <152702503883.25871.17829919385428251068.stgit@tstruk-mobl1.jf.intel.com>
 <20180523135003.GG363@linux.intel.com>
 <20180530171315.GA23184@linux.intel.com>
 <20180530205438.GA27912@linux.intel.com>
 <alpine.LRH.2.21.1805310954060.15212@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1805310954060.15212@namei.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 31, 2018 at 09:55:00AM +1000, James Morris wrote:
> On Wed, 30 May 2018, Jarkko Sakkinen wrote:
> 
> > Should I make a follow up PR for 4.18 with only this fix included?
> 
> What about for current -rc?

I think so. I will do it.

/Jarkko
