Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:64606 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbeFDTz5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jun 2018 15:55:57 -0400
Date: Mon, 4 Jun 2018 22:55:54 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for nonblocking operation
Message-ID: <20180604195554.GD2691@linux.intel.com>
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 31, 2018 at 04:29:09PM -0700, Tadeusz Struk wrote:
> The TCG SAPI specification [1] defines a set of functions, which allows
> applications to use the TPM device in either blocking or non-blocking fashion.
> Each command defined by the specification has a corresponding
> Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
> together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
> mode of operation. Currently the driver supports only blocking calls, which
> doesn't allow asynchronous operation. This patch changes it and adds support
> for nonblocking write and a new poll function to enable applications using
> the API as designed by the spec.
> The new functionality can be tested using standard TPM tools implemented
> in [2], with modified TCTI from [3].

I would need some statistics before I have interest to take these
changes in any form eg use case where this matters in the end.

/Jarkko
