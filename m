Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37025 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754334AbdK2L0n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Nov 2017 06:26:43 -0500
Received: by mail-wm0-f50.google.com with SMTP id f140so5217661wmd.2
        for <linux-integrity@vger.kernel.org>; Wed, 29 Nov 2017 03:26:43 -0800 (PST)
Subject: Re: FW: [RFC PATCH] tpm: don't return -EINVAL if TPM command
 validation fails
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: flihp <flihp@twobit.us>, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        "Roberts, William C" <william.c.roberts@intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <ebb69b95-96e3-b1cd-a7d0-6792e411e6d4@redhat.com>
 <DB638850A6A2434A93ECADDA0BC838905F09D5D9@ORSMSX103.amr.corp.intel.com>
 <602091d7-1b16-4694-57b2-8031acce8cbc@twobit.us>
 <a6305620-ac5c-5ead-7dd6-ed4e48e75e78@redhat.com>
 <20171126142109.rs434iod4gwekrbo@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <14e97066-4dfc-95e7-acc1-5d18f10114cd@redhat.com>
Date: Wed, 29 Nov 2017 12:26:40 +0100
MIME-Version: 1.0
In-Reply-To: <20171126142109.rs434iod4gwekrbo@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/26/2017 03:21 PM, Jarkko Sakkinen wrote:
> On Wed, Nov 22, 2017 at 08:25:29PM +0100, Javier Martinez Canillas wrote:
>> That was my interpretation as well and what I was arguing about. I'm glad to
>> know that you also think the same.
> 
> It could be that this rationale has been your earlier emails but
> I just haven't recognized it :-) I think I'm starting to buy this.
>

No worries, Philip did a much better work than I did at explaining the issue.
In fact, at the beginning I also thought that was an user-space problem until
he explained to me that the problem was in the kernel.
 
> I don't have any fixed standing points anything basically. It is
> just better to be really resistant with anything that is related
> to user-kernel interaction until you really get it...
>

And I really appreciate. It's much better to go back and forth on patches than
having an unstable interface that causes regressions between kernel releases.

I've posted a v2 that addressed Philip's comments. Hopefully this should be in
a good shape now.

> /Jarkko
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
