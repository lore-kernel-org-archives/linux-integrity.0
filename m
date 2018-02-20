Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62799 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbeBTOZ4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 09:25:56 -0500
Message-ID: <1519136753.4113.14.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org
Date: Tue, 20 Feb 2018 16:25:53 +0200
In-Reply-To: <1518812108.4475.21.camel@HansenPartnership.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518812108.4475.21.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-16 at 12:15 -0800, James Bottomley wrote:
> > I'm not sure how tpm_write() call path is handled.
> 
> It isn't currently since it uses tpm_transmit directly.  My thought
> on
> this is that if the TPM hasn't got its testing crap together by the
> time we enter userspace (which will be 10 or more seconds after we
> first sent the test commands), then we really have a problem and the
> user should see it.

Fair enough.

/Jarkko
