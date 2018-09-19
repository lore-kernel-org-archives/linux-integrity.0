Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14439 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731266AbeISUwH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Sep 2018 16:52:07 -0400
Date: Wed, 19 Sep 2018 18:13:39 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/20] tpm1: implement tpm1_pcr_read_dev() using
 tpm_buf structure
Message-ID: <20180919151339.GJ31076@linux.intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
 <20180918093459.19165-18-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180918093459.19165-18-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Sep 18, 2018 at 12:34:56PM +0300, Tomas Winkler wrote:
> Implement tpm1_pcr_read_dev() using tpm_buf and remove
> now unneeded structures from tpm.h
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
