Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59909 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbeCPMze (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 08:55:34 -0400
Date: Fri, 16 Mar 2018 14:55:25 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Sahil Rihan <srihan@fb.com>,
        Alexei Starovoitov <ast@fb.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180316125525.GB5035@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180312150231.GA24717@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Mar 12, 2018 at 09:02:32AM -0600, Jason Gunthorpe wrote:
> On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> > TCPA log are can be empty when the TPM is disabled. This commit changes the
> > behavior of tpm_read_log_acpi() to return successfully in this case.
> 
> The commit should explain why we'd want this..
> 
> eg Why does it matter to create the extra sysfs files to report an empty
> log?
> 
> Jason

The initialization of the driver will fail otherwise. Not sure if I
understand your question.

/Jarkko
