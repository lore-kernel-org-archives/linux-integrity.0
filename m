Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43164 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbdLUQeS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 11:34:18 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
 memory region
Date: Thu, 21 Dec 2017 16:34:16 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF5828988FFF@ORSMSX109.amr.corp.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-2-javierm@redhat.com>
 <20171220180855.GB22908@ziepe.ca>
 <f9da193f-e1b4-c126-d272-b98bafda3b99@redhat.com>
 <20171220185458.GE22908@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828988917@ORSMSX109.amr.corp.intel.com>
 <e47b722a-da89-927d-b87a-1b21edd1b64d@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828988F88@ORSMSX109.amr.corp.intel.com>
 <f1f61477-a0df-1072-9751-8e9c254856e2@redhat.com>
In-Reply-To: <f1f61477-a0df-1072-9751-8e9c254856e2@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Javier Martinez Canillas [mailto:javierm@redhat.com]
>Sent: Thursday, December 21, 2017 7:54 AM
>To: Shaikh, Azhar <azhar.shaikh@intel.com>; Jason Gunthorpe
><jgg@ziepe.ca>
>Cc: linux-kernel@vger.kernel.org; James Ettle <james@ettle.org.uk>; Hans de
>Goede <hdegoede@redhat.com>; Arnd Bergmann <arnd@arndb.de>; Jarkko
>Sakkinen <jarkko.sakkinen@linux.intel.com>; Peter Huewe
><peterhuewe@gmx.de>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; linux-integrity@vger.kernel.org
>Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
>memory region
>
>On 12/21/2017 04:39 PM, Shaikh, Azhar wrote:
>> HI Javier,
>>
>>
>>> -----Original Message-----
>>> From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
>>> owner@vger.kernel.org] On Behalf Of Javier Martinez Canillas
>>> Sent: Thursday, December 21, 2017 4:49 AM
>>> To: Shaikh, Azhar <azhar.shaikh@intel.com>; Jason Gunthorpe
>>> <jgg@ziepe.ca>
>>> Cc: linux-kernel@vger.kernel.org; James Ettle <james@ettle.org.uk>;
>>> Hans de Goede <hdegoede@redhat.com>; Arnd Bergmann
><arnd@arndb.de>;
>>> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Peter Huewe
>>> <peterhuewe@gmx.de>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>;
>>> linux-integrity@vger.kernel.org
>>> Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already
>>> unmapped I/O memory region
>>>
>>> Hello Azhar,
>>>
>>> On 12/20/2017 08:15 PM, Shaikh, Azhar wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
>>>>> Sent: Wednesday, December 20, 2017 10:55 AM
>>>>> To: Javier Martinez Canillas <javierm@redhat.com>
>>>>> Cc: linux-kernel@vger.kernel.org; James Ettle <james@ettle.org.uk>;
>>>>> Hans de Goede <hdegoede@redhat.com>; Shaikh, Azhar
>>>>> <azhar.shaikh@intel.com>; Arnd Bergmann <arnd@arndb.de>; Jarkko
>>>>> Sakkinen <jarkko.sakkinen@linux.intel.com>; Peter Huewe
>>>>> <peterhuewe@gmx.de>; Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org>;
>>>>> linux- integrity@vger.kernel.org
>>>>> Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already
>>>>> unmapped I/O memory region
>>>>>
>>>>> On Wed, Dec 20, 2017 at 07:21:31PM +0100, Javier Martinez Canillas
>wrote:
>>>>>
>>>>>>> The below draft fixes everything except #1. That needs a more
>>>>>>> thoughtful idea..
>>>>>>>
>>>>>>
>>>>>> I'll just drop this patch from the series and you can fix all the
>>>>>> issues in the error / driver removal paths. It's not a dependency
>>>>>> anyways, I included it just because noticed the issue while
>>>>>> reading the
>>> code.
>>>>>
>>>>> Azhar, this means it becomes your problem :)
>>>>>
>>>>
>>>> Sure, I will fix this.
>>>> Javier you can drop this patch.
>>>>
>>>
>>> On a second though, we should just merge $SUBJECT since is an obvious
>>> fix for one of the issues. Then you could fix the remaining bugs in
>>> error and driver removal paths.
>>
>> I think you are asking to keep this patch as a part of this series, itself and not
>upload separately. Is this correct? Please correct me if I am wrong.
>>
>
>Yes, what I meant is that we should just keep this patch in the series since it
>fixes one of the resource cleanup bugs. Then you can fix the other issues as a
>follow-up.
>

Ok, but even the patch which I will be submitting will be doing the cleanup. So it will just split the change.


>Best regards,
>--
>Javier Martinez Canillas
>Software Engineer - Desktop Hardware Enablement Red Hat

Regards,
Azhar Shaikh 
