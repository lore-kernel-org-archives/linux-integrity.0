Return-Path: <SRS0=2pHC=Q7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A38C43381
	for <linux-integrity@archiver.kernel.org>; Sun, 24 Feb 2019 22:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1208820842
	for <linux-integrity@archiver.kernel.org>; Sun, 24 Feb 2019 22:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPwBhp3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbfBXWMI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 24 Feb 2019 17:12:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41025 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBXWMI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Feb 2019 17:12:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id t7so6253767otk.8
        for <linux-integrity@vger.kernel.org>; Sun, 24 Feb 2019 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XttKmD05Qtp9eepfd6tIkmcLqAthgNI109O56kyYc2c=;
        b=uPwBhp3zrSEGDpxcc3SClZN2q4OmJCdeIcLrBW8vzA2mg6Tm4wdsVgF6Azkj6CgyuM
         70Xd+fsScupQqzSuoUg1tpg8ZrG3zoS5Vx/lSGJ5wdrrGC4JZ+T6viM1Oro8s8sxW18e
         kIZBjaFTCiP3oeuhim8Raj29Za6RF0J+AY7dOJ23sN3hdxq0R0GopK+qbdMvRIeiJar0
         6sHkHyt1lkekJrXceoQ4Pjasnb6oH5uI3Xgl4UHvvn2DPMpexzqP4cSmJUM7vYKpUU+B
         4W/2+aUkuAZ+seF6MmHW48ibZao0qBRUt4hvpaqyOFfPDUDokGItessZDZXfYmIUa25y
         wbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XttKmD05Qtp9eepfd6tIkmcLqAthgNI109O56kyYc2c=;
        b=SIRMoPF04HA4P/SrnHAvQYAcqR9OKf1gEk9hASonkt3uMthGrqU41CeOVDhSNTnNON
         N3uEweZetVXXkxiI++WAxsjMKB9aLMBcyIjkJY3x87GC67hMoP9nVmc6eFRHDlvm/zT6
         wa/HGlmhLi+ROidSrvPpNX1pD+h4+blppbxzGAi2rLQtrbPaF6hBgdS2Gv3NeL8YNkjq
         Ycm5Um/8veAp8knXCab0Kbtnk2UMpxQJexUw9WB6wH1jVLwUulshYCMpjjOIwHpoTDuQ
         JJheBOaqjskPSpfsX/oAtr+N70ux/HRcZRGibXRMi6wejStiyNPaYpTPeeC9HhEbp21I
         ++uw==
X-Gm-Message-State: AHQUAuZR7J+Vmdw/aKjwDUGIhoHp55zcFI4ISo4JnuD0yA5tUvifaRpC
        lX/F8thVjOYD1UfdBj0w3GQ=
X-Google-Smtp-Source: AHgI3IYmAFkrUxmBC2CfYJ/kNMyoG4wDpQN1dagws9EFzbjJjCJ02EFwIvTnmroQRpaDCJfsRZRC9g==
X-Received: by 2002:a9d:53c8:: with SMTP id i8mr9948760oth.60.1551046326900;
        Sun, 24 Feb 2019 14:12:06 -0800 (PST)
Received: from ?IPv6:2600:1700:dc40:8a50:a4cd:d9dc:8a53:baa6? ([2600:1700:dc40:8a50:a4cd:d9dc:8a53:baa6])
        by smtp.gmail.com with ESMTPSA id k100sm4166449otk.5.2019.02.24.14.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 14:12:05 -0800 (PST)
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com>
 <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com>
 <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com>
 <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com>
From:   David Tolnay <dtolnay@gmail.com>
Message-ID: <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
Date:   Sun, 24 Feb 2019 14:12:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551025819.3106.25.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/24/19 8:30 AM, James Bottomley wrote:
> QEMU implements a virtual hardware emulation for discovery, but once
> discovered all the packet communication is handed off to the vTPM
> socket.
> 
> The virtual hardware emulation can be anything we have a driver for. 
> TIS is the simplest, which is why I think they used it.  TIS is
> actually a simple interface specification, it supports discovery over
> anything, but the discovery implemented in standard guest drivers is
> over ACPI, OF and PNP.  If you want more esoteric discovery methods, we
> also support i2c.  However, that latter is really only for embedded.  I
> think QEMU chose TIS because it works seamlessly on both Linux and
> Windows guests.
> 
> 
>> All of this is what I would like to avoid by using a virtio driver.
> 
> How? Discovery is the part that you have to do, whether it's using
> emulated physical mechanisms or virtual bus discovery.

What I mean is that we avoid the need for *TPM-specific virtual hardware
emulation* for discovery by using a virtio driver.

We avoid implementing TIS or any other TPM-specific interface mechanism,
and we avoid implementing ACPI or OF or PNP or I2C or any other
additional bus necessitated by the existing set of Linux TPM drivers
which we wouldn't otherwise need.

The virtio driver performs discovery via virtio, which crosvm implements
already for all of its supported devices. This substantially reduces the
amount of TPM-specific code compared to your suggestions, and lowers the
barrier to entry for implementing TPM support in other hypervisors which
I hope we agree is beneficial.

Turning this around a different way, suppose that there already was a
virtio TPM driver in the kernel. For me as a hypervisor implementer,
what advantages do you see that would make me decide to implement
TPM-specific virtual hardware emulation in the form of TIS rather than
simply leveraging a virtio driver like for other virtual devices?


> If you want to make this more concrete: I once wrote a pure socsim
> packet TPM driver:
> 
> https://patchwork.ozlabs.org/patch/712465/
> 
> Since you just point it at the network socket, it does no discovery at
> all and works in any Linux environment that has net.  I actually still
> use it because a socsim TPM is easier to debug from the outside. 
> However it was 230 lines.  Your device is 460 so that means about half
> your driver is actually about discovery.

It looks like all the comments in the virtio driver account for the
difference, not necessarily discovery.

But to put this in perspective, what we save is the 1000+ lines I see in
QEMU dedicated to TIS. Without a virtio driver (or socsim, or something
else that avoids TPM-specific hardware emulation for device discovery),
QEMU and crosvm and other hypervisors need to reproduce a TIS
implementation. Conceptually this is simple but it is still a quite
substantial barrier compared to not needing any TPM-specific discovery.


> The only reasons I can see to use a virtual bus is either because its
> way more efficient (the storage/network use case) or because you've
> stripped down the hypervisor so far that it's incapable of emulating
> any physical device (the firecracker use case).

Crosvm does fall under the Firecracker use case, I believe.
