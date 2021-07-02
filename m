Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4CEC11F68
	for <linux-integrity@archiver.kernel.org>; Fri,  2 Jul 2021 07:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC7E61416
	for <linux-integrity@archiver.kernel.org>; Fri,  2 Jul 2021 07:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhGBHPJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 2 Jul 2021 03:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhGBHPJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 03:15:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0388B613EE;
        Fri,  2 Jul 2021 07:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625209957;
        bh=RHtWJLJs1E5Xp5VhqTKYWUoX9ZxgU2PEXVWI2yyFe3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ga9ogyvOtxevMMVXYq0gR8FwiEUJzJaqTFRwEp391rs7tIvvhB4ZzyHf+qq//vcc2
         JdVHCBm/4yPoE7zq//HRpHXCKZ/SUN4GupNyvOAI0kcJqYYQnOey7V+sT+dcxECUV6
         1AjwXhkcLmL1sYC+j66uIGK7UZnvVy++ALQbrimM=
Date:   Fri, 2 Jul 2021 09:12:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Hao Wu <hao.wu@rubrik.com>, shrihari.kalkar@rubrik.com,
        seungyeop.han@rubrik.com, anish.jhaveri@rubrik.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        pmenzel@molgen.mpg.de, kgold@linux.ibm.com,
        zohar@linux.vnet.ibm.com, why2jjj.linux@gmail.com, hamza@hpe.com,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
Message-ID: <YN68Y1t1eokIg7o1@kroah.com>
References: <20210624053321.861-1-hao.wu@rubrik.com>
 <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210702063555.q2phirfv7wxc6axu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702063555.q2phirfv7wxc6axu@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 02, 2021 at 09:35:55AM +0300, Jarkko Sakkinen wrote:
> On Tue, Jun 29, 2021 at 09:22:05PM -0700, Hao Wu wrote:
> > This is a fix for the ATMEL TPM crash bug reported in
> > https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
> > 
> > According to the discussions in the original thread,
> > we don't want to revert the timeout of wait_for_tpm_stat
> > for non-ATMEL chips, which brings back the performance cost.
> > For investigation and analysis of why wait_for_tpm_stat
> > caused the issue, and how the regression was introduced,
> > please read the original thread above.
> > 
> > Thus the proposed fix here is to only revert the timeout
> > for ATMEL chips by checking the vendor ID.
> > 
> > Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> > Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
> 
> Fixes tag should be before SOB.

Does not matter :)
