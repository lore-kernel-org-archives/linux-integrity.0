Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:32676 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbeCFLcz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 06:32:55 -0500
Message-ID: <1520335971.7549.11.camel@linux.intel.com>
Subject: Re: [PATCH V2] tpm_crb: use __le64 annotated variable for response
 buffer address
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2018 13:32:51 +0200
In-Reply-To: <20180306093415.12356-1-tomas.winkler@intel.com>
References: <20180306093415.12356-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-03-06 at 11:34 +0200, Tomas Winkler wrote:
> use __le64 annotated variable for response buffer address as this is
> read in little endian format form the register.
> 
> This suppresses sparse warning
> drivers/char/tpm/tpm_crb.c:558:18: warning: cast to restricted __le64
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
