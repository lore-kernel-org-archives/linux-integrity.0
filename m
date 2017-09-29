Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:46461 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbdI2UJ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 16:09:29 -0400
Received: by mail-it0-f42.google.com with SMTP id d192so1107189itd.1
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 13:09:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506715304.5691.151.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com> <1506629560.5691.33.camel@linux.vnet.ibm.com>
 <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
 <1506646397.5691.64.camel@linux.vnet.ibm.com> <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
 <1506711726.5691.141.camel@linux.vnet.ibm.com> <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
 <1506715304.5691.151.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 29 Sep 2017 13:09:27 -0700
Message-ID: <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Sep 29, 2017 at 1:01 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2017-09-29 at 12:17 -0700, Matthew Garrett wrote:
>> I'm arguing that (for our case at least) the only way we can use IMA
>> is to rely on using a digital signature - we can either have that
>> digital signature be in security.ima, or we can have it in
>> security.evm. Since we need that signature in any case, we derive no
>> benefit from having security.evm be an hmac - our two reasonable
>> choices are:
>>
>> 1) security.ima as a digital signature, security.evm as an hmac
>> 2) security.ima as a hash, security.evm as a digital signature
>
> There's a major difference between security.ima containing a file hash
> vs a signature.  A signature, assuming the file_check hook is in
> policy, prevents the file from being modified, making the file
> "immutable".

But the same is effectively true if security.evm is a digital
signature and there's no symmetric key? For what we want to do (ensure
that executables that are allowed to run with elevated privileges
haven't been tampered with), that's completely ok.

>> I'm not really clear on what attacks are prevented by using the inode
>> number. If I'm able to preserve all the other security metadata when
>> copying a file, I can just create a hardlink to the original instead
>> and have the same outcome.
>
> The issue is the ability of having different security metadata, not
> the same security metadata. (I need to refresh my memory as to hard
> links, and whether they can have different security metadata.)

If the security metadata is different then copying another
security.evm will fail, surely?

> Originally the UUID was not included in the HMAC calculation.  Perhaps
> the patch description of commit 74de668 "evm: add file system uuid to
> EVM hmac" will help clarify the reasoning for including the inode and
> uuid in the hmac calculation.

Not really - if you're not crossing a filesystem boundary then you're
still able to just create a hardlink.
