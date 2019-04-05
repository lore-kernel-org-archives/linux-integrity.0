Return-Path: <SRS0=mqgK=SH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5D3C4360F
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 02:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A73217D4
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 02:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="B3AOLhuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDEC1A (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:27:00 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43052 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727562AbfDEC07 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 22:26:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EA59A8EE12C;
        Thu,  4 Apr 2019 19:26:58 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2kEOmOe2yif6; Thu,  4 Apr 2019 19:26:58 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6F6408EE03B;
        Thu,  4 Apr 2019 19:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554431218;
        bh=D7DaMyQLcbHmnAuDjNcn7dd37LClpnAIgslLXPsuQus=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B3AOLhuhrQCwY/yF2VvKjsEwvTu966aP6I8vpTqgHf5MqUkppU5YU7OuyCvmcFK95
         RVQLmaXTlQtwuDIOnEUsNWWhLcjrknpZ0kNK7W9byiGxq3rbX3iyIl8gGC6+OlWCRJ
         9v82NoTJucd7g+9/oXy/9ZWdbbEV5mw46yK6Kt9s=
Message-ID: <1554431217.24612.37.camel@HansenPartnership.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Date:   Thu, 04 Apr 2019 19:26:57 -0700
In-Reply-To: <CACdnJuutKe+i8KLUmPWjbFOWfrO2FzYVPjYZGgEatFmZWkw=UA@mail.gmail.com>
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
         <1554417315.24612.15.camel@HansenPartnership.com>
         <CACdnJuutKe+i8KLUmPWjbFOWfrO2FzYVPjYZGgEatFmZWkw=UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-04 at 18:50 -0700, Matthew Garrett wrote:
> On Thu, Apr 4, 2019 at 3:35 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > Redundant information is always possible, but it can become
> > inconsistent and, because the hashes can't be derived from each
> > other, it's hard to tell if it is inconsistent without redoing the
> > whole hash with each method.
> 
> Part of the problem here is that IMA is effectively used for two
> related but different purposes - measurement and appraisal. You
> generally want measurements to be comparable across filesystems,
> whereas appraisal doesn't need to be.

Sure, but I think the only requirement for measurement is knowing how
to reproduce them.  As long as you know the algorithm the filesystem is
using ... i.e. it's recorded in the IMA log, you should be able to
verify them.

>  So if we don't have comparable measurements, there's less benefit in
> performing measurement (we have no real idea what the expected
> measurements would be in advance).

As long as the algorithm used for the measurement is recorded, I don't
think there's a problem.  The IMA log currently records the hash
algorithm and the actual hash, so if we take shaX to be a flat hash, we
could use shaX-merkle for fs-verity and everything would work.

> That's less important for appraisal, but arguably we don't care about
> appraisal of stuff on fs-verity backed filesystems to begin with
> because we can just attest that they're legitimate?

I think Ted mentioned they did like to sign the merkle tree to prove
the apk being installed was legitimate, so I think both measurement and
appraisal are relevant.

> > I was more wondering what, if any, problems would follow if we did
> > let the filesystem choose the hash method and simply used the top
> > merkle hash in place of the usual IMA hash?
> 
> We could definitely just pass it through as a separate hash type, and
> my initial thinking was that fs-verity might be a reasonable use case
> for that, but I'm not sure that it buys us much in the IMA case.

Unifying the interfaces for measurement and appraisal sounds like a
desirable thing.  IMA has just been debating measurement on mmap and
the per-page hashes of fs-verity seem to be tailor made for this.

Note: I'm not insisting on this, you just asked for other feedback and
I think it's a useful discussion.

James

