Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:46884 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753830AbdLHQHn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 11:07:43 -0500
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
To: Jason Gunthorpe <jgg@ziepe.ca>, Alexander.Steffen@infineon.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
 <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
 <20171207183743.GB16884@ziepe.ca>
 <37b47bbcce5d4cf1b1fad32576e501d4@infineon.com>
 <20171208155641.GA2883@ziepe.ca>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <c544a476-5ea9-df81-ea8b-01fa578738f0@molgen.mpg.de>
Date: Fri, 8 Dec 2017 17:07:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171208155641.GA2883@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Dear Jason, dear Alexander,


Thank you for your replies.


Am 08.12.2017 um 16:56 schrieb Jason Gunthorpe:
> On Fri, Dec 08, 2017 at 12:14:04PM +0000, Alexander.Steffen@infineon.com wrote:

[...]

>> Anyway, from the log messages it is clear that tpm_msleep got called
>> seven times with delays of 20/40/80/160/320/640/1280ms. But still
>> all timestamps lie within the same second. How can this be with a
>> cumulated delay of ~2.5s?
> 
> Yes, that does seem to be the bug, our sleep function doesn't work
> aynmore for some reason :|

I have no access to the system right now, but want to point out, that 
the log was created by `journactl -k`, so I do not know if that messes 
with the time stamps. I checked the output of `dmesg` but didn't see the 
TPM error messages in the output - only `tpm_tis MSFT0101:00: 2.0 TPM 
(device-id 0xFE, rev-id 4)`. Do I need to pass a different error message 
to `dmesg`?

>> Also, I've just noticed that despite the name tpm_msleep calls
>> usleep_range, not msleep. Can this have an influence? Should
>> tpm_msleep call msleep for longer delays, as suggested by
>> Documentation/timers/timers-howto.txt?
> 
> This change was introduced recently and is probably the source of this
> regression.

I'll try to test this on Monday.


Kind regards,

Paul
