Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17650 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752406AbdKTTeJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 14:34:09 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Date: Mon, 20 Nov 2017 19:34:07 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582896E9A7@ORSMSX109.amr.corp.intel.com>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
 <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
 <20171120183441.GC29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E937@ORSMSX109.amr.corp.intel.com>
 <20171120192117.GJ29075@ziepe.ca>
In-Reply-To: <20171120192117.GJ29075@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
>owner@vger.kernel.org] On Behalf Of Jason Gunthorpe
>Sent: Monday, November 20, 2017 11:21 AM
>To: Shaikh, Azhar <azhar.shaikh@intel.com>
>Cc: jarkko.sakkinen@linux.intel.com; peterhuewe@gmx.de; linux-
>integrity@vger.kernel.org
>Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
>duration of transmit_cmd()
>
>On Mon, Nov 20, 2017 at 06:52:13PM +0000, Shaikh, Azhar wrote:
>
>> We want to have the CLKRUN disabled for any/all TPM transactions.
>> The clk_toggle handles only the case while a TPM command is being sent
>> and received.  We have to take into consideration other places too
>> where TPM access is happening outside the TPM command flow. For
>> eg: request_locality, check_locality, release_locality, wait_startup
>> which might be called outside the flow of a TPM command.
>
>Okay, this makes sense, and would be good to touch on in the commit
>description if it stays this way, IMHO.

Sure, I will add this in the commit message.

>
>However, why not have check_locality, release_locality, wait_startup use
>clk_toggle instead? That seems better to me??
>

I think, better to have the clk disable/enable at one place instead of adding it all  locations where TPM access is done. The clk_toggle is kind of a special case where, for the complete duration of the TPM command processing, the CLKRUN protocol was supposed to be disabled. For rest of the places we can disable and re-enable the clkrun as soon as possible.

Also since it is part of the read/write APIs we won't miss any other location in the code where TPM access is done.

>> Will change it to clk_enable.  Should I then upload the next patch for
>> review and remove the "RFC" tag now? And if so, should I retain the
>> change history of the patch versions?
>
>Yes for both.
>
>I think we are well past the RFC stage now :)
>

Thank you :)
I will post the next patchset and remove the RFC tag.

>Jason

Regards,
Azhar Shaikh
