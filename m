Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46048 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbeDTFkN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Apr 2018 01:40:13 -0400
Date: Fri, 20 Apr 2018 08:40:09 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tpm: Move shared eventlog functions to common.c
Message-ID: <20180420054009.GC15364@linux.intel.com>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-4-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412101350.210547-4-tweek@google.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Apr 12, 2018 at 12:13:49PM +0200, Thiebaud Weksteen wrote:
> Functions and structures specific to TPM1 are renamed from tpm* to tpm1*.
> 
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
