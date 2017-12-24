Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:14289 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbdLXU55 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Dec 2017 15:57:57 -0500
Date: Sun, 24 Dec 2017 22:57:50 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
 memory region
Message-ID: <20171224205750.z25vnk3apew3zuc6@linux.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171220113538.16099-2-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 20, 2017 at 12:35:35PM +0100, Javier Martinez Canillas wrote:
> The driver maps the I/O memory address to control the LPC bus CLKRUN_EN,
> but on the error path the memory is accessed by the .clk_enable handler
> after this was already unmapped. So only unmap the I/O memory region if
> it will not be used anymore.
> 
> Also, the correct thing to do is to cleanup the resources in the inverse
> order that were acquired to prevent issues like these.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

I applied Azhar's updated patches to master and next. Shouldn't this be
dropped now?

/Jarkko
