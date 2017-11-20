Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14845 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdKTXpk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 18:45:40 -0500
Date: Tue, 21 Nov 2017 01:45:36 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add explicit chip->ops locking for sysfs attributes.
Message-ID: <20171120234536.inncp6ey37ofkd74@linux.intel.com>
References: <1510867501-9498-1-git-send-email-linux@roeck-us.net>
 <20171120221323.252ki4nmmrymnty6@linux.intel.com>
 <20171120224523.GA26294@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120224523.GA26294@roeck-us.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 20, 2017 at 02:45:23PM -0800, Guenter Roeck wrote:
> On Tue, Nov 21, 2017 at 12:13:23AM +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 16, 2017 at 01:25:01PM -0800, Guenter Roeck wrote:
> > > Add explicit chip->ops locking for all sysfs attributes.
> > > This lets us support those attributes on tpm2 devices.
> > > 
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/char/tpm/tpm-chip.c  |   4 --
> > >  drivers/char/tpm/tpm-sysfs.c | 125 ++++++++++++++++++++++++++++++++-----------
> > >  2 files changed, 93 insertions(+), 36 deletions(-)
> > 
> > I think the patch looks ok (with a quick skim) as code change. We need
> > it. It should have been already done. Thanks for doing this.
> > 
> > I don't digest the commit message.
> > 
> > You should just to explain why this change needs to be done in order to
> > support sysfs attributes with TPM 2.0 devices and not speculate how it
> > will be used in future commits.
> > 
> 
> How about the following ?
> 
> "tpm: Enable sysfs support for TPM2 devices
> 
> Access to chip->ops on TPM2 devices requires an explicit lock,
> since the pointer is set to NULL in tpm_class_shutdown().
> Implement that lock for sysfs access functions and enable sysfs
> support for TPM2 devices."
> 
> Thanks,
> Guenter

I can go with that. No need to send a new commit just for this :-)

I'll do some testing and give my final thoughts about the code
change and if everything is good I can change the commit message.
If not, submit the next version with that commit message.

/Jarkko
