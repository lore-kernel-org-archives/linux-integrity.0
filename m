Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5074 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731221AbeISVDG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Sep 2018 17:03:06 -0400
Date: Wed, 19 Sep 2018 18:24:34 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/20] tpm1: reimplement tpm1_continue_selftest()
 using tpm_buf
Message-ID: <20180919152434.GM31076@linux.intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
 <20180918093459.19165-21-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180918093459.19165-21-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Sep 18, 2018 at 12:34:59PM +0300, Tomas Winkler wrote:
> Reimplement tpm1_continue_selftest() using tpm_buf structure.
> This is the last command using the old tpm_cmd_t structure
> and now the structure can be removed.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Minor rant: the last sentence should state simply that as there
are no other fields in tpm_cmd_t can be removed. The rationale
is that the patch set ceases to exist after it is accepted. It
is a temporary item, not something that should be referred in
the commit log.

/Jarkko
