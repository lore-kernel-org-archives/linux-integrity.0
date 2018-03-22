Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751674AbeCVTjD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 15:39:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2MJOCIS068815
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 15:39:02 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gvf89hrbc-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 15:39:02 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 22 Mar 2018 19:39:00 -0000
Subject: Re: [PATCH v2 0/2] ima: Fallback to the builtin hash algorithm
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 22 Mar 2018 15:38:55 -0400
In-Reply-To: <20180322144313.28748-1-pvorel@suse.cz>
References: <20180322144313.28748-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521747535.3848.273.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-22 at 15:43 +0100, Petr Vorel wrote:
> Hello Mimi,
> 
> Changes v1->v2:
> * Move loading buildin hash algorithm to ima_init_crypto() (as requested)
> * Add crypto_alloc_shash() (DRY)
> 
> [1]:
> > The first call to ima_init() emits an error, but we continue without
> > any further messages.  If the change was in ima_init_crypto(), the
> > error message could indicate the resolution.
> I cannot say I like v2 as change in ima_init_crypto() requires more
> changes due updating ima_hash_algo. IMHO v1 with added simple error
> message would be better.  I probably didn't understand what exactly you
> wanted to log in ima_init_crypto(). Am I missing something?

Agreed, the previous version was simpler/better.  My complaint with
the previous version was that there was an error message, but
continued without any indication of how it was resolved.  Changing the
message in ima_init_crypto() is one solution, but adding an additional
message works too. Would this work for you?

@@ -73,6 +73,8 @@ int __init ima_init_crypto(void)
                       hash_algo_name[ima_hash_algo], rc);
                return rc;
        }
+       pr_info("Allocated default hash algorithm: %s\n",
+                hash_algo_name[ima_hash_algo]);
        return 0;
 }

Mimi

> If you like this version, you may want to squash it into single commit.
> 
> Kind regards,
> Petr
> 
> [1]: https://marc.info/?l=linux-integrity&m=152155002608419&w=2
> 
> Petr Vorel (2):
>   ima: Introduce ima_alloc_alg() to reduce duplicity
>   ima: Fallback to the builtin hash algorithm
> 
>  security/integrity/ima/ima.h        |  1 +
>  security/integrity/ima/ima_crypto.c | 58 +++++++++++++++++++++++++++----------
>  security/integrity/ima/ima_main.c   | 26 ++---------------
>  3 files changed, 47 insertions(+), 38 deletions(-)
> 
