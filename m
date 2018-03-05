Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16604 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbeCER7T (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 12:59:19 -0500
Date: Mon, 5 Mar 2018 19:59:12 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Message-ID: <20180305175912.GD5791@linux.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
 <20180305125642.GA3425@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Mar 05, 2018 at 01:09:09PM +0000, Winkler, Tomas wrote:
> > enum tpm_duration {
> > 	TPM_DURATION_DEFAULT = 2000,
> > 	TPM_DURATION_LONG = 300000,
> > };
> > 
> How is this aligned with the spec PTP spec?

For TPM 2.0 that spec only partially defines durations for CCs and thus
our look up table is already kind "flakky". In a sense that the default
duration is upper limit for spec defined durations.

> > These would be both for TPM 1.2 and TPM 2.0. Instead of having table for
> > every ordinal there should be a small tables describing commands that
> > require long timeout.
> 
> Yeah I didn't cover the 1.2. 

I could probably help with TPM 1.2 changes if required.

/Jarkko
