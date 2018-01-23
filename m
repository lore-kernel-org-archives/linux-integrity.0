Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:24337 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeAWMjO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jan 2018 07:39:14 -0500
Date: Tue, 23 Jan 2018 14:39:11 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 3/3] tpm-chip: Export TPM device to user space even
 when startup failed
Message-ID: <20180123123911.g4rwz7klqmru4phf@linux.intel.com>
References: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
 <20171214160614.11808-4-Alexander.Steffen@infineon.com>
 <20180118184510.zamelyx7c7fo3alh@linux.intel.com>
 <20180118192441.GA17294@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180118192441.GA17294@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Jan 18, 2018 at 12:24:41PM -0700, Jason Gunthorpe wrote:
> On Thu, Jan 18, 2018 at 08:45:10PM +0200, Jarkko Sakkinen wrote:
> 
> > For SGX code that I've been upstreaming to arch/x86 tree the feedback
> > was that local variable declarations should be in line length order,
> > which makes sense to me i.e. startup_succesful should be the first
> > declaration.
> 
> AFAIK that 'reverse christmas tree' style particularly local to the
> net tree, not a general kernel style guideline. We've never used it in
> TPM for instance.
> 
> Jason

And apparently also for x86 but if it is not general principle I'm fine
not using it.

/Jarkko
