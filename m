Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24959 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752776AbeF2LdD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 07:33:03 -0400
Date: Fri, 29 Jun 2018 14:32:54 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Louis Collard <louiscollard@chromium.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: Re: [PATCH v2] tpm: Allow tpm_tis drivers to set hwrng quality.
Message-ID: <20180629113254.GB10894@linux.intel.com>
References: <20180629081355.155317-1-louiscollard@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629081355.155317-1-louiscollard@chromium.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 29, 2018 at 04:13:55PM +0800, Louis Collard wrote:
> Adds plumbing required for drivers based on tpm_tis to set hwrng quality.
> 
> Signed-off-by: Louis Collard <louiscollard@chromium.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
