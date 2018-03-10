Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:3113 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932368AbeCJQBz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 10 Mar 2018 11:01:55 -0500
Message-ID: <c440c1eeedc9640d8355606f4935048279bf5b1e.camel@linux.intel.com>
Subject: Re: [PATCH V2] tpm_crb: use __le64 annotated variable for response
 buffer address
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Mar 2018 18:01:52 +0200
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

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
