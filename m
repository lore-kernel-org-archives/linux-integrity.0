Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35842 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdLLTMJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Dec 2017 14:12:09 -0500
Received: by mail-wr0-f195.google.com with SMTP id v105so22244542wrc.3
        for <linux-integrity@vger.kernel.org>; Tue, 12 Dec 2017 11:12:09 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Ettle <james@ettle.org.uk>, linux-integrity@vger.kernel.org,
        azhar.shaikh@intel.com, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <20171212185730.GC16603@ziepe.ca>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <cfb8318e-65ce-94a7-1f1a-8f052657701d@redhat.com>
Date: Tue, 12 Dec 2017 20:12:06 +0100
MIME-Version: 1.0
In-Reply-To: <20171212185730.GC16603@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jason,

On 12/12/2017 07:57 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2017 at 12:38:00PM +0100, Javier Martinez Canillas wrote:
> 
>> I'm not familiar with LPC so please let me know if my assumptions are wrong,
>> but I find suspicious that a driver for a single device attached to the bus
>> can control the CLKRUN# signal which AFAIU may be needed for other devices.
> 
> My understanding was that the fix was to force CLKRUN on before
> starting a LPC transaction for TPM.
>

Yes, I got that part from the commit message and the thread when was posted.
 
> I guess the issues is blindly assuming that CLKRUN started out as off.
> It needs to remember the old setting and put it back, and hope against
> all hope there isn't another thread mucking with it.
>

This is the part that worries me, and it seems that assumption was wrong
due the reported issues with other PS/2 devices attached to the LPC bus.

> Guessing that on a system with a LPC connected superio controller for
> PS/2 that CLKRUN will be always high???
>

I'm not really familiar with the LPC bus trasmision protocol to comment
on this. But if different devices rely on the CLKRUN state, then as you
said it needs to remember the old setting and also some synchronization
mechanism should be used to serialize access to it and prevent a race?

> Jason
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
