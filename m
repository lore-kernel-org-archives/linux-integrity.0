Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:3264 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755458AbdLVSjf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 13:39:35 -0500
Date: Fri, 22 Dec 2017 20:39:30 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell
 systems due CLKRUN enabled
Message-ID: <20171222183930.kvdesz7pzhnhtztq@linux.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <96f3f833-22f8-5400-bd22-7c1c622bbe61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <96f3f833-22f8-5400-bd22-7c1c622bbe61@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 20, 2017 at 12:43:39PM +0100, Hans de Goede wrote:
> Note I'm just reading along here, but I'm wondering if both the TPM
> and now also some PS/2 controllers need CLK_RUN to be disabled,
> why don't we just disable it once permanently and be done with it?
> 
> It seems that on machines with a PS/2 controller connected to
> the LPC bus the BIOS is already doing this, so I've a feeling that
> it not being done on devices with a TPM is a bug in the firmware
> there and we should just disable it everywhere (and probably
> find a better place then the TPM driver to do the disabling).
> 
> Note this is just an observation, I could be completely wrong here,
> but I've a feeling that just disabling CLKRUN all together is the
> right thing to do and that seems like an easier fix to me.

Agreed. Thanks for noting this. Right now, I would just apply TPM
driver specific fixes.

/Jarkko
