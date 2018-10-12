Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728804AbeJLWzq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Oct 2018 18:55:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CFKsHm049567
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 11:22:47 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n2vcxw01u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 11:22:47 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 12 Oct 2018 09:22:46 -0600
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
Date: Fri, 12 Oct 2018 08:22:39 -0700
In-Reply-To: <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
         <20181011203126.15338-1-ndesaulniers@google.com>
         <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
         <1539356751.2656.5.camel@linux.ibm.com>
         <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539357759.2656.7.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-10-12 at 10:13 -0500, Denis Kenzior wrote:
> Hi James,
> 
> > > So can't we simply use 'bool' or uint32 as the type for h3
> > > instead of re-ordering everything
> > 
> > The problem is the standard is ambiguious.  The only thing that's
> > guaranteed to work for all time is a char *.  If you want to keep
> > the order, what I'd suggest is inserting a dummy pointer argument
> > which is always expected to be NULL between the h3 and the varargs.
> 
> So maybe I'm misunderstanding something, but the issue seems to be
> that unsigned char is promoted to 'unsigned char *' by Clang and
> probably unsigned int or int by gcc.
> 
> So instead of having unsigned char h3, can't we simply have bool h3
> or unsigned int h3?

Given the ambiguity in the standards, the safe thing that will work for
all time and all potential compilers is a char *

James
