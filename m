Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:42730 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754319AbdLHP4o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 10:56:44 -0500
Received: by mail-it0-f53.google.com with SMTP id p139so5780776itb.1
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 07:56:43 -0800 (PST)
Date: Fri, 8 Dec 2017 08:56:41 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexander.Steffen@infineon.com
Cc: pmenzel@molgen.mpg.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
Message-ID: <20171208155641.GA2883@ziepe.ca>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
 <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
 <20171207183743.GB16884@ziepe.ca>
 <37b47bbcce5d4cf1b1fad32576e501d4@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37b47bbcce5d4cf1b1fad32576e501d4@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 12:14:04PM +0000, Alexander.Steffen@infineon.com wrote:

> Is it really that ugly? I still need delay_msec to increase the
> delay each round. I can see the benefit of your suggestion when it
> is important to get the timing exactly right (and also account for
> time spent elsewhere, when our code might not be executing). But in
> this case having delays that are approximately right (or longer than
> intended) is sufficient.

For timeouts like this we really need to be above the TPM specified
delay in all cases, even if usleep_range selected something
smaller/larger.. The only way to do that is with an absolute timeout..


> Anyway, from the log messages it is clear that tpm_msleep got called
> seven times with delays of 20/40/80/160/320/640/1280ms. But still
> all timestamps lie within the same second. How can this be with a
> cumulated delay of ~2.5s?

Yes, that does seem to be the bug, our sleep function doesn't work
aynmore for some reason :|

> Also, I've just noticed that despite the name tpm_msleep calls
> usleep_range, not msleep. Can this have an influence? Should
> tpm_msleep call msleep for longer delays, as suggested by
> Documentation/timers/timers-howto.txt?

This change was introduced recently and is probably the source of this
regression.

Jason
