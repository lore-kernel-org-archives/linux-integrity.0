Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:1974 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbeBFUEq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Feb 2018 15:04:46 -0500
Date: Tue, 6 Feb 2018 22:04:41 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180206200441.c2fnehekqbk3jcsg@linux.intel.com>
References: <20180128075101.6883-1-tomas.winkler@intel.com>
 <20180128075101.6883-3-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180128075101.6883-3-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Jan 28, 2018 at 09:51:01AM +0200, Tomas Winkler wrote:
> We cannot use go_idle cmd_ready commands via runtime_pm handles
> as with the introduction of localities this is no longer an optional
> feature, while runtime pm can be not enabled.
> Though cmd_ready/go_idle provides power saving feature, it's also part of
> TPM2 protocol and should be called explicitly.
> This patch exposes cmd_read/go_idle via tpm class ops and removes
> runtime pm support as it is not used by any driver.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Makes sense so that only 1/2 woud need to be backported to stable
(1/2 should probably have cc for stable).

/Jarkko
