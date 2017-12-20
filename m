Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43586 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754929AbdLTMMT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 07:12:19 -0500
Received: by mail-wm0-f66.google.com with SMTP id n138so9426141wmg.2
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 04:12:18 -0800 (PST)
Subject: Re: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell systems
 due CLKRUN enabled
To: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc: James Ettle <james@ettle.org.uk>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
References: <20171220113538.16099-1-javierm@redhat.com>
 <96f3f833-22f8-5400-bd22-7c1c622bbe61@redhat.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <da95e481-be7d-63f2-1b54-1e1c6145ed3f@redhat.com>
Date: Wed, 20 Dec 2017 13:12:16 +0100
MIME-Version: 1.0
In-Reply-To: <96f3f833-22f8-5400-bd22-7c1c622bbe61@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Hans,

Thanks a lot for your feedback.

On 12/20/2017 12:43 PM, Hans de Goede wrote:
> Hi,
> 
> On 20-12-17 12:35, Javier Martinez Canillas wrote:
>> Hello,
>>
>> Commit 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
>> added logic in the TPM TIS driver to disable the Low Pin Count CLKRUN
>> signal during TPM transactions.
>>
>> Unfortunately this breaks other devices that are attached to the LPC bus
>> like for example PS/2 mouse and keyboards.
>>
>> The bug was reported to the Fedora kernel [0] and the kernel bugzilla [1].
>> This issue and the propossed solution were discussed in this [2] thread,
>> and the reporter (Jame Ettle) confirmed that his system works again after
>> the fix in this series.
>>
>> The patches are based on top or Jarkko Sakkinen's linux-tpmdd [3] tree.
>>
>> James,
>>
>> Even when there shouldn't be any functional changes, I included some other
>> fixes / cleanups in this series so it would be great if you can test them
>> again. I can't because I don't have access to a machine affected by this.
>>
>> [0]: https://bugzilla.redhat.com/show_bug.cgi?id=1498987
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=197287
>> [2]: https://patchwork.kernel.org/patch/10119417/
>> [3]: git.infradead.org/users/jjs/linux-tpmdd.git
>>
>> Best regards,
>> Javier
>>
>>
>> Javier Martinez Canillas (4):
>>    tpm: fix access attempt to an already unmapped I/O memory region
>>    tpm: delete the TPM_TIS_CLK_ENABLE flag
>>    tpm: follow coding style for variable declaration in
>>      tpm_tis_core_init()
>>    tpm: only attempt to disable the LPC CLKRUN if is already enabled
>>
>>   drivers/char/tpm/tpm_tis.c      | 17 +----------------
>>   drivers/char/tpm/tpm_tis_core.c | 24 +++++++++++++++++-------
>>   drivers/char/tpm/tpm_tis_core.h |  1 -
>>   3 files changed, 18 insertions(+), 24 deletions(-)
> 
> Note I'm just reading along here, but I'm wondering if both the TPM
> and now also some PS/2 controllers need CLK_RUN to be disabled,
> why don't we just disable it once permanently and be done with it?
>

That's the same question I asked to Azhar who authored the patch that
added the CLKRUN toggle logic to the driver, but he didn't answer yet:

https://www.spinics.net/lists/linux-integrity/msg01107.html

My understanding is that by permanently disabling it, then other devices
that do support the CLKRUN protocol will continue to work correctly since
the CLKRUN# signal is optional and only used if the host LCLK is stopped.

The disadvantage though will be that the power management feature of stopping
the LPC host LCLK clock when entering into low-power states will not be used.
 
> It seems that on machines with a PS/2 controller connected to
> the LPC bus the BIOS is already doing this, so I've a feeling that
> it not being done on devices with a TPM is a bug in the firmware

Absolutely agree, system integratos should make sure that all the devices
connected to the LPC either have CLKRUN protocol support and is enabled
or disable the CLKRUN protocol permanently.

> there and we should just disable it everywhere (and probably
> find a better place then the TPM driver to do the disabling).
>

Indeed. Touching a global bus configuration in a driver for a single device
isn't safe to say the least. One problem is that we don't have a LPC bus
subsystem so that's why these sort of quirks are done at the driver level.

> Note this is just an observation, I could be completely wrong here,
> but I've a feeling that just disabling CLKRUN all together is the
> right thing to do and that seems like an easier fix to me.
>

I think your observation is correct. The only problem is the power management
feature being disabled as mentioned. Although as you said it seems that most
BIOS do that (as shown by the patch I posted that just avoids toggling the
CLKRUN state if it's already disabled).

> Specifically what worries me is: what if another driver also takes
> the temporarily disable CLK_RUN approach because of similar issues?
> Now we've 2 drivers playing with the CLKRUN state and racing with
> each others.
>

Agreed. You don't even need another driver, if a Braswell system has 2 TPMs
then you have a race condition and one driver could enable the CLKRUN state
while the other driver thinks that's already disabled, and TPM transactions
won't work in that case.

So yeah, it's not a great situation.

> Regards,
> 
> Hans
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
