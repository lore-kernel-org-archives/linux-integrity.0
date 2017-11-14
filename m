Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:32954 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757209AbdKNX2O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Nov 2017 18:28:14 -0500
Received: by mail-it0-f47.google.com with SMTP id n134so13498822itg.0
        for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2017 15:28:14 -0800 (PST)
Date: Tue, 14 Nov 2017 16:28:12 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@intel.com
Subject: Re: [PATCH RFC v2 2/2] tpm_tis: Move ilb_base_addr to tpm_tis_tcg_phy
Message-ID: <20171114232812.GB25894@ziepe.ca>
References: <1510090328-153106-1-git-send-email-azhar.shaikh@intel.com>
 <1510090328-153106-3-git-send-email-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510090328-153106-3-git-send-email-azhar.shaikh@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 07, 2017 at 01:32:08PM -0800, Azhar Shaikh wrote:

> +#ifdef CONFIG_X86
> +	if (is_bsw())
> +		iounmap(phy->ilb_base_addr);
> +#endif

This whole thing would be much better if is_bsw was just

bool is_bsw(void)
{ 
   if (!IS_ENABLED(CONFIG_X86))
       return false;
   [..]
}

Then drop every single one of these #ifdef CONFIG_X86

Jason
