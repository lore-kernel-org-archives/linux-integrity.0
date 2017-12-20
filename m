Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7300 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754664AbdLTPmE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 10:42:04 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
        "Alexander.Steffen@infineon.com" <Alexander.Steffen@infineon.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "james@ettle.org.uk" <james@ettle.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell
 systems due CLKRUN enabled
Date: Wed, 20 Dec 2017 15:41:55 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF58289887AA@ORSMSX109.amr.corp.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <96f3f833-22f8-5400-bd22-7c1c622bbe61@redhat.com>
 <da95e481-be7d-63f2-1b54-1e1c6145ed3f@redhat.com>
 <a114994f3498411dab915403ac214130@infineon.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF58289886F4@ORSMSX109.amr.corp.intel.com>
 <ffad5984-a05b-f27f-f207-a02a58ac8ae2@redhat.com>
In-Reply-To: <ffad5984-a05b-f27f-f207-a02a58ac8ae2@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Javier Martinez Canillas [mailto:javierm@redhat.com]
>Sent: Wednesday, December 20, 2017 7:31 AM
>To: Shaikh, Azhar <azhar.shaikh@intel.com>;
>Alexander.Steffen@infineon.com; hdegoede@redhat.com; linux-
>kernel@vger.kernel.org
>Cc: james@ettle.org.uk; arnd@arndb.de; jarkko.sakkinen@linux.intel.com;
>peterhuewe@gmx.de; jgg@ziepe.ca; gregkh@linuxfoundation.org; linux-
>integrity@vger.kernel.org
>Subject: Re: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell
>systems due CLKRUN enabled
>
>Hello Azhar,
>
>On 12/20/2017 04:08 PM, Shaikh, Azhar wrote:
>
>[snip]
>
>>>>
>>>>> It seems that on machines with a PS/2 controller connected to the
>>>>> LPC bus the BIOS is already doing this, so I've a feeling that it
>>>>> not being done on devices with a TPM is a bug in the firmware
>>>>
>>>> Absolutely agree, system integratos should make sure that all the
>>>> devices connected to the LPC either have CLKRUN protocol support and
>>>> is enabled or disable the CLKRUN protocol permanently.
>>>
>>> As far as I understand it, this is exactly the issue here: They know
>>> that there are devices that do not support the CLKRUN protocol (the
>>> TPM in this case), but they still need to enable it to prevent other
>>> issues. So for the TPM to continue to work, CLKRUN needs to be
>>> disabled temporarily while the TPM is active.
>>>
>>
>> Yes that was the reason to have this fix. We needed CLKRUN to be enabled
>for Braswell SOC . But the TPM in this case SLB9655 does not support CLKRUN
>(please check this public documentation
>https://www.infineon.com/dgdl/Infineon-TPM+SLB+9665-DS-v10_15-
>EN.pdf?fileId=5546d4625185e0e201518b83d9273d87 section 2.3 Power
>Management). So as Alexander mentioned CLKRUN is disabled while TPM
>transactions are in progress.
>>
>
>Yes I do understand that. Please read my answer to Alexander's email and
>also my question (and Hans') about keeping the CLKRUN protocol
>permanently disabled.
>

We had to enable CLKRUN for BSW issues as mentioned here https://www.intel.com/content/www/us/en/processors/pentium/pentium-celeron-n-series-spec-update.html  on Page 24 CHP 49 and Page 25 CHP 51



>Best regards,
>--
>Javier Martinez Canillas
>Software Engineer - Desktop Hardware Enablement Red Hat
