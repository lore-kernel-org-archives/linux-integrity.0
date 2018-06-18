Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:34082 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935546AbeFRSK0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jun 2018 14:10:26 -0400
Date: Mon, 18 Jun 2018 21:09:43 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Louis Collard <louiscollard@chromium.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: Re: [PATCH] tpm: Allow tpm_tis drivers to set hwrng quality.
Message-ID: <20180618180943.GD20697@linux.intel.com>
References: <20180608071146.110567-1-louiscollard@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180608071146.110567-1-louiscollard@chromium.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 08, 2018 at 03:11:46PM +0800, Louis Collard wrote:
> Adds plumbing required for drivers based on tpm_tis to set hwrng quality.
> 
> Signed-off-by: Louis Collard <louiscollard@chromium.org>

NAK because this not connected to the current GIT tree (should probably
make a patch set?).

/Jarkko
