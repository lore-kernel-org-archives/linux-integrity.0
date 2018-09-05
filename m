Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19279 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeIEPoN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Sep 2018 11:44:13 -0400
Date: Wed, 5 Sep 2018 14:12:56 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: fix response size validation in tpm_get_random()
Message-ID: <20180905111256.GA9696@linux.intel.com>
References: <20180903011004.12161-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180903011004.12161-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Sep 03, 2018 at 04:10:04AM +0300, Jarkko Sakkinen wrote:
> When checking whether the response is large enough to be able to contain
> the received random bytes in tpm_get_random() and tpm2_get_random(),
> they fail to take account the header size, which should be added to the
> minimum size. This commit fixes this issue.
> 
> Cc: stable@vger.kernel.org
> Fixes: c659af78eb7b ("tpm: Check size of response before accessing data")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Stefan, you did the original commit. Does this look right to you?

/Jarkko
