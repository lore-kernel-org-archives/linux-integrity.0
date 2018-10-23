Return-Path: <SRS0=MMpd=ND=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CC5C46475
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Oct 2018 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C96A207DD
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Oct 2018 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iUOchUn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C96A207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeJWWLR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:11:17 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36020 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726953AbeJWWLR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Oct 2018 18:11:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 265348EE0FC;
        Tue, 23 Oct 2018 06:47:45 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i6aXmiHBOQJu; Tue, 23 Oct 2018 06:47:44 -0700 (PDT)
Received: from [10.101.217.208] (unknown [185.7.230.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 53D218EE0D5;
        Tue, 23 Oct 2018 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540302464;
        bh=d34rsOcLy6Ig9YXNEZLodAf3iDwYaaa+JnImK0ra0RY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iUOchUn9HrouYaSW7qcqqSyt+4x5HOIC64JYJYmbiXp+MAFTWM0SJ57kymEDhogYA
         XICxGc7PPafT42Y5PNSxWbm7+O4ZYs3JuyitvtTHBMweZT+gefQZl/vKZhfcQVmI6Q
         3FKngX7asUaci02zN/Ezf+uJ8ZlAL3/GstlaR6AI=
Message-ID: <1540302461.2787.6.camel@HansenPartnership.com>
Subject: Re: LPC 2018
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        montywiseman32@gmail.com, serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Tue, 23 Oct 2018 14:47:41 +0100
In-Reply-To: <1369.1540301956@warthog.procyon.org.uk>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2018-10-23 at 14:39 +0100, David Howells wrote:
> James Morris <jmorris@namei.org> wrote:
> 
> > > I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think you
> > > have a Wednesday overlap, though, so Wednesday would work.
> > 
> > LSS is Thurs+Fri, but we may have a quorum for Weds.
> 
> I'm getting to Edinburgh tomorrow, so I wouldn't be available before
> 3pm.

I think to get a room it has to be after 6pm, so that's no problem.

> Btw, will there be networking available to be used during speaking?

You mean wired?  Not that I noticed but they might have if you ask
nicely.  The wifi seems to be functional.

James

