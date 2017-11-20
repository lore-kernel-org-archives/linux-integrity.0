Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:39832 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751109AbdKTVTk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 16:19:40 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Date: Mon, 20 Nov 2017 21:19:37 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582896EA2E@ORSMSX109.amr.corp.intel.com>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
 <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
 <20171120183441.GC29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E937@ORSMSX109.amr.corp.intel.com>
 <20171120192117.GJ29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E9A7@ORSMSX109.amr.corp.intel.com>
 <20171120193829.GM29075@ziepe.ca>
In-Reply-To: <20171120193829.GM29075@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
>Sent: Monday, November 20, 2017 11:38 AM
>To: Shaikh, Azhar <azhar.shaikh@intel.com>
>Cc: jarkko.sakkinen@linux.intel.com; peterhuewe@gmx.de; linux-
>integrity@vger.kernel.org
>Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
>duration of transmit_cmd()
>
>On Mon, Nov 20, 2017 at 07:34:07PM +0000, Shaikh, Azhar wrote:
>
>> >However, why not have check_locality, release_locality, wait_startup
>> >use clk_toggle instead? That seems better to me??
>> >
>>
>> I think, better to have the clk disable/enable at one place instead of
>> adding it all locations where TPM access is done. The clk_toggle is
>> kind of a special case where, for the complete duration of the TPM
>> command processing, the CLKRUN protocol was supposed to be disabled.
>> For rest of the places we can disable and re-enable the clkrun as soon
>> as possible.
>
>> Also since it is part of the read/write APIs we won't miss any other
>> location in the code where TPM access is done.
>
>But I wonder if you will hit the same bug that motivated this change in the
>other places?
>

I guess not, since, I have tested this patch on 6 devices which completed 10000 suspend/resume cycles successfully.
This is also one of the reason to keep tpm_platform_begin_xfer and tpm_platform_end_xfer functions.

>It seems clearer to me to have a strong guard of the clock across the entire
>high level action, since this hardware is so broken.
>

So, I should remove the tpm_platform_begin_xfer and tpm_platform_end_xfer functions and have that code in clk_toggle(clk_enable).
And then for having  high level action, I will have to add 

+if (chip->ops->clk_toggle != NULL)
+               chip->ops->clk_toggle(chip, true);
..
..
<snip>
+       if (chip->ops->clk_toggle != NULL)
+               chip->ops->clk_toggle(chip, false);


In 
-> tpm_tis_core_init()
-> tpm_tis_plat_remove()
-> tpm_tis_reenable_interrupts()
-> tpm_tis_update_timeouts()
-> tpm_transmit_cmd() [ Already implemented in this patch ]

>You could add a debug to ensure that read/write is never without clk_enable
>being held.
>

Sorry, but I didn't get this, adding a debug part.

>Jason
