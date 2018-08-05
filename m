Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34002 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeHEVFp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Aug 2018 17:05:45 -0400
Received: by mail-it0-f68.google.com with SMTP id d70-v6so10356562ith.1
        for <linux-integrity@vger.kernel.org>; Sun, 05 Aug 2018 12:00:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180805163139.GB27062@linux-l9pv.suse>
References: <20180805032119.20485-1-jlee@suse.com> <CAKv+Gu81vEGNggcWv1NyPJsMeK0HRi_DanH2+Z_4metoNG=txA@mail.gmail.com>
 <20180805163139.GB27062@linux-l9pv.suse>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 5 Aug 2018 21:00:13 +0200
Message-ID: <CAKv+Gu8eW3Q0DhXN38qZ1nDJz8Hz7wJcWvLRSW3xm1qVt54AaA@mail.gmail.com>
Subject: Re: [PATCH 0/6][RFC] Add EFI secure key to key retention service
To: joeyli <jlee@suse.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 5 August 2018 at 18:31, joeyli <jlee@suse.com> wrote:
> On Sun, Aug 05, 2018 at 09:25:56AM +0200, Ard Biesheuvel wrote:
>> Hello Chun,yi,
>>
>> On 5 August 2018 at 05:21, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>> > When secure boot is enabled, only signed EFI binary can access
>> > EFI boot service variable before ExitBootService. Which means that
>> > the EFI boot service variable is secure.
>> >
>>
>> No it, isn't, and this is a very dangerous assumption to make.
>>
>> 'Secure' means different things to different people. 'Secure boot' is
>> a misnomer, since it is too vague: it should be called 'authenticated
>> boot', and the catch is that authentication using public-key crypto
>> does not involve secrets at all. The UEFI variable store was not
>> designed with confidentiality in mind, and assuming [given the
>> reputation of EFI on the implementation side] that you can use it to
>> keep secrets is rather unwise imho.
>>
>
> I agreed with you. Especially I can't refute the part of EFI
> implementation, manufacturers can not be fully trusted.
>
> I am thinking a case... Some machines provide setup mode. If user
> earses all manufacturer's reloaded keys and only enrolls their own
> key. Which means that user fully controls the authentication
> environment. Then the EFI boot service varible can be trusted by
> the user.

This has nothing to do with trust but everything to do with confidentiality.

*Nothing* in the UEFI variable store stack has been designed or
implemented with confidentiality in mind. The contents of EFI
variables are readable in the clear from the SPI flash. Code that
handles variable store reads may leave unsanitized buffers behind. We
have efivarfs that needs to be modified to hide 'secret' variables,
but also, to kzfree() every allocation that is used in handling
varstore access etc etc.



> But this case is too strict for normal user.
>
> Thanks for your review and comments. I will think more about your
> suggestions.
>
> Joey Lee
