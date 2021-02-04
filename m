Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89558C433E0
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Feb 2021 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550B064F59
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Feb 2021 18:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbhBDSKx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238380AbhBDSBi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 13:01:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FE1864E27;
        Thu,  4 Feb 2021 18:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612461657;
        bh=gQE4gnuMAcYDrBdptHws1DsAHJJIKtASdxyvgH4xSbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4sNZmIIjkH/I8JbrSSfLBPzSKLOtuIthLKtCptYO7u4ILwpFk/eu2Uy4+iXMLEkR
         26pEPWTeVIUhmjDhWe0TizT4NPMm5aaWBG6oSCkzBIq2qjWO+3fYZr5tycWI1HSvAW
         LEu1/YKpbpRZ/ET+eRQSGKgX9uIqSiCdpQxxEoW46Uw7To5t1H7kuMjnqH71Co1x9s
         rCK5qE3UUa9LXnQZp9ghzE2NuZEah4fSe4qeQ9hQy3fknYcdyoKPlnEA91Oy/Twm0v
         msP+PqCYakHyGo9GvpJZfedykDyJZGJmni/A42MW4dvmXbF44ZGacz7JpqDjZ1Gns1
         QzKm21vn/oBaw==
Date:   Thu, 4 Feb 2021 18:00:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        joe@perches.com, catalin.marinas@arm.com, mpe@ellerman.id.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v16 10/12] arm64: Use OF alloc and free functions for FDT
Message-ID: <20210204180048.GD21303@willie-the-truck>
References: <20210204164135.29856-1-nramas@linux.microsoft.com>
 <20210204164135.29856-11-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204164135.29856-11-nramas@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 04, 2021 at 08:41:33AM -0800, Lakshmi Ramasubramanian wrote:
> of_alloc_and_init_fdt() and of_free_fdt() have been defined in
> drivers/of/kexec.c to allocate and free memory for FDT.
> 
> Use of_alloc_and_init_fdt() and of_free_fdt() to allocate and
> initialize the FDT, and to free the FDT respectively.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 37 +++++++-------------------
>  1 file changed, 10 insertions(+), 27 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
