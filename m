Return-Path: <SRS0=2aJh=RY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB3DC4360F
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Mar 2019 11:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086DC218FD
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Mar 2019 11:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="UBFL84xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfCULsQ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:48:16 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:35508 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfCULsO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Mar 2019 07:48:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 77CF2B83CA8;
        Thu, 21 Mar 2019 14:48:13 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5eQrnZOoTYc4; Thu, 21 Mar 2019 14:48:13 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 2DB70B83FE6;
        Thu, 21 Mar 2019 14:48:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru 2DB70B83FE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1553168893;
        bh=ooi8lgR/3m84hMf3wkfZGs/8sxM/rioOlzWrJ8fOInc=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=UBFL84xtU5dU+Ay6ok9a0ulz3Z0ikFxfS3EG+SaCgdWxZqX1Op9dV3SDGRGkbohhc
         wGl38XV3J9dbpw1RVdDml4QEPHPwG/NlGwJ4DEP5lqQc/Twd1RZ8hqSiX5ehT4XmmI
         l6C+niIpAC5nYnNHd9uiAW6m9yEPEAhopBgWQqgvypB0syvrJwxU1bD9LKTQkuWhZU
         jjnSSG2IhTSDNf1A55XhZlP+4mYWjjFR8ew0WVpmiVLvtJaMMCIII0y4Fl3ZgAw720
         EQ3jVdZXZk7BI8h09gzpzV289UFar9owceDfQ4DtnKbFXPzedNuWMnK6NPKSzYAT03
         /CGtPp0BbL37g==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E4Z7HdDEE0e3; Thu, 21 Mar 2019 14:48:12 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id E921CB83CA8;
        Thu, 21 Mar 2019 14:48:12 +0300 (MSK)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com>
 <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com>
 <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com>
 <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
Date:   Thu, 21 Mar 2019 14:48:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1553167318.4899.382.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 21.03.2019 14:21, Mimi Zohar wrote:
> <snip>
> Igor, as for shared libraries:
> 
> 1. Extend ima_file_mmap() to permit, based on policy, verifying file
> signatures for files being mmap'ed read and preventing validly signed
> files from being mmap'ed write.
> 
> 2. Define an IMA mprotect hook that permits, based on policy,
> preventing memory having validly signed backing storage from setting
> the memory region to write, but allow execute.
> 
> (This will require access to the IMA mmap signature verification
> status cached in the "iint".)

Yes, it could work.

Pages mapped from the signed backing store rarely need to be altered
so preventing them from being changed will work.

Along with disabling creating anonymous executable pages at all since
is is hardly needed for the system services for normal work.

It could block polymorphic code so only ROP (return-oriented programming)
could survive after intercepting of execution flow without having an ability
to download any extra code from their servers.
