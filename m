Return-Path: <SRS0=uwT9=B3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF02C433E1
	for <linux-integrity@archiver.kernel.org>; Mon, 17 Aug 2020 20:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C00B2072D
	for <linux-integrity@archiver.kernel.org>; Mon, 17 Aug 2020 20:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qJLxntGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgHQUCG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:02:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33380 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgHQUCF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 16:02:05 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B3EC120B4908;
        Mon, 17 Aug 2020 13:02:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3EC120B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597694524;
        bh=2kp5ghcCRtPQbyIOLyk13l3Yu40CQWzri5r/ljwsKFI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qJLxntGY2OBmUXuS9DE9TZ1ZeZ092XacdCovENDukXqHHICp1STvVr5gd3P+UV39a
         +iWdeupLAIUUvtyJUXauD8cEY6+zO8foXTTPi9Cjm8ooDHwvKuCzTu7pZi8vbH3zEI
         gX1AvW3zwmS5CnVh4HuvPZPM7C6uYZiBhg5qgL/w=
Subject: Re: [PATCH v3 0/4] IMA: verify measurement of certificate imported
 into a keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        ltp@lists.linux.it
Cc:     linux-integrity@vger.kernel.org
References: <20200817130916.27634-1-pvorel@suse.cz>
 <bc89bf8e0c40e6d66c86b42f55f9bf69ec7e335e.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <cdf45ba0-287b-8fa1-d067-1c6c4f386939@linux.microsoft.com>
Date:   Mon, 17 Aug 2020 13:02:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bc89bf8e0c40e6d66c86b42f55f9bf69ec7e335e.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/17/20 12:18 PM, Mimi Zohar wrote:

> On Mon, 2020-08-17 at 15:09 +0200, Petr Vorel wrote:
>> Hi Mimi, Lakshmi,
>>
>> changes v2->v3:
>> fixed regression in my third commit.
>> (please verify it on installed LTP, or at least run make install in
>> testcases/kernel/security/integrity/ima/datafiles/ima_keys/)
> 
> I did, but nothing changed.  I probably need to set an environment
> variable.
> 
> After building and installing LTP, it's finding the file, but some of
> the issues still exist:
> 
> ima_keys 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> ima_keys 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
> ima_keys 1 TINFO: verify key measurement for keyrings and templates specified in IMA policy
> grep: Unmatched ( or \(
> ima_keys 1 TPASS: specified keyrings were measured correctly
> ima_keys 2 TINFO: verify measurement of certificate imported into a keyring
> keyctl_session_to_parent: Operation not permitted
> ima_keys 2 TPASS: logged certificate matches the original
> 
> IMA policy:
> measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
> measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
> 

I think I see the problem

keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
		sed "s/\./\\\./g" | cut -d'=' -f2; done | sort -u

The above line generates the list of keyrings (read from the IMA policy) 
with a newline after the first policy entry with "keyrings=". Please see 
below:

ima_keys 1 TINFO: \.ima|\.builtin_trusted_keys
key_import_test

When this is checked in the "do-done" loop grep returns "mismatched (" 
due to the newline.

I tried with "(" removed from the following line and that fixes the problem:

grep -E "($templates)*($keyrings)" $ASCII_MEASUREMENTS | while read line

But a better fix might be to remove the "newline" in $keyrings. I'll try 
that.

Regarding the following error:
keyctl_session_to_parent: Operation not permitted

The following line in test2() can be removed. Not sure if this is needed.
	keyctl new_session > /dev/null

thanks,
  -lakshmi
