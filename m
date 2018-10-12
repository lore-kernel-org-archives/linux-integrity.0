Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729251AbeJLXeg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Oct 2018 19:34:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CG0IAG114632
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 12:01:25 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n2w0dcv61-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 12:01:25 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 12 Oct 2018 10:01:23 -0600
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
Date: Fri, 12 Oct 2018 09:01:15 -0700
In-Reply-To: <da2a675f-bd2d-a1f3-6a67-5579e75bdb76@gmail.com>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
         <20181011203126.15338-1-ndesaulniers@google.com>
         <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
         <1539356751.2656.5.camel@linux.ibm.com>
         <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
         <1539357759.2656.7.camel@linux.ibm.com>
         <16de2bb3-815a-f534-4618-af854c906017@gmail.com>
         <1539359181.2656.13.camel@linux.ibm.com>
         <da2a675f-bd2d-a1f3-6a67-5579e75bdb76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539360075.2656.18.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-10-12 at 10:53 -0500, Denis Kenzior wrote:
> Hi James,
> 
> > >   From the links provided in the patch it seems that one cannot
> > > pass char/float/short to va_start().  Fair enough.  So if we make
> > > h3 an unsigned int, the issue goes away, no?
> > 
> > For the current version of clang, yes.  However, if we're fixing
> > this for good a char * pointer is the only guaranteed thing because
> > it mirrors current use in printf.
> > 
> 
> All right.  I guess I wasn't aware that non-printf like variadic 
> functions are now considered harmful or of the impending crusade
> against them :)

It's not, it's just a maintainer issue: The original problem is because
we coded for gcc specifically; it doesn't complain and does the right
thing, so everyone was happy.  Now Clang comes along and is unhappy
with this, so the question a good maintainer should ask is "how do I
fix this so it never comes back again?", not "what's the easiest
bandaid to get both Clang and gcc to work?" because the latter is how
we got here in the first place.

James

> But in the context of this patch, can we please use something less 
> invasive than changing all the arguments around?  Promoting h3 to a
> bool (if possible) or int/unsigned int would get my vote.
> 
> Regards,
> -Denis
> 
