Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33892 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbdKVTZd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Nov 2017 14:25:33 -0500
Received: by mail-wr0-f173.google.com with SMTP id k18so10585558wre.1
        for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2017 11:25:33 -0800 (PST)
Subject: Re: FW: [RFC PATCH] tpm: don't return -EINVAL if TPM command
 validation fails
To: flihp <flihp@twobit.us>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
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
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <a6305620-ac5c-5ead-7dd6-ed4e48e75e78@redhat.com>
Date: Wed, 22 Nov 2017 20:25:29 +0100
MIME-Version: 1.0
In-Reply-To: <602091d7-1b16-4694-57b2-8031acce8cbc@twobit.us>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Philip,

On 11/22/2017 06:16 PM, flihp wrote:
> Apologies for the slow response. I didn't get switched over from
> tpmdd-devel to linux-integrity till just now.
>

No worries, thanks a lot for your feedback.
 
>> On 11/21/2017 01:30 PM, Jarkko Sakkinen wrote:
>>> On Tue, Nov 21, 2017 at 10:07:34AM +0100, Javier Martinez Canillas
>>> wrote:
>>>> As mentioned, I think this should be documented. I guess most
>>>> people would see the in-kernel resource manager as a virtualized
>>>> TPM, since the "TSS TAB and Resource Manager Specification" [0]
>>>> explains the RM making an analogy with a virtual memory manager:
>>>>
>>>> "The Resource Manager (RM) manages the TPM context in a manner 
>>>> similar to a virtual memory manager. It swaps objects, sessions,
>>>> and sequences in and out of the limited TPM memory as needed."
>>>
>>> A process in virtual memory has a different environment than code 
>>> running on bare metal without page table, doesn't it?
>>>
>>>> And even your latest LPC presentation mention that the handles in
>>>> the in-kernel resource manager are virtualized [1].
>>>>
>>>> And I disagree that it does not matter, since the same spec
>>>> says:
>>>>
>>>> "This layer is mostly transparent to the upper layers of the TSS
>>>> and is not required."
>>>>
>>>> But returning -EINVAL instead of a proper TPM command response
>>>> with a TPM_RC_COMMAND_CODE code makes it not transparent to the
>>>> upper layer.
>>>
>>> *mostly*
>>>
>>
>> Fair enough
> 
> The intent of this "mostly transparent" stuff is to convey that the RM
> should be as transparent as possible while acknowledging that there are
> some cases where it's not / can't be. I can't say why the original
> author phrased it in this somewhat ambiguous way but I wouldn't call
> this a fair interpretation. It's definitely one way to read it though.
> 
> The case in question is the RM performing a function on behalf of the
> TPM: command code validation. This is a perfectly valid thing to do in
> the RM though the RM should aim to behave as the TPM would if the RM
> takes any action (sending a TPM response buffer with the appropriate
> response code).
>

That was my interpretation as well and what I was arguing about. I'm glad to
know that you also think the same.

> An additional detail is described in section 3.1 "Error Codes". There is
> a mechanism to encode information about which layer in the stack
> produced the response buffer. When the TPM gets a command with a command
> code it doesn't support then this field will be '0' since '0' identifies
> the TPM. If the RM is taking over this function it should set the field
> to indicate as much.
> 
>>>> If the TPM spaces infrastructure is not compliant with the spec,
>>>> then I think that should also be documented.
>>>
>>> TPM specification is not a formal specification AFAIK.
>>>
>>>>> matters less than breaking the sandbox.
>>>>>
>>>>
>>>> Yes, sorry for that. It wasn't clear to me that there was a
>>>> sandbox and my lack of familiarity with the code was the reason
>>>> why I posted as a RFC in the first place.
>>>>
>>>> Do you agree with Jason's suggestion to send a synthesized TPM 
>>>> command in the that the command isn't supported?
>>>
>>> Nope.
>>>
>>
>> Ok. Thanks a lot for your feedback. I already had that patch but
>> didn't want to post it before knowing your opinion, I'll drop it
>> now.
>>
>> Philip,
>>
>> I think this means that we can now fix this in user-space then? That
>> was in fact my first suggestion in the filed tpm2-tools issue.
> 
> We can work around quirks in the kernel RM in user space if we must
> (short term?) but I'm hesitant to do so in this case. Would feel better
> about a short term work-around knowing it's only going to be short term.
>

Agreed, as explained in my last email, the possible ways to fix in user-space
would be workarounds for the kernel RM not being consistent and not following
the TPM specification.

Can you please comment on the RFCv2 patch I shared that sends a TPM response
with the appropriate response code as suggested by Jason? I'm convinced that
is the correct approach to handle this case.

> Philip
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
