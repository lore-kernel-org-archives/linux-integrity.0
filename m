Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12286C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F14206C0
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 22:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkejVaAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfBVWY7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:24:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45554 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVWY7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 17:24:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so3179823ota.12
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 14:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g3gniH5R9IxH4gZoOqusDXJ1L2k9+wJejk8bs5TwyA8=;
        b=nkejVaAl5ykfXq9cv3hm13S9zulh1qyvr71MFBZIlSRnfu5tpyf9aDjusuNUESv9Wv
         KI151L+u/7vPnOppwKdT1Ozs6fvpyYRgA58QYaO+dZfneCr5ljivd6glRzncqTH26IK7
         djzx3m4HD2fZRP5U/XT262jYMmDTSiL8JNKjfZm9JjZESdHPi7OIxY7un/pHfsjNnY0y
         KuYxGqfwxowVtRDVpaT1PWpYk/3q00dtDxVS8OQR8JOmpM9P9tTBzYJT9a9/rtM71m6p
         ztWeBN5CCsVvU1Z72ncq9B3vOH9jZfvY+L8FnpmAAdRNGjM+yJowoygmqxcAMzi9Wc0x
         XWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g3gniH5R9IxH4gZoOqusDXJ1L2k9+wJejk8bs5TwyA8=;
        b=QWYDMOMbSECyZ+vYPnppqKWxgBzR3LW2OWlXGNKjXdxVjddAdOutaRX7uPEGIn2RHJ
         s7QyZTqz0+0hhpsymoXKPch1+M2RcAVNhVgI+pFvKu+83h7TL1/xyKMy4dvDjh4t/5A1
         AEoTFF1lzqU1a/QJ/vLBUerYcUiAbEQdVVKK6CIioKK/kWQ7GQQXjPRs3WskdkVIYtik
         qUAHDjivfVkfyzU7RWlWtEMDvyBaVLQpRfSObP9wPZ94wLI4aoxoMHkgyFGuBgcL+lWi
         JDk9OMsjcaG2XtRDbSsCfpjoaVfIN6bc3PHVrkpjpp0pY9GyK2QFu817EsRXEd6cHZEf
         XtoQ==
X-Gm-Message-State: AHQUAuYsfJvoDzVxAWJVPP6bytn8XjRJt+dhJT4nHAVONv7d1XiY2Bje
        Z4n1ft9j8EPQomaaNbPmEpU=
X-Google-Smtp-Source: AHgI3IbM7DANl1oQp9wHZkn63fFebBYka7EP38xfILueHxz8XxpeveL33o6nRq9ECaPmigFzKQNgfw==
X-Received: by 2002:a9d:1b0:: with SMTP id e45mr4334866ote.307.1550874298134;
        Fri, 22 Feb 2019 14:24:58 -0800 (PST)
Received: from ?IPv6:2600:1700:dc40:8a50:bd50:a563:2590:39f6? ([2600:1700:dc40:8a50:bd50:a563:2590:39f6])
        by smtp.gmail.com with ESMTPSA id w200sm1107605oif.13.2019.02.22.14.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:24:57 -0800 (PST)
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222102610.GB5613@linux.intel.com>
 <20190222101728-mutt-send-email-mst@kernel.org>
 <20190222193156.GA6475@linux.intel.com>
 <20190222193305.GB6475@linux.intel.com>
 <20190222161636-mutt-send-email-mst@kernel.org>
 <20190222215001.GA21427@linux.intel.com>
