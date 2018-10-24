Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A550C004D3
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 08:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48D12081B
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 08:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48D12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeJXRMy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:12:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:4585 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeJXRMy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Oct 2018 13:12:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 01:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="80492725"
Received: from sakethyx-mobl2.gar.corp.intel.com ([10.249.254.29])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2018 01:45:39 -0700
Date:   Wed, 24 Oct 2018 11:45:37 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     David Howells <dhowells@redhat.com>
cc:     James Morris <jmorris@namei.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        montywiseman32@gmail.com, serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: LPC 2018
In-Reply-To: <1369.1540301956@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.21.1810241144410.3525@jsakkine-mobl1>
References: <alpine.LRH.2.21.1810160946210.2779@namei.org> <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com> <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com> <20181011154847.GA5978@mail.hallyn.com> <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
 <1539296304.3108.54.camel@HansenPartnership.com> <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1> <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com> <alpine.LRH.2.21.1810160833560.14147@namei.org> <1539642523.2867.44.camel@HansenPartnership.com>
 <1369.1540301956@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 23 Oct 2018, David Howells wrote:
> James Morris <jmorris@namei.org> wrote:
>
>>> I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think you have
>>> a Wednesday overlap, though, so Wednesday would work.
>>
>> LSS is Thurs+Fri, but we may have a quorum for Weds.
>
> I'm getting to Edinburgh tomorrow, so I wouldn't be available before 3pm.
>
> Btw, will there be networking available to be used during speaking?
>
> David
>
Just arrived to the airport. Pick a time. For me any time after 3PM
should work.

/Jarkko
