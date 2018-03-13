Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42568 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933329AbeCMQAx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Mar 2018 12:00:53 -0400
Subject: Re: [PATCH v3 1/6] tpm-buf: create new functions for handling TPM
 buffers
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
 <1520720090.4495.12.camel@HansenPartnership.com>
 <277bd8a1-9e7f-f6e8-bede-5208f0456adf@gmail.com>
 <1520877553.4522.25.camel@HansenPartnership.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <87c7bc38-2f43-9bb0-ac76-ebbc08ce4977@gmail.com>
Date: Tue, 13 Mar 2018 09:00:48 -0700
MIME-Version: 1.0
In-Reply-To: <1520877553.4522.25.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 3/12/18 10:59 AM, James Bottomley wrote:
> On Mon, 2018-03-12 at 09:00 -0700, J Freyensee wrote:
>>> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>>> +{
>>> +	int rc;
>>> +
>>> +	rc = __tpm_buf_init(buf);
>>
>> Assuming that functions like tpm_buf_init() are the top-level API
>> being defined in this patch, shouldn't it check if buf is valid
>> before passing into the internal functions like __tpm_buf_init(buf)
>> (maybe WARN()/BUG_ON()?).  Or does __tpm_buf_init(buf) do this check?
> These are kernel internal APIs designed for on stack struct tpm_buf
> usage,

ok.

> so I can't think of a viable threat model that would require
> this type of checking ... do you have one?

no, nothing particular in mind.  I just get a little nervous when I see 
variables being passed unchecked into internal functions starting with '__'.

Regards,
Jay

>
> James
>
