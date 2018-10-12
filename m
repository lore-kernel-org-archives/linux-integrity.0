Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728830AbeJLWi5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Oct 2018 18:38:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CExVwX100672
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 11:06:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n2w2t2dtg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 11:06:01 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 12 Oct 2018 09:05:59 -0600
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
From: James Bottomley <jejb@linux.ibm.com>
To: Denis Kenzior <denkenz@gmail.com>, ndesaulniers@google.com,
        dhowells@redhat.com
Cc: natechancellor@gmail.com, ebiggers@google.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 12 Oct 2018 08:05:51 -0700
In-Reply-To: <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
         <20181011203126.15338-1-ndesaulniers@google.com>
         <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539356751.2656.5.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-10-12 at 07:29 -0500, Denis Kenzior wrote:
> Hi Nick,
> 
> > @@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest,
> > const unsigned char *key,
> >    */
> >   static int TSS_authhmac(unsigned char *digest, const unsigned
> > char *key,
> >   			unsigned int keylen, unsigned char *h1,
> > -			unsigned char *h2, unsigned char h3, ...)
> > +			unsigned char h2, unsigned char *h3, ...)
> >   {
> >   	unsigned char paramdigest[SHA1_DIGEST_SIZE];
> >   	struct sdesc *sdesc;
> 
> So my concern here is that this actually breaks the natural argument 
> order compared to what the specification uses.  This in turn
> requires 
> one to perform some mental gymnastics and I'm not sure that this is
> such 
> a good idea.  Refer to 
> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Main-Part-3-
> Commands_v1.2_rev116_01032011.pdf 
> for details.
> 
> Note that H3 is really the 'continueAuthSession' variable which is a 
> bool.  In the above specification BOOL has a size of 1, and
> TSS_authhmac already assigns a h3 to 'c' which is used for the actual
> hashing.
> 
> So can't we simply use 'bool' or uint32 as the type for h3 instead
> of re-ordering everything

The problem is the standard is ambiguious.  The only thing that's
guaranteed to work for all time is a char *.  If you want to keep the
order, what I'd suggest is inserting a dummy pointer argument which is
always expected to be NULL between the h3 and the varargs.

James
