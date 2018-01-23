Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:40683 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeAWNI7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jan 2018 08:08:59 -0500
Date: Tue, 23 Jan 2018 15:08:41 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        tpmdd-devel@lists.sourceforge.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180123130841.ub2amxalgr2oapu6@linux.intel.com>
References: <20180123112731.3687-1-tomas.winkler@intel.com>
 <20180123112731.3687-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123112731.3687-2-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jan 23, 2018 at 01:27:30PM +0200, Tomas Winkler wrote:
> We cannot use go_idle cmd_ready commands via runtime_pm handles
> as with the introduction of localities this is no longer an optional
> feature, while runtime pm can be not enabled.
> Though cmd_ready/go_idle provides power saving feature, it's also part of
> TPM2 protocol and should be called explicitly.
> This patch exposes cmd_read/go_idle via tpm class ops and removes
> runtime pm support as it is not used by any driver.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Thank you.

LGTM

Jason, what do you think?

/Jarkko
