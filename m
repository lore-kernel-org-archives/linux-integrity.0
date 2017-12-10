Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35109 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdLJPHE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Dec 2017 10:07:04 -0500
Received: by mail-wm0-f46.google.com with SMTP id f9so10051535wmh.0
        for <linux-integrity@vger.kernel.org>; Sun, 10 Dec 2017 07:07:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512915528.3846.29.camel@linux.vnet.ibm.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
 <1512915528.3846.29.camel@linux.vnet.ibm.com>
From: "Paul R. Tagliamonte" <paultag@gmail.com>
Date: Sun, 10 Dec 2017 10:06:42 -0500
Message-ID: <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
Subject: Re: IMA keyctl problems
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Thanks for the quick reply!

Good call, but no such luck --

$ sudo keyctl show %keyring:.ima
Can't find 'keyring:.ima'

  Paul



On Sun, Dec 10, 2017 at 9:18 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Sat, 2017-12-09 at 17:01 -0500, Paul R. Tagliamonte wrote:
>> Hey all!
>>
>> I have an asymmetric key loaded into _ima on my root user's @u
>> keyring. v/r/s is set on the keyrings, and key:
>>
>> ```
>>  943483453 --alswrv      0 65534  keyring: _uid.0
>>  559919368 ----s-rv      0     0   \_ keyring: _ima
>>  475931491 ----s-rv      0     0       \_ asymmetric: Local IMA Key
>> ```
>>
>> However, when I try and run my VM with IMA set to log, I'm getting a
>> log full of:
>>
>> "integrity: no _ima keyring: -126"
>
> Depending on how the kernel was built (CONFIG_IMA_TRUSTED_KEYRING),
> the IMA keys need to be loaded either on the trusted keyring named
> .ima or the _ima keyring.  The kernel itself creates the trusted .ima
> keyring.
>
> The command "sudo keyctl show %keyring:.ima" will indicate if the
> ".ima" was created.
>
> Mimi
>



-- 
:wq
