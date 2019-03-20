Return-Path: <SRS0=28DF=RX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4804FC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Mar 2019 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF43218B0
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Mar 2019 18:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="wZ3AD6ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfCTSI1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:08:27 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:57612 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCTSI1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Mar 2019 14:08:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 75685B6A198;
        Wed, 20 Mar 2019 21:08:24 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6PevQaW0LyIs; Wed, 20 Mar 2019 21:08:23 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 738B9B6A18D;
        Wed, 20 Mar 2019 21:08:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru 738B9B6A18D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1553105303;
        bh=TiqlwCLqm4mkef75hMk0zqv7UQYqu6ccE8KI0/IF1YE=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=wZ3AD6msEtdGepJsh8kE24kkB17TbpzDp+V7W/zeE7Ny9od5hiP0VrmmAzRIvatAK
         sK6GytRE/EpndyptTThyHEitcgd+kpqbwvvtLu7bo5fj07p7rG9mCRQpvYZ1i0C+5P
         NIV3JAZY8ngjPKr43UIGhAAuWh3jAL2ZASfw47Fx9SubM25ILe9WR/I8dfaXcR4LGq
         yKTY77DbrNhEmfm0waPny0rEM30EBMPAY93Ho7Y2JRH4OJdGc2lZv51LcM8hptdTyz
         IG6zFDRwMP2swOiwAyNEHpSSYFEYylmnSDCnGgs/jRVvjr0LjLpIjZX1b7lsQXd0a0
         +sidqt8qHJxpw==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id io-D_FCPyeuR; Wed, 20 Mar 2019 21:08:23 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id 34B56B6A187;
        Wed, 20 Mar 2019 21:08:23 +0300 (MSK)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Matthew Garrett <mjg59@google.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com>
 <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com>
 <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com>
 <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <7331263b-3994-3fa8-e28b-6d791ace4ee4@omprussia.ru>
Date:   Wed, 20 Mar 2019 21:08:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 20.03.2019 20:23, Matthew Garrett wrote:
> On Wed, Mar 20, 2019 at 1:11 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
>> My point was about better protecting of shared libraries making life harder
>> for exploits that are downloading extra code from external servers.
> 
> Like you said, they can implement this by copying the code from
> read-only pages to separate executable pages. It does make it harder,
> but not to a huge degree - anything that's mprotect()ing file-backed
> pages to PROT_EXEC later is presumably doing so to avoid IMA, and
> making this change will just encourage them to add further
> workarounds. Since this is a fight we literally can't win, what's the
> benefit?

Well, may be it would be enough to:
1) Verify with IMA every file root processes read,
2) Use seccomp to forbid mprotect(..., PROT_EXEC) for 99% of processes,
    so they would have to use normal mmap(..., PROT_EXEC, ...) to load the
    code.

P.S. #2 should also protect against patching already mapped executable pages
because they are typically mapped read-only, so one would use
mprotect(..., PROT_READ | PROT_WRITE | PROT_EXEC) to enable write access
to it. So with #2 it wouldn't even be possible to reuse already mapped
pages nor to create new.

May be #2 could be implemented as a separate thing to avoid writing eBPF
seccomp filters to check mprotect() argument for rised PROT_EXEC flag.
