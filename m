Return-Path: <SRS0=us8B=RK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4C0C43381
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 17:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8462081B
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 17:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SaEjq3KJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfCGRPU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:15:20 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34904 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbfCGRPU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Mar 2019 12:15:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C8C408EE1EC;
        Thu,  7 Mar 2019 09:15:19 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iOlHY5eMTNuO; Thu,  7 Mar 2019 09:15:19 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D92998EE1A0;
        Thu,  7 Mar 2019 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1551978919;
        bh=QhJU0g7y6jdErlaHSBzsLdIQdFVFsNu8h5vikg9P1UE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SaEjq3KJBn5/E4CHEc0Zt8HQMgDMconILfzZvrSETHaxncLBvKdw+Q4UNlpx8g2G0
         fdpIlJyqL1Vm3R2XL2x2XioGtwBqERKrr7ZXWT5pepDdbvfbgjLwAvIefPK0b1zOTj
         TuQVNhqr1X7LqNXAY36a2piErlia24c+NZVTwmgc=
Message-ID: <1551978916.2983.35.camel@HansenPartnership.com>
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Markku Savela <msa@moth.iki.fi>,
        linux-integrity@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Date:   Thu, 07 Mar 2019 09:15:16 -0800
In-Reply-To: <1551183277.27819.66.camel@linux.ibm.com>
References: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
         <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
         <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
         <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi>
         <1550753358.17768.85.camel@linux.ibm.com>
         <776f0386-6c4d-9ad4-929c-44ba9fd4c9d0@moth.iki.fi>
         <88215b47-976c-96d5-1098-40868d28d576@moth.iki.fi>
         <357e44f8-df31-48ec-d2f0-deabd0161fc0@moth.iki.fi>
         <1551183277.27819.66.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-02-26 at 07:14 -0500, Mimi Zohar wrote:
> On Tue, 2019-02-26 at 10:12 +0200, Markku Savela wrote:
> > In case anyone is interested, I got IMA to accept TPM chip in my
> > special 
> > case (linaro optee kernel) by changing
> > 
> >    clk-bcm2835.c: core_initcall -> susbsys_initcall
> >    raspberrypi.c: subsys_initcall -> core_initcall
> > 
> > At first check, the system seems to be ok. Maybe some combination
> > of initcalls could work, but this is enough for me.
> 
> Thank you for sharing this!

I've just had one of these on x86: a Dell Inspiron 7000 that I got for
my wife.  This is the dmesg:

cottony:~ # dmesg|grep -i tpm
[    0.000000] ACPI: TPM2 0x000000008A595160 000034 (v03 DELL   CBX3     00000001 AMI  00000000)
[    1.628559] ima: No TPM chip found, activating TPM-bypass! (rc=-19)

I haven't investigated what type of TPM this is yet, but I suspect the
bus is attaching after IMA activates.  The TPM works normally after
this.

James

