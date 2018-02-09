Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:24657 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeBIQox (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Feb 2018 11:44:53 -0500
Date: Fri, 9 Feb 2018 18:44:49 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org,
        Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Subject: Re: [PATCH v2 1/5] tpm: fix potential buffer overruns caused by bit
 glitches on the bus
Message-ID: <20180209164449.udqwdxmsp2o3wdx7@linux.intel.com>
References: <1518121688.21828.12.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518121688.21828.12.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 08, 2018 at 12:28:08PM -0800, James Bottomley wrote:
> From: Jeremy Boone <jeremy.boone@nccgroup.trust>
> 
> Discrete TPMs are often connected over slow serial buses which, on
> some platforms, can have glitches causing bit flips.  If a bit does
> flip it could cause an overrun if it's in one of the size parameters,
> so sanity check that we're not overrunning the provided buffer when
> doing a memcpy().
> 
> Signed-off-by: Jeremy Boone <jeremy.boone@nccgroup.trust>
> Cc: stable@vger.kernel.org
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
