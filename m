Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51282 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753581AbdKOTiF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 14:38:05 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH RFC v2 2/2] tpm_tis: Move ilb_base_addr to
 tpm_tis_tcg_phy
Date: Wed, 15 Nov 2017 19:36:47 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582896DAEB@ORSMSX109.amr.corp.intel.com>
References: <1510090328-153106-1-git-send-email-azhar.shaikh@intel.com>
 <1510090328-153106-3-git-send-email-azhar.shaikh@intel.com>
 <20171114232812.GB25894@ziepe.ca>
 <20171115081408.7jzoyxbycuw7y3w6@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Shaikh, Azhar
>Sent: Wednesday, November 15, 2017 9:59 AM
>To: Sakkinen, Jarkko <jarkko.sakkinen@intel.com>; Jason Gunthorpe
><jgg@ziepe.ca>
>Cc: linux-integrity@vger.kernel.org
>Subject: RE: [PATCH RFC v2 2/2] tpm_tis: Move ilb_base_addr to
>tpm_tis_tcg_phy
>
>
>
>>-----Original Message-----
>>From: Sakkinen, Jarkko
>>Sent: Wednesday, November 15, 2017 12:14 AM
>>To: Jason Gunthorpe <jgg@ziepe.ca>
>>Cc: Shaikh, Azhar <azhar.shaikh@intel.com>;
>>linux-integrity@vger.kernel.org
>>Subject: Re: [PATCH RFC v2 2/2] tpm_tis: Move ilb_base_addr to
>>tpm_tis_tcg_phy
>>
>>On Tue, Nov 14, 2017 at 04:28:12PM -0700, Jason Gunthorpe wrote:
>>> On Tue, Nov 07, 2017 at 01:32:08PM -0800, Azhar Shaikh wrote:
>>>
>>> > +#ifdef CONFIG_X86
>>> > +	if (is_bsw())
>>> > +		iounmap(phy->ilb_base_addr);
>>> > +#endif
>>>
>>> This whole thing would be much better if is_bsw was just
>>>
>>> bool is_bsw(void)
>>> {
>>>    if (!IS_ENABLED(CONFIG_X86))
>>>        return false;
>>>    [..]
>>> }
>>>
>>> Then drop every single one of these #ifdef CONFIG_X86
>>>
>>> Jason
>>
>>+1
>>
>
>Thank you for the suggestion.
>Will incorporate this in next patch series.
>

If I implement is_bsw() as below and move it(is_bsw()) outside the #ifdef CONFIG_X86, I will still get compilation errors for non-x86 platforms, since INTEL_FAM6_ATOM_AIRMONT will be undefined. 

bool is_bsw(void)
{
    if (!IS_ENABLED(CONFIG_X86))
        return false;
return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1 : 0);
}

I think I will have to keep is_bsw() implementation unchanged?

>>/Jarkko
