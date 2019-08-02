Return-Path: <SRS0=ASXu=V6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B32C32750
	for <linux-integrity@archiver.kernel.org>; Fri,  2 Aug 2019 20:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42D2205F4
	for <linux-integrity@archiver.kernel.org>; Fri,  2 Aug 2019 20:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406939AbfHBUMU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 2 Aug 2019 16:12:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:18883 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405161AbfHBUMU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 16:12:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 13:12:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="175014681"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2019 13:12:17 -0700
Date:   Fri, 2 Aug 2019 23:12:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     linux-integrity@vger.kernel.org, tmaimon77@gmail.com,
        oshrialkoby85@gmail.com, Eyal.Cohen@nuvoton.com,
        Dan.Morav@nuvoton.com
Subject: Re: [RFC PATCH 1/2] tpm: Make implementation of
 read16/read32/write32 optional
Message-ID: <20190802201216.7autqk5r5ncrbyyo@linux.intel.com>
References: <20190718170355.6464-1-Alexander.Steffen@infineon.com>
 <20190718170355.6464-2-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718170355.6464-2-Alexander.Steffen@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 18, 2019 at 07:03:54PM +0200, Alexander Steffen wrote:
> Only tpm_tis has a faster way to access multiple bytes at once, every other
> driver will just fall back to read_bytes/write_bytes. Therefore, move this
> common code out of tpm_tis_spi into tpm_tis_core, so that it is
> automatically used when low-level drivers do not implement the specialized
> methods.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.h | 41 ++++++++++++++++++++++++++++++---
>  drivers/char/tpm/tpm_tis_spi.c  | 41 ---------------------------------
>  2 files changed, 38 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 7337819f5d7b..2c6557b29a1d 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -122,13 +122,37 @@ static inline int tpm_tis_read8(struct tpm_tis_data *data, u32 addr, u8 *result)
>  static inline int tpm_tis_read16(struct tpm_tis_data *data, u32 addr,
>  				 u16 *result)
>  {
> -	return data->phy_ops->read16(data, addr, result);
> +	if (data->phy_ops->read16) {
> +		return data->phy_ops->read16(data, addr, result);
> +	} else {
> +		__le16 result_le;
> +		int rc;
> +
> +		rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
> +					       (u8 *)&result_le);
> +		if (!rc)
> +			*result = le16_to_cpu(result_le);
> +
> +		return rc;
> +	}

Looks great.

I prefer to have variable declarations in the beginning of function for
most of the time. Other than that looks legit.

/Jarkko
