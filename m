Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:47669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753420AbeGEPnS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jul 2018 11:43:18 -0400
Date: Thu, 5 Jul 2018 18:43:00 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] ima: Use tpm_default_chip() and call TPM functions with
 a tpm_chip
Message-ID: <20180705154300.GA12193@linux.intel.com>
References: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
 <1530550839.3709.46.camel@linux.vnet.ibm.com>
 <1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
 <1530706203.3452.74.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530706203.3452.74.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jul 04, 2018 at 08:10:03AM -0400, Mimi Zohar wrote:
> > > Jarkko, would you mind staging this patch with the rest of the patch
> > > set?
> > 
> > Yes, sure, I can do that. Any additional tag?
> 
> Thanks, just these.

I pushed the changes to my tree (also next).

> Mimi

/Jarkko
