Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36152 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbdLUPxw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 10:53:52 -0500
Received: by mail-wm0-f48.google.com with SMTP id b76so16764668wmg.1
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 07:53:52 -0800 (PST)
Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
 memory region
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-2-javierm@redhat.com> <20171220180855.GB22908@ziepe.ca>
 <f9da193f-e1b4-c126-d272-b98bafda3b99@redhat.com>
 <20171220185458.GE22908@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828988917@ORSMSX109.amr.corp.intel.com>
 <e47b722a-da89-927d-b87a-1b21edd1b64d@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828988F88@ORSMSX109.amr.corp.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <f1f61477-a0df-1072-9751-8e9c254856e2@redhat.com>
Date: Thu, 21 Dec 2017 16:53:49 +0100
MIME-Version: 1.0
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF5828988F88@ORSMSX109.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/21/2017 04:39 PM, Shaikh, Azhar wrote:
> HI Javier,
> 
> 
>> -----Original Message-----
>> From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
>> owner@vger.kernel.org] On Behalf Of Javier Martinez Canillas
>> Sent: Thursday, December 21, 2017 4:49 AM
>> To: Shaikh, Azhar <azhar.shaikh@intel.com>; Jason Gunthorpe
>> <jgg@ziepe.ca>
>> Cc: linux-kernel@vger.kernel.org; James Ettle <james@ettle.org.uk>; Hans de
>> Goede <hdegoede@redhat.com>; Arnd Bergmann <arnd@arndb.de>; Jarkko
>> Sakkinen <jarkko.sakkinen@linux.intel.com>; Peter Huewe
>> <peterhuewe@gmx.de>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; linux-integrity@vger.kernel.org
>> Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
>> memory region
>>
>> Hello Azhar,
>>
>> On 12/20/2017 08:15 PM, Shaikh, Azhar wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
>>>> Sent: Wednesday, December 20, 2017 10:55 AM
>>>> To: Javier Martinez Canillas <javierm@redhat.com>
>>>> Cc: linux-kernel@vger.kernel.org; James Ettle <james@ettle.org.uk>;
>>>> Hans de Goede <hdegoede@redhat.com>; Shaikh, Azhar
>>>> <azhar.shaikh@intel.com>; Arnd Bergmann <arnd@arndb.de>; Jarkko
>>>> Sakkinen <jarkko.sakkinen@linux.intel.com>; Peter Huewe
>>>> <peterhuewe@gmx.de>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>;
>>>> linux- integrity@vger.kernel.org
>>>> Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already
>>>> unmapped I/O memory region
>>>>
>>>> On Wed, Dec 20, 2017 at 07:21:31PM +0100, Javier Martinez Canillas wrote:
>>>>
>>>>>> The below draft fixes everything except #1. That needs a more
>>>>>> thoughtful idea..
>>>>>>
>>>>>
>>>>> I'll just drop this patch from the series and you can fix all the
>>>>> issues in the error / driver removal paths. It's not a dependency
>>>>> anyways, I included it just because noticed the issue while reading the
>> code.
>>>>
>>>> Azhar, this means it becomes your problem :)
>>>>
>>>
>>> Sure, I will fix this.
>>> Javier you can drop this patch.
>>>
>>
>> On a second though, we should just merge $SUBJECT since is an obvious fix
>> for one of the issues. Then you could fix the remaining bugs in error and
>> driver removal paths.
> 
> I think you are asking to keep this patch as a part of this series, itself and not upload separately. Is this correct? Please correct me if I am wrong.
>

Yes, what I meant is that we should just keep this patch in the series since
it fixes one of the resource cleanup bugs. Then you can fix the other issues
as a follow-up.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
