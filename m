Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:45372 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdKQAVH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 19:21:07 -0500
Received: by mail-it0-f65.google.com with SMTP id l196so2132587itl.4
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 16:21:07 -0800 (PST)
Date: Thu, 16 Nov 2017 17:21:05 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add explicit chip->ops locking for sysfs
 attributes.
Message-ID: <20171117002105.GD4276@ziepe.ca>
References: <1510868454-31912-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510868454-31912-1-git-send-email-linux@roeck-us.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Nov 16, 2017 at 01:40:54PM -0800, Guenter Roeck wrote:
> Add explicit chip->ops locking for all sysfs attributes.
> This lets us support those attributes on tpm2 devices.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> v2: It makes sense to actually compile the code.
> 
>  drivers/char/tpm/tpm-chip.c  |   4 --
>  drivers/char/tpm/tpm-sysfs.c | 127 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 94 insertions(+), 37 deletions(-)

I haven't exhaustively checked this, but as the originator of the
comment, this looks broadly like the right approach to me.

Cheers,
Jason
