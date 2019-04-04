Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17423C4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 12:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D944C206B7
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 12:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdAn9Hby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfDDMvp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:51:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35648 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDDMvp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 08:51:45 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so3446836itc.0
        for <linux-integrity@vger.kernel.org>; Thu, 04 Apr 2019 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4e3JznGoldTA3qcnNB07wlG3luOlv01GzXcBCM4v9M=;
        b=VdAn9Hby7/EIMq1ho/dndo4ri9mJ/LdHBCvR1c3vmY9I8+tTIqel9iDJXFpb2yva5Y
         4XfhL2BGhmJ512p1y6N5yW+rSf3Ge5pHPiC9nESGYeHMobyvYh7gNjHfz/+gdcGdUNbh
         OS955VJV+zgcKoQzJ6w0rqQ9LXrX1hoPDJv/7Z/ccbWKXpsAD5H/xYUmUSLwaEDvmYXz
         K3hYO3t0jGtbW8cx1oBb49GC8caoow0pJNIbY72+YwOINDj6GWq7/1aa5302zDPNPgPD
         7TkGuKwo774dRSohI3oGE7uzpAZDofenuInqP8C6e4ByCSNbvu73VCC1SQjIWcD998NX
         umzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4e3JznGoldTA3qcnNB07wlG3luOlv01GzXcBCM4v9M=;
        b=lEC3j1YTzjdaO+dtskTggFMyfvWtKXF1FTIte6yF64TLoxj/TpVYeDkEp8tjORYFSE
         OwB4Mthn+nGjFEZG4AOMeq6pOqAPZSfax6jTcbRxPrtHxLYc4EP8q4RP1H9JWmCGvrJ6
         cl0ySFhB4uAB3UbHh9HHxjQjZSAPX6+HWcal0KCt/PjRXA6OINK7d8SHr9Fy7uS50NZF
         dtZOJ55+NjtXQMRt9YnZpeKhNiomXuQqQDiXEd4ypGZJjM8eYYXFQuxa68FBJ/ZOZZIf
         eZITVQJBp7KRW59EXDcfa4HQuNFUxqovReIG27tsDlwmUjW9Y73W3Ga446kEtqPX2FJv
         jrmw==
X-Gm-Message-State: APjAAAU8HPbnZqggtcUwgeWRtLOE96P7M2YE0Z6K9U5xnOvS+SW10lTa
        L1RQABPyN1W1AB5oqIphNqfNIS4/PsJVr6i83pP9pg==
X-Google-Smtp-Source: APXvYqzBekKCjc2BSkRJoOnGF74Lifi0Hsi0Pkx/7er65Rh4fRGwkhogir5YlHCa3o+1W1PjqEWFi7E2jidHi4zwN/c=
X-Received: by 2002:a02:93ee:: with SMTP id z101mr4730406jah.17.1554382304427;
 Thu, 04 Apr 2019 05:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190403193238.145204-1-matthewgarrett@google.com>
In-Reply-To: <20190403193238.145204-1-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 4 Apr 2019 19:51:33 +0700
Message-ID: <CAKv+Gu_oujdfdaW+yvDRgroqRKMPDYRwXrXz1HgohLHm1Haj7Q@mail.gmail.com>
Subject: Re: [PATCH] efi: Include tpm_eventlog.h after asm/efi.h to avoid
 memcpy breakage
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thiebaud Weksteen <tweek@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 3 Apr 2019 at 21:32, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> 769a8089c1fd2 (x86, efi, kasan: #undef memset/memcpy/memmove per arch)
> disables the KASAN version of certain memory calls in the EFI boot stub.
> tpm_eventlog.h references memcpy, so must be included after asm/efi.h in
> order to allow 769a8089c1fd2 to take effect on its declarations.
>

I can't find any reference to memcpy in tpm_eventlog.h or tpm.h which
it includes. So can you describe the exact problem? If the issue is
due to one of the transitively included headers two levels down, then
this is fragile as hell since the same header may be included by
linux/efi.h due to, e.g.,  minor config changes.


> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  drivers/firmware/efi/libstub/tpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index b6e93e14fcf1..777c1e82495a 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -8,9 +8,11 @@
>   *     Thiebaud Weksteen <tweek@google.com>
>   */
>  #include <linux/efi.h>
> -#include <linux/tpm_eventlog.h>
>  #include <asm/efi.h>
>
> +/* Must be included after asm/efi.h in order to avoid using the wrong memcpy */
> +#include <linux/tpm_eventlog.h>
> +
>  #include "efistub.h"
>
>  #ifdef CONFIG_RESET_ATTACK_MITIGATION
> --
> 2.21.0.392.gf8f6787159e-goog
>
