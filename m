Return-Path: <SRS0=M3wd=Q6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D482C43381
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Feb 2019 01:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AAA2081B
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Feb 2019 01:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcdUpvpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfBWBXx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:23:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35061 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfBWBXx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 20:23:53 -0500
Received: by mail-ot1-f68.google.com with SMTP id z19so3513501otm.2
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 17:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z5ANCm8b375l88ztRuXwF16/XPNTU4f2iDKZWokprow=;
        b=XcdUpvpdqSLMQbHFuRMwoZP2BsdD7edkdgqwOyj1kGMac66oXT2AWrQOMU4H9jvnoz
         3WnITBJij/2aAouWNnASYgpKP1A3EMFBU9zVlhGsKTpUFwl4PePo3AawpC4scfi1Kl/0
         sq/HZDk+mcO1NqtePJxgAisUBYRWftjotwMlMlG45xX5F9ms/u98o6khtRGygGzRIvRy
         dxYc00Is7P3Xc/Q4Lqxm2EUkgL0r8cEpZMnXhJNjowkAGOsVBR2JZrMOnTLpU6XwSZUt
         eDw8l8GduHZQM1Mh+XJ4vU8URlA87xV/uzY8MuUcN7vz40K3Mh+QLG8Zz8e6dM/t0mLn
         L1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z5ANCm8b375l88ztRuXwF16/XPNTU4f2iDKZWokprow=;
        b=Zd3AFtIbFdRmvCp7a2llEc3xRFXQsMSeFT8xZXUpV3wNwKYkirXsk7X44h8T9i7IpZ
         w4Fhrh2UWhYd50V9HQii/xKhdx87AdAE4s/E9Kcmb08IJioDZb/kUkgJ1gG22/zjhnqD
         CP7nNuUdLXiejJxUphM+m/IY68bXMuCVJqDbXIaGdXCgrdx/qC62e7OeLbPaCnJJG41M
         +RDW2iV0s9f0GfANvQO36/18CZMpYaXeiASAmPOBEJjHHGjcPYhLrqc1qbawEvvSbNyT
         hmlF1kWgSlJrHipo3lGLTaC66iFfLOq70VnkI5c4RNJQAdisbQdthvGtBL49UY7xHEQO
         FuTg==
X-Gm-Message-State: AHQUAuYqan4Ncsws8Xh9YFRO68BN+1YzLyKomY7eEcYwlb+Ff1Z3SMme
        pUtrqccN45NDkNgtrHM6J9nhW+VFM7Y=
X-Google-Smtp-Source: AHgI3IZVcJenOEiLs9NrtabCzw9XCUKAyUP7sSjxcY/5OCzddOqZeXhv+ZFaG2wR/lnnNFI+urqeGA==
X-Received: by 2002:a9d:5e02:: with SMTP id d2mr2243872oti.327.1550885031818;
        Fri, 22 Feb 2019 17:23:51 -0800 (PST)
Received: from ?IPv6:2600:1700:dc40:8a50:bd50:a563:2590:39f6? ([2600:1700:dc40:8a50:bd50:a563:2590:39f6])
        by smtp.gmail.com with ESMTPSA id c132sm1247036oia.41.2019.02.22.17.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 17:23:50 -0800 (PST)
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222003207-mutt-send-email-mst@kernel.org>
 <461bd10a-0a30-81e3-63b4-0798eb75b9e7@gmail.com>
 <20190222170817-mutt-send-email-mst@kernel.org>
From:   David Tolnay <dtolnay@gmail.com>
Message-ID: <ba2bb76f-461f-147e-8081-42f231adefda@gmail.com>
Date:   Fri, 22 Feb 2019 17:23:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222170817-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/22/19 2:24 PM, Michael S. Tsirkin wrote:
> On Fri, Feb 22, 2019 at 01:40:25PM -0800, David Tolnay wrote:
>> On 2/21/19 9:51 PM, Michael S. Tsirkin wrote:
>>>
>>> Maintainer entry?
>>
>> Good call, I will add one.
>>
>> Could you let me know what workflow would work best for you? I can direct
>> patches toward Chrome OS's kernel tree and only a Chrome OS list, then send them
>> your way only once they have been reviewed and accepted there. Or I can list one
>> or both of the linux-integrity@v.k.o and virtualization@l.l-f.o lists along with
>> a list for Chrome OS reviewers.
>>
>> Either way, we'll want eyes from people who know virtio and from people who know
>> TPM on most changes.
> 
> Well if you are changing a host/guest interface then you also need to copy
> virtio-dev. That one is subscriber only so that would
> imply sending there after it's reviewed in chrome.
> As an extra bonus reviewed code is hopefully higher quality
> so less review work for me ;)
> so the first option sounds like a better plan.
> 
> But I hope accepted above just means it goes on some branch,
> such that we won't end up with production code that
> is set in stone and needs to be maintained forever?

