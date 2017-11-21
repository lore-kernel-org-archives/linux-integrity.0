Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:35053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751281AbdKUTS1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 14:18:27 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Date: Tue, 21 Nov 2017 19:18:25 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582896EE30@ORSMSX109.amr.corp.intel.com>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
 <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
 <20171120183441.GC29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E937@ORSMSX109.amr.corp.intel.com>
 <20171120192117.GJ29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E9A7@ORSMSX109.amr.corp.intel.com>
 <20171120193829.GM29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896EA2E@ORSMSX109.amr.corp.intel.com>
 <20171120232604.GS29075@ziepe.ca>
In-Reply-To: <20171120232604.GS29075@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
>Sent: Monday, November 20, 2017 3:26 PM
>To: Shaikh, Azhar <azhar.shaikh@intel.com>
>Cc: jarkko.sakkinen@linux.intel.com; peterhuewe@gmx.de; linux-
>integrity@vger.kernel.org
>Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
>duration of transmit_cmd()
>
>On Mon, Nov 20, 2017 at 09:19:37PM +0000, Shaikh, Azhar wrote:
>
>> -> tpm_tis_core_init()
>
>Yes, and IIRC, this covers tpm_tis_update_timeouts() too?
>

tpm_tis_update_timeouts() doesn't seem to be covered by tpm_tis_core_init(). I cannot find tpm_tis_update_timeouts() called from any function.

>> -> tpm_tis_plat_remove()
>
>This should be in tpm_tis_remove and a little rework would be needed here
>
>> -> tpm_tis_reenable_interrupts()
>> -> tpm_transmit_cmd() [ Already implemented in this patch ]
>
>Yes
>
>> >You could add a debug to ensure that read/write is never without
>> >clk_enable being held.
>>
>> Sorry, but I didn't get this, adding a debug part.
>
>Just check a flag in the read/write functions to see if clkrun is on and WARN if
>not
>
>Not sure if this is going to be overall better than what you have or not.. But
>considering the nature of the bug it seems safer to have a wider range when
>CLKRUN is working?
>

Having a wider range would mean clocks running for a bit longer duration than current implementation, which might have power implications, minimal though, would be good if we could avoid it from here :-)
Also since this patch has already passed rigorous testing as mentioned earlier, hence would be good if we have the current implementation as it is.

>Jason
