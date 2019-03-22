Return-Path: <SRS0=JOkf=RZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9D5C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Mar 2019 07:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2188D204FD
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Mar 2019 07:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="ykXxGBYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfCVH7J (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:59:09 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:48982 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfCVH7J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Mar 2019 03:59:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 90430B80E44;
        Fri, 22 Mar 2019 10:59:07 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Rg_Vyk_Hz69d; Fri, 22 Mar 2019 10:59:07 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 343E5B80E84;
        Fri, 22 Mar 2019 10:59:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru 343E5B80E84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1553241547;
        bh=GpjRHOoI+kTblHcSmFAM3WIOhk/bhiHptvFexJtuChs=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=ykXxGBYmqbWjP4DYKbUt3cal0Qc2EyprjoJUdjFfLwjWX68rCpwBeiFrHEUflc/l+
         mLsVEOAr75hqC9r3BO8JFGfR/muABYVses+tlyaEPWopQI65A0fKqlTqdpViGhOse4
         fWRC5e3wd5gZHl+AjbblYctXhN7M3hjOYL2U2TCdW1I+UeynJfhOK2uN94H6VqeyYd
         h7KuxL71om+RAtagE6f2XjNbXw9M2Svk4JeVMIoIKeZ1REvEsKPfL4/rb2gCMVckps
         PsjnOYVeq0dSKEMf6zuz+ZX87XKJIFsI8urYeqOztNzXEQc2kqWHlAKCth/fVoT1lW
         OQ2/0OVp+hYBg==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ik1n0uWakkdW; Fri, 22 Mar 2019 10:59:07 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id 00EF7B80E44;
        Fri, 22 Mar 2019 10:59:07 +0300 (MSK)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Matthew Garrett <mjg59@google.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
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
 <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
Date:   Fri, 22 Mar 2019 10:59:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 21.03.2019 21:04, Matthew Garrett wrote:
> On Thu, Mar 21, 2019 at 4:48 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
>> Along with disabling creating anonymous executable pages at all since
>> is is hardly needed for the system services for normal work.
> 
> Is this true? Do no JIT compilers behave this way?

Well, besides JIT I've scanned all /proc/PID/maps of my web-server and didn't
find any process with mapped anonymous executable pages.

As for JIT I suppose we could use prctl or something else to allow having
anonymous executable pages.

I'm pondering about some system-wide (or processes subtree-wide) default
setting controlling whether it is allowed to have anonymous pages by default,
and then some mechanism to turn it on/off on a per-process bases. Perhaps
with some locking preventing reenabling after it was dropped.

And what do you think about it?
