Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45821 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdLUQRd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 11:17:33 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so16951375wme.4
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 08:17:33 -0800 (PST)
Date: Thu, 21 Dec 2017 09:17:28 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexander.Steffen@infineon.com
Cc: chiu@endlessm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: Re: TPM driver breaks S3 suspend
Message-ID: <20171221161728.GB20015@ziepe.ca>
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
 <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 21, 2017 at 10:19:09AM +0000, Alexander.Steffen@infineon.com wrote:

> The correct solution should be something like tpm2_auto_startup
> (execute selftests, if they fail because of the missing startup
> command, execute that and retry the selftests). Interestingly,
> tpm1_auto_startup (same purpose as tpm2_auto_startup, but for TPM
> 1.2 instead) does not use the same sequence, the startup-retry part
> is missing. Is there any reason this is done differently for TPM
> 1.2?

No TPM 1.2 has needed the retry loop so far.. don't see any problem
with adding it if the spec supports it.

Jason
