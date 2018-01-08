Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14563 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756343AbeAHKr3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jan 2018 05:47:29 -0500
Date: Mon, 8 Jan 2018 12:47:22 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH -next] tpm_tis: Remove unused variables
Message-ID: <20180108104722.2yw4wiwxb6kadqdg@linux.intel.com>
References: <1514948961-20524-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1514948961-20524-1-git-send-email-weiyongjun1@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jan 03, 2018 at 03:09:21AM +0000, Wei Yongjun wrote:
> Fixes the following sparse warnings:
> 
> drivers/char/tpm/tpm_tis.c: In function a??tpm_tis_pnp_removea??:
> drivers/char/tpm/tpm_tis.c:274:23: warning: unused variable a??priva?? [-Wunused-variable]
>   struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>                        ^
> drivers/char/tpm/tpm_tis.c: In function a??tpm_tis_plat_removea??:
> drivers/char/tpm/tpm_tis.c:324:23: warning: unused variable a??priva?? [-Wunused-variable]
>   struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>                        ^
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thank you. Already merged Arnd's patch.

/Jarkko
