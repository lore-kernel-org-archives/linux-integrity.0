Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34863 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966012AbeEJOlz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 10:41:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id o78-v6so4862532wmg.0
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 07:41:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508105515.GB6132@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca> <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Thu, 10 May 2018 09:41:53 -0500
Message-ID: <CAAi9uDtt=U_7uSVrxBkC_-ZLobU9WiA4UxuN0pJk18b0Rhv+Lg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        philip.b.tricca@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 8, 2018 at 5:55 AM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> On Fri, May 04, 2018 at 02:56:25PM -0500, David R. Bild wrote:
>> On Fri, May 4, 2018 at 2:06 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>> >
>> > On Fri, May 04, 2018 at 08:00:22AM -0500, David R. Bild wrote:
>> > > Normally the system platform (i.e., BIOS/UEFI for x86) is responsible
>> > > for performing initialization of the TPM.  For these modules, the host
>> > > kernel is the platform, so we perform the initialization in the driver
>> > > before registering the TPM with the kernel TPM subsystem.
>> >
>> > The tpm driver already does most of this stuff automatically, why
>> > duplicate it there and why is it coded in a way that doesn't use the
>> > existing TPM services to do it?
>>
>> I didn't want to have to duplicate all that functionality and was
>> disappointed when that became the only option (due to the two reasons
>> outlined below) for supporting existing kernels with an out-of-tree
>> module.
>>
>> Bringing the module in-tree opens the option of reworking some of the
>> TPM subsystem to support this use case.  I'm open to concrete
>> suggestions on how to do so.
>>
>> 1) The first reason is that I don't think the necessary pieces are
>> currently made available for reuse. I'd love to not repeat that code,
>> but
>>
>> - some required structs and functions are declared in private headers
>> (drivers/char/tpm/*.h instead of include/linux/tpm.h).
>> - many of the required functions are not exported.
>>
>> If the TPM maintainers are open to more of the API being "public", I
>> can look into preparing patches that export the necessary operations.
>>
>> 2) The second reason is that the initialization done by the driver is
>> work that should be done by platform, before the kernel ever sees the
>> TPM.
>
> This is too speculative to give any confirmitive promises. Do not fully
> understand the reasoning. For example: why should I care about
> out-of-tree modules?

You shouldn't care about out-of-tree modules, per se.  But the same
issues affect *in-tree* modules too.

Currently there is no way for an in-tree driver to accomplish all
three of the following

1) Disable the platform hierarchy (or set the platform auth password).
2) Use the TPM subsystem to accomplish step 1 (as opposed to
reimplementing startup, self-test, etc. which this driver currently
does).
3) Ensure that step 1 is done before the TPM is exposed to userspace
as /dev/tpmX (to prevent a race with userspace for control of the
platform hierarchy).

> I can look code changes but the text above contains
> too many words to nail anything down. I'm confused.

I see four possible resolutions:

1) Accept the code as is. No changes to the TPM subsystem. I do not
like this option.

2) Make more of the TPM driver API public (internally public) so that
the driver can reuse that code instead of reimplementing.  Not ideal,
as this could require major restructuring of the TPM code.

3) Allow the driver to register the TPM with TPM driver, but not yet
expose the TPM to userspace.  Let the driver do some additional work
(like set the platform hierarchy password) and then explicitly inform
the TPM driver that it is safe to expose the TPM to userspace.  This
would be my preferred approach.

4) The TPM driver (or daemon, perhaps. I don't under James's proposal
yet) sets the platform password.  As you say, this is an intrusive
change and only for a very specific use case right now. Perhaps not
ideal.

Do these make sense?

Best,
David
