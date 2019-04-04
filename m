Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC796C4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 22:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA10206DF
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 22:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="shWJwrGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfDDWfS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:35:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40048 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728663AbfDDWfS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 18:35:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 058BF8EE12C;
        Thu,  4 Apr 2019 15:35:18 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4TQJgh6GxdO0; Thu,  4 Apr 2019 15:35:17 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 49F9F8EE03B;
        Thu,  4 Apr 2019 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554417317;
        bh=ycrWVojWYW5qVGsTI3+AcoyNU0M0Art4sA+6EfVNh+M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=shWJwrGb/qSUp19mlKd7/ajw6Z0HLNq9L12l23L2NuPFyw9kw0GZ1fupuaMnb7+/k
         DJoewlGR1KmyDxoY7LmkXv2DNemrUOVuKO8jCnRnDXWsRPI/dzx+Kq1B+Rve3YjVcU
         suLbOsimBAFYQicTO0ObpMRpLgI6u3B4/lDnNqEM=
Message-ID: <1554417315.24612.15.camel@HansenPartnership.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Date:   Thu, 04 Apr 2019 15:35:15 -0700
In-Reply-To: <CACdnJutZzJu7FxcLWasyvx9BLQJeGrA=7WA389JL8ixFJ6Skrg@mail.gmail.com>
References: <20190226215034.68772-1-matthewgarrett@google.com>
         <20190226215034.68772-4-matthewgarrett@google.com>
         <1551369834.10911.195.camel@linux.ibm.com>
         <1551377110.10911.202.camel@linux.ibm.com>
         <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
         <1551391154.10911.210.camel@linux.ibm.com>
         <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
         <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
         <1551731553.10911.510.camel@linux.ibm.com>
         <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
         <1551791930.31706.41.camel@linux.ibm.com>
         <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
         <1551815469.31706.132.camel@linux.ibm.com>
         <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
         <1551875418.31706.158.camel@linux.ibm.com>
         <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
         <1551911937.31706.217.camel@linux.ibm.com>
         <CACdnJut9T0xE-Q+ZAfqaRMUeBX=7w+cYE5Y7Ls1PdH-bJfv8MQ@mail.gmail.com>
         <1551923650.31706.258.camel@linux.ibm.com>
         <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
         <1551991690.31706.416.camel@linux.ibm.com>
         <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
         <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com>
         <1554416328.24612.11.camel@HansenPartnership.com>
         <CACdnJutZzJu7FxcLWasyvx9BLQJeGrA=7WA389JL8ixFJ6Skrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-04 at 15:26 -0700, Matthew Garrett wrote:
> On Thu, Apr 4, 2019 at 3:18 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > The obvious other thought is integration with fs-verity, which is a
> > filesystem maintained possibly signed merkel tree hash.  The
> > problem here is what does vfs_get_hash() actually mean?  The
> > assumption seems to be that it is the flat hash of the entire file
> > which doesn't work for merkle trees.  However, if it could be a
> > representative hash of the file which is produced however the
> > filesystem decides, it could work (well, unless the file is copied
> > on to a different fs, of course ...).
> 
> We could always use fs-verity to store additional verifiable metadata
> including actual hashes for consistency?

Redundant information is always possible, but it can become
inconsistent and, because the hashes can't be derived from each other,
it's hard to tell if it is inconsistent without redoing the whole hash
with each method.

I was more wondering what, if any, problems would follow if we did let
the filesystem choose the hash method and simply used the top merkle
hash in place of the usual IMA hash?

James

