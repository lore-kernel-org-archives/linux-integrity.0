Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727701AbeJEU35 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 16:29:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95DSgdP071615
        for <linux-integrity@vger.kernel.org>; Fri, 5 Oct 2018 09:31:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mx863tnru-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 05 Oct 2018 09:31:12 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 5 Oct 2018 14:31:10 +0100
Subject: Re: [PATCH v2] ima: fix showing large 'violations' or
 'runtime_measurements_count'
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Fri, 05 Oct 2018 09:30:54 -0400
In-Reply-To: <20181004222853.GA95899@gmail.com>
References: <20181004000106.153693-1-ebiggers@kernel.org>
         <1538691695.3702.361.camel@linux.ibm.com>
         <20181004222853.GA95899@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538746254.3541.7.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-10-04 at 15:28 -0700, Eric Biggers wrote:
> On Thu, Oct 04, 2018 at 06:21:35PM -0400, Mimi Zohar wrote:
> > On Wed, 2018-10-03 at 17:01 -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > The 12 character temporary buffer is not necessarily long enough to hold
> > > a 'long' value.  Increase it.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > >  security/integrity/ima/ima_fs.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> > > index ae9d5c766a3ce..4b50fe9c18edd 100644
> > > --- a/security/integrity/ima/ima_fs.c
> > > +++ b/security/integrity/ima/ima_fs.c
> > > @@ -42,14 +42,15 @@ static int __init default_canonical_fmt_setup(char *str)
> > >  __setup("ima_canonical_fmt", default_canonical_fmt_setup);
> > > 
> > >  static int valid_policy = 1;
> > > -#define TMPBUFLEN 12
> > > +
> > >  static ssize_t ima_show_htable_value(char __user *buf, size_t count,
> > >  				     loff_t *ppos, atomic_long_t *val)
> > >  {
> > > -	char tmpbuf[TMPBUFLEN];
> > > +	/* temporary buffer that is plenty long enough */

This comment is useless.

> > > +	char tmpbuf[32];

char tmpbuf[32];	/* string size needed for largest long value */

> > 
> > If the maximum value of long is 9,223,372,036,854,775,807, the largest
> > string needed to represent this value is 20 characters.  Should 32 be
> > hardcoded like this?
> 
> There's no real cost to overestimating slightly here, and it's better than
> trying to count exactly and getting it wrong (hint: it's actually more than 20
> characters).

Please explain how it is more than 20 characters.

Mimi
