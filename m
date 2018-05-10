Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:47078 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965013AbeEJPR4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 11:17:56 -0400
Received: by mail-wr0-f169.google.com with SMTP id a12-v6so2375634wrn.13
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 08:17:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525963652.3258.4.camel@HansenPartnership.com>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca> <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com> <1525793148.3672.8.camel@HansenPartnership.com>
 <CAAi9uDvgd5+d5fNbSGEeEVvdHLzwid6SqC0BVA3BPXkFWR4ooQ@mail.gmail.com>
 <1525793785.3672.12.camel@HansenPartnership.com> <CAAi9uDsLmW3K=1UYsmJKOc6hsXqcJXFHyO_scMan5u8d94D9=Q@mail.gmail.com>
 <1525963652.3258.4.camel@HansenPartnership.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Thu, 10 May 2018 10:17:54 -0500
Message-ID: <CAAi9uDv0BVY9SP_rnBQxRBqJ-dwc1PbH6NL8-+YM9HbC5N1dew@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        philip.b.tricca@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 10, 2018 at 9:47 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Thu, 2018-05-10 at 09:25 -0500, David R. Bild wrote:
>> The TPM holds access credentials for connecting to the Xaptum
>> network.
>
> OK, so these are effectively DevId keys.  However, what makes you think
> knowing the platform auth allows you to duplicate the keys?

It doesn't and we don't think that.

> As long as
> you created them correctly (as in without duplication authority) then
> even knowing the platform authorization I can't get them out of your
> TPM.

Correct.  No one can copy/duplicate/read them.

But they can delete them, which is effectively a denial of service
attack against the device.

>> We provision the credentials (the DAA secret key, specifically) under
>> the platform hierarchy. The key can be used without platform
>> authorization, but not removed.  If we disable the platform hierarchy
>> entirely, I think the credentials will no longer be available for
>> use.
>
> That's certainly true if you actually need to use the platform
> hierarchy.  Your initial emails on the subject did say you were
> disabling it though ...

Mea culpa.  Lazy wording on my part.

>> > Early boot means userspace. for a hot pluggable device, this would
>> > probably be something in udev if you follow the no-daemon model and
>> > the daemon could do it if you do follow the daemon model.
>>
>> Could you expand on the udev approach?  I might not understand enough
>> about udev (or the coming TPM resource manager changes) to follow the
>> suggestion.

>> This seems unsafe to me.  There's a race between a malicious
>> userspace program and the daemon to set the platform
>> authorization.  If the malicious program wins, it can reset the TPM,
>> removing the credentials, and the device won't be able to connect to
>> the Xaptum network. (This is a liveness concern, not safety.  A
>> denial-of-service attack, essentially.)
>
> OK, I'm getting confused by your threat model.  I don't think knowing
> the platform auth I can obtain your keys.  However, I agree, I can
> definitely remove them.

Correct. Removal (not copying) is our concern.

>  However, setting platform auth doesn't solve
> this: I can execute a TPM2_Clear to regain the platform auth and if you
> disable this

According to the spec (v1.38) TPM2_Clear

- flushes the Storage and Endorsement hierarchies, not the Platform hierarchy.

- resets the Storage, Endorsement, and Lockout auth, but not the Platform auth.

> I can't re-own the TPM at all.

You can execute TPM2_Clear  (if you have lockout auth. We don't set
lockout auth, so you will.) to regain control of the Storage and
Endorsement hierarchies.  We only control the platform hierarchy.

Best,
David
