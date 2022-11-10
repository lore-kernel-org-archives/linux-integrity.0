Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217C0C4332F
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Nov 2022 11:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiKJLPF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 10 Nov 2022 06:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiKJLOv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 06:14:51 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E454701A7
        for <linux-integrity@vger.kernel.org>; Thu, 10 Nov 2022 03:14:32 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q71so1486773pgq.8
        for <linux-integrity@vger.kernel.org>; Thu, 10 Nov 2022 03:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bINLLU9PD1pEzI3atyU2ZEDrwA88CdhG/1pr/Rzw2KY=;
        b=nsvQUFkPM65XhIKwogsU8yFQC96WEi+N/yF/Dm226uiIActc6A0bN6qqFIDPuQTlGJ
         vSf3dKVDaWeHQI9uq4/xMdRAeTm9KCEMxaOSTLMPDh61pJ5qzfk3I9Mb0/Yb7rtMNGEs
         CXJ9v7vfNey2imsN19gPKiwrgxV5UfhaYy6f7lp4iQgVkFkfj4rbRhY/58VL0NzyXjVb
         OAV925LQimY7UTD1i+RDWzYd84ifVYVHZqfNO1DV05CbmgmLUbuJ0DmK0pAzSSO35/rf
         1It/xD8LsK/bqdsfqwHPB64W4hjmHerEViFIRsarzGZxkQpv+rtH8wOPI2VwmPgozU8i
         gFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bINLLU9PD1pEzI3atyU2ZEDrwA88CdhG/1pr/Rzw2KY=;
        b=jTCdNIy+HZv9FixPKOvMo37KvNhLaQ2CnOD0Mpw3cCfQ6nECQRKsl8qefQZ1O7vLIj
         sOPq1VBYwf/6nf8/oDyi61r5pvXJfFt5dsHqE6H+JWpQOsIbM1r+dMM0PupZ7Hk5gZ9n
         D0OPcgZJX83TL3vKq/gcv2gUDYtwljVO3EVWg5xaDxSsTs6usSt2wHSuKCGKrrjVar5P
         3CcnKlONM9w+M5HRWp/vog4aarNdGposvB794jNECkfcsf/unfUju2S+AVejOyMdtPG4
         sakl0SPSyeJ4akJqUjJJrOl/bRZ2gRBIs0lqYi2NGmpvPed1LUvmDISvPIQuUE1UWZm5
         oRDw==
X-Gm-Message-State: ACrzQf3qU33dqAbkBd3IZvq6jeDizNQUDgZgC5PDQZVjPJDFl94karZD
        7LSLfKAm+8k8elDOvZKk5o9vl3OAzrAR5d3GTIFKkA==
X-Google-Smtp-Source: AMsMyM7pNQARAbULI6QCzZi6RINV5taBDWPVxndnKjwvl2BvAbsPjPGxaHD5QBaBNVTFXQNULJkyAtUYpbUEcMd9T/A=
X-Received: by 2002:a63:db42:0:b0:45c:9c73:d72e with SMTP id
 x2-20020a63db42000000b0045c9c73d72emr53321246pgi.181.1668078871936; Thu, 10
 Nov 2022 03:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20221110111140.1999538-1-sumit.garg@linaro.org>
In-Reply-To: <20221110111140.1999538-1-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 10 Nov 2022 16:44:20 +0530
Message-ID: <CAFA6WYMKSjvgNgbf=cJXiTE3LitS-whtRbqJW1cdkHMJ1TsdUg@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: Make registered shm dependency explicit
To:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jerome Forissier <jerome.forissier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

+ Jarkko (Apologies I accidently missed you while sending the original patch).

On Thu, 10 Nov 2022 at 16:42, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> TEE trusted keys support depends on registered shared memory support
> since the key buffers are needed to be registered with OP-TEE. So make
> that dependency explicit to not register trusted keys support if
> underlying implementation doesn't support registered shared memory.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> index c8626686ee1b..ac3e270ade69 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -219,7 +219,8 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
>
>  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  {
> -       if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> +       if (ver->impl_id == TEE_IMPL_ID_OPTEE &&
> +           ver->gen_caps & TEE_GEN_CAP_REG_MEM)
>                 return 1;
>         else
>                 return 0;
> --
> 2.34.1
>
