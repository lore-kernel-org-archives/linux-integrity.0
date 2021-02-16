Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0869C433E0
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Feb 2021 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70EFB64E07
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Feb 2021 16:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBPQRs (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhBPQRs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 11:17:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CC564E07;
        Tue, 16 Feb 2021 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613492227;
        bh=NdLDhzXHl0GyYRE9oOhGrcjVuspo1aupNW+noKrGQ4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6a316QC2YY1/7m00I67iwoQjcoaUpgswZ3MXSyDWtlLZfGCbMaDeB74ByNr0RAtP
         SCRC0vq6BZtf+8evjlqLwVbmhkihpUl1C1C3VGawM7gpacDxt62V1RlZA6Y8zKrsGL
         SDdLuXoE93xHhmQUhhdvvNpgzmZQfqiDVSOy7Lhr8uNPWZAoRB0X4sxGEEVpYisaCg
         7/1/3BT1USLIsVJx2coufUEBLEbESeT6vOSZzdsSQuR8dCgVUSSsQajzx1N6G7NH/T
         dgDDhRfl+Ds6zJh6dvQJFUPezf26qfsAfSo/4VzKiTe8POH05jfEjzm2LG6N86esh4
         Y1wrp6wYe03Xg==
Date:   Tue, 16 Feb 2021 18:16:55 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     linux-integrity@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in
 tpm_tis_gen_interrupt() and tpm_get_timeouts()
Message-ID: <YCvv9wvj4jUIKpa7@kernel.org>
References: <20210216081750.191250-1-jarkko@kernel.org>
 <ccb8ff69-5223-c293-bdda-46f041b7b770@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccb8ff69-5223-c293-bdda-46f041b7b770@debian.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 16, 2021 at 12:02:24PM +0100, Laurent Bigonville wrote:
> Le 16/02/21 à 09:17, Jarkko Sakkinen a écrit :
> > From: Lukasz Majczak <lma@semihalf.com>
> > 
> > This is shown with Samsung Chromebook Pro (Caroline) with TPM 1.2
> > (SLB 9670):
> > 
> > [    4.324298] TPM returned invalid status
> > [    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f
> > 
> > Background
> > ==========
> > 
> > TCG PC Client Platform TPM Profile (PTP) Specification, paragraph 6.1 FIFO
> > Interface Locality Usage per Register, Table 39 Register Behavior Based on
> > Locality Setting for FIFO - a read attempt to TPM_STS_x Registers returns
> > 0xFF in case of lack of locality. The described situation manifests itself
> > with the following warning trace:
> > 
> > The fix
> > =======
> > 
> > Add the proper decorations to tpm_tis_gen_interrupt() and
> > tpm_get_timeouts().
> 
> I tried that patch (alone on the top of the HEAD of Linus master) and I
> still get the same trace in dmesg

Can you give a shot to

git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

It has couple of more fixes, and paste the log.

/Jarkko
