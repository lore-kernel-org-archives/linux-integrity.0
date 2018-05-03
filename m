Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from anor.bigon.be ([91.121.173.99]:37972 "EHLO anor.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbeECLsK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 May 2018 07:48:10 -0400
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Alexander.Steffen@infineon.com,
        linux-integrity@vger.kernel.org
References: <20171111154516.GI17451@ziepe.ca>
 <20171111191257.owuqtgzie3ostsab@cantor> <20171111194647.GA6918@ziepe.ca>
 <20171111203132.hkejjs6cdrrzq3y3@cantor>
 <20171114145953.m3a343qvgln2z4er@linux.intel.com>
 <1510672631.4078.7.camel@HansenPartnership.com>
 <20171117131620.het4yxavz6lco6ow@linux.intel.com>
 <67ca8d8f-bd2c-a1ad-72d1-7f4b8df0a847@debian.org>
 <20180103003355.oaie7tych5lmtxiq@cantor>
 <bea3c5c2-4abe-27bc-3fe0-761457cca897@debian.org>
 <20180214114353.tw72tztmth2agpqu@linux.intel.com>
 <58cd2dfe-24e7-e320-c7ef-153ba5855835@debian.org>
 <d7d5a45fd2479eaf4495adde53391d53ee6d1ca6.camel@linux.intel.com>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <471775d9-374a-a97b-dacd-a4ca2beb56eb@debian.org>
Date: Thu, 3 May 2018 13:38:17 +0200
MIME-Version: 1.0
In-Reply-To: <d7d5a45fd2479eaf4495adde53391d53ee6d1ca6.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Le 15/03/18 a 17:24, Jarkko Sakkinen a ecrit :
> On Fri, 2018-03-09 at 18:24 +0100, Laurent Bigonville wrote:
>> The duration that that was in your patch seems to work, cannot this be
>> implemented?
>>
>> I'm quite surprised I'm the only one impacted by this...
> Sorry it took so long time response but I had forgotten so too many
> details.
>
> After re-reading (PHEW!) the whole thread I'm thinking if we could
> use section 5.5.2.4 as a reference to select a timeout of TIMEOUT_A
> (albeit it is for request locality) and use Jerry's suggestion to
> put wait_for_tpm_stat() there? Opinions?
Hey,

Sorry to bother you again, but are there any progress on getting this 
mainlined?

Kind regards,

Laurent Bigonville
