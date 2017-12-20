Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:6615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755902AbdLTTPX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 14:15:23 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
        Javier Martinez Canillas <javierm@redhat.com>
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
Date: Wed, 20 Dec 2017 19:15:19 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF5828988917@ORSMSX109.amr.corp.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-2-javierm@redhat.com>
 <20171220180855.GB22908@ziepe.ca>
 <f9da193f-e1b4-c126-d272-b98bafda3b99@redhat.com>
 <20171220185458.GE22908@ziepe.ca>
In-Reply-To: <20171220185458.GE22908@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
>Sent: Wednesday, December 20, 2017 10:55 AM
>To: Javier Martinez Canillas <javierm@redhat.com>
>Cc: linux-kernel@vger.kernel.org; James Ettle <james@ettle.org.uk>; Hans de
>Goede <hdegoede@redhat.com>; Shaikh, Azhar <azhar.shaikh@intel.com>;
>Arnd Bergmann <arnd@arndb.de>; Jarkko Sakkinen
><jarkko.sakkinen@linux.intel.com>; Peter Huewe <peterhuewe@gmx.de>;
>Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
>integrity@vger.kernel.org
>Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
>memory region
>
>On Wed, Dec 20, 2017 at 07:21:31PM +0100, Javier Martinez Canillas wrote:
>
>> > The below draft fixes everything except #1. That needs a more
>> > thoughtful idea..
>> >
>>
>> I'll just drop this patch from the series and you can fix all the
>> issues in the error / driver removal paths. It's not a dependency
>> anyways, I included it just because noticed the issue while reading the code.
>
>Azhar, this means it becomes your problem :)
>

Sure, I will fix this.
Javier you can drop this patch.

>Since the patches Jarkko has queued from you introduce oops's you need to
>fix them..
>
>Jason

Regards,
Azhar Shaikh
