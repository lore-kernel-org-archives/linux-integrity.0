Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from imap.newtech.fi ([83.150.94.195]:34920 "EHLO mail.newtech.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbeIRMen (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Sep 2018 08:34:43 -0400
From: Dag Nygren <dag@newtech.fi>
To: xen-devel@lists.xenproject.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgross@suse.com, "Dr . Greg Wettstein" <greg@enjellic.com>,
        dunlapg@umich.edu, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jgg@ziepe.ca,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH v2] tpm: Restore functionality to xen vtpm driver.
Date: Tue, 18 Sep 2018 09:54:47 +0300
Message-ID: <6898808.CzJHl40L0f@eseries.newtech.fi>
In-Reply-To: <5d63093d-620d-80d5-1138-0332a210d61f@oracle.com>
References: <20180913212551.2435-1-boris.ostrovsky@oracle.com> <20180917211900.GD6716@linux.intel.com> <5d63093d-620d-80d5-1138-0332a210d61f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On tisdag 18 september 2018 kl. 01:25:29 EEST Boris Ostrovsky wrote:
> On 9/17/18 5:19 PM, Jarkko Sakkinen wrote:

> > Just to understand this bug better why did not the wrong version
> > cause any undefined behavior? Sounds like a fatal bug. Does this
> > cause crashes?
> 
> AFAIK, no, no crashes. I haven't tested this myself (and I believe
> relatively few people use this functionality, which explains why this
> has not been fixed for so long) but I don't think it will necessarily
> crash. It's just that the frontend driver will be reading from wrong
> location, causing TPM not to function properly.

I bumped my head into this last week and spent most of the
week trying to figure out why the vtpm did not respond.
Finally found the email from the guy that dirscovered and fixed
it. Did the fix and rescompiled. Now it seems to be working
fine. The patch is surprisingly 2 years old!!
I will be very pleased to see it go in to the
official kernel!

But no crash. Just a timeout when trying to communicate with
the vtpm-engine.

Best
Dag
