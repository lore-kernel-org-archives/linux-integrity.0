Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40054 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbeBTONf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 09:13:35 -0500
Message-ID: <1519136010.4113.10.camel@linux.intel.com>
Subject: Re: [PATCH 2/2 v3] tpm: separate cmd_ready/go_idle from runtime_pm
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Feb 2018 16:13:30 +0200
In-Reply-To: <20180219115221.7kd3ks7mrzmw36mz@linux.intel.com>
References: <20180214134319.4400-1-tomas.winkler@intel.com>
         <20180214134319.4400-3-tomas.winkler@intel.com>
         <20180219115221.7kd3ks7mrzmw36mz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-19 at 13:52 +0200, Jarkko Sakkinen wrote:
> On Wed, Feb 14, 2018 at 03:43:19PM +0200, Tomas Winkler wrote:
> > We cannot use go_idle cmd_ready commands via runtime_pm handles
> > as with the introduction of localities this is no longer an
> > optional
> > feature, while runtime pm can be not enabled.
> > Though cmd_ready/go_idle provides power saving feature, it's also
> > part of
> > TPM2 protocol and should be called explicitly.
> > This patch exposes cmd_read/go_idle via tpm class ops and removes
> > runtime pm support as it is not used by any driver.
> > 
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> > V2: resent
> > V3: resent
> 
> Only the cover letter needs a backlog but the code change looks
> good to me.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
