Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729219AbeJLXTf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Oct 2018 19:19:35 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CFimO3062000
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 11:46:30 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n2v5jxu0h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 11:46:30 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 12 Oct 2018 09:46:29 -0600
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
Date: Fri, 12 Oct 2018 08:46:21 -0700
In-Reply-To: <16de2bb3-815a-f534-4618-af854c906017@gmail.com>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
         <20181011203126.15338-1-ndesaulniers@google.com>
         <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
         <1539356751.2656.5.camel@linux.ibm.com>
         <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
         <1539357759.2656.7.camel@linux.ibm.com>
         <16de2bb3-815a-f534-4618-af854c906017@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539359181.2656.13.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-10-12 at 10:44 -0500, Denis Kenzior wrote:
> Hi James,
> 
> > > So instead of having unsigned char h3, can't we simply have bool
> > > h3 or unsigned int h3?
> > 
> > Given the ambiguity in the standards, the safe thing that will work
> > for all time and all potential compilers is a char *
> > 
> 
> All right.  You state this with certainty, but I'd still like you to 
> educate me why?
> 
>  From the links provided in the patch it seems that one cannot pass 
> char/float/short to va_start().  Fair enough.  So if we make h3 an 
> unsigned int, the issue goes away, no?

For the current version of clang, yes.  However, if we're fixing this
for good a char * pointer is the only guaranteed thing because it
mirrors current use in printf.

James
