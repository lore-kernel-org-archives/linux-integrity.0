Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36010 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeCFMjv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 07:39:51 -0500
Received: by mail-wm0-f43.google.com with SMTP id 188so21874124wme.1
        for <linux-integrity@vger.kernel.org>; Tue, 06 Mar 2018 04:39:51 -0800 (PST)
Subject: Re: [PATCH 0/5 V2] tpm: timeouts revamp
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180306092503.11568-1-tomas.winkler@intel.com>
 <1520338622.3779.1.camel@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
Date: Tue, 6 Mar 2018 13:39:49 +0100
MIME-Version: 1.0
In-Reply-To: <1520338622.3779.1.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 03/06/2018 01:17 PM, Jarkko Sakkinen wrote:
> On Tue, 2018-03-06 at 11:24 +0200, Tomas Winkler wrote:
>> This series cleans up tpm timeouts setting and handling.
>>
>> First motivation was to fix failures coming from too short timeouts
>> for commands that creates keys.
>> Key generation may take significant time depending on the underlying
>> hardware. Rather than increasing default timeout a new constant is
>> added, to not stall too long on regular commands failures.
>>
>> Second is to define timeouts for new tpm2 commands
>> defined in TCG 1.36 spec.
>

Probably a typo, since the latest TCG spec version is the 1.38 [0].
 
> Where can we get that specification? I don't have that new
> version and couldn't find it from the public internet.
> 
> /Jarkko
> 

[0]: https://trustedcomputinggroup.org/tpm-library-specification/

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
