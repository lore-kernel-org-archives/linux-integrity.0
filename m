Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:5294 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbdKTWN1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 17:13:27 -0500
Date: Tue, 21 Nov 2017 00:13:23 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add explicit chip->ops locking for sysfs attributes.
Message-ID: <20171120221323.252ki4nmmrymnty6@linux.intel.com>
References: <1510867501-9498-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510867501-9498-1-git-send-email-linux@roeck-us.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Nov 16, 2017 at 01:25:01PM -0800, Guenter Roeck wrote:
> Add explicit chip->ops locking for all sysfs attributes.
> This lets us support those attributes on tpm2 devices.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/char/tpm/tpm-chip.c  |   4 --
>  drivers/char/tpm/tpm-sysfs.c | 125 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 93 insertions(+), 36 deletions(-)

I think the patch looks ok (with a quick skim) as code change. We need
it. It should have been already done. Thanks for doing this.

I don't digest the commit message.

You should just to explain why this change needs to be done in order to
support sysfs attributes with TPM 2.0 devices and not speculate how it
will be used in future commits.

/Jarkko
