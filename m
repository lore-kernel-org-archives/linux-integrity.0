Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41311 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbeCOQ35 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 12:29:57 -0400
Message-ID: <3f6082da29c0f779faed7a14f068b601c87d92c6.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/8] tpm: move tpm_getcap to tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:29:48 +0200
In-Reply-To: <20180310082428.31519-3-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-3-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> 1. Move tpm_getcap to tpm1-cmd. Rename the function to tpm1_getcap.
> 2. Remove unused tpm_getcap_header with unused constant
> as this functionality is already implemented using tpm_buf construct.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