From:   David Tolnay <dtolnay@gmail.com>
Message-ID: <f16bd565-0a7e-d7bb-a5e8-eda48ac8de80@gmail.com>
Date:   Fri, 22 Feb 2019 14:24:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222215001.GA21427@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/22/19 1:50 PM, Jarkko Sakkinen wrote:
> On Fri, Feb 22, 2019 at 04:25:08PM -0500, Michael S. Tsirkin wrote:
>> On Fri, Feb 22, 2019 at 09:33:05PM +0200, Jarkko Sakkinen wrote:
>>> On Fri, Feb 22, 2019 at 09:31:56PM +0200, Jarkko Sakkinen wrote:
>>>> On Fri, Feb 22, 2019 at 10:23:02AM -0500, Michael S. Tsirkin wrote:
>>>>> On Fri, Feb 22, 2019 at 12:26:10PM +0200, Jarkko Sakkinen wrote:
>>>>>> On Thu, Feb 21, 2019 at 06:14:02PM -0800, David Tolnay wrote:
>>>>>>> Add a config TCG_VIRTIO_VTPM which enables a driver providing the guest
>>>>>>> kernel side of TPM over virtio.
>>>>>>>
>>>>>>> Use case: TPM support is needed for performing trusted work from within
>>>>>>> a virtual machine launched by Chrome OS.
>>>>>>>
>>>>>>> Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
>>>>>>> implementation of the virtio TPM device can be found in these two source
>>>>>>> files:
>>>>>>>
>>>>>>> - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
>>>>>>> - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs
>>>>>>
>>>>>> These files/links do not make sense for kernel testing. Please remove
>>>>>> them from the next version.
>>>>>
>>>>> To clarify generally for a virtio device we want
>>>>> - guest support
>>>>> - device support
>>>>> - spec
>>>>>
>>>>> If the device is implemented in qemu and guest in linux kernel,
>>>>> then there are lots of people familiar with these
>>>>> programming environments, so sometimes we merge
>>>>> guest and host code even if spec isn't written up at all.
>>>>>
>>>>> If you don't want to do that there's a small number of people who can
>>>>> properly review code, e.g. I don't think lots of people on this list are
>>>>> familiar with crosvm.  One way to address this would be to build a QEMU
>>>>> implementation. Another would be to write up a spec.  You can do both
>>>>> too :)
>>>>
>>>> I don't really understand your arguments.
>>>
>>> ... and I did your response total three times and did not find any
>>> causality of any sort from anything.
>>>
>>> /Jarkko
>>
>> Thanks for spending the time reading my response.  What was included in
>> it was a general suggestion for a virtio based driver to be acceptable
>> in upstream Linux.
>>
>> You pointed out that a pointer to a prototype implementation in Rust
>> isn't relevant. However, FYI just posting guest code and asking for it
>> to be merged alone won't work for a virtio driver either. I am merely
>> trying to speed things up instead of having the contributor repost with
>> a tweaked commit log just to immediately get another set of nacks.
> 
> I did not say anything about relevance of any implementation. I tried to
> mainly point out that looking at random source files implemented with a
> relatively alien language to most does not really make a case.
> 
> Things that would help to move this forward:
> 
> - Documentation of the stack, nothing spectacular but more like how it
>   works in practical terms.
> - Sufficiently easy ways to test the code.
> - Explain in the commit message why we want this.
> 
> /Jarkko


Thanks Jarkko, I respect all of the points you've raised and you are absolutely
correct to ask for a spec and/or spec-quality documentation, detailed testing
steps for exercising this driver in qemu or crosvm, and strong justification for
the new driver.

- Regarding spec, at this point we'll follow up with OASIS to claim a device
  number and pin down the protocol in sufficient detail to make it clear when an
  implementation is conformant. As I noted in the patch message, at the very
  least the virtio device number will need to be resolved before this driver
  could be accepted.

  On the Chrome OS side we're comfortable pursuing review of the spec and review
  of the driver in parallel. At what point in the spec process the driver can be
  accepted is up to you folks.

- I will make sure to include detailed testing steps with the next patch.

- I'm glad we are hashing out why this driver is necessary (or why it is not
  necessary, if it turns out that way) in this discussion. You are right that it
  may have been better originally sent as an RFC. Once I understand there to be
  some agreement, I will write that up for the next patch.

Thanks,
David
