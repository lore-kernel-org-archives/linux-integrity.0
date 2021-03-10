Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC1AC433E0
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Mar 2021 19:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844B564FDE
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Mar 2021 19:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhCJTct (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:32:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233928AbhCJTce (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 14:32:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A856264EF6;
        Wed, 10 Mar 2021 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615404754;
        bh=vEJCIFloLyk07WqFLgtIOhrepr8cJB5MmqAuD21elZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qC5/J62TO9Taw1vkk2nw9ksoHgVOsx3Fr4gzXgTjsZ0z5U8SadwNUITkhF9GgxRGC
         jfo6dUigWCl7BxVzL9ZZudCSmV6YqIE73sAJNl8S3CDGoFYP3yyldMsyQXKkKkYREU
         HBXsqa17Vh4vdWL8zO9J9I2fttYI1LYUOuMKHD5Uu1pPGcl3lbq3sHH5y11aVEwH/O
         SDZfhIlVNBbohRrkqiKRZQEpW+8bHGrTIWS8arsmbJ7Zi8aKX+gOCEdHUJeLN2mA2N
         MNzugNd+4yZZs7zlApdfd2kgy//ikrAoXvIdtbHo5bMAmgmqBLcAyzGFYvg9xPzGL5
         CSgD2XpPV08Wg==
Date:   Wed, 10 Mar 2021 21:32:10 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Andrew James <ajames3254@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: Fwd: TPM unaligned memory accesses
Message-ID: <YEkeuk06i3dGZn+b@kernel.org>
References: <CA+dP_Q1Siy7CEMABgEtUAVnbWxiQ8DLc2LkgVY+W29QEcC1YDA@mail.gmail.com>
 <CA+dP_Q3o8r-0h5W1dVOppeEFoyfz2F4A9Ve_-zOB9hWWQSS7ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+dP_Q3o8r-0h5W1dVOppeEFoyfz2F4A9Ve_-zOB9hWWQSS7ng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 10, 2021 at 04:41:54PM +1100, Andrew James wrote:
> Hi everyone,
> 
> I noticed the following potential unaligned memory access in
> tpm-interface.c, and I was wondering how it would be handled on
> architectures that don't support unaligned accesses.  Is this TPM code
> expected to work on all architectures?
> 
> ssize_t tpm_transmit_cmd(...)
> {
>     const struct tpm_header *header = (struct tpm_header *)buf->data;
>     int err;
>     ssize_t len;
> 
>      len = tpm_transmit(chip, buf->data, PAGE_SIZE);
>      if (len <  0)
>          return len;
> 
>      err = be32_to_cpu(header->return_code);
>         ...
> }
> 
> I'm referring to the line at the bottom, before the ellipsis where we
> read 'return_code'.
> 
> struct tpm_header has a __be16 tag followed by a __be32 return code.
> If we are reading 'return_code', is this an unaligned access?
> Similarly this would apply to the 'length' member too?
> 
> Documentation/unaligned-memory-access.txt recommends going through the
> kernel API get_unaligned() and put_unaligned() in <asm/unaligned.h> to
> avoid unaligned accesses, but I don't see this anywhere in the TPM
> code.  I'm just trying to wrap my head around this.

There's a patch for this in existence:

https://lore.kernel.org/tpmdd-devel/1479899094-9486-1-git-send-email-tomas.winkler@intel.com/

It's years since this was sent but I recall the issues were fairly
easy to fix.

/Jarkko
