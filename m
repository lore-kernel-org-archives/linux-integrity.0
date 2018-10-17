Return-Path: <SRS0=91Is=M5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A909EECDE3E
	for <linux-integrity@archiver.kernel.org>; Wed, 17 Oct 2018 23:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507EF208E4
	for <linux-integrity@archiver.kernel.org>; Wed, 17 Oct 2018 23:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OLT5R7uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507EF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJRHqJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:46:09 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58760 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbeJRHqJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Oct 2018 03:46:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 524818EE2BB;
        Wed, 17 Oct 2018 16:48:02 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uTiJa6QwPRwh; Wed, 17 Oct 2018 16:48:02 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A3D158EE0D2;
        Wed, 17 Oct 2018 16:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539820082;
        bh=kSEozmVfqaNQn7Bh7JkxJz2hpv3zF3tyNq/BoX4OjCs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OLT5R7uZhUMFnk2ipnzZxjrOrI49hJY2y0A5oeUnZR7uC3V9cuYLEQxT8ujx3WcdT
         dTY8s4lNSX5c6xM6/hnj8ExAkoTo4XoNS2pQxn9nRnsimSlUU0Myg5LNWgRoCzm+wo
         pYiC+M5a+DINjc5OlmgwcLoFvF7YHjHAqcp25RDU=
Message-ID: <1539820080.2736.0.camel@HansenPartnership.com>
Subject: Re: LPC 2018
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>
Cc:     Matthew Garrett <mjg59@google.com>, montywiseman32@gmail.com,
        serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Wed, 17 Oct 2018 16:48:00 -0700
In-Reply-To: <alpine.DEB.2.21.1810180246040.5022@jsakkine-mobl1>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
         <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
         <20181011154847.GA5978@mail.hallyn.com>
         <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
         <1539296304.3108.54.camel@HansenPartnership.com>
         <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>
         <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
         <alpine.LRH.2.21.1810160833560.14147@namei.org>
         <alpine.DEB.2.21.1810180246040.5022@jsakkine-mobl1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2018-10-18 at 02:47 +0300, Jarkko Sakkinen wrote:
> On Tue, 16 Oct 2018, James Morris wrote:
> > On Mon, 15 Oct 2018, Matthew Garrett wrote:
> > 
> > > I'll also be there all week
> > 
> > ~rimshot~
> > 
> > 
> > > and I'll be talking about some of the work we're doing with IMA
> > > and the
> > > approaches we're taking for network filesystems - definitely
> > > happy to
> > > chat to people about that and some of the TPM work we're doing.
> > 
> > What about a TPM BoF at LSS?
> 
> Would not be a bad idea at least for the topic that I interested to
> resolve (TPM-kernel secure channel).

Re-rolling those patches is on my list.  Right at the moment I'm
working on coupling it to TPM attestation.

James

