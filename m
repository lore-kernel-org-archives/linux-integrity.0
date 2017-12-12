Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:41629 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbdLLS5f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Dec 2017 13:57:35 -0500
Received: by mail-wm0-f43.google.com with SMTP id g75so690695wme.0
        for <linux-integrity@vger.kernel.org>; Tue, 12 Dec 2017 10:57:35 -0800 (PST)
Date: Tue, 12 Dec 2017 11:57:30 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: James Ettle <james@ettle.org.uk>, linux-integrity@vger.kernel.org,
        azhar.shaikh@intel.com, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171212185730.GC16603@ziepe.ca>
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Dec 12, 2017 at 12:38:00PM +0100, Javier Martinez Canillas wrote:

> I'm not familiar with LPC so please let me know if my assumptions are wrong,
> but I find suspicious that a driver for a single device attached to the bus
> can control the CLKRUN# signal which AFAIU may be needed for other devices.

My understanding was that the fix was to force CLKRUN on before
starting a LPC transaction for TPM.

I guess the issues is blindly assuming that CLKRUN started out as off.
It needs to remember the old setting and put it back, and hope against
all hope there isn't another thread mucking with it.

Guessing that on a system with a LPC connected superio controller for
PS/2 that CLKRUN will be always high???

Jason
