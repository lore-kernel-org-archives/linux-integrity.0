Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5341C43217
	for <linux-integrity@archiver.kernel.org>; Sun, 27 Nov 2022 17:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiK0RTD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 27 Nov 2022 12:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0RTC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 12:19:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EDAE02C;
        Sun, 27 Nov 2022 09:19:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8101CE0B17;
        Sun, 27 Nov 2022 17:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BD1C433D6;
        Sun, 27 Nov 2022 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669569537;
        bh=KW0UxM81yAuHRMHuXigXGqAtkB2EIbkn1TF4ei8GhnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4aPLr+QKBnz6S+wqZ7Og/STRM5bWFJeRBon5efIYGJQgFC/FlN2aLbWw6DSMZkef
         0Q8Ck28ZeRZbkQstqgQJGtMypklnE6OnzF2rjqAYF1cK7+4MTDSouNF8lwXP3dpXsZ
         JYgBr9+7Cd6lSUpeugq4iV5+cDD0Cr4iDdqiJXraz0/ST+vsPrj/ut3VYUIrCUgI4M
         iDmpK7Kuwe7uXy93LGvrLzM2CPkKkH6fBZaWZPU1QgAL32VrQTvKfTlLVHkYxvw4I7
         gg1AoWVsot9+9IG+zNNfN/GrPsv+e9dTqa7eM2sgWZv+YQJeID2xUrfC61a0IO571a
         R25ppvCZgVvBQ==
Date:   Sun, 27 Nov 2022 19:18:53 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tpm: acpi: Call acpi_put_table() to fix memory
 leak
Message-ID: <Y4Ob/aJ9s5G9zuT7@kernel.org>
References: <1668684222-38457-1-git-send-email-guohanjun@huawei.com>
 <1668684222-38457-2-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668684222-38457-2-git-send-email-guohanjun@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 17, 2022 at 07:23:40PM +0800, Hanjun Guo wrote:
> The start and length of the event log area are obtained from
> TPM2 or TCPA table, so we call acpi_get_table() to get the
> ACPI information, but the acpi_get_table() should be coupled with
> acpi_put_table() to release the ACPI memory, add the acpi_put_table()
> properly to fix the memory leak.
> 
> While we are at it, remove the redundant empty line at the
> end of the tpm_read_log_acpi().
> 
> Fixes: 0bfb23746052 ("tpm: Move eventlog files to a subdirectory")
> Fixes: 85467f63a05c ("tpm: Add support for event log pointer found in TPM2 ACPI table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 1b18ce5..0913d3eb 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -90,16 +90,21 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  			return -ENODEV;
>  
>  		if (tbl->header.length <
> -				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy))
> +				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy)) {
> +			acpi_put_table((struct acpi_table_header *)tbl);
>  			return -ENODEV;
> +		}
>  
>  		tpm2_phy = (void *)tbl + sizeof(*tbl);
>  		len = tpm2_phy->log_area_minimum_length;
>  
>  		start = tpm2_phy->log_area_start_address;
> -		if (!start || !len)
> +		if (!start || !len) {
> +			acpi_put_table((struct acpi_table_header *)tbl);
>  			return -ENODEV;
> +		}
>  
> +		acpi_put_table((struct acpi_table_header *)tbl);
>  		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>  	} else {
>  		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> @@ -120,8 +125,10 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  			break;
>  		}
>  
> +		acpi_put_table((struct acpi_table_header *)buff);
>  		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>  	}
> +
>  	if (!len) {
>  		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
>  		return -EIO;
> @@ -156,5 +163,4 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	kfree(log->bios_event_log);
>  	log->bios_event_log = NULL;
>  	return ret;
> -
>  }
> -- 
> 1.7.12.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

