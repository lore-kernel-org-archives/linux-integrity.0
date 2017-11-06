Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19027 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754171AbdKFXbe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2017 18:31:34 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH RFC] tpm: Keep CLKRUN enabled throughout the duration of
 transmit_cmd()
Date: Mon, 6 Nov 2017 23:31:32 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582896ADF9@ORSMSX109.amr.corp.intel.com>
References: <1509751809-148601-1-git-send-email-azhar.shaikh@intel.com>
 <20171106170741.GH26011@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896ADAB@ORSMSX109.amr.corp.intel.com>
 <20171106223932.GA21466@ziepe.ca>
In-Reply-To: <20171106223932.GA21466@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
>Sent: Monday, November 6, 2017 2:40 PM
>To: Shaikh, Azhar <azhar.shaikh@intel.com>
>Cc: Sakkinen, Jarkko <jarkko.sakkinen@intel.com>; linux-
>integrity@vger.kernel.org
>Subject: Re: [PATCH RFC] tpm: Keep CLKRUN enabled throughout the duration
>of transmit_cmd()
>
>On Mon, Nov 06, 2017 at 10:11:39PM +0000, Shaikh, Azhar wrote:
>
>> >Why are you using a mixture of callbacks and linked functions to
>> >solve this problem?
>> >
>> >Can't you do everything with callbacks?
>> >
>>
>> I have set the flag TPM_TIS_CLK_ENABLE in the callback. But then in
>> tpm_platform_begin_xfer() I want it to run once to disable clkrun and
>> then return for all other instances, till the the flag is cleared.  If
>> I just set the flag in tpm_tis_clkrun_toggle(), then for any TPM
>> transaction after that the clkrun will not be disabled with current
>> implementation. Hence calling it once before setting the flag so that
>> it is kept enabled for the next transaction.
>
>I mean, why do we have global functions called tpm_platform_begin_xfer at
>all, everything should be in a callback, not some mixture.
>
>The static function sort of made sense when it was only ever called by the tis
>driver, but now that you are hoisting things up a layer it is not okay anymore,
>you need to add new driver callbacks instead.
>

Ok, will not call tpm_platform_begin_xfer() from the callback function and make it back static again to keep it within tis driver only.

>> +++ b/drivers/char/tpm/tpm_tis.c
>> @@ -140,6 +140,7 @@ static int check_acpi_tpm2(struct device *dev)
>>  #define LPC_CLKRUN_EN                   (1 << 2)
>>
>>  static void __iomem *ilb_base_addr;
>> +static bool run_once;
>
>No global statics. The ilb_base_addr global is really ugly you should move it to
>struct tpm_tis_tcg_phy
>

Ok, I will do this as a separate patch.

>Jason
