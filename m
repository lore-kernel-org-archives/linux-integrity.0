Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:35342 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbeIQTUz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Sep 2018 15:20:55 -0400
Subject: Re: [PATCH v2] tpm: Restore functionality to xen vtpm driver.
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, dunlapg@umich.edu,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>, stable@vger.kernel.org
References: <20180913212551.2435-1-boris.ostrovsky@oracle.com>
 <20180916192510.GF7473@linux.intel.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <b82c4603-1a60-16ec-14b6-81251e114b75@oracle.com>
Date: Mon, 17 Sep 2018 09:54:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180916192510.GF7473@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 9/16/18 3:25 PM, Jarkko Sakkinen wrote:
> On Thu, Sep 13, 2018 at 05:25:51PM -0400, Boris Ostrovsky wrote:
>> From: "Dr. Greg Wettstein" <greg@wind.enjellic.com>
>>
>> Functionality of the xen-tpmfront driver was lost secondary to
>> the introduction of xenbus multi-page support in commit ccc9d90a9a8b
>> ("xenbus_client: Extend interface to support multi-page ring").
>>
>> In this commit a pointer to the shared page address was being
>> passed to the xenbus_grant_ring() function rather then the
>> address of the shared page itself.  This resulted in a situation
> I'm sorry but I'm far from being expert with Xen and this sentence
> confuses me so maybe could open it up a bit.
>
> For me "shared page address" and "address of the shared page" are
> the same thing. What am I missing? I mean just different forms in
> english to describe the exact same thing...

xenbus_grant_ring() takes as an argument address of the ring shared
between two guests. What Greg was trying to describe was the fact that
existing code instead passes address of location where this address is
stored (i.e. somewhat similar to difference between pointer and pointer
to a pointer).

Would this be better:

"In this commit pointer to location of the where the shared page address
is stored was being passed to the xenbus_grant_ring() function rather
then the
address of the shared page itself."

Or please suggest a better alternative, I'll be happy to amend the
commit message.


Thanks.
-boris
