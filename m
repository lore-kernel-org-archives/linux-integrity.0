Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:12541 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbeABFbc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jan 2018 00:31:32 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 1/2] tpm_tis: Move ilb_base_addr to tpm_tis_data
Date: Tue, 2 Jan 2018 05:31:30 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582898A05E@ORSMSX109.amr.corp.intel.com>
References: <1514865944-95086-1-git-send-email-azhar.shaikh@intel.com>
 <1514865944-95086-2-git-send-email-azhar.shaikh@intel.com>
 <20180102044044.GA29208@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582898A03C@ORSMSX109.amr.corp.intel.com>
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF582898A03C@ORSMSX109.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
>owner@vger.kernel.org] On Behalf Of Shaikh, Azhar
>Sent: Monday, January 1, 2018 9:02 PM
>To: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: jarkko.sakkinen@linux.intel.com; peterhuewe@gmx.de; linux-security-
>module@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: RE: [PATCH v8 1/2] tpm_tis: Move ilb_base_addr to tpm_tis_data
>
>
>
>>-----Original Message-----
>>From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
>>Sent: Monday, January 1, 2018 8:41 PM
>>To: Shaikh, Azhar <azhar.shaikh@intel.com>
>>Cc: jarkko.sakkinen@linux.intel.com; peterhuewe@gmx.de; linux-security-
>>module@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
>>kernel@vger.kernel.org
>>Subject: Re: [PATCH v8 1/2] tpm_tis: Move ilb_base_addr to tpm_tis_data
>>
>>On Mon, Jan 01, 2018 at 08:05:43PM -0800, Azhar Shaikh wrote:
>>
>>> -	return tpm_chip_register(chip);
>>> +	rc = tpm_chip_register(chip);
>>> +	if (rc && is_bsw())
>>> +		iounmap(priv->ilb_base_addr);
>>> +
>>> +	return rc;
>>>  out_err:
>>>  	tpm_tis_remove(chip);
>>> +	if (is_bsw())
>>> +		iounmap(priv->ilb_base_addr);
>>> +
>>>  	return rc;
>>>  }
>>
>>I thought you were resending this to fix the above, why is is it still wonky?
>>
>
>Oh! I fixed it in the second patch ("tpm: Keep CLKRUN enabled throughout
>the duration of transmit_cmd()"). Should have fixed in this patch instead. My
>bad, didn't see it was introduced in this patch. I thought it was part of second
>patch. Will fix this.
>

On checking, the ops->clk_enable is not still introduced yet. It is introduced in the second patch. The cleanup is done in the next patch.
So do you want me to still fix this here?

>>Jason

Regards,
Azhar Shaikh
