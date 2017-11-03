Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:61428 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753361AbdKCQGH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 12:06:07 -0400
Date: Fri, 03 Nov 2017 17:05:49 +0100
In-Reply-To: <20171103142841.2nphkjojzamrdezm@linux.intel.com>
References: <20171031202357.GA1030@ziepe.ca> <20171103142841.2nphkjojzamrdezm@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] tpm: Update MAINTAINERS for Jason Gunthorpe
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
From: Peter Huewe <peterhuewe@gmx.de>
Message-ID: <0812DDC3-187D-4F29-BFB5-9A4F509CA376@gmx.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



Am 3. November 2017 15:28:41 MEZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
>On Tue, Oct 31, 2017 at 02:23:57PM -0600, Jason Gunthorpe wrote:
>> My email address for open source work is moving to this new permanent
>> personal address.
>> 
>> Signed-off-by: Jason Gunthorpe <jgunthorpe@ziepe.ca>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6671f375f7fcdd..b79eb071475ffc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13588,7 +13588,7 @@ TPM DEVICE DRIVER
>>  M:	Peter Huewe <peterhuewe@gmx.de>
>>  M:	Marcel Selhorst <tpmdd@selhorst.net>
>>  M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> -R:	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>> +R:	Jason Gunthorpe <jgg@ziepe.ca>
>>  W:	http://tpmdd.sourceforge.net
>>  L:	tpmdd-devel@lists.sourceforge.net (moderated for non-subscribers)
>>  Q:	https://patchwork.kernel.org/project/tpmdd-devel/list/
>> -- 
>> 2.7.4
>> 
>
>Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
>Should these updates go to my tree? I posted previous update to
>linux-kernel@vger.kernel.org.
Which equals /dev/null for most cases.

Why shouldn'tit go through your tree?
It's a maintainers update for your subsystem - and you did it in the past when modifying the urls.

>/Jarkko

-- 
Sent from my mobile
