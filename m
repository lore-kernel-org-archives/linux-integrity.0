Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36214 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeBARlA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 12:41:00 -0500
Received: by mail-wr0-f181.google.com with SMTP id y3so10060585wrh.3
        for <linux-integrity@vger.kernel.org>; Thu, 01 Feb 2018 09:40:59 -0800 (PST)
Date: Thu, 1 Feb 2018 10:40:53 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180201174053.GQ17053@ziepe.ca>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1517498648.3145.4.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 01, 2018 at 03:24:08PM +0000, James Bottomley wrote:

> OK, I investigated but now my TPM has returned to normal (as in it
> passes the selftest immediately).  There's clearly something that makes
> it return TPM_RC_TESTING to every self test probe for seconds at a
> time, but I don't know what it is.  Sending a different command seems
> to cause the problem to clear (Managed to reproduce once with the patch
> to verify), so this is my proposed fix.  It's clearly nonsensical to
> detach the driver because the self test still returns TPM_RC_TESTING,
> so convert that return to a TPM_RC_SUCCESS on timeout.  It prints a
> warning message so we'll see it in the logs if it causes problems.
>  Given that this seems to be some type of internal TPM issue, I don't
> believe changing the timings would work.

But if a selftest returns TPM2_RC_TESTING I would expect the next
command to also fail with a testing in progress code? At least by the
spec..

The point of invoking selftest is to get to a state where future TPM
commands will succeed, so returning immediately on RC_TESTING seems
wrong?

Jason
