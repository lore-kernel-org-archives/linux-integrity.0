Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44489 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdKFWLl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2017 17:11:41 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH RFC] tpm: Keep CLKRUN enabled throughout the duration of
 transmit_cmd()
Date: Mon, 6 Nov 2017 22:11:39 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582896ADAB@ORSMSX109.amr.corp.intel.com>
References: <1509751809-148601-1-git-send-email-azhar.shaikh@intel.com>
 <20171106170741.GH26011@ziepe.ca>
In-Reply-To: <20171106170741.GH26011@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
>Sent: Monday, November 6, 2017 9:08 AM
>To: Shaikh, Azhar <azhar.shaikh@intel.com>
>Cc: Sakkinen, Jarkko <jarkko.sakkinen@intel.com>; linux-
>integrity@vger.kernel.org
>Subject: Re: [PATCH RFC] tpm: Keep CLKRUN enabled throughout the duration
>of transmit_cmd()
>
>On Fri, Nov 03, 2017 at 04:30:09PM -0700, Azhar Shaikh wrote:
>> @@ -413,6 +413,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct
>tpm_space *space,
>>  	if (chip->dev.parent)
>>  		pm_runtime_get_sync(chip->dev.parent);
>>
>> +	chip->ops->clk_toggle(chip, true);
>
>You added this new op to the general code, but only updated two drivers,
>surely this makes all the other tis drivers oops as clk_toggle will be NULL?
>
>Suggest checking for NULL before calling.
>

Sure, will add the NULL check.

>> +#ifdef CONFIG_X86
>
>This is a good place to use IS_ENABLED instead of ifdef:
>
>> +/**
>> + * tpm_tis_clkrun_toggle() - Keep clkrun protocol disabled for entire
>duration
>> + *                           of a single TPM command
>> + * @chip:	TPM chip to use
>> + * @value:	1 - Disable CLKRUN protocol, so that clocks are free running
>> + *		0 - Enable CLKRUN protocol
>> + */
>> +static void tpm_tis_clkrun_toggle(struct tpm_chip *chip, bool value)
>> +{
>> +	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
>
>   if (!IS_ENABLED(CONFIG_X86))
>         return;
>

Will add this check and remove the #ifdef

>> +
>> +	if (value) {
>> +		tpm_platform_begin_xfer(data);
>> +		data->flags |= TPM_TIS_CLK_ENABLE;
>> +	} else {
>> +		data->flags &= ~TPM_TIS_CLK_ENABLE;
>> +		tpm_platform_end_xfer(data);
>> +	}
>> +}
>> +#else
>> +static void tpm_tis_clkrun_toggle(struct tpm_chip *chip, bool value)
>> +{ } #endif
>
>> +#ifdef CONFIG_X86
>> +void tpm_platform_begin_xfer(struct tpm_tis_data *data); void
>> +tpm_platform_end_xfer(struct tpm_tis_data *data); #else void
>> +tpm_platform_begin_xfer(struct tpm_tis_data *data) { } void
>> +tpm_platform_end_xfer(struct tpm_tis_data *data) { }
>
>These empty stubs need inlines
>

Sure, will add inline.

>Why are you using a mixture of callbacks and linked functions to solve this
>problem?
>
>Can't you do everything with callbacks?
>

I have set the flag TPM_TIS_CLK_ENABLE in the callback. But then in tpm_platform_begin_xfer() I want it to run once to disable clkrun and then return for all other instances, till the the flag is cleared.
If I just set the flag in tpm_tis_clkrun_toggle(), then for any TPM transaction after that the clkrun will not be disabled with current implementation. Hence calling it once before setting the flag so that it is kept enabled for the next transaction.

OR

I can update the callback as below:

+static void tpm_tis_clkrun_toggle(struct tpm_chip *chip, bool value)
+{
+	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
+
+	if (!IS_ENABLED(CONFIG_X86))
+		return;
+
+	if (value)
+		data->flags |= TPM_TIS_CLK_ENABLE;
+	else
+		data->flags &= ~TPM_TIS_CLK_ENABLE;
+}


And in tpm_platform_begin_xfer() maintain a flag which will track, that it is called at least once before returning, after the TPM_TIS_CLK_ENABLE is set. But I am not sure if this is a good approach. Could you please suggest the correct approach here.
Below is a rough/test patch how this could be implemented.

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -140,6 +140,7 @@ static int check_acpi_tpm2(struct device *dev)
 #define LPC_CLKRUN_EN                   (1 << 2)

 static void __iomem *ilb_base_addr;
+static bool run_once;

 static inline bool is_bsw(void)
 {
@@ -154,7 +155,7 @@ void tpm_platform_begin_xfer(struct tpm_tis_data *data)
 {
        u32 clkrun_val;

-       if (!is_bsw() || (data->flags & TPM_TIS_CLK_ENABLE))
+       if (!is_bsw() || ((data->flags & TPM_TIS_CLK_ENABLE) && run_once))
                return;

        clkrun_val = ioread32(ilb_base_addr + LPC_CNTRL_REG_OFFSET);
@@ -169,6 +170,11 @@ void tpm_platform_begin_xfer(struct tpm_tis_data *data)
         */
        outb(0xCC, 0x80);

+       if (!(data->flags & TPM_TIS_CLK_ENABLE))
+               run_once = false;
+       else
+               run_once = true;
+
 }
>Jason

Regards,
Azhar Shaikh
