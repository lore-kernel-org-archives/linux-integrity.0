Return-Path: <SRS0=+7J6=RV=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643EDC43381
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Mar 2019 15:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFCB20863
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Mar 2019 15:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="TBaMI4FL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCRP1h (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:27:37 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:34060 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfCRP1h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Mar 2019 11:27:37 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Mar 2019 11:27:37 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 48F5AB53BE6
        for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2019 18:18:11 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bC_pzuidUysL for <linux-integrity@vger.kernel.org>;
        Mon, 18 Mar 2019 18:18:11 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 0902FB53BE8
        for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2019 18:18:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru 0902FB53BE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1552922291;
        bh=xR7gPAFl8FneZVwQjP8KCq5L2L6pmgTWzs7M7E6FfZ8=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=TBaMI4FLXIN5iF3d/67wlJH4J2/bX4b06TSP8F6Fzuf7L6QI43iCeziDD5562Bn1c
         GW7Ml9VyT48BlqUZHsFYGoMi+IJNTir6ll+OBK0lb1WM+kQn9OjvfYaO/OoQ/4Q2Qx
         PHzo9Rsdbk+0MxP/I4clzaiOYuVE07C+J/no4Btsr+LW/3rcPEgMw6VYfh04iHR1j9
         sovVxi3dcG0RAGXUiTz/0fXOR+8ViFmXlVOpYq2sxYxKJeMfq/7EJoeNBbfzeYOc2/
         AZsV7nITM91wFyub+uMpkWHGA3Oo/+Ha15a2U7zeVddfzmd2h4aZi8ptixGTy8FPtw
         vlqH34X33RFRQ==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0C5HGIztJWjr for <linux-integrity@vger.kernel.org>;
        Mon, 18 Mar 2019 18:18:10 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id CAB59B53BE6
        for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2019 18:18:10 +0300 (MSK)
To:     linux-integrity@vger.kernel.org
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Subject: Should mprotect(..., PROT_EXEC) be checked by IMA?
Message-ID: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
Date:   Mon, 18 Mar 2019 18:18:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello!

I've found that IMA checks for executable mmap()s but not for the combination
of mmap(..., PROT_READ, ...) + mprotect(..., PROT_EXEC).

So it looks like is possible to load arbitrary executable code by rewriting
dlopen() and dlsym() functions to map all ELF segments read-only first then
making them executable with mprotect().

So should security_file_mprotect() be changed similarly
to security_mmap_file() to call IMA security hook?

Thanks.
