Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44560 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdJRSTN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 14:19:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id v132so10491121oie.1
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 11:19:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACE9dm_vpTi705PJxGZkeNWUyHALZzVc2x=RUw_p=DZCPZfoXw@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
 <1508291395.4513.95.camel@linux.vnet.ibm.com> <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
 <1508292499.4513.99.camel@linux.vnet.ibm.com> <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
 <1508295225.4513.123.camel@linux.vnet.ibm.com> <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
 <1508349118.4510.14.camel@linux.vnet.ibm.com> <CACE9dm_vpTi705PJxGZkeNWUyHALZzVc2x=RUw_p=DZCPZfoXw@mail.gmail.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Wed, 18 Oct 2017 21:19:12 +0300
Message-ID: <CACE9dm_oL5G2ZMqn0VustRrR6LOTvNXxd_8uQyNSi04EBjmdQA@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

(previous email was sent by mistake incompleted)

I have not read thread in detail so sorry if I will repeat something.

EVM support signatures.
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/tree/security/integrity/evm/evm_main.c?h=next#n166

They can be mutable or immutable if I not is marked immutables
Mutable signature will be replaced on the first verification.

And ima-evm-utils has support to generate evm signatures

https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/src/evmctl.c#l1549

Also there is concept of EVM signatures not bound to inode unique data
like ino and generation..

Also there are patches I made 2 years ago

2015-10-22  ima: limit capabilities for unsigned executable
2015-10-22  evm: load EVM key from the kernel
2015-10-22  evm: require EVM signature based appraisal
2015-10-22  ima: provide appraise_type=evmsig
2015-10-22  evm: provide immutable EVM signature

They are on the top here

https://git.kernel.org/pub/scm/linux/kernel/git/kasatkin/linux-digsig.git/log/?h=evm-next

Have you seen it?

Dmitry

On Wed, Oct 18, 2017 at 9:16 PM, Dmitry Kasatkin
<dmitry.kasatkin@gmail.com> wrote:
> Hi,
>
> I have not read thread in detail so sorry if I will repeat something.
>
> EVM support signatures.
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/tree/security/integrity/evm/evm_main.c?h=next#n166
>
> They can be mutable or immutable if I not is marked immutables
> Mutable signature will be replaced on the first verification.
>
> And ima-evm-utils has support to generate evm signatures
>
> https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/src/evmctl.c#l1549
>
> Also there is concept of EVM signatures not bound to inode unique data like
> ino and generation
>
>
> On Wed, Oct 18, 2017 at 8:51 PM, Mimi Zohar <zohar@linux.vnet.ibm.com>
> wrote:
>>
>> > >> I may be misdiagnosing this, but as far as I can tell IMA_NEW_FILE is
>> > >> only set in ima_appraise_measurement() if action is set to something,
>> > >> and if ima_match_rules() doesn't match then this will never be the
>> > >> case?
>> > >
>> > > True, but having IMA_NEW_FILE set would only help with writing the
>> > > first xattr, not subsequent ones.
>> >
>> > Ok. I'm not sure this is easily fixable to handle my use-case without
>> > breaking assumptions made in yours, so I'm wondering if a different
>> > approach would be better here. For us, there's no problem with
>> > updating any of the EVM-protected xattrs at runtime as long as doing
>> > so invalidates the iint cache entry (hmm, does setting an xattr bump
>> > the iversion? If so, we already get this behaviour). How would you
>> > feel about a runtime controllable flag that enabled this, possibly
>> > tied into the /sys/kernel/security/evm write? We'd end up with:
>> >
>> > 1: Enable HMAC
>> > 2: Enable RSA
>> > 4: Permit extended attribute writes
>> >
>> > Existing behaviour would be preserved since 1 would lock down the
>> > interface, and we could reject cases where 1 and 4 are set
>> > simultaneously.
>>
>> Here's an alternative, though admittedly one that is more difficult to
>> implement and dependent on having a portable EVM signature type.
>>
>> Define the equivalent of listxattr that allows writing multiple
>> xattrs.  Change option 4 above to "Permit writing a group of extended
>> attributes, including an EVM signature, when none currently exist."
>>
>> Then option 1 and 4 won't need to be mutually exclusive.
>>
>> Mimi
>>
>
>
>
> --
> Thanks,
> Dmitry



-- 
Thanks,
Dmitry
