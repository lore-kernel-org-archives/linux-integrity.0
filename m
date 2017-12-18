Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34087 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757744AbdLRLLS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 06:11:18 -0500
Received: by mail-wm0-f68.google.com with SMTP id y82so7068256wmg.1
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 03:11:17 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Ettle <james@ettle.org.uk>, linux-integrity@vger.kernel.org,
        azhar.shaikh@intel.com, linux-kernel@vger.kernel.org,
        james.l.morris@oracle.com
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca> <1513443676.29063.0.camel@linux.intel.com>
 <34783fa1-4235-0057-1351-f7da9ee57024@redhat.com>
Message-ID: <1d724655-b0cc-b1bd-c771-839a04a74000@redhat.com>
Date: Mon, 18 Dec 2017 12:11:15 +0100
MIME-Version: 1.0
In-Reply-To: <34783fa1-4235-0057-1351-f7da9ee57024@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/16/2017 09:59 PM, Javier Martinez Canillas wrote:
> On 12/16/2017 06:01 PM, Jarkko Sakkinen wrote:
>> On Fri, 2017-12-15 at 10:38 -0700, Jason Gunthorpe wrote:
>>> On Fri, Dec 15, 2017 at 04:56:30PM +0200, Jarkko Sakkinen wrote:
>>>> On Thu, Dec 14, 2017 at 12:10:52PM -0700, Jason Gunthorpe wrote:
>>>>> On Thu, Dec 14, 2017 at 08:08:58PM +0100, Javier Martinez Canillas wrote:
>>>>>
>>>>>> Although probably reverting the offending commits is the right thing to do
>>>>>> until a proper solution is proposed.
>>>>>
>>>>> Yes, if a fix is not forthcoming soon Jarkko should revert.
>>>>>
>>>>
>>>> I think I should drop the current patch going to 4.16 and revert the old
>>>> patch. Do we agree on this?
>>>
>>> I think the entire is_bsw thing needs to go, clearly manipulating
>>> CLKRUN directly was not fully thought out?
>>>
>>> Hopefully Intel will come up with a fix patch to preserve PS/2
>>> functionality and it won't come to a revert..
>>
>> Agreed.
>>
> 
> Agreed. Although it would be good to have a solution soon, because this has been
> broken since v4.13 and v4.15-rc4 is likely to come this weekend. So we may end
> with Braswell system being non-function for 3 kernel releases...
> 
> As mentioned I can write a patch to hide this behavior under a Kconfig option
> that's disabled by default (and maybe depend on BROKEN) or a module parameter
> until a proper solution is found.
> 

I meant something like the following [0]. That way, it'll be disabled by default
but still users that really need this workaround can do:

$ ./scripts/config --enable EXPERT
$ ./scripts/config --enable CONFIG_TCG_TIS_ENABLE_CLKRUN_QUIRK

What do you think?

[0]:
>From 2ac0d743392ab96d5bf804830e0f0763a253c6e8 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Mon, 18 Dec 2017 11:10:01 +0100
Subject: [PATCH 1/1] tpm: Add Kconfig option to avoid disabling LPC CLKRUN
 unconditionally

Commit 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
added logic in the TPM TIS driver to disable the Low Pin Count CLKRUN
signal during TPM transations.

Unfortunately this breaks other devices that are attached into the LPC
bus (e.g: PS/2 mouse and keyboards), so the CLKRUN signal shouldn't be
disabled unconditionally.

Until a proper solution is found, add a Kconfig option to explicitly
enable that behavior if needed instead of doing it unconditionally on
all Braswell machines.

Fixes: 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/char/tpm/Kconfig        | 10 ++++++++++
 drivers/char/tpm/tpm_tis_core.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index a30352202f1f..220bd24e399f 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -43,6 +43,16 @@ config TCG_TIS
 	  within Linux. To compile this driver as a module, choose  M here;
 	  the module will be called tpm_tis.
 
+config TCG_TIS_ENABLE_CLKRUN_QUIRK
+	bool "Enable LPC CLKRUN workaround for Braswell systems TPM" if EXPERT
+	depends on TCG_TIS_CORE && X86
+	default n
+	---help---
+	  On Intel Braswell systems, the Low Pin Count bus CLKRUN signal has to
+	  be disabled during TPM devices transactions to operate correctly. This
+	  could break other devices attached to the LPC bus (i.e: PS/2 mouse and
+	  keyboards) so only enable if the TPM is the only device in the LPC bus.
+
 config TCG_TIS_SPI
 	tristate "TPM Interface Specification 1.3 Interface / TPM 2.0 FIFO Interface - (SPI)"
 	depends on SPI
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index e7bd2e750f69..0858c08b3b89 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -688,7 +688,7 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
 	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
 	u32 clkrun_val;
 
-	if (!IS_ENABLED(CONFIG_X86) || !is_bsw())
+	if (!IS_ENABLED(TCG_TIS_ENABLE_CLKRUN_QUIRK) || !is_bsw())
 		return;
 
 	if (value) {
-- 
2.14.3
