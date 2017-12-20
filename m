Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28604 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755301AbdLTPTW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 10:19:22 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH 2/4] tpm: delete the TPM_TIS_CLK_ENABLE flag
Date: Wed, 20 Dec 2017 15:19:19 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF5828988730@ORSMSX109.amr.corp.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-3-javierm@redhat.com>
In-Reply-To: <20171220113538.16099-3-javierm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Javier Martinez Canillas [mailto:javierm@redhat.com]
>Sent: Wednesday, December 20, 2017 3:36 AM
>To: linux-kernel@vger.kernel.org
>Cc: James Ettle <james@ettle.org.uk>; Hans de Goede
><hdegoede@redhat.com>; Shaikh, Azhar <azhar.shaikh@intel.com>; Javier
>Martinez Canillas <javierm@redhat.com>; Arnd Bergmann <arnd@arndb.de>;
>Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Peter Huewe
><peterhuewe@gmx.de>; Jason Gunthorpe <jgg@ziepe.ca>; Greg Kroah-
>Hartman <gregkh@linuxfoundation.org>; linux-integrity@vger.kernel.org
>Subject: [PATCH 2/4] tpm: delete the TPM_TIS_CLK_ENABLE flag
>
>This flag is only used to warn if CLKRUN_EN wasn't disabled on Braswell
>systems, but the only way this can happen is if the code is not correct.
>
>So it's an unnecessary check that just makes the code harder to read.
>

Hi Javier,

This code was implemented as a suggestion from Jason on the previous patches. 
https://www.spinics.net/lists/linux-integrity/msg00827.html


>Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>---
>
> drivers/char/tpm/tpm_tis.c      | 15 ---------------
> drivers/char/tpm/tpm_tis_core.c |  2 --  drivers/char/tpm/tpm_tis_core.h |  1
>-
> 3 files changed, 18 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c index
>d29add49b033..d0ad9a89b02b 100644
>--- a/drivers/char/tpm/tpm_tis.c
>+++ b/drivers/char/tpm/tpm_tis.c
>@@ -138,9 +138,6 @@ static int tpm_tcg_read_bytes(struct tpm_tis_data
>*data, u32 addr, u16 len,  {
> 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
>
>-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
>-		WARN(1, "CLKRUN not enabled!\n");
>-
> 	while (len--)
> 		*result++ = ioread8(phy->iobase + addr);
>
>@@ -152,9 +149,6 @@ static int tpm_tcg_write_bytes(struct tpm_tis_data
>*data, u32 addr, u16 len,  {
> 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
>
>-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
>-		WARN(1, "CLKRUN not enabled!\n");
>-
> 	while (len--)
> 		iowrite8(*value++, phy->iobase + addr);
>
>@@ -165,9 +159,6 @@ static int tpm_tcg_read16(struct tpm_tis_data *data,
>u32 addr, u16 *result)  {
> 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
>
>-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
>-		WARN(1, "CLKRUN not enabled!\n");
>-
> 	*result = ioread16(phy->iobase + addr);
>
> 	return 0;
>@@ -177,9 +168,6 @@ static int tpm_tcg_read32(struct tpm_tis_data *data,
>u32 addr, u32 *result)  {
> 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
>
>-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
>-		WARN(1, "CLKRUN not enabled!\n");
>-
> 	*result = ioread32(phy->iobase + addr);
>
> 	return 0;
>@@ -189,9 +177,6 @@ static int tpm_tcg_write32(struct tpm_tis_data *data,
>u32 addr, u32 value)  {
> 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
>
>-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
>-		WARN(1, "CLKRUN not enabled!\n");
>-
> 	iowrite32(value, phy->iobase + addr);
>
> 	return 0;
>diff --git a/drivers/char/tpm/tpm_tis_core.c
>b/drivers/char/tpm/tpm_tis_core.c index 3455abbb2035..09da1e1adc40
>100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -746,7 +746,6 @@ static void tpm_tis_clkrun_enable(struct tpm_chip
>*chip, bool value)
> 		return;
>
> 	if (value) {
>-		data->flags |= TPM_TIS_CLK_ENABLE;
> 		data->clkrun_enabled++;
> 		if (data->clkrun_enabled > 1)
> 			return;
>@@ -777,7 +776,6 @@ static void tpm_tis_clkrun_enable(struct tpm_chip
>*chip, bool value)
> 		 * sure LPC clock is running before sending any TPM
>command.
> 		 */
> 		outb(0xCC, 0x80);
>-		data->flags &= ~TPM_TIS_CLK_ENABLE;
> 	}
> }
>
>diff --git a/drivers/char/tpm/tpm_tis_core.h
>b/drivers/char/tpm/tpm_tis_core.h index afc50cde1ba6..d5c6a2e952b3
>100644
>--- a/drivers/char/tpm/tpm_tis_core.h
>+++ b/drivers/char/tpm/tpm_tis_core.h
>@@ -86,7 +86,6 @@ enum tis_defaults {
>
> enum tpm_tis_flags {
> 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
>-	TPM_TIS_CLK_ENABLE		= BIT(1),
> };
>
> struct tpm_tis_data {
>--
>2.14.3
