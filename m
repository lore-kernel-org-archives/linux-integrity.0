Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:20160 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeIZQrp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Sep 2018 12:47:45 -0400
Date: Wed, 26 Sep 2018 13:35:21 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Louis Collard <louiscollard@chromium.org>
Cc: linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org,
        Jason Gunthorpe <jgg@ziepe.ca>, david.bild@xaptum.com
Subject: Re: [PATCH] Allow hwrng to initialize crng.
Message-ID: <20180926103521.GB4885@linux.intel.com>
References: <20180926032455.224600-1-louiscollard@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180926032455.224600-1-louiscollard@chromium.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Sep 26, 2018 at 11:24:55AM +0800, Louis Collard wrote:
> Some systems, for example embedded systems, do not generate
> enough entropy on boot through interrupts, and boot may be blocked for
> several minutes waiting for a call to getrandom to complete.
> 
> Currently, random data is read from a hwrng when it is registered,
> and is loaded into primary_crng. This data is treated in the same
> way as data that is device-specific but otherwise unchanging, and
> so primary_crng cannot become initialized with the data from the
> hwrng.
> 
> This change causes the data initially read from the hwrng to be
> treated the same as subsequent data that is read from the hwrng if
> it's quality score is non-zero.
> 
> The implications of this are:
> 
> The data read from hwrng can cause primary_crng to become
> initialized, therefore avoiding problems of getrandom blocking
> on boot.
> 
> Calls to getrandom (with GRND_RANDOM) may be using entropy
> exclusively (or in practise, almost exclusively) from the hwrng.
> 
> Regarding the latter point; this behavior is the same as if a
> user specified a quality score of 1 (bit of entropy per 1024 bits)
> so hopefully this is not too scary a change to make.
> 
> This change is the result of the discussion here:
> https://patchwork.kernel.org/patch/10453893/
> 
> Signed-off-by: Louis Collard <louiscollard@chromium.org>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
