Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-00273201.pphosted.com ([208.84.65.16]:39770 "EHLO
        mx0b-00273201.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751906AbeERQf0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 12:35:26 -0400
From: Mark Baushke <mdb@juniper.net>
To: Petko Manolov <petkan@nucleusys.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petko Manolov <petkan@mip-labs.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Cleaning up IMA
Date: Fri, 18 May 2018 16:08:15 +0000
Message-ID: <4161E088-AC54-4A26-A4F8-5B9132518C29@juniper.net>
References: <1526580423.3632.17.camel@linux.vnet.ibm.com>
 <92E32D97-B60A-4D75-AC9F-594F95E432B1@juniper.net>
 <1526651759.3632.172.camel@linux.vnet.ibm.com>
 <9298.1526652376@eng-mail01.juniper.net>
 <1526657654.3404.17.camel@linux.vnet.ibm.com> <20180518155803.GB4816@carbon>
In-Reply-To: <20180518155803.GB4816@carbon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> On May 18, 2018, at 8:58 AM, Petko Manolov <petkan@nucleusys.com> wrote:
> 
> On 18-05-18 11:34:14, Mimi Zohar wrote:
>> On Fri, 2018-05-18 at 07:06 -0700, Mark D. Baushke wrote:
>>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>>> 
>>>> On Fri, 2018-05-18 at 13:44 +0000, Mark Baushke wrote:
>>>>> Hi Mimi,
>>>>> 
>>>>> I see that Petko has already provide the answer and an updated patch.
>>>>> 
>>>>> I was off-line most of yesterday, and am only now catching up on email.
>>>>> 
>>>>> To confirm, yes, we are still using the ima_update_policy() code.
>> 
>> Updating the policy wasn't the question. It was about using the IMA blacklist, 
>> as opposed to the system blacklist.
> 
> The system-wide blacklist is populated at build time only.  This means that you 
> need kernel change if you want to revoke a certificate, which is sub-optimal.  
> To be useful for us it should be able to accept imports at run-time.
> 
> Until the system-wide blacklist keyring doesn't have this functionality i 
> suggest that we keep .ima_blacklist around.
> 

Ahhh... yes. One of the things we allow our customers to do is choose to revoke our development keys so that only production signed images will run on their networks if they wish to make use of that feature.

As such, adding to the .ima_blacklist is used and will continue to be useful.

We typically make that decision before we enter multi-user mode on reboot...

        Enjoy!
        -- Mark
