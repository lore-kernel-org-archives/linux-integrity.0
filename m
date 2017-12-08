Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:44132 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbdLHMOG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 07:14:06 -0500
From: <Alexander.Steffen@infineon.com>
To: <jgg@ziepe.ca>
CC: <pmenzel@molgen.mpg.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
Date: Fri, 8 Dec 2017 12:14:04 +0000
Message-ID: <37b47bbcce5d4cf1b1fad32576e501d4@infineon.com>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
 <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
 <20171207183743.GB16884@ziepe.ca>
In-Reply-To: <20171207183743.GB16884@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On Thu, Dec 07, 2017 at 03:56:07PM +0000, Alexander.Steffen@infineon.com
> wrote:
> 
> > > If these are intentional, it'd be great
> > > to give some hint to the user, what effect this has.
> >
> > I agree that those error messages in their current form are not that
> > helpful for the users. But they are part of the general driver
> > architecture, and are also caused by other parts of the code
> > (e.g. when using a TPM 1.2 that is deactivated or when the platform
> > did not send a startup command). We should find a way to hide (or at
> > least mark) those kind of expected errors.
> 
> Other parts of the TPM code did supresses 'expected' errors like this,
> I'm not sure if it got removed during Jarkko's cleanup though - we
> need to put stuff like that back, it should not printk for something
> like this.

Yes, I've got this task here somewhere, just no time to do it...

> For this, if we are waiting then it should compute an absolute time
> after which it will give up.
> 
> Code it like this instead and get rid of the ugly 'duration' scheme.
> 
> ktime_t stop = ktime_add_ns(ktime_get(), [timeout in ns]);
> do
> {
> }
> while (ktime_before(ktime_get(), stop);

Is it really that ugly? I still need delay_msec to increase the delay each round. I can see the benefit of your suggestion when it is important to get the timing exactly right (and also account for time spent elsewhere, when our code might not be executing). But in this case having delays that are approximately right (or longer than intended) is sufficient.

Anyway, from the log messages it is clear that tpm_msleep got called seven times with delays of 20/40/80/160/320/640/1280ms. But still all timestamps lie within the same second. How can this be with a cumulated delay of ~2.5s?

Also, I've just noticed that despite the name tpm_msleep calls usleep_range, not msleep. Can this have an influence? Should tpm_msleep call msleep for longer delays, as suggested by Documentation/timers/timers-howto.txt?

Alexander
