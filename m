Return-Path: <SRS0=OrKi=PZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3FBC43387
	for <linux-integrity@archiver.kernel.org>; Thu, 17 Jan 2019 07:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB22D20855
	for <linux-integrity@archiver.kernel.org>; Thu, 17 Jan 2019 07:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfAQHxa (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:53:30 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727272AbfAQHxa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Jan 2019 02:53:30 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 00A8DBB531BF47FB961F;
        Thu, 17 Jan 2019 07:53:29 +0000 (GMT)
Received: from [10.204.65.149] (10.204.65.149) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 17 Jan
 2019 07:53:24 +0000
Subject: Re: [PATCH 2/5] tpm: Fix event log types for TPM2
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <matthewgarrett@google.com>
CC:     <linux-integrity@vger.kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, Matthew Garrett <mjg59@google.com>
References: <20190109014847.39980-1-matthewgarrett@google.com>
 <20190109014847.39980-3-matthewgarrett@google.com>
 <20190116214227.GA25803@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <9f794f5f-e596-6b0d-563e-a6c7f16f9b6a@huawei.com>
Date:   Thu, 17 Jan 2019 08:53:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190116214227.GA25803@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.149]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/16/2019 10:42 PM, Jarkko Sakkinen wrote:
> On Tue, Jan 08, 2019 at 05:48:44PM -0800, Matthew Garrett wrote:
>> From: Matthew Garrett <mjg59@google.com>
>>
>> These structs are defined as having variable length members, not fixed
>> size ones. Fix that up and rename them to more accurately describe the
>> only safe way they can be used, and fix the code that relied on having
>> fixed structures.
>>
>> Signed-off-by: Matthew Garrett <mjg59@google.com>
> 
> This collides with Roberto's work. How this must be worked out is to
> first merge Roberto's patches and then this patch set should be aligned
> with that baseline.
> 
> Roberto, are you ready to send soon an updated version? When you do,
> please cc the patches to Matthew. Matthew, what you should do is to
> review Roberto's patches and give him feedback so that his changes
> will work for you. Right now the only "customer" is IMA.

I will check your comment about patch 5/5 and reply.

Roberto


> So yeah, this how I would like to prioritize things. I'll hold on for
> detailed review for your patches up until Roberto's patches have been
> merged because there is just too much intersection.
> 
> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
