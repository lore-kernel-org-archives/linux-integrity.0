Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45261 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdLNMFx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 07:05:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so10824187wme.4
        for <linux-integrity@vger.kernel.org>; Thu, 14 Dec 2017 04:05:52 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Ettle <james@ettle.org.uk>
Cc: linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <20171214112124.7t2oxch2gadyfqsr@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <0b46ecfe-8b6c-e169-bff6-e7ce01693a8c@redhat.com>
Date: Thu, 14 Dec 2017 13:05:49 +0100
MIME-Version: 1.0
In-Reply-To: <20171214112124.7t2oxch2gadyfqsr@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jarkko,

On 12/14/2017 12:21 PM, Jarkko Sakkinen wrote:
> On Mon, Dec 11, 2017 at 07:37:29PM +0000, James Ettle wrote:
>> Hello,
>>
>> [First: Apologies if cross-posting from Kernel.org BZ is bad form; my
>> distro BZ advised I post this to your mailing list as well.]
>>
>> Situation: enabling TPM on a Clevo W510LU with an Intel N3160 CPU
>> breaks PS/2 keyboard and mouse. They just don't respond until after a
>> suspend/resume cycle, and after that they later stop after a while.
>>
>> I have confirmed this by blacklisting tpm modules. I noticed this
>> first with kernel 4.13, and have bisected it down to:
> 
> In my GIT tree there is now:
> 
> commit db3248e8a036c39141c8f7e9f1cf5c5ae6815f76 (HEAD -> next, origin/next, origin/master, master)
> Author: Azhar Shaikh <azhar.shaikh@intel.com>
> Date:   Wed Dec 6 17:38:10 2017 -0800
> 
>     tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()
>     
>     Commit 5e572cab92f0bb5 ("tpm: Enable CLKRUN protocol for Braswell
>     systems") disabled CLKRUN protocol during TPM transactions and re-enabled
>     once the transaction is completed. But there were still some corner cases
>     observed where, reading of TPM header failed for savestate command
>     while going to suspend, which resulted in suspend failure.
>     To fix this issue keep the CLKRUN protocol disabled for the entire
>     duration of a single TPM command and not disabling and re-enabling
>     again for every TPM transaction. For the other TPM accesses outside
>     TPM command flow, add a higher level of disabling and re-enabling
>     the CLKRUN protocol, instead of doing for every TPM transaction.
>     
>     Fixes: 5e572cab92f0bb5 ("tpm: Enable CLKRUN protocol for Braswell systems")
>     
>     Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
>     Reviewed-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
>     Tested-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
>     Signed-off-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
> 
> Can you try this?
>

I already suggested the same [0], but James said that made no difference [1].
 
> /Jarkko
>

[0]: https://lkml.org/lkml/2017/12/12/268
[1]: https://lkml.org/lkml/2017/12/12/1127

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
