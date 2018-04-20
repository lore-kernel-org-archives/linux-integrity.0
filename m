Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:43204 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbeDTFkl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Apr 2018 01:40:41 -0400
Date: Fri, 20 Apr 2018 08:40:38 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tpm: Move eventlog declarations to its own header
Message-ID: <20180420054038.GD15364@linux.intel.com>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-5-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412101350.210547-5-tweek@google.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Apr 12, 2018 at 12:13:50PM +0200, Thiebaud Weksteen wrote:
> Reduce the size of tpm.h by moving eventlog declarations to a separate
> header.
> 
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
