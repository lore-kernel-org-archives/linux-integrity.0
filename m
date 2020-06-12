Return-Path: <SRS0=hFkr=7Z=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7F3C433E1
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347B320723
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VnnOl8MD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFLTuR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:50:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60316 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgFLTuP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 15:50:15 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B356C205DDAF;
        Fri, 12 Jun 2020 12:50:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B356C205DDAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591991414;
        bh=GdD9+kQ9aITh+TAeiBW5btAMPcCymvbqsDCBMG9pDJY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VnnOl8MDm+ruzYyoWNTT6EMXTeW1KeweCnFkTcpwagJQWqkhh3u2nYF34qqGdvPBo
         aKpmwhEtVxIJ52SRseNK4B+wSrg34/L38VYKHNrJKNIGKH9mAEuhek8tb571EKHoaS
         LUA0x4yXrn6jiMXz029ksb3O+OHqmzVjEI6yk2LE=
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
To:     Mimi Zohar <zohar@linux.ibm.com>, sgrubb@redhat.com,
        paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
 <1591989920.11061.90.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <42482562-d74c-2678-069f-1d8ef4feffac@linux.microsoft.com>
Date:   Fri, 12 Jun 2020 12:50:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591989920.11061.90.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/12/20 12:25 PM, Mimi Zohar wrote:

> The idea is a good idea, but you're assuming that "result" is always
> errno.  That was probably true originally, but isn't now.  For
> example, ima_appraise_measurement() calls xattr_verify(), which
> compares the security.ima hash with the calculated file hash.  On
> failure, it returns the result of memcmp().  Each and every code path
> will need to be checked.
> 

Good catch Mimi.

Instead of "errno" should we just use "result" and log the value given 
in the result parameter?

 From the audit field dictionary (link given below) "result" is already 
a known field that is used to indicate the result of the audited operation.

@Steve\Paul:
Like "res" is "result" also expected to have only values "0" or "1", or 
can it be any result code?

https://github.com/linux-audit/audit-documentation/blob/master/specs/fields/field-dictionary.csv

res 	alphanumeric 	result of the audited operation(success/fail) 	

result 	alphanumeric 	result of the audited operation(success/fail)

thanks,
  -lakshmi
