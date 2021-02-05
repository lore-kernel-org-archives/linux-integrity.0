Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02610C433DB
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Feb 2021 23:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE51964FDE
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Feb 2021 23:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBEXUP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 5 Feb 2021 18:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhBEKHB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 05:07:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE67964FF1;
        Fri,  5 Feb 2021 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612519551;
        bh=bs0XNM8gkt3RASjOhVZFNWk8DM7IhwKfz2bXsbWngbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbIfqWAXQsPNyAuKIieIdtVLPMHJ4NI+F0LTN+UJt9FrMnXbzvB3pKdCfS/t5MwSl
         AK9Nuslo3MM1WLO3kiQenPY8+z6owyOWKcAu6jPwAgua3mIbi4ZH5luM6FwFl61tsH
         qTu+hDP9uUVP1Zduw88mqpxLB8Okw811bmSy6tMU=
Date:   Fri, 5 Feb 2021 11:05:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ima: Free IMA measurement buffer after kexec
 syscall
Message-ID: <YB0YfGxfQPV2BqeO@kroah.com>
References: <20210204174951.25771-1-nramas@linux.microsoft.com>
 <20210204174951.25771-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204174951.25771-2-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 04, 2021 at 09:49:51AM -0800, Lakshmi Ramasubramanian wrote:
> IMA allocates kernel virtual memory to carry forward the measurement
> list, from the current kernel to the next kernel on kexec system call,
> in ima_add_kexec_buffer() function.  This buffer is not freed before
> completing the kexec system call resulting in memory leak.
> 
> Add ima_buffer field in "struct kimage" to store the virtual address
> of the buffer allocated for the IMA measurement list.
> Free the memory allocated for the IMA measurement list in
> kimage_file_post_load_cleanup() function.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
> ---
>  include/linux/kexec.h              | 5 +++++
>  kernel/kexec_file.c                | 5 +++++
>  security/integrity/ima/ima_kexec.c | 2 ++
>  3 files changed, 12 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
