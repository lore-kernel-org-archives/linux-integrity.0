Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0FBC43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5358D20675
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 22:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnCojv76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfBVWAV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:00:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46964 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBVWAU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 17:00:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id j135so2896484oib.13
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 14:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y0Y8cF9Ik6e8P0FaFinQLS2KaPKKrGWLwr7qWlusd+k=;
        b=AnCojv76vr3mm8WWlnFU4q0VKi4q7XYX7ITGzMySwXJu6QsmYQu5y3NbXEU9wwc3MF
         NsPjb/YxvbrK8N1qLl83ycZMFwnDolgMvZdw59tzOC5xLBm17tnKQWFbs1Zntdio4y47
         E9d2Gpdvx8wE9BFkLzboiuMfYh1BB3l4M/H6n5vfVzsBM/DftdcCJp5ZjYFJU61k18ip
         NU6XnSX4F85fZa1Ta1VMhzeYIIa0E8AkiPwrYuobiYapDSmzkbj/YNIhmeA4xOr5/s49
         IRifLokvN2mipzNkmUXlgOJRa7MIWLKcq7ey1PhzokIIzNMInXpr4kP4onY0DbjKa6gj
         Sj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y0Y8cF9Ik6e8P0FaFinQLS2KaPKKrGWLwr7qWlusd+k=;
        b=U1gAtQKZ+NaPoiC/25fnl2togRhQJkjKDQIVWgXoN3npT9I+hDBwOoQxfUYFFn3x3C
         +h6QAdE0NaoNWuv5NgzgkQ9tr39bcwGM+6daOPhxCVMPb/eoJ8NZurisdMIBeTGWbbzz
         JZRpOO3hvI0YRHYmPIPDno4kfwGcSmDNMmdUrGTqVT0VM0V8QjQz79AZZ8txHmW/6L4h
         PVZHj+/Rq8/43SEzd/xfpfy8M4H5SnBNtBbQzrBXLQeRS8cSqsASJTjIbwzjxdbSDXHP
         AzV4tvYuRygaqwPlvGeI0G01JbEt2O6urQZWqMGVr6nPioBbGCNS3NvTIfXT/ZxhjJf7
         nMUA==
X-Gm-Message-State: AHQUAuaIztLEM2Ng5JhxGcvPlWyKjnwjkRiStbZ9dbnvZM7v6SPgZo+C
        dPNQyY5cFuwq1C0ooRIcT3s=
X-Google-Smtp-Source: AHgI3IbzuQua+w+2tCVkkbBcmVnCSCC0Do0nXeIY4xt7JV7jM3UGGRHJy2DuU7McVKPWZKXT3c7XQQ==
X-Received: by 2002:aca:db43:: with SMTP id s64mr2764602oig.165.1550872820137;
        Fri, 22 Feb 2019 14:00:20 -0800 (PST)
Received: from ?IPv6:2600:1700:dc40:8a50:bd50:a563:2590:39f6? ([2600:1700:dc40:8a50:bd50:a563:2590:39f6])
        by smtp.gmail.com with ESMTPSA id r124sm1113167oih.7.2019.02.22.14.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:00:19 -0800 (PST)
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
From:   David Tolnay <dtolnay@gmail.com>
Message-ID: <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
Date:   Fri, 22 Feb 2019 14:00:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550849416.2787.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/22/19 7:30 AM, James Bottomley wrote:
> On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
>> Add a config TCG_VIRTIO_VTPM which enables a driver providing the
>> guest kernel side of TPM over virtio.
> 
> What's the use case for using this over the current non-virtio vTPM?. 
> I always thought virtio was about guest to host transport efficiency,
> but the phsical TPM, being connected over a very slow bus, is about as
> inefficient as you can get in that regard, so why do we need to use
> virtio to drive the virtual one?
> 
>> Use case: TPM support is needed for performing trusted work from
>> within a virtual machine launched by Chrome OS.
> 
> The current vTPM does this, what's the use case for your special one?

Thanks James, these are important questions and the intention certainly isn't to
have another driver that does the same thing with differences for no reason.

I see three existing vTPM drivers already in drivers/char/tpm.

- tpm_ibmvtpm, which is specific to PowerPC and implemented in terms of PowerPC
  hcalls.

- xen-tpmfront, which is specific to Xen.

- tpm_vtpm_proxy, which as I understand it is intended to enable userspace TPM.
  That is, if we are using this driver in a guest kernel, the TPM implementation
  also needs to reside in the guest kernel rather than in the hypervisor.

For our use case which is not PowerPC and is running in our own hypervisor with
the TPM needing to be provided by the hypervisor, none of the existing vTPM
drivers seemed to fit the bill.

Please let me know if I arrived at the wrong conclusion on this!

Thanks,
David
