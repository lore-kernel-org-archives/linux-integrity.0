Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751943AbeEKCYV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 22:24:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4B2NoR0143224
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 22:24:20 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hw1ug92an-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 22:24:20 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 11 May 2018 03:24:19 +0100
Subject: Re: [PATCH] ima: Remove unused variable ima_initialized
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>, Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org
Date: Thu, 10 May 2018 22:24:15 -0400
In-Reply-To: <alpine.LRH.2.21.1805110406020.1003@namei.org>
References: <20180510151548.7155-1-pvorel@suse.cz>
         <alpine.LRH.2.21.1805110406020.1003@namei.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526005455.3545.15.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-05-11 at 04:06 +1000, James Morris wrote:
> On Thu, 10 May 2018, Petr Vorel wrote:

Commit a756024 ("ima: added ima_policy_flag variable") replaced
ima_initialized with ima_policy_flag, but didn't remove
ima_initialized.  This patch removes it.

> 
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  security/integrity/ima/ima.h      | 1 -
> >  security/integrity/ima/ima_main.c | 7 ++-----
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> 
> Reviewed-by: James Morris <james.morris@microsoft.com>

Thanks.

Mimi
