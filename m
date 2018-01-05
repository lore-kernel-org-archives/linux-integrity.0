Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:16828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751723AbeAEPEK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jan 2018 10:04:10 -0500
Subject: Re: [GIT PULL] linux-integrity patches for 4.16-security-next-general
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>
CC: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <1515159816.4418.7.camel@linux.vnet.ibm.com>
 <4806797a-bb15-6996-6654-7e21d39b7699@huawei.com>
 <1515164397.4418.11.camel@linux.vnet.ibm.com>
From: Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <ed27b1da-ed24-0119-b52e-c475d66f0e25@huawei.com>
Date: Fri, 5 Jan 2018 16:04:03 +0100
MIME-Version: 1.0
In-Reply-To: <1515164397.4418.11.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 1/5/2018 3:59 PM, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Fri, 2018-01-05 at 15:55 +0100, Roberto Sassu wrote:
>> On 1/5/2018 2:43 PM, Mimi Zohar wrote:
>>> Hi James,
>>>
>>> Mimi Zohar (2):
>>>         ima: relax requiring a file signature for new files with zero length
>>>         ima: support new "hash" and "dont_hash" policy actions
>> Hi Mimi
>>
>> I think there is an issue in the patch above.
>>
>> +	/* HASH just sets the digital signature flag, nothing else */
>> +	if ((action & IMA_HASH) && !(iint->flags & IMA_DIGSIG)) {
>>
>> IMA_DIGSIG now is an atomic flag.
> 
> Yes, this caused me grief, but is fixed in next-integrity branch.

Ok, I didn't update.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
