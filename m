Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751776AbeCWN0F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Mar 2018 09:26:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2NDPwkJ057529
        for <linux-integrity@vger.kernel.org>; Fri, 23 Mar 2018 09:26:04 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gvybegx2s-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 23 Mar 2018 09:26:04 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 23 Mar 2018 13:26:02 -0000
Subject: Re: [PATCH v2 0/2] ima: Fallback to the builtin hash algorithm
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Fri, 23 Mar 2018 09:25:58 -0400
In-Reply-To: <20180323105442.nyolkydmggw2uvlx@dell5510>
References: <20180322144313.28748-1-pvorel@suse.cz>
         <1521747535.3848.273.camel@linux.vnet.ibm.com>
         <20180323105442.nyolkydmggw2uvlx@dell5510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521811558.3575.21.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-03-23 at 11:54 +0100, Petr Vorel wrote:
> Hello Mimi,
> 
> > Agreed, the previous version was simpler/better.  My complaint with
> > the previous version was that there was an error message, but
> > continued without any indication of how it was resolved.  Changing the
> > message in ima_init_crypto() is one solution, but adding an additional
> > message works too. Would this work for you?
> 
> > @@ -73,6 +73,8 @@ int __init ima_init_crypto(void)
> >                        hash_algo_name[ima_hash_algo], rc);
> >                 return rc;
> >         }
> > +       pr_info("Allocated default hash algorithm: %s\n",
> > +                hash_algo_name[ima_hash_algo]);
> >         return 0;
> >  }
> Well, this is not correct, as if you specify correct (i.e. buildin) non default algorithm, it's said to
> be the default. e.g. ima_hash=md5
> [    2.161089] ima: Allocated default hash algorithm: md5
> Just a detail, but why not be precise?
> Going to post a version which fixes that having a message in ima_init_crypto().

Oh, I see your point!  If a file is signed, the measurement list will
contain the file hash based on the file signature's hash algorithm.
"default", in this case, refers to the hash algorithm for unsigned
files.

Thank you for making the message clearer, less ambiguous.

Mimi
