Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8955 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdJTCQK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 22:16:10 -0400
Subject: Re: [PATCH] ima: fix ineffective default hash algorithm due to
 invalid hash algorithm boot argument
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        <linux-integrity@vger.kernel.org>
References: <20171018033801.220383-1-wangboshi@huawei.com>
 <1508425516.3268.18.camel@linux.vnet.ibm.com>
From: Boshi Wang <wangboshi@huawei.com>
Message-ID: <ce080bf4-0398-3193-1c16-f2f79a26b5c5@huawei.com>
Date: Fri, 20 Oct 2017 10:14:07 +0800
MIME-Version: 1.0
In-Reply-To: <1508425516.3268.18.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


On 2017/10/19 23:05, Mimi Zohar wrote:
> On Wed, 2017-10-18 at 11:38 +0800, Boshi Wang wrote:
>> The hash_setup function always sets hash_setup_done variable. If an
>> invalid hash algorithm is passed, the default hash algorithm specified
>> by CONFIG_IMA_DEFAULT_HASH could not be used.
> The Subject line of this email is too long and needs to be clearer.
>   Please refer to Documentation/process/submitting-patches.rst section
> 14 "The canonical patch format".  I would recommend shortening it to
> something like "ima: fix hash algorithm initialization".
>
> The patch description should start out with a concise explanation of
> the current status, followed by the problem description and end with
> the solution.  For example,
>
> The hash_setup function always sets the hash_setup_done flag, even
> when the hash algorithm is invalid.  This prevents the default hash
> algorithm defined as CONFIG_IMA_DEFAULT_HASH from being used.
>
> This patch sets hash_setup_done flag only for valid hash algorithms.
Thank you for your advice. I will change the subject and the patch description
in the next version.
>
> Mimi
>
>> Signed-off-by: Boshi Wang <wangboshi@huawei.com>
>> ---
>>   security/integrity/ima/ima_main.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 2aebb79..ab70a39 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -51,6 +51,8 @@ static int __init hash_setup(char *str)
>>   			ima_hash_algo = HASH_ALGO_SHA1;
>>   		else if (strncmp(str, "md5", 3) == 0)
>>   			ima_hash_algo = HASH_ALGO_MD5;
>> +		else
>> +			return 1;
>>   		goto out;
>>   	}
>>
>> @@ -60,6 +62,8 @@ static int __init hash_setup(char *str)
>>   			break;
>>   		}
>>   	}
>> +	if (i == HASH_ALGO__LAST)
>> +		return 1;
>>   out:
>>   	hash_setup_done = 1;
>>   	return 1;
