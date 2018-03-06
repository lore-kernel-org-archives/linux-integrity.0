Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:4262 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbeCFLcV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 06:32:21 -0500
Message-ID: <1520335937.7549.10.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] tpm: move tpm1 selftest code from tpm-interface
 tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2018 13:32:17 +0200
In-Reply-To: <20180306093041.11996-5-tomas.winkler@intel.com>
References: <20180306093041.11996-1-tomas.winkler@intel.com>
         <20180306093041.11996-5-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-03-06 at 11:30 +0200, Tomas Winkler wrote:
> Move the tmp1 selftest code functions to tpm1-cmd.c
> tpm_pcr_read_dev to tpm1_pcr_read_dev
> tpm_continue_selftest to tpm1_continue_selftest
> tpm_do_selftest to tpm1_do_selftest
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

The same remark about tpm_buf as for tpm_get_random().

/Jarkko
