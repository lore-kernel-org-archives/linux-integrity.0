Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D16EC004D3
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 15:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03561207DD
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 15:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03561207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJXXzw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:55:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:35328 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJXXzw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Oct 2018 19:55:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 08:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="243999383"
Received: from pwolsza-mobl1.ger.corp.intel.com ([10.249.254.37])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2018 08:27:15 -0700
Date:   Wed, 24 Oct 2018 18:27:14 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>, montywiseman32@gmail.com,
        serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: LPC 2018
In-Reply-To: <1540371542.3008.29.camel@HansenPartnership.com>
Message-ID: <alpine.DEB.2.21.1810241823400.6725@jsakkine-mobl1>
References: <alpine.LRH.2.21.1810160946210.2779@namei.org>  <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>  <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>  <20181011154847.GA5978@mail.hallyn.com>  <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com> 
 <1539296304.3108.54.camel@HansenPartnership.com>  <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>  <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>  <alpine.LRH.2.21.1810160833560.14147@namei.org>  <1539642523.2867.44.camel@HansenPartnership.com>
  <1369.1540301956@warthog.procyon.org.uk>  <alpine.DEB.2.21.1810241144410.3525@jsakkine-mobl1> <1540371542.3008.29.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On Wed, 24 Oct 2018, James Bottomley wrote:

> On Wed, 2018-10-24 at 11:45 +0300, Jarkko Sakkinen wrote:
>> On Tue, 23 Oct 2018, David Howells wrote:
>>> James Morris <jmorris@namei.org> wrote:
>>>
>>>>> I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think
>>>>> you have
>>>>> a Wednesday overlap, though, so Wednesday would work.
>>>>
>>>> LSS is Thurs+Fri, but we may have a quorum for Weds.
>>>
>>> I'm getting to Edinburgh tomorrow, so I wouldn't be available
>>> before 3pm.
>>>
>>> Btw, will there be networking available to be used during speaking?
>>>
>>> David
>>>
>>
>> Just arrived to the airport. Pick a time. For me any time after 3PM
>> should work.
>
> OK, let's say 18:00 in the Moffat room level -2 of the convention
> centre.
>
> James
>
>

Phew, I did not get to my room before 3PM so I was worried that you had
already started (only now got my shit unpacked etc.) :-)

BTW, I really like the solution for the HMAC channel. That's why I'm
shooting for the details. Yesterday I somehow managed to miss the patch
that exposes the name to the user space. That probably explains the odd
question I had when I was intervening your and Ken's discussion.

/Jarkko
