Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751750AbeF1V1z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jun 2018 17:27:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SLO0Sv011994
        for <linux-integrity@vger.kernel.org>; Thu, 28 Jun 2018 17:27:54 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jw7b48njy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Jun 2018 17:27:54 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 28 Jun 2018 22:27:52 +0100
Subject: Re: [PATCH] integrity: prevent deadlock during digsig verification.
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Mikhail Kurinnoi <viewizard@viewizard.com>
Cc: Matthias Gerstner <mgerstner@suse.de>,
        linux-integrity@vger.kernel.org
Date: Thu, 28 Jun 2018 17:27:47 -0400
In-Reply-To: <20180628235051.10151b04@totoro>
References: <20180627163342.3e1d6333@totoro>
         <20180628163900.GD8003@f195.suse.de>
         <1530213278.3366.47.camel@linux.vnet.ibm.com>
         <20180628235051.10151b04@totoro>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530221267.3366.69.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-06-28 at 23:50 +0300, Mikhail Kurinnoi wrote:
> ? Thu, 28 Jun 2018 15:14:38 -0400
> Mimi Zohar <zohar@linux.vnet.ibm.com> ?????:
> 
> > On Thu, 2018-06-28 at 18:39 +0200, Matthias Gerstner wrote:
> > > Hi,
> > >   
> > > > In this patch, I propose add an exception for
> > > > "crypto-pkcs1pad(rsa,*)" module requests only in case of enabled
> > > > integrity asymmetric keys support.  
> > > 
> > > I have tested the patch in my test setup and it looks good. No
> > > deadlocks so far.  
> > 
> > I really wish we didn't have to do a string compare "crypto-
> > pkcs1pad(rsa" each and every time.  Is the check once per crypto
> > algorithm?
> 
> As I understood, it check once per crypto algorithm:
> 
> "crypto_alloc_tfm() will first attempt to locate an already loaded
> algorithm.
> ...
> If that fails it will send a query to any loaded crypto manager to
> construct an algorithm on the fly.
> A refcount is grabbed on the algorithm which is then associated with
> the new transform."
> 
> https://github.com/torvalds/linux/blob/a97d8efd9d350bd9c6cf13689c7cc09049b42acd/crypto/api.c#L515

After having loaded "all" the crypto algorithms, we wouldn't need to
ever do the string compare again.  As this isn't on a critical path,
nor is it likely for all crypto algorithms to be loaded, it probably
doesn't make sense to address it.

Mimi
