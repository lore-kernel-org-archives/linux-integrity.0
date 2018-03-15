Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41530 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeCORFF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 13:05:05 -0400
Message-ID: <1122028a7efd57fa6b5c1cabfd470fe986f7acba.camel@linux.intel.com>
Subject: Re: [PATCH v2 8/8] tpm: move tpm2 code validation to tpm2-space.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:49:01 +0200
In-Reply-To: <20180310082428.31519-9-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-9-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Add new function tpm2_validate_command to tpm2-space.c
> that wraps up open coded functionality from tpm_validate_command.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Same comment as for 7/8. Probably might apply also for 1-6.

/Jarkko
