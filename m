Return-Path: <SRS0=MMpd=ND=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D521C46475
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Oct 2018 13:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B46207DD
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Oct 2018 13:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B46207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJWVkT (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:40:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:26485 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWVkT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Oct 2018 17:40:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 06:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,416,1534834800"; 
   d="scan'208";a="243641397"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.111])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 06:16:49 -0700
Date:   Tue, 23 Oct 2018 16:16:48 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Nayna Jain <nayna@linux.ibm.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>, montywiseman32@gmail.com,
        serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: LPC 2018
In-Reply-To: <7831fac7-40ba-a3e8-61c8-166a54cfe515@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1810231616200.19836@jsakkine-mobl1>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com> <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com> <20181011154847.GA5978@mail.hallyn.com> <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com> <1539296304.3108.54.camel@HansenPartnership.com>
 <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1> <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com> <alpine.LRH.2.21.1810160833560.14147@namei.org> <1539642523.2867.44.camel@HansenPartnership.com> <alpine.LRH.2.21.1810160946210.2779@namei.org>
 <1539691005.11939.258.camel@linux.ibm.com> <alpine.DEB.2.21.1810180301090.5022@jsakkine-mobl1> <7831fac7-40ba-a3e8-61c8-166a54cfe515@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1566704368-1540300613=:19836"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1566704368-1540300613=:19836
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Sat, 20 Oct 2018, Nayna Jain wrote:

>
>
> On 10/18/2018 05:35 AM, Jarkko Sakkinen wrote:
>> On Tue, 16 Oct 2018, Mimi Zohar wrote:
>>> On Tue, 2018-10-16 at 09:46 +1100, James Morris wrote:
>>>> On Mon, 15 Oct 2018, James Bottomley wrote:
>>>> 
>>>>>> What about a TPM BoF at LSS
>>>>> 
>>>>> I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think you have
>>>>> a Wednesday overlap, though, so Wednesday would work.
>>>> 
>>>> LSS is Thurs+Fri, but we may have a quorum for Weds.
>>> 
>>> Some of us are arriving Wed.  Perhaps try scheduling it later in the
>>> day Wed.
>>> 
>>> Mimi
>> 
>> Yeah, could be possible (also arriving that day). Do not really care if
>> we talk about the same stuff that I want to talk in my presentation
>> (namely channel encryption). I was thinking to talk about it as an 
>> introduction to the topic but this way around I could summarize the
>> BoF.
>> 
>> I hope the time is late as possible though on Wed.
>> 
>> /Jarkko
>
> Do we have a time finalized to meet on Wednesday ? I will also be joining.
>
> Thanks & Regards,
>     - Nayna
>
>

How can I join given that I have only ticket to LSS not to the summit?


/Jarkko
--8323329-1566704368-1540300613=:19836--
