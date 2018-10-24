Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A9C67863
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 08:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC4B2082E
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 08:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="vo5CNEDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC4B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJXR0U (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:26:20 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45352 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbeJXR0U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Oct 2018 13:26:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CD9FD8EE0FC;
        Wed, 24 Oct 2018 01:59:05 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xPhLnyPNVCv2; Wed, 24 Oct 2018 01:59:05 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 281EC8EE055;
        Wed, 24 Oct 2018 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540371545;
        bh=WfjGGnCI0C9sNrPzBbO59YwUP8YDr5dD2diYfkNkzuc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vo5CNEDAl7zawXAOrAViibcNBf7uROzFMoVh6aoIhlBGZmdjk4E/xi0x3XOga1loy
         9CjwIczJdp9cgARaALY9hOBdmKYBHxaEgAHgiZ5kZljJ7lBnQusk58y9l25yLWj9Ug
         z6JGqan4jgLDuYxco+x4WF//kg/i4sqCxJ0dC+IQ=
Message-ID: <1540371542.3008.29.camel@HansenPartnership.com>
Subject: Re: LPC 2018
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>, montywiseman32@gmail.com,
        serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Wed, 24 Oct 2018 09:59:02 +0100
In-Reply-To: <alpine.DEB.2.21.1810241144410.3525@jsakkine-mobl1>
References: <alpine.LRH.2.21.1810160946210.2779@namei.org>
         <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
         <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
         <20181011154847.GA5978@mail.hallyn.com>
         <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
         <1539296304.3108.54.camel@HansenPartnership.com>
         <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>
         <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
         <alpine.LRH.2.21.1810160833560.14147@namei.org>
         <1539642523.2867.44.camel@HansenPartnership.com>
         <1369.1540301956@warthog.procyon.org.uk>
         <alpine.DEB.2.21.1810241144410.3525@jsakkine-mobl1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-10-24 at 11:45 +0300, Jarkko Sakkinen wrote:
> On Tue, 23 Oct 2018, David Howells wrote:
> > James Morris <jmorris@namei.org> wrote:
> > 
> > > > I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think
> > > > you have
> > > > a Wednesday overlap, though, so Wednesday would work.
> > > 
> > > LSS is Thurs+Fri, but we may have a quorum for Weds.
> > 
> > I'm getting to Edinburgh tomorrow, so I wouldn't be available
> > before 3pm.
> > 
> > Btw, will there be networking available to be used during speaking?
> > 
> > David
> > 
> 
> Just arrived to the airport. Pick a time. For me any time after 3PM
> should work.

OK, let's say 18:00 in the Moffat room level -2 of the convention
centre.

James

