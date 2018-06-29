Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56295 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932999AbeF2SJ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 14:09:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so3065302wmv.5
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 11:09:59 -0700 (PDT)
Date: Fri, 29 Jun 2018 12:09:53 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: require to compile as part of the kernel
Message-ID: <20180629180953.GG379@ziepe.ca>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
 <20180629153141.GE379@ziepe.ca>
 <20180629174743.GC4060@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629174743.GC4060@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 29, 2018 at 08:47:43PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 29, 2018 at 09:31:41AM -0600, Jason Gunthorpe wrote:
> > > -#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> > > -
> > > +#if defined(CONFIG_TCG_TPM)
> > 
> > Huh. This new version is certainly right
> 
> Hmm...
> 
> If the option is kept as tristate, shouldn't this be actually:
> 
> #if defined(CONFIG_TCG_TPM) && !defined(CONFIG_TCG_TPM_MODULE)
> 
> ?

Er, yes, it should be writte as

#if IS_ENABLED(CONFIG_TCG_TPM)

these days

Jason
