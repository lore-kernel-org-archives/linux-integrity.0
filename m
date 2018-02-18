Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44695 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBRRIj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Feb 2018 12:08:39 -0500
Received: by mail-wr0-f194.google.com with SMTP id v65so7360756wrc.11
        for <linux-integrity@vger.kernel.org>; Sun, 18 Feb 2018 09:08:38 -0800 (PST)
Date: Sun, 18 Feb 2018 10:08:31 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: fix selftest failure regression
Message-ID: <20180218170831.GA4476@ziepe.ca>
References: <1518122886.21828.20.camel@HansenPartnership.com>
 <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
 <1518812108.4475.21.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1518812108.4475.21.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Feb 16, 2018 at 12:15:08PM -0800, James Bottomley wrote:

> It isn't currently since it uses tpm_transmit directly.  My thought on
> this is that if the TPM hasn't got its testing crap together by the
> time we enter userspace (which will be 10 or more seconds after we
> first sent the test commands), then we really have a problem and the
> user should see it.

Why would it be 10s? My embedded systems got to userspace in something
like 0.5s after sending the startup.

Not sure what to do here.. Our model has been that userspace gets a
raw view - but it has also been that the kernel makes the TPM fully
ready.

Jason
