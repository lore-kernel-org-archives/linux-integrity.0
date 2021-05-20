Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E2DC433B4
	for <linux-integrity@archiver.kernel.org>; Thu, 20 May 2021 16:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6287A611AE
	for <linux-integrity@archiver.kernel.org>; Thu, 20 May 2021 16:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhETQk6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 20 May 2021 12:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhETQk5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 12:40:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D46B66101E;
        Thu, 20 May 2021 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528776;
        bh=mObjZUvojMIcttlGVKOdPZNIC+72oRM77+VaW6oOZtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQi0wcQ1KfRkkfbfZ5gRHrmfWXI55F+viWrMSvvcblM6Q84GAa7VZvS454pH8Q8x2
         8LhEm6jxEYwNGN+pPkQXm7+dUPkRH9NfrKYntzmhc4f38r6fmxNgMmr0QYxQ7FD6Nj
         FLNC+2+Q1HoywJ6WuKgl6KOdrK9okB2QXjNVcVxQ7TR213QrY5Q9zP10QNHEIJaQSE
         pXETGFqaj9FbLL4cS7obTSt8IpfwGoWsccXv9UKawEt3/TYu0X/DjMhaHRRpG6+G1n
         RiocVzBx9UcRr7+pa4GtdtsdpBGw5f7uBB1x1TwCvzxiNz947Oa3Jpe6qmcgYNiVzD
         nIrA5jQyUOu+w==
Date:   Thu, 20 May 2021 19:39:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v2] tpm2: add longer timeout for verify signature command
Message-ID: <YKaQxV4wzZ/UYrdu@kernel.org>
References: <20210519140059.85919-1-amirmizi6@gmail.com>
 <20210519140059.85919-2-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519140059.85919-2-amirmizi6@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 19, 2021 at 05:00:59PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> While running a TPM2_CC_VERIFY_SIGNATURE(0x177) operation with RSA 3070-bit

The hexcode for the TPM command is absoulutely irrelevant detail.

AFAIK, 3070-bit does not exist. It's 3072-bit.

> keys the TPM driver fails with the following error:

Empty line here.

> "kernel: [ 2416.187522] tpm tpm0: Operation Timed out"
> 
> Since a) the TPM PC Client specification does not specify a number for

Remove "a)".
> verify signature operation timeout, and b) the duration of

Remove "b)".

> TPM2_CC_VERIFY_SIGNATURE with RSA 3070-bit keys exceeds the current timeout
> of TPM_LONG (2 seconds), it is preferable to pick the longest timeout
> possible.

Empty line here.

> Therefore, set the duration for TPM2_CC_VERIFY_SIGNATUE to TPM_LONG_LONG
> (5 minutes).
> 
Add here:

Link: https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/

> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>


> ---
>  drivers/char/tpm/tpm2-cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 7603295..e71154b 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -87,7 +87,7 @@ static u8 tpm2_ordinal_duration_index(u32 ordinal)
>  		return TPM_MEDIUM;
>  
>  	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
> -		return TPM_LONG;
> +		return TPM_LONG_LONG;
>  
>  	case TPM2_CC_PCR_EXTEND:              /* 182 */
>  		return TPM_MEDIUM;
> -- 
> 2.7.4
> 
> 

/Jarkko
