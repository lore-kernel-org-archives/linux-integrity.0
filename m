Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38390 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935923AbeFRTdL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jun 2018 15:33:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so17714141wmf.3
        for <linux-integrity@vger.kernel.org>; Mon, 18 Jun 2018 12:33:11 -0700 (PDT)
Date: Mon, 18 Jun 2018 13:33:06 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Louis Collard <louiscollard@chromium.org>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
Message-ID: <20180618193306.GF6805@ziepe.ca>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180618180712.GB20697@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jun 18, 2018 at 09:07:12PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 08, 2018 at 02:54:38PM +0800, Louis Collard wrote:
> > It is now possible for drivers to easily specify a hwrng quality, however
> > most do not currently do this, and in cases where they do, it may be
> > desirable to override the driver-specified value with a user-specified
> > one. This patch adds a parameter to set or override the hwrng quality.
> > 
> > Signed-off-by: Louis Collard <louiscollard@chromium.org>
> >  drivers/char/tpm/tpm-chip.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 0a62c19937b6..4def49cfc634 100644
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -33,6 +33,11 @@
> >  DEFINE_IDR(dev_nums_idr);
> >  static DEFINE_MUTEX(idr_lock);
> >  
> > +static short override_rng_quality = -1;
> > +module_param(override_rng_quality, short, 0644);
> 
> Should this be 600 i.e. not to leak this information?

There is a real push these days against adding module parameters, and
apparently, IMA can't function with TPM as a module.

Are you sure this shouldn't be done in some other way?

Jason
