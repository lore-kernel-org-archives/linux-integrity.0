Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:39806 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754170AbeARTYq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 14:24:46 -0500
Received: by mail-wm0-f47.google.com with SMTP id i11so24989164wmf.4
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jan 2018 11:24:46 -0800 (PST)
Date: Thu, 18 Jan 2018 12:24:41 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 3/3] tpm-chip: Export TPM device to user space even
 when startup failed
Message-ID: <20180118192441.GA17294@ziepe.ca>
References: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
 <20171214160614.11808-4-Alexander.Steffen@infineon.com>
 <20180118184510.zamelyx7c7fo3alh@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180118184510.zamelyx7c7fo3alh@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Jan 18, 2018 at 08:45:10PM +0200, Jarkko Sakkinen wrote:

> For SGX code that I've been upstreaming to arch/x86 tree the feedback
> was that local variable declarations should be in line length order,
> which makes sense to me i.e. startup_succesful should be the first
> declaration.

AFAIK that 'reverse christmas tree' style particularly local to the
net tree, not a general kernel style guideline. We've never used it in
TPM for instance.

Jason
