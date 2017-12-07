Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46522 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbdLGSht (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Dec 2017 13:37:49 -0500
Received: by mail-wr0-f195.google.com with SMTP id x49so8473670wrb.13
        for <linux-integrity@vger.kernel.org>; Thu, 07 Dec 2017 10:37:48 -0800 (PST)
Date: Thu, 7 Dec 2017 11:37:43 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexander.Steffen@infineon.com
Cc: pmenzel@molgen.mpg.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
Message-ID: <20171207183743.GB16884@ziepe.ca>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
 <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 07, 2017 at 03:56:07PM +0000, Alexander.Steffen@infineon.com wrote:

> > If these are intentional, it'd be great
> > to give some hint to the user, what effect this has.
> 
> I agree that those error messages in their current form are not that
> helpful for the users. But they are part of the general driver
> architecture, and are also caused by other parts of the code
> (e.g. when using a TPM 1.2 that is deactivated or when the platform
> did not send a startup command). We should find a way to hide (or at
> least mark) those kind of expected errors.

Other parts of the TPM code did supresses 'expected' errors like this,
I'm not sure if it got removed during Jarkko's cleanup though - we
need to put stuff like that back, it should not printk for something
like this.

For this, if we are waiting then it should compute an absolute time
after which it will give up.

Code it like this instead and get rid of the ugly 'duration' scheme.

ktime_t stop = ktime_add_ns(ktime_get(), [timeout in ns]);
do
{
}
while (ktime_before(ktime_get(), stop);

Jason
