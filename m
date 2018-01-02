Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33371 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeABEkr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jan 2018 23:40:47 -0500
Received: by mail-io0-f169.google.com with SMTP id t63so10750696iod.0
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jan 2018 20:40:46 -0800 (PST)
Date: Mon, 1 Jan 2018 21:40:44 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: jarkko.sakkinen@linux.intel.com, peterhuewe@gmx.de,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] tpm_tis: Move ilb_base_addr to tpm_tis_data
Message-ID: <20180102044044.GA29208@ziepe.ca>
References: <1514865944-95086-1-git-send-email-azhar.shaikh@intel.com>
 <1514865944-95086-2-git-send-email-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1514865944-95086-2-git-send-email-azhar.shaikh@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jan 01, 2018 at 08:05:43PM -0800, Azhar Shaikh wrote:

> -	return tpm_chip_register(chip);
> +	rc = tpm_chip_register(chip);
> +	if (rc && is_bsw())
> +		iounmap(priv->ilb_base_addr);
> +
> +	return rc;
>  out_err:
>  	tpm_tis_remove(chip);
> +	if (is_bsw())
> +		iounmap(priv->ilb_base_addr);
> +
>  	return rc;
>  }

I thought you were resending this to fix the above, why is is it still
wonky?

Jason
