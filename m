Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-db5eur01on0052.outbound.protection.outlook.com ([104.47.2.52]:36843
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751729AbeDKK6Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Apr 2018 06:58:24 -0400
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Martin Townsend <mtownsend1973@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Breno Matheus Lima <brenomatheus@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size
 Error
Date: Wed, 11 Apr 2018 10:58:20 +0000
Message-ID: <VI1PR0402MB3485BDF95BF4D15057420DE198BD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
 <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
 <CAOMZO5DdS-n2taSMsXHAFotCHZdg3Z1in5fy10_5F4Ttwj4vLw@mail.gmail.com>
 <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com>
 <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com>
 <1523399780.3238.30.camel@HansenPartnership.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 4/11/2018 1:36 AM, James Bottomley wrote:
> On Tue, 2018-04-10 at 23:01 +0100, Martin Townsend wrote:
>> Using openssl to get the signature in my x509 cert
>>
>>    Signature Algorithm: sha256WithRSAEncryption
>>          68:82:cc:5d:f9:ee:fb:1a:77:72:a6:a9:c6:4c:cc:d7:f6:2a:
>>          17:a5:db:bf:5a:2b:8d:39:60:dc:a0:93:39:45:0f:bc:a7:e8:
>>          7f:6c:06:84:2d:f3:c1:94:0a:60:56:1c:50:78:dc:34:d1:87:
>>
>> So there's an extra 0x00 and the signature is 257 bytes so I guess
>> this is upsetting CAAM, just need to work out where it's coming from,
>> or whether it's valid and CAAM should be handling it.
> 
> A signature is just a bignum so leading zeros are permitted because
> it's the same numeric value; however, there are normalization
> procedures that require stripping the leading zeros, say before doing a
> hash or other operation which would be affected by them.
> 
> CAAM should definitely handle it on the "be liberal in what you accept"
>  principle.  The kernel should probably remove the leading zeros on the
> "be conservative in what you do" part of the same principle. 
> 
Looking at the generic SW implementation (crypto/rsa.c, rsa_verify()), leading
zeros are removed:
	s = mpi_read_raw_from_sgl(req->src, req->src_len);

CAAM implementation of rsa is not doing this (though it is removing leading
zeros when reading public, private keys).
It has to be fixed. Thanks for the report.

>>   I notice that in my stack trace I have pkcs1pad_verify which
>> suggests some sort of padding?
> 
> Yes, RSA has various forms of padding because the information being
> encrypted is usually much smaller than the encryption unit; PKCS1 is
> the most common (although its now deprecated in favour of OAEP because
> of all the padding oracle problems).
> 
RSA padding has been intentionally added as a template, wrapping "textbook"
(raw) RSA primitives.
For PKCS#1 v1.5, a template instantiation is called pkcs1pad(rsa, hash_alg).

Currently in kernel the only supported RSA padding scheme is PKCS#1 v1.5.
When implemented, another scheme - for e.g. OAEP - would be added in a similar
way, as a template: oaep(rsa, ...).

Horia
