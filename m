Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41683 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758928AbdKOT5e (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 14:57:34 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH RFC v2 2/2] tpm_tis: Move ilb_base_addr to
 tpm_tis_tcg_phy
Date: Wed, 15 Nov 2017 19:57:31 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582896DB32@ORSMSX109.amr.corp.intel.com>
References: <1510090328-153106-1-git-send-email-azhar.shaikh@intel.com>
 <1510090328-153106-3-git-send-email-azhar.shaikh@intel.com>
 <20171114232812.GB25894@ziepe.ca>
 <20171115081408.7jzoyxbycuw7y3w6@intel.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896DAEB@ORSMSX109.amr.corp.intel.com>
 <20171115193957.GT25894@ziepe.ca>
In-Reply-To: <20171115193957.GT25894@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
>Sent: Wednesday, November 15, 2017 11:40 AM
>To: Shaikh, Azhar <azhar.shaikh@intel.com>
>Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; linux-
>integrity@vger.kernel.org
>Subject: Re: [PATCH RFC v2 2/2] tpm_tis: Move ilb_base_addr to
>tpm_tis_tcg_phy
>
>On Wed, Nov 15, 2017 at 07:36:47PM +0000, Shaikh, Azhar wrote:
>
>> If I implement is_bsw() as below and move it(is_bsw()) outside the #ifdef
>CONFIG_X86, I will still get compilation errors for non-x86 platforms, since
>INTEL_FAM6_ATOM_AIRMONT will be undefined.
>>
>> bool is_bsw(void)
>> {
>>     if (!IS_ENABLED(CONFIG_X86))
>>         return false;
>> return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1
>: 0);
>> }
>>
>> I think I will have to keep is_bsw() implementation unchanged?
>
>No, still move the #ifdef to is_bsw, just like this instead:
>
>bool is_bsw(void)
>{
>#ifdef CONFIG_X86
>     return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1
>     : 0);
>#else
>     return false;
>#endif
>}
>


Ok, sure.
Should have thought myself about this... :(

>Jason
