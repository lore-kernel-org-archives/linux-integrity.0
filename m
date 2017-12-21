Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:53816 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbdLUKvV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 05:51:21 -0500
Subject: Re: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell systems
 due CLKRUN enabled
To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
References: <20171220113538.16099-1-javierm@redhat.com>
From: James Ettle <james@ettle.org.uk>
Message-ID: <5c098570-5aea-533c-c096-b5eb5ecc5c95@ettle.org.uk>
Date: Thu, 21 Dec 2017 10:51:13 +0000
MIME-Version: 1.0
In-Reply-To: <20171220113538.16099-1-javierm@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

OK, I built a kernel based on:

- git clone of git.infradead.org/users/jjs/linux-tpmdd.git taken last night
- applying the patch in https://patchwork.kernel.org/patch/10119417/
- stock config-4.14.6-300.fc27.x86_64 + make oldconfig

The tpm modules are loaded and the keyboard is working.

Note: I won't have access to this machine over the next few weeks.

Thanks,
James.


On 20/12/17 11:35, Javier Martinez Canillas wrote:
> Hello,
> 
> Commit 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
> added logic in the TPM TIS driver to disable the Low Pin Count CLKRUN
> signal during TPM transactions.
> 
> Unfortunately this breaks other devices that are attached to the LPC bus
> like for example PS/2 mouse and keyboards.
> 
> The bug was reported to the Fedora kernel [0] and the kernel bugzilla [1].
> This issue and the propossed solution were discussed in this [2] thread,
> and the reporter (Jame Ettle) confirmed that his system works again after
> the fix in this series.
> 
> The patches are based on top or Jarkko Sakkinen's linux-tpmdd [3] tree.
> 
> James,
> 
> Even when there shouldn't be any functional changes, I included some other
> fixes / cleanups in this series so it would be great if you can test them
> again. I can't because I don't have access to a machine affected by this.
> 
> [0]: https://bugzilla.redhat.com/show_bug.cgi?id=1498987
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=197287
> [2]: https://patchwork.kernel.org/patch/10119417/
> [3]: git.infradead.org/users/jjs/linux-tpmdd.git
> 
> Best regards,
> Javier
> 
> 
> Javier Martinez Canillas (4):
>   tpm: fix access attempt to an already unmapped I/O memory region
>   tpm: delete the TPM_TIS_CLK_ENABLE flag
>   tpm: follow coding style for variable declaration in
>     tpm_tis_core_init()
>   tpm: only attempt to disable the LPC CLKRUN if is already enabled
> 
>  drivers/char/tpm/tpm_tis.c      | 17 +----------------
>  drivers/char/tpm/tpm_tis_core.c | 24 +++++++++++++++++-------
>  drivers/char/tpm/tpm_tis_core.h |  1 -
>  3 files changed, 18 insertions(+), 24 deletions(-)
> 
