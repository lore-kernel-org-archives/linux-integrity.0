Return-Path: <SRS0=MMpd=ND=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AB4C46475
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Oct 2018 13:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7132075D
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Oct 2018 13:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7132075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeJWWCu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:02:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24921 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbeJWWCt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Oct 2018 18:02:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE1373002957;
        Tue, 23 Oct 2018 13:39:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A18D709F2;
        Tue, 23 Oct 2018 13:39:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.LRH.2.21.1810160946210.2779@namei.org>
References: <alpine.LRH.2.21.1810160946210.2779@namei.org> <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com> <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com> <20181011154847.GA5978@mail.hallyn.com> <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com> <1539296304.3108.54.camel@HansenPartnership.com> <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1> <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com> <alpine.LRH.2.21.1810160833560.14147@namei.org> <1539642523.2867.44.camel@HansenPartnership.com>
To:     James Morris <jmorris@namei.org>
Cc:     dhowells@redhat.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        montywiseman32@gmail.com, serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: LPC 2018
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1368.1540301956.1@warthog.procyon.org.uk>
Date:   Tue, 23 Oct 2018 14:39:16 +0100
Message-ID: <1369.1540301956@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 23 Oct 2018 13:39:20 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think you have
> > a Wednesday overlap, though, so Wednesday would work.
> 
> LSS is Thurs+Fri, but we may have a quorum for Weds.

I'm getting to Edinburgh tomorrow, so I wouldn't be available before 3pm.

Btw, will there be networking available to be used during speaking?

David
