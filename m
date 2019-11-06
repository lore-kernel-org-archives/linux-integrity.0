Return-Path: <SRS0=mDd2=Y6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FC2C5DF63
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Nov 2019 19:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54BB2075C
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Nov 2019 19:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AhnKNEvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfKFTHy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:07:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38516 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfKFTHy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 14:07:54 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 82BE720B7192
        for <linux-integrity@vger.kernel.org>; Wed,  6 Nov 2019 11:07:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82BE720B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573067273;
        bh=wnMKg1XryLmSQG3VaJvJW5BP4hdtFdn0UBJ5xSEx6d4=;
        h=To:From:Subject:Date:From;
        b=AhnKNEvIb3GOx/veoCOSQ0GiZ7vsUhdDBiIqfaDjfAMvpff2RyU8+z9m6URlrq0f+
         HVbQlx77VFqHPwgksWuDKeCLEO9p6pSS8688hGTlvqMVXc1/MibM6C+g82GT3/bxD3
         UmX82Q+iv28kdXyxHNIueoOFqFdyDIAXW7c/H6eE=
To:     linux-integrity@vger.kernel.org
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Mail to David Howells @ redhat bounced
Message-ID: <01af8d01-30ef-c4e2-ab16-5d660a060fd5@linux.microsoft.com>
Date:   Wed, 6 Nov 2019 11:07:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'd copied David Howells on a patch set related to key measurement. The 
mail bounced:

David Howells <dhowells@redhat.com>

<dhowells@redhat.com>: Host or domain name not found. Name service error for
     name=int-mx-nasa.corp.redhat.com type=A: Host not found

Please let me know his current email address.

thanks,
  -lakshmi



