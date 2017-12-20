Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45515 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755724AbdLTSd3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 13:33:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so11659633wme.4
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 10:33:28 -0800 (PST)
Subject: Re: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell systems
 due CLKRUN enabled
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        "Alexander.Steffen@infineon.com" <Alexander.Steffen@infineon.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james@ettle.org.uk" <james@ettle.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171220113538.16099-1-javierm@redhat.com>
 <96f3f833-22f8-5400-bd22-7c1c622bbe61@redhat.com>
 <da95e481-be7d-63f2-1b54-1e1c6145ed3f@redhat.com>
 <a114994f3498411dab915403ac214130@infineon.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF58289886F4@ORSMSX109.amr.corp.intel.com>
 <ffad5984-a05b-f27f-f207-a02a58ac8ae2@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF58289887AA@ORSMSX109.amr.corp.intel.com>
 <ba99c3c1-c3da-4045-a9d9-3801793db6b1@redhat.com>
 <20171220174400.GA22908@ziepe.ca>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <13fd882e-a387-3ba0-d6c0-83463b9d3840@redhat.com>
Date: Wed, 20 Dec 2017 19:33:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171220174400.GA22908@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/20/2017 06:44 PM, Jason Gunthorpe wrote:
> On Wed, Dec 20, 2017 at 05:45:16PM +0100, Javier Martinez Canillas wrote:
> 
>> CHP51 says "LPC Clock Control Using the LPC_CLKRUN# May Not Behave As Expected"
>> and that the implication is that "The SoC may prevent a peripheral device from
>> successfully requesting the LPC clock".
> 
> Now we are back to the beginning - the LPC_CLKRUN protocol is simply
> broken in BSW chipsets, and it has nothing to do with the TPM?
> 
> Intel is trying to work around that broken-ness and still preserve
> power management in the case where only the TPM is connected to the
> LPC bus.. It is questionable to me if this is even a good idea, or if
> Linux is the right place to implement this work around (eg something
> in SMM mode may be more appropriate for a chipset bug)
> 
> I think your patch is still the right improvement, if the BIOS turned
> the feature off, we should not turn it back on.
>

Yes, the patch has merits on its own since fixes a flaw in the logic of
the original CLKRUN patch. I think we should merge it and then the other
issues can be fixed (or rework how the CLKRUN is managed) as follow-ups.
 
> Jason
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
