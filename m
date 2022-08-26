Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69503ECAAA3
	for <linux-integrity@archiver.kernel.org>; Fri, 26 Aug 2022 04:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242055AbiHZEEI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 26 Aug 2022 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiHZEEG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Aug 2022 00:04:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D80CA0330;
        Thu, 25 Aug 2022 21:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 187CA61E88;
        Fri, 26 Aug 2022 04:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C14C433D6;
        Fri, 26 Aug 2022 04:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661486644;
        bh=uHX9AUrlZ/1oNgPDOP2COdLfdippZAZ0Dd+zXIDXEO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQFU9KEHkkw3COM5gBeUJcZwCZMWzcrhdeUSOThugdI0Um916XbjToTqTQaxlg/Su
         8IBRPt5R16YdL+1MBxT/XbXNtNrSO+/RVQA/oIgBDKUq16ID3pMViVVGZKfMnRb4Ou
         VyDkx/0s33zAhkFx3fYc1TVPA40VTug/VQrY6GqLi1WSGIOxcqdm+bzlTR8otTwODn
         pGfJpksLAwM8aZMcBb6FQthToDehMQlZiQKbWY/NbGN4RTCFnTeDYd5pJ822uvhSeu
         IIdkxoL1H6a2rxaXhTKk9t8ZOA1bdoJR7mSL2Fd13jRWJ2v5sGpnE8HYWNXi6lOJhk
         zN5u2VeCvcrsg==
Date:   Fri, 26 Aug 2022 07:03:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander.Steffen@infineon.com, jgg@ziepe.ca, peterhuewe@gmx.de,
        joel@jms.id.au
Subject: Re: [PATCH] tpm: tis_i2c: Fix sanity check interrupt enable mask
Message-ID: <YwhGLZX2+dggWHcI@kernel.org>
References: <20220817200333.305264-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817200333.305264-1-eajames@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 17, 2022 at 03:03:33PM -0500, Eddie James wrote:
> The sanity check mask for TPM_INT_ENABLE register was off by 8 bits,
> resulting in failure to probe if the TPM_INT_ENABLE register was a
> valid value.
> 
> Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 0692510dfcab..635a69dfcbbd 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -49,7 +49,7 @@
>  
>  /* Masks with bits that must be read zero */
>  #define TPM_ACCESS_READ_ZERO 0x48
> -#define TPM_INT_ENABLE_ZERO 0x7FFFFF6
> +#define TPM_INT_ENABLE_ZERO 0x7FFFFF60
>  #define TPM_STS_READ_ZERO 0x23
>  #define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
>  #define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
> -- 
> 2.31.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you.

BR, Jarkko
