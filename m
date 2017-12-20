Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33094 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755943AbdLTSKI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 13:10:08 -0500
Received: by mail-io0-f181.google.com with SMTP id t196so18243409iof.0
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 10:10:08 -0800 (PST)
Date: Wed, 20 Dec 2017 11:10:05 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 2/4] tpm: delete the TPM_TIS_CLK_ENABLE flag
Message-ID: <20171220181005.GC22908@ziepe.ca>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-3-javierm@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828988730@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF5828988730@ORSMSX109.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 20, 2017 at 03:19:19PM +0000, Shaikh, Azhar wrote:
> >This flag is only used to warn if CLKRUN_EN wasn't disabled on Braswell
> >systems, but the only way this can happen is if the code is not correct.
> >
> >So it's an unnecessary check that just makes the code harder to read.
> 
> This code was implemented as a suggestion from Jason on the previous patches. 
> https://www.spinics.net/lists/linux-integrity/msg00827.html

The concept was to be like ASSERT_RTNL, maybe it just needs a suitably
named static inline to addrress Javier's readability concerns?

Jason
