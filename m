Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:40040 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeCWEEr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Mar 2018 00:04:47 -0400
Received: by mail-pg0-f42.google.com with SMTP id g8so4143208pgv.7
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 21:04:47 -0700 (PDT)
Date: Thu, 22 Mar 2018 22:04:45 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: A subtle problem when resuming xen-front and using IMA and
 multiple TPM devices on the system
Message-ID: <20180323040445.GB13175@ziepe.ca>
References: <28f8dc8a-cfa3-376a-5e6a-98d79418e3d1@linux.vnet.ibm.com>
 <20180322213937.GF9469@ziepe.ca>
 <0d302b6b-850f-9ae7-39e2-b28d859dbd38@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0d302b6b-850f-9ae7-39e2-b28d859dbd38@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Mar 22, 2018 at 08:57:59PM -0400, Stefan Berger wrote:
> On 03/22/2018 05:39 PM, Jason Gunthorpe wrote:
> >On Thu, Mar 22, 2018 at 12:20:33PM -0400, Stefan Berger wrote:
> >>I tried to convert the IMA code to look up a TPM chip and use it until
> >>shutdown, when it releases it before device_shutdown(). Ideally this would
> >>work but because of xen-front's resume code it doesn't. There the chip is
> >>unregistered upon domU resume (tpmfront_resume calls tpmfron_remove) and for
> >>that reason IMA cannot be holding onto that chip until shutdown.
> >Well removing the TPM during resume seems totally wrong, don't do
> >that.
> 
> though that's what seems to be happening:

Sure, but that is totally wrong, Xen shouldn't do that.

Don't design core interfaces around an insane driver, you were on the
right path to have IMA hold a chip handle not use a chip index. That
is a long standing needed cleanup.

Xen, IMA and suspend will just not be compatible until someone fixes
that driver.

And maybe that is for the best, perhaps that remove thing is some
statement that TPM state does not preserve across suspend/resume. Who
knows.

Jason
