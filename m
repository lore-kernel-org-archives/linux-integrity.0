Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:7641 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935531AbeFRSHS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jun 2018 14:07:18 -0400
Date: Mon, 18 Jun 2018 21:07:12 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Louis Collard <louiscollard@chromium.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
Message-ID: <20180618180712.GB20697@linux.intel.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180608065438.110109-1-louiscollard@chromium.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 08, 2018 at 02:54:38PM +0800, Louis Collard wrote:
> It is now possible for drivers to easily specify a hwrng quality, however
> most do not currently do this, and in cases where they do, it may be
> desirable to override the driver-specified value with a user-specified
> one. This patch adds a parameter to set or override the hwrng quality.
> 
> Signed-off-by: Louis Collard <louiscollard@chromium.org>
> ---
>  drivers/char/tpm/tpm-chip.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0a62c19937b6..4def49cfc634 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -33,6 +33,11 @@
>  DEFINE_IDR(dev_nums_idr);
>  static DEFINE_MUTEX(idr_lock);
>  
> +static short override_rng_quality = -1;
> +module_param(override_rng_quality, short, 0644);

Should this be 600 i.e. not to leak this information?

/Jarkko
