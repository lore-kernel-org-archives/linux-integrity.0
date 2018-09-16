Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:40174 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbeIQAbq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Sep 2018 20:31:46 -0400
Date: Sun, 16 Sep 2018 22:07:24 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 02/17] compat_ioctl: move drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20180916190724.GA7473@linux.intel.com>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912150142.157913-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180912150142.157913-2-arnd@arndb.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Sep 12, 2018 at 05:01:03PM +0200, Arnd Bergmann wrote:
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 87a0ce47f201..a170f5ca7416 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -678,20 +678,10 @@ static long vtpmx_fops_ioctl(struct file *f, unsigned int ioctl,
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vtpmx_fops_compat_ioctl(struct file *f, unsigned int ioctl,
> -					  unsigned long arg)
> -{
> -	return vtpmx_fops_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static const struct file_operations vtpmx_fops = {
>  	.owner = THIS_MODULE,
>  	.unlocked_ioctl = vtpmx_fops_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl = vtpmx_fops_compat_ioctl,
> -#endif
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  	.llseek = noop_llseek,
>  };

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
