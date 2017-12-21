Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39798 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbdLUSoH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 13:44:07 -0500
Received: by mail-wm0-f45.google.com with SMTP id i11so17542072wmf.4
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 10:44:06 -0800 (PST)
Subject: Re: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell systems
 due CLKRUN enabled
To: Jeffery Miller <jmiller@neverware.com>
Cc: James Ettle <james@ettle.org.uk>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
References: <20171220113538.16099-1-javierm@redhat.com>
 <5c098570-5aea-533c-c096-b5eb5ecc5c95@ettle.org.uk>
 <225df7f0-2422-1c5a-f44e-96cfd3b24232@redhat.com>
 <CAERfUWpNfXkc+tKG72k_ZXeeNG_5pnTkJW0j18FJQ_gj-11yog@mail.gmail.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <3f7bd120-0a62-cc7b-588c-2cfb566b51a7@redhat.com>
Date: Thu, 21 Dec 2017 19:44:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAERfUWpNfXkc+tKG72k_ZXeeNG_5pnTkJW0j18FJQ_gj-11yog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jeffery,

On 12/21/2017 06:25 PM, Jeffery Miller wrote:
> On Thu, Dec 21, 2017 at 6:46 AM, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> I meant linux-tpmdd + the 4 patches in this series.
> 
> Javier,
> I applied the four patches to the linux-tpmdd master 46dd3b29e328 this
> morning and it
> fixed the touchpad on my affected machine.
> 
> To be clear, the patchwork patches I applied were:
> 10125523
> 10125515
> 10125513
> 10125531
> 
> I have a slightly different machine (Lenovo Yoga 11e) but found the
> same original CLKRUN commit doing a bisect.
> 

Great, thanks for testing!

Can I add your Tested-by tag then?

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
