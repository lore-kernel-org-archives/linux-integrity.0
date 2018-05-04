Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbeEDOWy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 May 2018 10:22:54 -0400
Date: Fri, 4 May 2018 07:22:53 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Laurent Bigonville <bigon@debian.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Alexander.Steffen@infineon.com,
        linux-integrity@vger.kernel.org
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
Message-ID: <20180504142253.t2kx37sxebuoy7fm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1510672631.4078.7.camel@HansenPartnership.com>
 <20171117131620.het4yxavz6lco6ow@linux.intel.com>
 <67ca8d8f-bd2c-a1ad-72d1-7f4b8df0a847@debian.org>
 <20180103003355.oaie7tych5lmtxiq@cantor>
 <bea3c5c2-4abe-27bc-3fe0-761457cca897@debian.org>
 <20180214114353.tw72tztmth2agpqu@linux.intel.com>
 <58cd2dfe-24e7-e320-c7ef-153ba5855835@debian.org>
 <d7d5a45fd2479eaf4495adde53391d53ee6d1ca6.camel@linux.intel.com>
 <471775d9-374a-a97b-dacd-a4ca2beb56eb@debian.org>
 <20180504081803.GC6373@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
In-Reply-To: <20180504081803.GC6373@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri May 04 18, Jarkko Sakkinen wrote:
>On Thu, May 03, 2018 at 01:38:17PM +0200, Laurent Bigonville wrote:
>> Le 15/03/18 a 17:24, Jarkko Sakkinen a ecrit :
>> > On Fri, 2018-03-09 at 18:24 +0100, Laurent Bigonville wrote:
>> > > The duration that that was in your patch seems to work, cannot this be
>> > > implemented?
>> > >
>> > > I'm quite surprised I'm the only one impacted by this...
>> > Sorry it took so long time response but I had forgotten so too many
>> > details.
>> >
>> > After re-reading (PHEW!) the whole thread I'm thinking if we could
>> > use section 5.5.2.4 as a reference to select a timeout of TIMEOUT_A
>> > (albeit it is for request locality) and use Jerry's suggestion to
>> > put wait_for_tpm_stat() there? Opinions?
>> Hey,
>>
>> Sorry to bother you again, but are there any progress on getting this
>> mainlined?
>>
>> Kind regards,
>>
>> Laurent Bigonville
>
>Sorry for not doing anything. Jerry, do you want to send patch?
>
>/Jarkko

Yes. I'll send a patch today.

Jerry
