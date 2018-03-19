Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43327 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754708AbeCSCNZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Mar 2018 22:13:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id f23-v6so9339688plr.10
        for <linux-integrity@vger.kernel.org>; Sun, 18 Mar 2018 19:13:25 -0700 (PDT)
Date: Sun, 18 Mar 2018 20:13:23 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Sahil Rihan <srihan@fb.com>,
        Alexei Starovoitov <ast@fb.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180319021323.GD27186@ziepe.ca>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca>
 <20180316125525.GB5035@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180316125525.GB5035@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:55:25PM +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 12, 2018 at 09:02:32AM -0600, Jason Gunthorpe wrote:
> > On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> > > TCPA log are can be empty when the TPM is disabled. This commit changes the
> > > behavior of tpm_read_log_acpi() to return successfully in this case.
> > 
> > The commit should explain why we'd want this..
> > 
> > eg Why does it matter to create the extra sysfs files to report an empty
> > log?
> > 
> > Jason
> 
> The initialization of the driver will fail otherwise. Not sure if I
> understand your question.

Well, I mean in the sense of what is broken and why is this the right
fix. Why not return -ENODEV?

Jason