Understood. We will avoid considering anything canonical before
upstream has a chance to weigh in. Thanks for the caution.


>>>> + *
>>>> + * The intended hypervisor-side implementation is as follows.
>>>> + *
>>>> + *     while true:
>>>> + *         await next virtio buffer.
>>>> + *         expect first descriptor in chain to be guest-to-host.
>>>> + *         read tpm command from that buffer.
>>>> + *         synchronously perform TPM work determined by the command.
>>>> + *         expect second descriptor in chain to be host-to-guest.
>>>> + *         write TPM response into that buffer.
>>>> + *         place buffer on virtio used queue indicating how many bytes written.
>>>
>>> That's fine I think except generally it should be legal for guest
>>> to split each buffer to several segments.
>>
>> Acknowledged. I will adjust this comment.
>>
>> To clarify, this means the hypervisor will need to accept a single descriptor
>> chain consisting of one or more guest-to-host descriptors which together form
>> the command, followed by one or more host-to-guest descriptors into which the
>> response may be written. Is that what you had in mind?
> 
> Exactly.
> 
>> TPM commands and responses are both capped at a moderate size (4096 bytes). With
>> that in mind, is it still necessary to allow split buffers? We won't be dealing
>> with multi-megabyte transfers.
> 
> This has been a general virtio rule, yes. See for example "2.6.4 Message
> Framing" in v1.1 draft.
> 
> It's generally not hard to implement and generally easier than argue about
> whether it's necessary. If you think it's a big problem, it's a good
> idea to take it up with the virtio tc. Address this to virtio-comment
> list.

I appreciate the explanation. As you said, it is easy to implement
so I'll fix this comment to allow for buffers split into segments. I
didn't know about this general virtio rule but it makes sense to me!


>>>> +/*
>>>> + * Timeout duration when waiting on the hypervisor to complete its end of the
>>>> + * TPM operation. This timeout is relatively high because certain TPM operations
>>>> + * can take dozens of seconds.
>>>> + */
>>>> +#define TPM_VIRTIO_TIMEOUT (120 * HZ)
>>>
>>> Should we read this from device? E.g. a busy hypervisor might
>>> take longer to respond ...
>>
>> That's true. Do you have an example of an existing virtio driver that reads
>> timeout from the hypervisor?
>>
>> To understand your perspective, do you see one of the following as being the
>> bigger advantage? -- either that we can use a timeout tighter than 120s for
>> hypervisors that believe they can respond quickly to any command, or that we can
>> relax the timeout beyond 120s for an especially overburdened hypervisor. The
>> first is nice because the caller in the guest will receive their error code
>> sooner in certain failure modes, but maybe that would be better addressed by
>> some other way of poking the host to find out whether it is still alive and
>> working. For the second, 120s is pretty generous and in our use case we would
>> just want to give up and retry much later at that point; I don't know how much
>> further it would be reasonable to grow a timeout.
> 
> I think the whole idea around timeout handling needs a bit more
> thought. What kind of reasons for the timeout do you envision
> that require the extra kicks?

The hesitation I had with responding to timeouts more aggressively
than just by kicking again, was that we don't want to end up in a
situation where the guest driver performs some kind of reset while
the hypervisor is still reading or writing one of the driver's
buffers. If timeout triggers a full remove and probe, including
kfree on the vtpm_device containing the buffer, that seems likely to
lead to memory corruption in the guest.

As you commented elsewhere, it sounds like NEEDS_RESET is the way to
go. If the guest driver times out, and observes that NEEDS_RESET bit
is set, then we can assume the hypervisor is not continuing to write
memory so a reset is safe.

Do you have guidance for how to safely handle a timeout in which
NEEDS_RESET has not been set?
