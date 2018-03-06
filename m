Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63757 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFLhh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 06:37:37 -0500
Message-ID: <1520336251.7549.13.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Tue, 06 Mar 2018 13:37:31 +0200
In-Reply-To: <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
         <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_probe() to use it.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Jason, is this now OK? I removed the error klog.

/Jarkko
