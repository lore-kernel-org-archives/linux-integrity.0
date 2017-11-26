Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:45337 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbdKZXXW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Nov 2017 18:23:22 -0500
Received: by mail-wr0-f175.google.com with SMTP id a63so24744303wrc.12
        for <linux-integrity@vger.kernel.org>; Sun, 26 Nov 2017 15:23:22 -0800 (PST)
Subject: Re: FW: [RFC PATCH] tpm: don't return -EINVAL if TPM command
 validation fails
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        flihp <flihp@twobit.us>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org,
        "Roberts, William C" <william.c.roberts@intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <ebb69b95-96e3-b1cd-a7d0-6792e411e6d4@redhat.com>
 <DB638850A6A2434A93ECADDA0BC838905F09D5D9@ORSMSX103.amr.corp.intel.com>
 <602091d7-1b16-4694-57b2-8031acce8cbc@twobit.us>
 <20171126141853.mqpyqpawygrm26x4@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <94a91afd-5a6c-c909-fde9-73dd52af5435@redhat.com>
Date: Mon, 27 Nov 2017 00:23:19 +0100
MIME-Version: 1.0
In-Reply-To: <20171126141853.mqpyqpawygrm26x4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/26/2017 03:18 PM, Jarkko Sakkinen wrote:
> On Wed, Nov 22, 2017 at 09:16:25AM -0800, flihp wrote:
>> The intent of this "mostly transparent" stuff is to convey that the RM
>> should be as transparent as possible while acknowledging that there are
>> some cases where it's not / can't be. I can't say why the original
>> author phrased it in this somewhat ambiguous way but I wouldn't call
>> this a fair interpretation. It's definitely one way to read it though.
>>
>> The case in question is the RM performing a function on behalf of the
>> TPM: command code validation. This is a perfectly valid thing to do in
>> the RM though the RM should aim to behave as the TPM would if the RM
>> takes any action (sending a TPM response buffer with the appropriate
>> response code).
>>
>> An additional detail is described in section 3.1 "Error Codes". There is
>> a mechanism to encode information about which layer in the stack
>> produced the response buffer. When the TPM gets a command with a command
>> code it doesn't support then this field will be '0' since '0' identifies
>> the TPM. If the RM is taking over this function it should set the field
>> to indicate as much.
> 
> Thanks for explaining this. I guess we could take this direction. I think
> by utilizing the field that you mentioned we could consider this. And it
> would be hard to imagine this change to cause anything serious (if
> anything at all) with backwards compatbility.
> 
> Javier, does you current version use this field? If not can you resend
> an update?
>

My current version wasn't setting the error level bits. I'll send a new
version that does this.

I'll also drop the RFC prefix and propose it as a formal patch since it
seems we are getting closer to an agreement and also add James as cc.
 
> /Jarkko
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
