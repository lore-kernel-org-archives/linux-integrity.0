Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40972 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388339AbeGWWwD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jul 2018 18:52:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so2101364wrr.8
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jul 2018 14:48:51 -0700 (PDT)
Date: Mon, 23 Jul 2018 15:48:46 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for partial reads
Message-ID: <20180723214846.GG532@ziepe.ca>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Jul 19, 2018 at 08:52:32AM -0700, Tadeusz Struk wrote:
> Currently to read a response from the TPM device an application needs
> provide "big enough" buffer for the whole response and read it in one go.
> The application doesn't know how big the response it beforehand so it
> always needs to maintain a 4K buffer and read the max (4K).
> In case if the user of the TSS library doesn't provide big enough buffer
> the TCTI spec says that the library should set the required size and return
> TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the application could
> allocate a bigger buffer and call receive again.
> To make it possible in the TSS library this requires being able to do
> partial reads from the driver.
> The library would read the header first to get the actual size of the
> response from the header and then read the rest of the response.
> This patch adds support for partial reads.

You should solve this in user space, the kernel API requires a full
sized buffer here, the tss library should always provide such an
internal buffer and then implement whatever scheme TSS wants by
memcpying from that buffer..

Jason
