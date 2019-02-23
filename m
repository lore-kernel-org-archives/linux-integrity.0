Return-Path: <SRS0=M3wd=Q6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5496C43381
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Feb 2019 02:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774602070D
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Feb 2019 02:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSAgJSoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfBWCl6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:41:58 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36826 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWCl5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 21:41:57 -0500
Received: by mail-oi1-f194.google.com with SMTP id t206so3307353oib.3
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 18:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qmcvgjez82CPBmulRHuTCVxfLCggzdl34Jt/mJqiY1Y=;
        b=CSAgJSoYTrqCiy5Jtx88DCYODRYKXPFtKeYdVy/aIVW9ZzzaZXRY/BNqTRpKfHj+NH
         rzfpgS0vVzMyag3xFxv1T41jyvi5mfDZxs/kw38VCpGeGOobNwsjeeRXV2TmJeKw2fLb
         XWud0tj4vYHeEXM+lAYGTpTbWFBfWl6OK0e3zmS90+glCTPR3j0y7hkkqcD7mPRLFGtJ
         uRBl9/WPWRX6e0Oamg+WulIf+r5ArOdYmcrHys7qZcWge2xDfzwvp6Om7LR7mgldS6eS
         KBVp/RkbUyCrRjZ11SHnVULdn4xDoJyocVC2lYUFQ9ESei6R7TnO8XpibbCVcEHS7aP/
         6Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qmcvgjez82CPBmulRHuTCVxfLCggzdl34Jt/mJqiY1Y=;
        b=ntozrN9BjJRs/3/xTsNgShKavIludJ0vmP4WWCwjsqKBW1czUsKnKaOzqKG8ZMERua
         LjjbfOl9578GXr/RkVrngEymhC9+ss58RHo4xBsrMxZ072/V4DHoXLXMQ8VLvNwD8kcr
         5UYzv7HoManaMAwRFMKEt3e85Hn+It/AVsw5bj25MjYRYgvpSajaJ6y58og05RsncBWu
         68keNhLWeOxyAkdteZ5bHLobs9p9a0Q733nNfDrDt7Fp1v8fVx92SpUER/dHmyJbc7pU
         +I2Hr+yPpXjpJf53xRsJ4ixMgGPjqUnSlhVKH7vukgZ4ROsH9zowX/kvkZoAHbtC+ew1
         lnWA==
X-Gm-Message-State: AHQUAuaSwRU/eTDEJejjZdt4nfcYCM4bfSLdaDFE1Ac6BsKGCuxB8ovy
        FslQwb6ftuKM1kZGSYw1ox4=
X-Google-Smtp-Source: AHgI3IasRTRO3DEBYK+2sft60PwYCz0m8eR+JPc34N8yuVC5aNN74czSl6a133lPU1NATNtcwZ6anA==
X-Received: by 2002:aca:b683:: with SMTP id g125mr4624497oif.17.1550889716530;
        Fri, 22 Feb 2019 18:41:56 -0800 (PST)
Received: from ?IPv6:2600:1700:dc40:8a50:bd50:a563:2590:39f6? ([2600:1700:dc40:8a50:bd50:a563:2590:39f6])
        by smtp.gmail.com with ESMTPSA id r9sm1273641otp.81.2019.02.22.18.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 18:41:55 -0800 (PST)
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
From:   David Tolnay <dtolnay@gmail.com>
Message-ID: <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
Date:   Fri, 22 Feb 2019 18:41:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550885645.3577.31.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/22/19 5:34 PM, James Bottomley wrote:
> On Fri, 2019-02-22 at 16:45 -0800, David Tolnay wrote:
> [...]
>> I appreciate the explanation and link, James!
>>
>> I had briefly investigated the existing support in QEMU before
>> pursuing a virtio based driver. At the time, I determined that QEMU
>> implements a register level emulation of a TPM rather than what our
>> team would consider a minimum viable vTPM.
> 
> Actually, no, it doesn't at all.  QEMU implements nothing about a TPM. 
> You have to set up a software TPM outside of qemu which talks over a
> socket and then use the vTPM socket to pass that TPM through to qemu. 
> Effectively QEMU is TPM implementation blind (which is why it can do
> both 1.2 and 2.0) all it provides is discovery of the virtual hardware.

Thanks, this sounds very similar to our use case. We'd like for crosvm
to be TPM implementation blind as well, with the TPM implementation
running in the host and attached via socket or D-Bus to the hypervisor.
The TPM implementation may be purely software or may be a daemon backed
by hardware TPM.

Sounds like there is a lot of overlap.


