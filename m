Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:46179 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932722AbeFZIVs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 04:21:48 -0400
Message-ID: <cfa499cd0a663517d17ede0206ad98a2b0d350e9.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/5] Have IMA find and use a tpm_chip until system
 shutdown
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org
Date: Tue, 26 Jun 2018 11:21:26 +0300
In-Reply-To: <165d1f1ba8219da81390b064aaf6787ee263fe12.camel@linux.intel.com>
References: <20180625104312.2213278-1-stefanb@linux.vnet.ibm.com>
         <7233579b5bf09fbea65e8132fb31fc9f6af59bad.camel@linux.intel.com>
         <165d1f1ba8219da81390b064aaf6787ee263fe12.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-26 at 11:20 +0300, Jarkko Sakkinen wrote:
> On Tue, 2018-06-26 at 11:19 +0300, Jarkko Sakkinen wrote:
> > On Mon, 2018-06-25 at 06:43 -0400, Stefan Berger wrote:
> > > This series of patches converts IMA's usage of the tpm_chip to find a TPM
> > > chip initially and use it until the machine is shut down. To do this we
> > > need
> > > to introduce a kref for the tpm_chip that IMA and all other users of a
> > > tpm_chip hold onto until they don't need the TPM chip anymore.
> > > 
> > >     Stefan
> > > 
> > > v3->v4:
> > >   - followed Jason's suggestions
> > 
> > "Jason's suggestions" means nothing.
> 
> Please fix the change log for the next version.

You should probably resend this version as also linu-security-module
is missing. NAK because of that.

/Jarkko
