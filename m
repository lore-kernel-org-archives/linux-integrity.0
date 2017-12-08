Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:37863 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754252AbdLHQST (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 11:18:19 -0500
Received: by mail-wr0-f182.google.com with SMTP id k61so11294619wrc.4
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 08:18:19 -0800 (PST)
Date: Fri, 8 Dec 2017 09:18:14 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
Message-ID: <20171208161814.GB2883@ziepe.ca>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
 <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
 <20171207183743.GB16884@ziepe.ca>
 <37b47bbcce5d4cf1b1fad32576e501d4@infineon.com>
 <20171208155641.GA2883@ziepe.ca>
 <c544a476-5ea9-df81-ea8b-01fa578738f0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <c544a476-5ea9-df81-ea8b-01fa578738f0@molgen.mpg.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 05:07:39PM +0100, Paul Menzel wrote:

> I have no access to the system right now, but want to point out, that the
> log was created by `journactl -k`, so I do not know if that messes with the
> time stamps. I checked the output of `dmesg` but didn't see the TPM error
> messages in the output - only `tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE,
> rev-id 4)`. Do I need to pass a different error message to `dmesg`?

It is a good question, I don't know.. If your kernel isn't setup to
timestamp messages then the journalstamp will certainly be garbage.

No idea why you wouldn't see the messages in dmesg, if they are not in
dmesg they couldn't get into the journal

Jason
