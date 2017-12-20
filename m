Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45070 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755063AbdLTLnm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 06:43:42 -0500
Received: by mail-wr0-f193.google.com with SMTP id h1so21996321wre.12
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 03:43:42 -0800 (PST)
Subject: Re: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell systems
 due CLKRUN enabled
To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: James Ettle <james@ettle.org.uk>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
References: <20171220113538.16099-1-javierm@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <96f3f833-22f8-5400-bd22-7c1c622bbe61@redhat.com>
Date: Wed, 20 Dec 2017 12:43:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171220113538.16099-1-javierm@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

On 20-12-17 12:35, Javier Martinez Canillas wrote:
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
>    tpm: fix access attempt to an already unmapped I/O memory region
>    tpm: delete the TPM_TIS_CLK_ENABLE flag
>    tpm: follow coding style for variable declaration in
>      tpm_tis_core_init()
>    tpm: only attempt to disable the LPC CLKRUN if is already enabled
> 
>   drivers/char/tpm/tpm_tis.c      | 17 +----------------
>   drivers/char/tpm/tpm_tis_core.c | 24 +++++++++++++++++-------
>   drivers/char/tpm/tpm_tis_core.h |  1 -
>   3 files changed, 18 insertions(+), 24 deletions(-)

Note I'm just reading along here, but I'm wondering if both the TPM
and now also some PS/2 controllers need CLK_RUN to be disabled,
why don't we just disable it once permanently and be done with it?

It seems that on machines with a PS/2 controller connected to
the LPC bus the BIOS is already doing this, so I've a feeling that
it not being done on devices with a TPM is a bug in the firmware
there and we should just disable it everywhere (and probably
find a better place then the TPM driver to do the disabling).

Note this is just an observation, I could be completely wrong here,
but I've a feeling that just disabling CLKRUN all together is the
right thing to do and that seems like an easier fix to me.

Specifically what worries me is: what if another driver also takes
the temporarily disable CLK_RUN approach because of similar issues?
Now we've 2 drivers playing with the CLKRUN state and racing with
each others.

Regards,

Hans
