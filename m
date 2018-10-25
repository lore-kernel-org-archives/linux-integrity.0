Return-Path: <SRS0=GfCd=NF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B98BC46475
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Oct 2018 07:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C1E20834
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Oct 2018 07:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C1E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeJYPqN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:46:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:23987 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbeJYPqN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Oct 2018 11:46:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 00:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,423,1534834800"; 
   d="scan'208";a="84015098"
Received: from sakethyx-mobl2.gar.corp.intel.com ([10.249.254.29])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2018 00:14:41 -0700
Date:   Thu, 25 Oct 2018 09:14:39 +0200 (CEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Monty Wiseman <montywiseman32@gmail.com>
cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>, serge@hallyn.com,
        chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: LSS-EU BoF(s) (renamed from LPC 2018)
In-Reply-To: <305bc8a7-876f-f1d3-9076-1a5b9c3daca3@gmail.com>
Message-ID: <alpine.DEB.2.21.1810250913220.3636@jsakkine-mobl1>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com> <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com> <20181011154847.GA5978@mail.hallyn.com> <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com> <1539296304.3108.54.camel@HansenPartnership.com>
 <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1> <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com> <alpine.LRH.2.21.1810160833560.14147@namei.org> <1539642523.2867.44.camel@HansenPartnership.com> <alpine.LRH.2.21.1810160946210.2779@namei.org>
 <1539691005.11939.258.camel@linux.ibm.com> <alpine.DEB.2.21.1810180301090.5022@jsakkine-mobl1> <7831fac7-40ba-a3e8-61c8-166a54cfe515@linux.ibm.com> <alpine.DEB.2.21.1810231616200.19836@jsakkine-mobl1> <1540301465.2787.4.camel@HansenPartnership.com>
 <1540301816.5583.187.camel@linux.ibm.com> <305bc8a7-876f-f1d3-9076-1a5b9c3daca3@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-393910550-1540451685=:3636"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-393910550-1540451685=:3636
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 24 Oct 2018, Monty Wiseman wrote:
> On 10/23/18 9:36 AM, Mimi Zohar wrote:
>> On Tue, 2018-10-23 at 14:31 +0100, James Bottomley wrote:
>>> On Tue, 2018-10-23 at 16:16 +0300, Jarkko Sakkinen wrote:
>>>> How can I join given that I have only ticket to LSS not to the
>>>> summit?
>>> According to Angela, the badges aren't a problem (they'll let you in)
>>> and I can have the the conference staff get us a room up to about 9pm
>>> tomorrow (although we'll have to start after the regular sessions end
>>> at 6pm).
>>> 
>>> However, we need to pick a time so they can allocate us the room.
>> Ok, let's try and define an agenda of what needs to be discussed. The
>> original discussion started out by Chuck wanting to get together and
>> discuss IMA on distributed filesystems at LPC, and Monty chiming in
>> about IMA format.
>> 
>> It seems the discussion has diverged and is now about having a TPM BoF
>> the evening before LSS-EU, for those not staying for LSS. Let's try
>> and put together an agenda.  Do we need/want another BoF for IMA?
>>   Should that be Thurs evening?
>
> There are 2 high level topics. While they are related they can happen 
> independently.
>
> 1> Changing the TPM driver's tpm_pcr_extend interface to support algorithm 
> agility for IMA (and other kernel services)
>
> 2> Changes to IMA
>
> I believe all the stakeholders for #1 will be here through Friday. If that's 
> the case, let's move that topic to Thursday PM and focus tonight (Wednesday) 
> on IMA. I'll let others break that topic down further if necessary.
>
> Monty
>
>> 
>> Mimi
>> 
>

I might come today little late to get my slides done (at the time of
the first coffee break). Does anyone happpen to have USB-C display
adapter? I forgot take my own with.

/Jarkko
--8323329-393910550-1540451685=:3636--
