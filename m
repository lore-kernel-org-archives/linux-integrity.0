Return-Path: <SRS0=MMpd=ND=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30875C46475
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Oct 2018 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EAD20665
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Oct 2018 13:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IUZ28944"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EAD20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJWVyk (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:54:40 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35814 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726953AbeJWVyk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Oct 2018 17:54:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6BCF78EE0FC;
        Tue, 23 Oct 2018 06:31:11 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uitMdJ3dop2d; Tue, 23 Oct 2018 06:31:11 -0700 (PDT)
Received: from [10.101.217.208] (unknown [185.7.230.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7C51F8EE0D5;
        Tue, 23 Oct 2018 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540301471;
        bh=NfpDCr4oTIAoUXsSGACHnzYwYaOb7cuFDCZd7DglAdc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IUZ28944wdiR52kdsun0uBFH8O8d752eLsp2Gv//PwSA8sOlhjK10tahaQPXCcb1z
         zorLVHJwrdgT7rQHqBNb7m0Xl2/aLEM7HMpBl4QoxizVkjuul9zct0j1NKzG9qKS4n
         wUuw9hCjD9cCkDjqf8ctQ8K16doF9UreYtu5+ek0=
Message-ID: <1540301465.2787.4.camel@HansenPartnership.com>
Subject: Re: LPC 2018
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>, montywiseman32@gmail.com,
        serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Tue, 23 Oct 2018 14:31:05 +0100
In-Reply-To: <alpine.DEB.2.21.1810231616200.19836@jsakkine-mobl1>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
         <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
         <20181011154847.GA5978@mail.hallyn.com>
         <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
         <1539296304.3108.54.camel@HansenPartnership.com>
         <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>
         <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
         <alpine.LRH.2.21.1810160833560.14147@namei.org>
         <1539642523.2867.44.camel@HansenPartnership.com>
         <alpine.LRH.2.21.1810160946210.2779@namei.org>
         <1539691005.11939.258.camel@linux.ibm.com>
         <alpine.DEB.2.21.1810180301090.5022@jsakkine-mobl1>
         <7831fac7-40ba-a3e8-61c8-166a54cfe515@linux.ibm.com>
         <alpine.DEB.2.21.1810231616200.19836@jsakkine-mobl1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2018-10-23 at 16:16 +0300, Jarkko Sakkinen wrote:
> 
> On Sat, 20 Oct 2018, Nayna Jain wrote:
> 
> > 
> > 
> > On 10/18/2018 05:35 AM, Jarkko Sakkinen wrote:
> > > On Tue, 16 Oct 2018, Mimi Zohar wrote:
> > > > On Tue, 2018-10-16 at 09:46 +1100, James Morris wrote:
> > > > > On Mon, 15 Oct 2018, James Bottomley wrote:
> > > > > 
> > > > > > > What about a TPM BoF at LSS
> > > > > > 
> > > > > > I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I
> > > > > > think you have a Wednesday overlap, though, so Wednesday
> > > > > > would work.
> > > > > 
> > > > > LSS is Thurs+Fri, but we may have a quorum for Weds.
> > > > 
> > > > Some of us are arriving Wed.  Perhaps try scheduling it later
> > > > in the day Wed.
> > > > 
> > > > Mimi
> > > 
> > > Yeah, could be possible (also arriving that day). Do not really
> > > care if we talk about the same stuff that I want to talk in my
> > > presentation (namely channel encryption). I was thinking to talk
> > > about it as an introduction to the topic but this way around I
> > > could summarize the BoF.
> > > 
> > > I hope the time is late as possible though on Wed.
> > > 
> > > /Jarkko
> > 
> > Do we have a time finalized to meet on Wednesday ? I will also be
> > joining.
> > 
> > Thanks & Regards,
> >     - Nayna
> > 
> > 
> 
> How can I join given that I have only ticket to LSS not to the
> summit?

According to Angela, the badges aren't a problem (they'll let you in)
and I can have the the conference staff get us a room up to about 9pm
tomorrow (although we'll have to start after the regular sessions end
at 6pm).

However, we need to pick a time so they can allocate us the room.

James
