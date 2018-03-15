Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:53032 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbeCOQkx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 12:40:53 -0400
Message-ID: <67805a53fd3471c70a9f29daa430d85d4879a23a.camel@linux.intel.com>
Subject: Re: [PATCH v2 5/8] tpm: factor out tpm1 pm suspend flow into
 tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:40:49 +0200
In-Reply-To: <20180310082428.31519-6-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-6-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Factor out tpm1 suspend flow from tpm-interface.c into a new function
> tpm1_pm_suspend in tpm1-cmd.c
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
