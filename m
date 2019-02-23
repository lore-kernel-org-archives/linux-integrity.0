Return-Path: <SRS0=M3wd=Q6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D851C43381
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Feb 2019 00:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BD3205C9
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Feb 2019 00:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTNmJDtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfBWApl (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:45:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40028 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBWApl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 19:45:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id x187so3161618oia.7
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 16:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bZ4nPDRR4ybI8HH59utuarp/kuuKZrmc7JvHGZjtMXM=;
        b=mTNmJDtgI1ublgCz7uflYrgO//jCfexQm8RdEqwvczEe7NR9JGBH8T9eNKF96IQXpk
         Xj361KMiVSqR0jOXPZ6PCxrYxzZDw8dGAe+1NAqRppGIMDoHdFn4meExY5f298rYQeA8
         u1wt8xmzMuDTuLHSpOVPXUy9Mx8bXWXACgUEVOKGFU91ybeznWd0zTG0psmPuIBCSQP7
         AC/Nyivaut6u6oaVxkYgfoHA8BoTMgcVClOngjHFbxy46OpRgAxEG5oU323xA6dD2lnV
         zmJiOm5qFJ4lq3uLck0Xi1Pj7YzjPesvx23LAeojWTURcGJCLKsly5EpHvur6SfQ/fGZ
         7/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bZ4nPDRR4ybI8HH59utuarp/kuuKZrmc7JvHGZjtMXM=;
        b=sOTRh8E8AkyBTMw8XwTIT2Zk8vDdHhpZCQ2a0rgdBS7U0UIQxvP6AysS6HJSswQbET
         3OwM6ehMPQlCtj1xJOm68eie8kgRRJft7fu1XSqf61CkrAQfzx8daE75QIgm2KWr5tbx
         Grw1xwQmaLJeCHuEFjbxb8UwgTfLOFGT+UTL41IzZxgrJTMRl1p1Fb3R0BoJ87E0/VM9
         D1WZazD8YISh8Fho4O+IZs0h7IEZUoLBqFLa7puZ0bgmwAAHdKUcdDyU729k4yBEBhdQ
         U8x2y7s1g5BeiV4dO2+ej401JJxk0WK6Od7g3VeOxPEp9HSJoRFfBCreiiypWRdFYjV5
         mV4A==
X-Gm-Message-State: AHQUAuaGrTh8NF6tgNT2+bhAP84gfc0sTEtqOuBd5LpJAxqhcqlMzgpQ
        eljomODvdWbs0HtiIjs8/DE=
X-Google-Smtp-Source: AHgI3IbCpqdfKGC1W9e6Af9TUJCkybuJc5rm2D6JaxmZOtVkBD21Xdy5xhTVpceD1g0DRn2c6+qCzQ==
X-Received: by 2002:aca:bb46:: with SMTP id l67mr4088223oif.119.1550882739858;
        Fri, 22 Feb 2019 16:45:39 -0800 (PST)
Received: from ?IPv6:2600:1700:dc40:8a50:bd50:a563:2590:39f6? ([2600:1700:dc40:8a50:bd50:a563:2590:39f6])
        by smtp.gmail.com with ESMTPSA id h205sm1246671oib.11.2019.02.22.16.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:45:39 -0800 (PST)
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
From:   David Tolnay <dtolnay@gmail.com>
Message-ID: <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
Date:   Fri, 22 Feb 2019 16:45:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550873900.2787.25.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/22/19 2:18 PM, James Bottomley wrote:
> On Fri, 2019-02-22 at 14:00 -0800, David Tolnay wrote:
>> On 2/22/19 7:30 AM, James Bottomley wrote:
>>> On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
>>>> Add a config TCG_VIRTIO_VTPM which enables a driver providing the
>>>> guest kernel side of TPM over virtio.
>>>
>>> What's the use case for using this over the current non-virtio
>>> vTPM?. I always thought virtio was about guest to host transport
>>> efficiency, but the phsical TPM, being connected over a very slow
>>> bus, is about as inefficient as you can get in that regard, so why
>>> do we need to use virtio to drive the virtual one?
>>>
>>>> Use case: TPM support is needed for performing trusted work from
>>>> within a virtual machine launched by Chrome OS.
>>>
>>> The current vTPM does this, what's the use case for your special
>>> one?
>>
>> Thanks James, these are important questions and the intention
>> certainly isn't to have another driver that does the same thing with
>> differences for no reason.
>>
>> I see three existing vTPM drivers already in drivers/char/tpm.
>>
>> - tpm_ibmvtpm, which is specific to PowerPC and implemented in terms
>> of PowerPC hcalls.
>>
>> - xen-tpmfront, which is specific to Xen.
>>
>> - tpm_vtpm_proxy, which as I understand it is intended to enable
>> userspace TPM.
>>   That is, if we are using this driver in a guest kernel, the TPM
>> implementation
>>   also needs to reside in the guest kernel rather than in the
>> hypervisor.
>>
>> For our use case which is not PowerPC and is running in our own
>> hypervisor with the TPM needing to be provided by the hypervisor,
>> none of the existing vTPM drivers seemed to fit the bill.
>>
>> Please let me know if I arrived at the wrong conclusion on this!
> 
> Actually, yes, your third statement is not wholly correct:  The in-
> kernel vTPM proxy can certainly be used to emulate a TPM within a guest
> for that guest to use without any support from the hypervisor. 
> However, when you have the correct qemu (requires a recent one), the
> vTPM emulator can run in the host (or hypervisor) and be passed through
> to the guest.  The best description of how to do that seems to be this
> blog entry:
> 
> https://s3hh.wordpress.com/2018/06/03/tpm-2-0-in-qemu/
> 
> So won't this mode of operation exactly work for you (obviously with
> necessary modifications to the crosvm hypervisor)?

I appreciate the explanation and link, James!

I had briefly investigated the existing support in QEMU before
pursuing a virtio based driver. At the time, I determined that QEMU
implements a register level emulation of a TPM rather than what our
team would consider a minimum viable vTPM. It implements the
TPM-specific TIS interface (QEMU's tpm_tis.c) as well as CRB
interface (QEMU's tpm_crb.c) which require Linux's TIS driver
(Linux's tpm_tis.c) and CRB driver (Linux's tpm_crb.c) respectively.
Both of those are based on ACPI.

As far as I can tell, QEMU does not provide a mode in which the
tpm_vtpm_proxy driver would be involved *in the guest*. Certainly
you could use a vtpm proxy driver *on the host* but would still need
some other TPM driver running in the guest for communication with
the host, possibly virtio. If this second approach is what you have
in mind, let me know but I don't think it is applicable to the
Chrome OS use case.

Clearly it's possible for us to go the QEMU route and implement ACPI
(which crosvm does not otherwise need) plus one or both of TIS and
CRB in crosvm, but since all we need is for TPM command buffers to
leave the VM and TPM response buffers to enter the VM, all of that
seems unnecessarily complicated. A virtio driver substantially
lowers the barrier to implementing a hypervisor vTPM.

Separately, I'd be curious whether you share Jason Gunthorpe's
opinion stated elsewhere in the thread, or whether you would
encourage the virtio TPM driver to be kept private if feasible
alternative drivers already exist. Jason's comment:

> We already have a xen 'virtioish' TPM driver, so I don't think there
> is a good reason to block a virtio driver if someone cares about
> it. There are enough good reasons to prefer virtio to other options,
> IMHO.

Best,
David
