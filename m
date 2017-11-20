Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37881 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdKTWp0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 17:45:26 -0500
Date: Mon, 20 Nov 2017 14:45:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add explicit chip->ops locking for sysfs attributes.
Message-ID: <20171120224523.GA26294@roeck-us.net>
References: <1510867501-9498-1-git-send-email-linux@roeck-us.net>
 <20171120221323.252ki4nmmrymnty6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120221323.252ki4nmmrymnty6@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 21, 2017 at 12:13:23AM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 16, 2017 at 01:25:01PM -0800, Guenter Roeck wrote:
> > Add explicit chip->ops locking for all sysfs attributes.
> > This lets us support those attributes on tpm2 devices.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/char/tpm/tpm-chip.c  |   4 --
> >  drivers/char/tpm/tpm-sysfs.c | 125 ++++++++++++++++++++++++++++++++-----------
> >  2 files changed, 93 insertions(+), 36 deletions(-)
> 
> I think the patch looks ok (with a quick skim) as code change. We need
> it. It should have been already done. Thanks for doing this.
> 
> I don't digest the commit message.
> 
> You should just to explain why this change needs to be done in order to
> support sysfs attributes with TPM 2.0 devices and not speculate how it
> will be used in future commits.
> 

How about the following ?

"tpm: Enable sysfs support for TPM2 devices

Access to chip->ops on TPM2 devices requires an explicit lock,
since the pointer is set to NULL in tpm_class_shutdown().
Implement that lock for sysfs access functions and enable sysfs
support for TPM2 devices."

Thanks,
Guenter
