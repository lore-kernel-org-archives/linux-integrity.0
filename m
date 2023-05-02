Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B81C7EE21
	for <linux-integrity@archiver.kernel.org>; Tue,  2 May 2023 13:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjEBN6p (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 2 May 2023 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjEBN6f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 May 2023 09:58:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AD41737
        for <linux-integrity@vger.kernel.org>; Tue,  2 May 2023 06:58:32 -0700 (PDT)
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q9hVp33n1z67ZD8;
        Tue,  2 May 2023 21:58:10 +0800 (CST)
Received: from [10.225.1.226] (10.225.1.226) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 2 May
 2023 14:58:29 +0100
Message-ID: <c433174f-6202-23c1-c0f8-590425fe3566@huawei-partners.com>
Date:   Tue, 2 May 2023 17:00:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v1 0/1] ima: obtain child measurement list from init
 namespace
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Denis Semakin <denis.semakin@huawei.com>,
        <linux-integrity@vger.kernel.org>
CC:     <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>,
        <ilya.hanov@huawei-partners.com>, <yusongping@huawei.com>,
        <hukeping@huawei.com>
References: <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
 <20230329085848.278269-1-denis.semakin@huawei.com>
 <70b507f8-aa4d-2efc-a183-790bee0c8ed5@linux.ibm.com>
From:   Denis Semakin <denis.semakin@huawei-partners.com>
In-Reply-To: <70b507f8-aa4d-2efc-a183-790bee0c8ed5@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.225.1.226]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 02.05.2023 16:36, Stefan Berger wrote:
>
>
> On 3/29/23 04:58, Denis Semakin wrote:
>> This patch allows to read measurement lists of child namespaces
>> form init IMA namespace in order to obtain the values of hashes
>> to perform operations and procedures of remote attestation.
>
> I supposed this type of support would go onto the next stage (current 
> posted
> 'stage' is auditing support, next would be measurement support)?
Yes. I agree.
>
>   Stefan
>
>>
>> Denis Semakin (1):
>>    ima: obtain child measurement list from init namespace
>>
>>   security/integrity/ima/ima.h             |   1 +
>>   security/integrity/ima/ima_fs.c          | 164 ++++++++++++++++++++++-
>>   security/integrity/ima/ima_init_ima_ns.c |   2 +
>>   security/integrity/ima/ima_ns.c          |  31 +++++
>>   4 files changed, 193 insertions(+), 5 deletions(-)
>>
