Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3709 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933961AbeGCQvI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jul 2018 12:51:08 -0400
Date: Tue, 3 Jul 2018 19:51:02 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <jejb@linux.vnet.ibm.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until module
 shutdown
Message-ID: <20180703165102.GB19800@linux.intel.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
 <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
 <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
 <1530631615.3142.6.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530631615.3142.6.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> On Tue, 2018-07-03 at 18:24 +0300, Jarkko Sakkinen wrote:
> [...]
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Is James maintaining this now? Have not seen his feedback yet...
> 
> Hey, I thought we both were ...
> 
> However, it looks fine to me
> 
> Reviewed-by: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
> 
> James

OK, I was not sure how that discussion went. I could add myself as
co-maintainer to MAINTAINERS because I anyway need to go through
all of these.

If anyone does not vote against, I'll send a patch.

/Jarkko
