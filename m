Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:24181 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965244AbeCSVYp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 17:24:45 -0400
Date: Mon, 19 Mar 2018 23:24:36 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sahil Rihan <srihan@fb.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180319212436.GD14364@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca>
 <20180316125525.GB5035@linux.intel.com>
 <20180319021323.GD27186@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319021323.GD27186@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Mar 18, 2018 at 08:13:23PM -0600, Jason Gunthorpe wrote:
> On Fri, Mar 16, 2018 at 02:55:25PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 12, 2018 at 09:02:32AM -0600, Jason Gunthorpe wrote:
> > > On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> > > > TCPA log are can be empty when the TPM is disabled. This commit changes the
> > > > behavior of tpm_read_log_acpi() to return successfully in this case.
> > > 
> > > The commit should explain why we'd want this..
> > > 
> > > eg Why does it matter to create the extra sysfs files to report an empty
> > > log?
> > > 
> > > Jason
> > 
> > The initialization of the driver will fail otherwise. Not sure if I
> > understand your question.
> 
> Well, I mean in the sense of what is broken and why is this the right
> fix. Why not return -ENODEV?

Well, because then the device initialization would fail.

Just noticed that this is missing:

Reported-by: Sahil Rihan <srihan@fb.com>

Sahil, would you care to try if this fixes the issue that you are
having or not?

/Jarkko
