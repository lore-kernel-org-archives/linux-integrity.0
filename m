Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41156 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732633AbeGLUqS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jul 2018 16:46:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id c21-v6so16648854pfn.8
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jul 2018 13:35:06 -0700 (PDT)
Date: Thu, 12 Jul 2018 13:37:46 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
Message-ID: <20180712203746.GG545@tuxbook-pro>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
 <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
 <1531165294.3332.40.camel@linux.ibm.com>
 <CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
 <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
 <20180710191951.GF1731@minitux>
 <CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
 <1531425793.3568.275.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1531425793.3568.275.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu 12 Jul 13:03 PDT 2018, Mimi Zohar wrote:

> On Wed, 2018-07-11 at 08:24 +0200, Ard Biesheuvel wrote:
> > On 10 July 2018 at 21:19, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> 
> > > Tbh the only case I can think of where there would be a "race condition"
> > > here is if we have a device that is polling the last byte of a
> > > predefined firmware memory area for the firmware loader to read some
> > > specific data into it. In cases where the firmware request is followed
> > > by some explicit signalling to the device (or a power on sequence) I'm
> > > unable to see the issue discussed here.
> > >
> > 
> > I agree. But the latter part is platform specific, and so it requires
> > some degree of trust in the driver author on the part of the IMA
> > routines that request_firmware() is called at an appropriate time.
> 
> Exactly.  Qualcomm could be using the pre-allocated buffer
> appropriately, but that doesn't guarantee how it will be used in the
> future.
> 

Agreed.

But a device that starts operate on the firmware memory before it's
fully loaded (and verified) will likely hit other nasty issues. Using a
traditional request_firmware() and memcpy() or simply mapping the buffer
into the remote piecemeal would have the same issue.

So I think that regardless of using IMA, if you don't have the ability
to control your device's view of the entire firmware buffer atomically
you must write your device drivers accordingly.

Regards,
Bjorn
