Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from anor.bigon.be ([91.121.173.99]:45111 "EHLO anor.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934002AbeEJLWE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 07:22:04 -0400
Subject: Re: [PATCH] tpm_tis: verify locality released before returning from
 release_locality
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20180505195453.10431-1-jsnitsel@redhat.com>
 <20180505200315.x7jt33j7psizmfyi@cantor>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <e2d0e88a-d4b7-9a4e-45c5-b2409d6c6cab@debian.org>
Date: Thu, 10 May 2018 13:21:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180505200315.x7jt33j7psizmfyi@cantor>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Le 05/05/18 a 22:03, Jerry Snitselaar a ecrit :
> On Sat May 05 18, Jerry Snitselaar wrote:
>> [...]
>>
>
> Laurent,

Hello Jerry,

> Can you try this patch with your system since it is the one
> that has exhibited the problem so far. I've tested on a
> tpm2.0 and tpm1.2 system here.

I just tested the patch and the driver is loading fine again and the 
device in /dev is present again, so it seems to work.

But for some reason the tpm is again locked (for no visible reason) due 
to "dictionary attack" so I cannot test further ATM :/

Regards,

Laurent

>
> Regards,
> Jerry
