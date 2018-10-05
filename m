Return-Path: <SRS0=SAWj=MR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED449C00449
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Oct 2018 16:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5067208E7
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Oct 2018 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTh+WuhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5067208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeJEX4x (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEX4x (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 19:56:53 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733B720834;
        Fri,  5 Oct 2018 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538758639;
        bh=vDFi4ZDuPYvrTcZmQnuGfeceao45STPBn6/AanRPc6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTh+WuhIKuI0uQ+aEFcQdgd1LuZIFefBfeinNt9SYixnB+I7rbqc1bQKhgphBMEVg
         GK+kYZNOaQTZcPB7xbT6Uz9Cz81xoMkDqpMr/k84qQtUskCh2aGHo183ALzeKzD4FH
         uQUAwhehkf17WlX1Vwsi5pAuf87ScjrS1xy97eZ4=
Date:   Fri, 5 Oct 2018 09:57:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH v2] ima: fix showing large 'violations' or
 'runtime_measurements_count'
Message-ID: <20181005165717.GA153200@gmail.com>
References: <20181004000106.153693-1-ebiggers@kernel.org>
 <1538691695.3702.361.camel@linux.ibm.com>
 <20181004222853.GA95899@gmail.com>
 <1538746254.3541.7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1538746254.3541.7.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181005165718.tRUbnIhwBoto8yi4rIbQB5mP-LTPQSmX6Mm0zABgdo4@z>

On Fri, Oct 05, 2018 at 09:30:54AM -0400, Mimi Zohar wrote:
> On Thu, 2018-10-04 at 15:28 -0700, Eric Biggers wrote:
> > On Thu, Oct 04, 2018 at 06:21:35PM -0400, Mimi Zohar wrote:
> > > On Wed, 2018-10-03 at 17:01 -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > The 12 character temporary buffer is not necessarily long enough to hold
> > > > a 'long' value.  Increase it.
> > > > 
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > ---
> > > >  security/integrity/ima/ima_fs.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> > > > index ae9d5c766a3ce..4b50fe9c18edd 100644
> > > > --- a/security/integrity/ima/ima_fs.c
> > > > +++ b/security/integrity/ima/ima_fs.c
> > > > @@ -42,14 +42,15 @@ static int __init default_canonical_fmt_setup(char *str)
> > > >  __setup("ima_canonical_fmt", default_canonical_fmt_setup);
> > > > 
> > > >  static int valid_policy = 1;
> > > > -#define TMPBUFLEN 12
> > > > +
> > > >  static ssize_t ima_show_htable_value(char __user *buf, size_t count,
> > > >  				     loff_t *ppos, atomic_long_t *val)
> > > >  {
> > > > -	char tmpbuf[TMPBUFLEN];
> > > > +	/* temporary buffer that is plenty long enough */
> 
> This comment is useless.
> 
> > > > +	char tmpbuf[32];
> 
> char tmpbuf[32];	/* string size needed for largest long value */
> 
> > > 
> > > If the maximum value of long is 9,223,372,036,854,775,807, the largest
> > > string needed to represent this value is 20 characters.  Should 32 be
> > > hardcoded like this?
> > 
> > There's no real cost to overestimating slightly here, and it's better than
> > trying to count exactly and getting it wrong (hint: it's actually more than 20
> > characters).
> 
> Please explain how it is more than 20 characters.
> 
> Mimi
> 

sizeof("-9223372036854775808\n") == 22.

Yes the comment is pretty useless, that's why I didn't want to have a comment;
but you requested one.  Personally, I'm not very interested in arguing about the
wording of an unnecessary comment (especially when your suggested wording is
misleading) and having to explain how to count characters in a string.  So just
FYI, I won't be sending any more versions of this patch; if you don't like
either of the versions I've sent, please just write your own.

- Eric
