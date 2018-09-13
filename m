Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40974 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeIMUVQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Sep 2018 16:21:16 -0400
Received: by mail-wr1-f52.google.com with SMTP id z96-v6so6239701wrb.8
        for <linux-integrity@vger.kernel.org>; Thu, 13 Sep 2018 08:11:19 -0700 (PDT)
Subject: Re: Question about the TPM driver
To: Martin Galvan <omgalvan.86@gmail.com>,
        James.Bottomley@hansenpartnership.com
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        Tadeusz Struk <tadeusz.struk@intel.com>
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
 <1536848529.3436.2.camel@HansenPartnership.com>
 <CAN19L9HHqs7WdxsS7zYLvQ1vbsDpViyMb+Xfz1bG3=c2Jz-Mbg@mail.gmail.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <7e7a570b-b7d1-8a3f-6614-e301cbbf71ce@redhat.com>
Date: Thu, 13 Sep 2018 17:11:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAN19L9HHqs7WdxsS7zYLvQ1vbsDpViyMb+Xfz1bG3=c2Jz-Mbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[adding Tadeusz Struk to CC list]

On 9/13/18 4:31 PM, Martin Galvan wrote:
> Hi James, thanks for your answer.
> 
> El jue., 13 sept. 2018 a las 11:22, James Bottomley
> (<James.Bottomley@hansenpartnership.com>) escribio:
>>
>> On Thu, 2018-09-13 at 10:14 -0300, Martin Galvan wrote:
>> Exact buffer size hasn't been thought to be an issue since you know
>> that any response will fit into MAX_RESPONSE_SIZE which the current
>> implementation defines to be 4096.
> 
> Interesting, I didn't know about this max. I guess you're referring to
> enum tpm_const's TPM_BUFSIZE constant, since I can't find this max in
> the spec. In any case, what would be the effect of removing this
> limitation and allowing a user to read the response in chunks rather
> than having to allocate 4k every time? I don't think things would
> break, though maybe I'm missing something.
> 

There was an attempt to add partial reads support some time ago [0],
but it was nacked due being an ABI break IIRC.

[0]: https://lkml.org/lkml/2018/7/19/618

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
