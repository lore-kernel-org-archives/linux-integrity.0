Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:58229 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeF2RsA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 13:48:00 -0400
Date: Fri, 29 Jun 2018 20:47:43 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: require to compile as part of the kernel
Message-ID: <20180629174743.GC4060@linux.intel.com>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
 <20180629153141.GE379@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629153141.GE379@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 29, 2018 at 09:31:41AM -0600, Jason Gunthorpe wrote:
> > -#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> > -
> > +#if defined(CONFIG_TCG_TPM)
> 
> Huh. This new version is certainly right

Hmm...

If the option is kept as tristate, shouldn't this be actually:

#if defined(CONFIG_TCG_TPM) && !defined(CONFIG_TCG_TPM_MODULE)

?

/Jarkko