>>  It implements the TPM-specific TIS interface (QEMU's tpm_tis.c) as
>> well as CRB interface (QEMU's tpm_crb.c) which require Linux's TIS
>> driver (Linux's tpm_tis.c) and CRB driver (Linux's tpm_crb.c)
>> respectively. Both of those are based on ACPI.
> 
> That's right, QEMU implements the device interface emulation, but it
> passes the actual TPM communication packets to the vTPM outside QEMU.

Could you clarify what you mean by a TPM communication packet since I am
less familiar with TPM and QEMU? I don't see "packet" terminology being
used in drivers/char/tpm. Is a packet equivalent to a fully formed TPM
command / response or is it a lower level aspect of the device interface
than that?

More concretely, would you say that a hypervisor necessarily needs to
implement TPM device interface emulation (TIS and/or CRB) in order to
expose a TPM running on the host to its guest OS? I can see QEMU has
those things.


>> As far as I can tell, QEMU does not provide a mode in which the
>> tpm_vtpm_proxy driver would be involved *in the guest*.
> 
> It doesn't need to.  the vTPM proxy can itself do all of that using the
> guest Linux kernel.  There's no hypervisor or host involvement.  This
> is analagous to the vTPM for container use case, except that to get
> both running in a guest you'd use no containment, so the vtpm client
> and server run in the guest together:
> 
> https://www.kernel.org/doc/html/v4.16/security/tpm/tpm_vtpm_proxy.html

I apologize for still not grasping how this would apply. You bring up a
vtpm proxy that runs in the guest Linux kernel with no hypervisor or
host involvement, with the vtpm client and server running in the guest
together. But host involvement is specifically what we want since only
the host is trusted to run the software TPM implementation or interact
with a hardware TPM. I am missing a link in the chain:

- guest userspace makes TPM call (through tpm2-tss or however else);
- guest kernel receives the call in tpm-dev-common / tpm-interface;
- tpm-interface delegates to a tpm-chip implementation (which one?
  vtpm_proxy_tpm_ops?);
- ???
- a host daemon triages and eventually performs the TPM operation.


>> Certainly you could use a vtpm proxy driver *on the host* but would
>> still need some other TPM driver running in the guest for
>> communication with the host, possibly virtio. If this second approach
>> is what you have in mind, let me know but I don't think it is
>> applicable to the Chrome OS use case.
> 
> Actually, the vTPM on-host use case doesn't use the in kernel vtpm
> proxy driver, it uses a plain unix socket.  That's what the original
> website tried to explain: you set up swtpm in socket mode, you point
> the qemu tpm emulation at the socket and you boot up your guest.

Okay. If I understand correctly, the vTPM on-host use case operates
through TIS and/or CRB implemented in QEMU and the tpm_tis / tpm_crb
driver in the guest. Do I have it right?

All of this is what I would like to avoid by using a virtio driver.


>> Clearly it's possible for us to go the QEMU route and implement ACPI
>> (which crosvm does not otherwise need) plus one or both of TIS and
>> CRB in crosvm, but since all we need is for TPM command buffers to
>> leave the VM and TPM response buffers to enter the VM, all of that
>> seems unnecessarily complicated. A virtio driver substantially
>> lowers the barrier to implementing a hypervisor vTPM.
> 
> I don't believe it requires ACPI, that's just one common way of
> enumerating TPMs and it's how the guest finds it.  If you implemented
> the QEMU passthrough in crosvm, you could use whatever mechanism that's
> convenient to you and would cause a TPM driver to bind.  It's the QEMU
> layer that provides the virtual hardware emulation for the device and
> the external vTPM that provides the TPM implementation.  The two are
> completely decoupled.
> 
> Are you saying crosvm has no ability at all to emulate the discovery
> that we use in the kernel to find TPMs?  Is it some type of firecracker
> like think that only supports fully emulated devices?

I am still digesting the rest of your comment, but yes, Firecracker is a
fork of crosvm so they are similar in this regard.

Thanks for your guidance and patience!


>> Separately, I'd be curious whether you share Jason Gunthorpe's
>> opinion stated elsewhere in the thread, or whether you would
>> encourage the virtio TPM driver to be kept private if feasible
>> alternative drivers already exist. Jason's comment:
>>
>>> We already have a xen 'virtioish' TPM driver, so I don't think
>>> there is a good reason to block a virtio driver if someone cares
>>> about it. There are enough good reasons to prefer virtio to other
>>> options, IMHO.
> 
> I've no real opinion on that one until I understand why you went down
> this path instead of using existing implementations.  Right at the
> moment I do get the impression its because you didn't know how the
> existing implementations worked.
> 
> James
> 
> 

