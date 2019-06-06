Return-Path: <SRS0=dWk4=UF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB84C04AB5
	for <linux-integrity@archiver.kernel.org>; Thu,  6 Jun 2019 08:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A5420673
	for <linux-integrity@archiver.kernel.org>; Thu,  6 Jun 2019 08:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfFFILj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:11:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbfFFILj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 04:11:39 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 12616B8CD41A40F69CC8;
        Thu,  6 Jun 2019 09:11:38 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 6 Jun
 2019 09:11:37 +0100
Subject: Re: [PATCH V4] IMA: Allow profiles to define the desired IMA template
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.vnet.ibm.com>, <prsriva02@gmail.com>,
        <bauerman@linux.ibm.com>, Matthew Garrett <mjg59@google.com>
References: <20190604203859.181156-1-matthewgarrett@google.com>
 <1559691534.4278.14.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <94b77c75-21c0-065a-892a-5f8a5f6eca15@huawei.com>
Date:   Thu, 6 Jun 2019 10:11:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1559691534.4278.14.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/2019 1:38 AM, Mimi Zohar wrote:
> Hi Matthew,
> 
> On Tue, 2019-06-04 at 13:38 -0700, Matthew Garrett wrote:
>> Admins may wish to log different measurements using different IMA
>> templates. Add support for overriding the default template on a per-rule
>> basis.
>>
>> Signed-off-by: Matthew Garrett <mjg59@google.com>
>> ---
>>   Remove mention of template format from the documentation, and avoid
>>   attempting to assign to template_desc if we weren't provided a pointer
>>   in the first place.
> 
> Thanks!  I've pushed this patch out, for now, to the next-queued-
> testing branch.  This will allow others to rebase their patch sets -
> kexec command line measurement, the appended signatures, and the VFS
> file hashes - on top of it.
> 
> Roberto, any chance you would be interested in adding the template
> field format support?

I would publish first the fixes and the digest lists patch set.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
