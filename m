Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F3C004D3
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 16:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C81E207DD
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 16:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="K+WeRseR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C81E207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Hansenpartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJYAfd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:35:33 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49946 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbeJYAfd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Oct 2018 20:35:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F0AB38EE0FC;
        Wed, 24 Oct 2018 09:06:52 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QmoEv6C9gI3l; Wed, 24 Oct 2018 09:06:52 -0700 (PDT)
Received: from [10.101.222.185] (unknown [185.7.230.216])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 830CF8EE055;
        Wed, 24 Oct 2018 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540397212;
        bh=vlbraZYIwag2CUzIZ3wbHSehFsI75ODXekpaBuf884s=;
        h=In-Reply-To:References:Subject:From:Date:To:CC:From;
        b=K+WeRseRITgmCRCm+VisxIAHUkhScA9D9ivzluxPmmwqiNrkr19JXUnQb73besIcB
         KmfE8wJyPWFaO7AX1QlyGGAsXpFXyVq1vWFXfngNR9QbCb87wDq2ujUXVPm8r4QM5Z
         K1hwLR/WSySGiyrKBF7GBZEm/N+ME2E66ictS/vQ=
User-Agent: K-9 Mail for Android
In-Reply-To: <777e08e7-c461-2d46-5226-7838b6d48488@huawei.com>
References: <alpine.LRH.2.21.1810160946210.2779@namei.org> <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com> <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com> <20181011154847.GA5978@mail.hallyn.com> <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com> <1539296304.3108.54.camel@HansenPartnership.com> <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1> <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com> <alpine.LRH.2.21.1810160833560.14147@namei.org> <1539642523.2867.44.camel@HansenPartnership.com> <1369.1540301956@warthog.procyon.org.uk> <alpine.DEB.2.21.1810241144410.3525@jsakkine-mobl1> <1540371542.3008.29.camel@HansenPartnership.com> <alpine.DEB.2.21.1810241823400.6725@jsakkine-mobl1> <777e08e7-c461-2d46-5226-7838b6d48488@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: LPC 2018
From:   James Bottomley <James.Bottomley@Hansenpartnership.com>
Date:   Wed, 24 Oct 2018 17:05:13 +0100
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>, montywiseman32@gmail.com,
        serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Message-ID: <5fed750f-4d0a-4257-9626-0c2025bfec4e@email.android.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On October 24, 2018 4:54:14 PM GMT, Roberto Sassu <roberto.sassu@huawei.com> wrote:
>Hi everyone
>
>is it possible to attend the session today? I can get a badge only
>tomorrow.

Yes, you can turn up without a badge.  If the conference Minders won't let you in ask to talk to the lf staff and they'll let you in.

James

>Thanks
>
>Roberto
>
>
>On 10/24/2018 4:27 PM, Jarkko Sakkinen wrote:
>> 
>> 
>> On Wed, 24 Oct 2018, James Bottomley wrote:
>> 
>>> On Wed, 2018-10-24 at 11:45 +0300, Jarkko Sakkinen wrote:
>>>> On Tue, 23 Oct 2018, David Howells wrote:
>>>>> James Morris <jmorris@namei.org> wrote:
>>>>>
>>>>>>> I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think
>>>>>>> you have
>>>>>>> a Wednesday overlap, though, so Wednesday would work.
>>>>>>
>>>>>> LSS is Thurs+Fri, but we may have a quorum for Weds.
>>>>>
>>>>> I'm getting to Edinburgh tomorrow, so I wouldn't be available
>>>>> before 3pm.
>>>>>
>>>>> Btw, will there be networking available to be used during
>speaking?
>>>>>
>>>>> David
>>>>>
>>>>
>>>> Just arrived to the airport. Pick a time. For me any time after 3PM
>>>> should work.
>>>
>>> OK, let's say 18:00 in the Moffat room level -2 of the convention
>>> centre.
>>>
>>> James
>>>
>>>
>> 
>> Phew, I did not get to my room before 3PM so I was worried that you
>had
>> already started (only now got my shit unpacked etc.) :-)
>> 
>> BTW, I really like the solution for the HMAC channel. That's why I'm
>> shooting for the details. Yesterday I somehow managed to miss the
>patch
>> that exposes the name to the user space. That probably explains the
>odd
>> question I had when I was intervening your and Ken's discussion.
>> 
>> /Jarkko


-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
