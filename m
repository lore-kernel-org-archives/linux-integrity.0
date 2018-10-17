Return-Path: <SRS0=91Is=M5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52308ECDE3D
	for <linux-integrity@archiver.kernel.org>; Wed, 17 Oct 2018 23:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102832145D
	for <linux-integrity@archiver.kernel.org>; Wed, 17 Oct 2018 23:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102832145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeJRHra (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:47:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:18387 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbeJRHr3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Oct 2018 03:47:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 16:49:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82317682"
Received: from unknown (HELO jsakkine-mobl1) ([10.249.254.40])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2018 16:49:18 -0700
Date:   Thu, 18 Oct 2018 02:49:17 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        montywiseman32@gmail.com, serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: LPC 2018
In-Reply-To: <1539642523.2867.44.camel@HansenPartnership.com>
Message-ID: <alpine.DEB.2.21.1810180247390.5022@jsakkine-mobl1>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>  <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>  <20181011154847.GA5978@mail.hallyn.com>  <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>  <1539296304.3108.54.camel@HansenPartnership.com> 
 <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>  <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>  <alpine.LRH.2.21.1810160833560.14147@namei.org> <1539642523.2867.44.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 15 Oct 2018, James Bottomley wrote:
> On Tue, 2018-10-16 at 08:35 +1100, James Morris wrote:
>> On Mon, 15 Oct 2018, Matthew Garrett wrote:
>>
>>> I'll also be there all week
>>
>> ~rimshot~
>>
>>
>>> and I'll be talking about some of the work we're doing with IMA and
>>> the approaches we're taking for network filesystems - definitely
>>> happy to chat to people about that and some of the TPM work we're
>>> doing.
>>
>> What about a TPM BoF at LSS
>
> I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think you have
> a Wednesday overlap, though, so Wednesday would work.
>
> James

LSS starts on 25th.

/Jarkko
