Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbeJEFY1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 01:24:27 -0400
Date: Thu, 4 Oct 2018 15:28:54 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH v2] ima: fix showing large 'violations' or
 'runtime_measurements_count'
Message-ID: <20181004222853.GA95899@gmail.com>
References: <20181004000106.153693-1-ebiggers@kernel.org>
 <1538691695.3702.361.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1538691695.3702.361.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 04, 2018 at 06:21:35PM -0400, Mimi Zohar wrote:
> On Wed, 2018-10-03 at 17:01 -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > The 12 character temporary buffer is not necessarily long enough to hold
> > a 'long' value.  Increase it.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  security/integrity/ima/ima_fs.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> > index ae9d5c766a3ce..4b50fe9c18edd 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -42,14 +42,15 @@ static int __init default_canonical_fmt_setup(char *str)
> >  __setup("ima_canonical_fmt", default_canonical_fmt_setup);
> > 
> >  static int valid_policy = 1;
> > -#define TMPBUFLEN 12
> > +
> >  static ssize_t ima_show_htable_value(char __user *buf, size_t count,
> >  				     loff_t *ppos, atomic_long_t *val)
> >  {
> > -	char tmpbuf[TMPBUFLEN];
> > +	/* temporary buffer that is plenty long enough */
> > +	char tmpbuf[32];
> 
> If the maximum value of long is 9,223,372,036,854,775,807, the largest
> string needed to represent this value is 20 characters.  Should 32 be
> hardcoded like this?
> 
> Mimi
> 

There's no real cost to overestimating slightly here, and it's better than
trying to count exactly and getting it wrong (hint: it's actually more than 20
characters).

- Eric
