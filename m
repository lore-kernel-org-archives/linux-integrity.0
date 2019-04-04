Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B2CC4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 22:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65580217D4
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 22:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IZlhdnPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfDDWSw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:18:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39774 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbfDDWSw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 18:18:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5EAE58EE12C;
        Thu,  4 Apr 2019 15:18:51 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pSxU1Ayvd7ZA; Thu,  4 Apr 2019 15:18:51 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D3ACF8EE03B;
        Thu,  4 Apr 2019 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1554416331;
        bh=rjAp81pykkHRrfJPhJ/5u7S21HR4Ib2c9LrZdzbG7XE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IZlhdnPDp73Mx1Si0FpsLnjYa0VM+3gJhzGkDvDBj6UtnUMjUy0SNWYtdTr3NQiR4
         f2TsuyERReqwkqr1nOucZDHoQUedGLZNulBl2DEd/8+qBzuR3hysoOUJQvbLt3bJ8i
         yE2UKMnsUH16vHXsYwX5mjXGEPjhJdVXK7vGnHXY=
Message-ID: <1554416328.24612.11.camel@HansenPartnership.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Date:   Thu, 04 Apr 2019 15:18:48 -0700
In-Reply-To: <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-04 at 14:46 -0700, Matthew Garrett wrote:
> On Thu, Mar 7, 2019 at 2:41 PM Matthew Garrett <mjg59@google.com>
> wrote:
> > Yup, happy to get further feedback on this.
> 
> Anyone other than me and Mimi with thoughts here? :)

The obvious other thought is integration with fs-verity, which is a
filesystem maintained possibly signed merkel tree hash.  The problem
here is what does vfs_get_hash() actually mean?  The assumption seems
to be that it is the flat hash of the entire file which doesn't work
for merkle trees.  However, if it could be a representative hash of the
file which is produced however the filesystem decides, it could work
(well, unless the file is copied on to a different fs, of course ...).

James

