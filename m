Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753086AbeF1TOp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jun 2018 15:14:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SJDgRl138283
        for <linux-integrity@vger.kernel.org>; Thu, 28 Jun 2018 15:14:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jw2ehha9j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Jun 2018 15:14:44 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 28 Jun 2018 20:14:42 +0100
Subject: Re: [PATCH] integrity: prevent deadlock during digsig verification.
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthias Gerstner <mgerstner@suse.de>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Cc: linux-integrity@vger.kernel.org
Date: Thu, 28 Jun 2018 15:14:38 -0400
In-Reply-To: <20180628163900.GD8003@f195.suse.de>
References: <20180627163342.3e1d6333@totoro>
         <20180628163900.GD8003@f195.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530213278.3366.47.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-06-28 at 18:39 +0200, Matthias Gerstner wrote:
> Hi,
> 
> > In this patch, I propose add an exception for "crypto-pkcs1pad(rsa,*)"
> > module requests only in case of enabled integrity asymmetric keys support.
> 
> I have tested the patch in my test setup and it looks good. No deadlocks
> so far.

I really wish we didn't have to do a string compare "crypto-
pkcs1pad(rsa" each and every time.  Is the check once per crypto
algorithm?

Mimi
