Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39200 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbdKVJ01 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Nov 2017 04:26:27 -0500
Received: by mail-wr0-f195.google.com with SMTP id 11so10530207wrb.6
        for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2017 01:26:26 -0800 (PST)
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: "Roberts, William C" <william.c.roberts@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <600d6778-f155-ea51-64dc-e0041c6943d3@redhat.com>
Date: Wed, 22 Nov 2017 10:26:24 +0100
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/21/2017 09:29 PM, Roberts, William C wrote:

[snip]

>>>
>>> Do you agree with Jason's suggestion to send a synthesized TPM command
>>> in the that the command isn't supported?
>>
>> Nope.
> 
> We should update the elf loader to make sure that ELF files don't contain
> Incorrect instructions. We shouldn't have this type of policy in the driver
> considering that the tpm is designed to handle it. Obviously you disagree,
> just understand you're wrong :-P
> 

I think the sandbox is correct and makes sense to only send well constructed
commands to the TPM. So my RFC patch breaking the sandbox is clearly wrong.

I still do believe that both interfaces (/dev/tpm and /dev/tpmrm) should be
consistent if possible though. In other words, I don't see the value of not
behaving as expected by the spec if this doesn't have security implications
as is the case with the approach suggested by Jason. And the implementation
for sending the synthesized response is also trivial.

The other option that's fixing this in user-space will be a workaround, since
it would either be to check for TPM_RC_SUCCESS instead of TPM_RC_COMMAND_CODE
or make the SAPI library infer that a -EINVAL error means that a command isn't
supported and return a TPM_RC_COMMAND_CODE to the caller.

For completeness, I'll share my patch implementing what Jason suggested, even
when is quite likely that Jarkko won't like it since he has a strong opinion
on this:
