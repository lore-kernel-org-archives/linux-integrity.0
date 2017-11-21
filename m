Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45780 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdKUJ1b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 04:27:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so1801664wme.4
        for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2017 01:27:30 -0800 (PST)
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
Message-ID: <43dcb260-a85c-fd71-fcc0-5d2526d72520@redhat.com>
Date: Tue, 21 Nov 2017 10:27:28 +0100
MIME-Version: 1.0
In-Reply-To: <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/21/2017 10:07 AM, Javier Martinez Canillas wrote:
> On 11/21/2017 12:15 AM, Jarkko Sakkinen wrote:
> 
>> matters less than breaking the sandbox.
>>
> 
> Yes, sorry for that. It wasn't clear to me that there was a sandbox and my
> lack of familiarity with the code was the reason why I posted as a RFC in
> the first place.
> 
> Do you agree with Jason's suggestion to send a synthesized TPM command in
> the that the command isn't supported?
> 

Sorry, this should had been: send a synthesized TPM response in the case that
the command isn't supported.

Best regards,
--
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
