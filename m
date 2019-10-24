Return-Path: <SRS0=bSBb=YR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926B0CA9EB9
	for <linux-integrity@archiver.kernel.org>; Thu, 24 Oct 2019 01:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EA12084B
	for <linux-integrity@archiver.kernel.org>; Thu, 24 Oct 2019 01:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pN66PVcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfJXB1u (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:27:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60460 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXB1t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 21:27:49 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3E7BA20F3BC1;
        Wed, 23 Oct 2019 18:27:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E7BA20F3BC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571880469;
        bh=7uKBvl8yiufQLf7daeVfbHD8ZvcsSsW7/pDpL5qUKm8=;
        h=To:From:Subject:Date:From;
        b=pN66PVcxLf8AGC9pt2mSBUkcm2fakbOHtiuJrGyMMAURTqR2FGmtu6AIZBIYAhzuZ
         gXkXFJrz+UBd5vcOJ7wVSlCCNVDIM7gQMUqLg/kSEGzvO3zTD6wgh3cmQt40sebcXI
         r9OCTCnPadqXFmMKr8/2uUNa9l6MV4vHFdypw820=
To:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Measure ima policy
Message-ID: <81e4a3f1-146b-cad2-a868-24a38cfde599@linux.microsoft.com>
Date:   Wed, 23 Oct 2019 18:27:48 -0700
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

Hi Mimi,

Do you know if there is a plan (or, work already in progress) to measure 
the "ima policy" that is currently in effect?

We were thinking it would be a good measurement to have that an 
attestation service can validate.

thanks,
  -lakshmi
