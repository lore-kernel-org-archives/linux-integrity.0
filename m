Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31891 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932672AbeEWM45 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 May 2018 08:56:57 -0400
Date: Wed, 23 May 2018 15:56:55 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] tpm: migrate tpm2_shutdown() to use struct tpm_buf
Message-ID: <20180523125655.GB363@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
 <20180518223032.ihszdef5wesj5nie@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518223032.ihszdef5wesj5nie@cantor>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, May 18, 2018 at 03:30:32PM -0700, Jerry Snitselaar wrote:
> On Mon Mar 26 18, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
> > entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
> > prints an error message.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanky you Jerry. I'll do one more round for this only to update kdoc.
It does not involve code changes so are you OK if you I keep your
reviewed-by despite this update?

/Jarkko
