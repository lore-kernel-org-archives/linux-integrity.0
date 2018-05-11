Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751163AbeEKUFu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 May 2018 16:05:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4BK3gcW035776
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 16:05:49 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hwgj1b7ra-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 16:05:49 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 11 May 2018 21:05:47 +0100
Subject: Re: [PATCH V4 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 11 May 2018 16:05:44 -0400
In-Reply-To: <CACdnJutj9oKqOX7UBXWbD+CpdL3Ed77=evN1gutRsZK1VWtYzQ@mail.gmail.com>
References: <20180509202811.29875-1-mjg59@google.com>
         <20180509202811.29875-2-mjg59@google.com>
         <1526013718.3414.32.camel@linux.vnet.ibm.com>
         <CACdnJutj9oKqOX7UBXWbD+CpdL3Ed77=evN1gutRsZK1VWtYzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526069144.3559.9.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-05-11 at 12:51 -0700, Matthew Garrett wrote:

> > Should "evm_xattrs" be defined directly in the securityfs directory or
> > in a subdirectory similar to ima?  It will be difficult later on to
> > move "evm_xattrs" to a subdirectory once applications start
> > reading/writing to it.  What would the subdirectory be called?
> 
> Yeah, that's tricky - the obvious directory would be evm, but that's
> already in use. integrity makes sense, but then ima should also be under it.

I haven't tried, but maybe we could use softlinks (eg.
<securityfs>/ima ==> <securityfs>/integrity/ima)?

And then there are namespaces ...

Mimi
