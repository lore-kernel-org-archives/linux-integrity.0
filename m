Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36581 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbeDKL4J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Apr 2018 07:56:09 -0400
MIME-Version: 1.0
In-Reply-To: <1523399780.3238.30.camel@HansenPartnership.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
 <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
 <CAOMZO5DdS-n2taSMsXHAFotCHZdg3Z1in5fy10_5F4Ttwj4vLw@mail.gmail.com>
 <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com>
 <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com> <1523399780.3238.30.camel@HansenPartnership.com>
From: Martin Townsend <mtownsend1973@gmail.com>
Date: Wed, 11 Apr 2018 12:56:07 +0100
Message-ID: <CABatt_yavaq5+gyQydSnL007WZ4gzavjsikXA=N3GJCeVyEyRw@mail.gmail.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size Error
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Fabio Estevam <festevam@gmail.com>,
        Horia Geanta Neag <horia.geanta@nxp.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Breno Matheus Lima <brenomatheus@gmail.com>,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi James,

On Tue, Apr 10, 2018 at 11:36 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
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
>>   I notice that in my stack trace I have pkcs1pad_verify which
>> suggests some sort of padding?
>
> Yes, RSA has various forms of padding because the information being
> encrypted is usually much smaller than the encryption unit; PKCS1 is
> the most common (although its now deprecated in favour of OAEP because
> of all the padding oracle problems).
>
> James
>

Thanks for the info, so the leading zero needs to be removed.
