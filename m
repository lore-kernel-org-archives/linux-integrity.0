Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from anor.bigon.be ([91.121.173.99]:41494 "EHLO anor.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbdKNA01 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 19:26:27 -0500
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
To: Jerry Snitselaar <jsnitsel@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org
References: <20171024160725.r6kj452jdzpkbb6o@linux.intel.com>
 <8f4df9a9-c8cd-832f-4c3f-5305fabab7a8@debian.org>
 <0a6e4771-f871-b3ca-b5b0-26dbd9efa8b1@debian.org>
 <20171110002820.wtfvb3tv5fcjqecu@localhost.localdomain>
 <20171110070738.ki5xie4z7yql77fk@localhost.localdomain>
 <9245ef7d-dd34-fa5f-6fd9-bfb9582f910e@debian.org>
 <20171110205300.eyfkoyabobv7llgb@localhost.localdomain>
 <20171111154516.GI17451@ziepe.ca> <20171111191257.owuqtgzie3ostsab@cantor>
 <20171111194647.GA6918@ziepe.ca> <20171111203132.hkejjs6cdrrzq3y3@cantor>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <06586f6e-cb43-6fa0-a8b4-cdc34ea90dfc@debian.org>
Date: Tue, 14 Nov 2017 01:26:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171111203132.hkejjs6cdrrzq3y3@cantor>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Le 11/11/17 a 21:31, Jerry Snitselaar a ecrit :
> On Sat Nov 11 17, Jason Gunthorpe wrote:
>> On Sat, Nov 11, 2017 at 12:12:57PM -0700, Jerry Snitselaar wrote:
>>
>>> Before the release_locality code would only actually release the
>>> locality if the request use bit was set. So after it grabbed the
>>> locality during probe it probably never released it. The idea with the
>>> new code was to release it when it was no longer needed so another
>>> requester would be able to take the tpm without having to wait for it
>>> to be released.
>>
>> If I recall, this was so that system level things outside linux could
>> access the TPM properly??
>>
>
> Yes, that is what drove this initially. I believe Jarkko was also
> thinking of the possibility in the future where something like a vm
> could request a locality as well, but that is just a hazy recollection
> of emails from back then.
>
>>> With the old code I think it would have to wait either
>>> until the next time release_locality was called, or attempt to seize
>>> the tpm with the seize bit in the access register. I need to read
>>> through the spec some more, but does the tpm ever force a change when
>>> the request use bit is set, or does it leave it up to the software
>>> to deal with it and only gets involved in the case where the seize
>>> bit has been set?
>>
>> Do we handle these cases? Maybe something like that has happened..
>>
>> Jason
>
> If that is what happened in this case we should see the beenSeized bit
> set in the access register (assuming the chip is doing things properly),
> but it only had the tpmRegValidSts and tpmEstablishment bits set.
>
> There is code in the interrupt handling that notices if the locality
> changes if the chip has that capability, but I don't think there is
> anything that deals with the seize bit. Another thing to be looked
> at.

I don't know if it's relevant, I was looking at the different tpm_* 
tools and tpm_nvinfo is giving me errors with 4.9:

$ sudo tpm_nvinfo  -l debug
Tspi_Context_Create success
Tspi_Context_Connect success
Tspi_Context_GetTpmObject success
Tspi_TPM_GetCapability success
NVRAM index   : 0x00000000 (0)
Tspi_TPM_GetCapability failed: 0x00000002 - layer=tpm, code=0002 (2), Bad memory index

NVRAM index   : 0x10000001 (268435457)
Tspi_TPM_GetCapability failed: 0x00000002 - layer=tpm, code=0002 (2), Bad memory index

NVRAM index   : 0xffffffff (4294967295)
Tspi_TPM_GetCapability failed: 0x00000002 - layer=tpm, code=0002 (2), Bad memory index

Tspi_Context_FreeMemory success
Tspi_Context_Close success
