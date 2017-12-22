Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25253 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756515AbdLVSiM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 13:38:12 -0500
Date: Fri, 22 Dec 2017 20:38:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 2/4] tpm: delete the TPM_TIS_CLK_ENABLE flag
Message-ID: <20171222183807.qoqqfptkes42f4rh@linux.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-3-javierm@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828988730@ORSMSX109.amr.corp.intel.com>
 <20171220181005.GC22908@ziepe.ca>
 <1cde2001-9ec0-02b3-42cc-11e931c0b22a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1cde2001-9ec0-02b3-42cc-11e931c0b22a@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 20, 2017 at 07:26:03PM +0100, Javier Martinez Canillas wrote:
> On 12/20/2017 07:10 PM, Jason Gunthorpe wrote:
> > On Wed, Dec 20, 2017 at 03:19:19PM +0000, Shaikh, Azhar wrote:
> >>> This flag is only used to warn if CLKRUN_EN wasn't disabled on Braswell
> >>> systems, but the only way this can happen is if the code is not correct.
> >>>
> >>> So it's an unnecessary check that just makes the code harder to read.
> >>
> >> This code was implemented as a suggestion from Jason on the previous patches. 
> >> https://www.spinics.net/lists/linux-integrity/msg00827.html
> > 
> > The concept was to be like ASSERT_RTNL, maybe it just needs a suitably
> > named static inline to addrress Javier's readability concerns?
> >
> 
> I really think is not worth it and pollutes all the tpm_tcg_{read,write}
> functions with those is_bsw() and flags checks. Your example is different
> since is a core API used by in lot of places in the kernel, but it's not
> the case here.
> 
> But I don't have a strong opinion either, it was Jarkko who questioned
> the value of the flag so I can drop this patch too if you disagree with
> the change. I'm mostly interested in PATCH 4/4 that's the actual fix.

Not going to fight over this one. I would apply the patch but if there
is strong opposition I can reconsider.

/Jarkko
