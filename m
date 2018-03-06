Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:29483 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeCFLb0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 06:31:26 -0500
Message-ID: <1520335881.7549.9.camel@linux.intel.com>
Subject: Re: [PATCH 3/4] tmp: factor out tpm1_get_random into tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2018 13:31:21 +0200
In-Reply-To: <20180306093041.11996-4-tomas.winkler@intel.com>
References: <20180306093041.11996-1-tomas.winkler@intel.com>
         <20180306093041.11996-4-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-03-06 at 11:30 +0200, Tomas Winkler wrote:
> Factor out get random implementation from tpm-interface.c
> into tpm1_get_random function in tpm1-cmd.c.
> No functional changes.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

While you are doing this, please make it use tpm_buf so tha we get stuff
out of that nasty union. Using "helper" structs is still fine, just move
it right before the function implementation out of tpm.h (there are
examples of this tpm2-cmd.c).

/Jarkko
