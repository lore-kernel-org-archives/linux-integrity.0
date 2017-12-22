Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34646 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756201AbdLVRsZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 12:48:25 -0500
Received: by mail-wr0-f196.google.com with SMTP id y21so28551184wrc.1
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 09:48:24 -0800 (PST)
Date: Fri, 22 Dec 2017 10:48:20 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: remove unused data fields from I2C and OF device
 ID tables
Message-ID: <20171222174820.GG30884@ziepe.ca>
References: <20171222174741.21534-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171222174741.21534-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 22, 2017 at 06:47:41PM +0100, Javier Martinez Canillas wrote:
> The data field for the entries in the device tables are set but not used.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> 
> Changes in v2:
> - Also empty spaces (suggested by Jason Gunthorpe).
> 
>  drivers/char/tpm/tpm_i2c_infineon.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@ziepe.ca>
