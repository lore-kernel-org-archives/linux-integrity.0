Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:14303 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbeCOQfl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 12:35:41 -0400
Message-ID: <ee4a88f87158e8cb38f90b955af85d68b9105a97.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/8] tpm: factor out tpm1 code into tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:35:36 +0200
In-Reply-To: <20180310082428.31519-1-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Move TPM1 implementation from tpm-interface.c to tpm1-cmd.c
> similarly to tpm2-cmd.c, as well as move TPM2 open code flows
> into new functions to tpm2-cmd.c
> The functions in tpm-interface.c should now be in form:

In which patch tpm1-cmd.c is created?

/Jarkko
