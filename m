Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33935 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbdLHVe7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 16:34:59 -0500
Received: by mail-wm0-f68.google.com with SMTP id y82so5932389wmg.1
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 13:34:59 -0800 (PST)
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Ken Goldman <kgold@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
 <20171126140646.hhjtyy26h5ebyd5a@linux.intel.com>
 <ec5d6e67-885b-a518-1c37-93eb3d49684e@linux.vnet.ibm.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <425a45d4-7d44-333e-0d7f-21a931c9d81d@redhat.com>
Date: Fri, 8 Dec 2017 22:34:56 +0100
MIME-Version: 1.0
In-Reply-To: <ec5d6e67-885b-a518-1c37-93eb3d49684e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Ken,

On 12/08/2017 09:20 PM, Ken Goldman wrote:
> On 11/26/2017 9:06 AM, Jarkko Sakkinen wrote:
>>
>> I think -EINVAL is better than synthetizing commands that are not really
>> from the TPM. And we would break backwards compatability by doing this.
>>
>> As I said in an earlier response I would rather compare resource
>> manager to virtual memory than virtual machine.
> 
> Agreed that synthesizing a response is not trivial.  (It's not that hard 
> either - a 6 byte hard coded header and a 4 byte big endian integer.)
>

At the end it was rather trivial. I posted that patch and got merged today:

http://git.infradead.org/users/jjs/linux-tpmdd.git/commitdiff/40ee8cc47c95de22a34c10561f2c00e3c665a29f?hp=7b4edc34bc7542068fa530c0d38babdac95a5e46
 
> But what would be wrong with sending an unknown command to the TPM and 
> letting it handle the response?
> 
>

I agree with you. As I said in this thread, I don't understand the security
implications that Jason says. The patch in $SUBJECT just avoids all the TPM
spaces code paths and sends the command that user-space passed to the kernel
to the real TPM2 hardware as it would do when writing to /dev/tpm? directly.

The kernel should provide mechanism and not policy in my opinion, so it should
be up to user-space to decide what programs are allowed to access the chardevs
or not. In any case, I'm also OK with the solution that was suggested and was
merged.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
