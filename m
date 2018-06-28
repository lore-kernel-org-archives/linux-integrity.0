Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:47030 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934400AbeF1Uuz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jun 2018 16:50:55 -0400
Received: by mail-qt0-f196.google.com with SMTP id h5-v6so6018664qtm.13
        for <linux-integrity@vger.kernel.org>; Thu, 28 Jun 2018 13:50:55 -0700 (PDT)
Date: Thu, 28 Jun 2018 23:50:51 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthias Gerstner <mgerstner@suse.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] integrity: prevent deadlock during digsig verification.
Message-ID: <20180628235051.10151b04@totoro>
In-Reply-To: <1530213278.3366.47.camel@linux.vnet.ibm.com>
References: <20180627163342.3e1d6333@totoro>
        <20180628163900.GD8003@f195.suse.de>
        <1530213278.3366.47.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Thu, 28 Jun 2018 15:14:38 -0400
Mimi Zohar <zohar@linux.vnet.ibm.com> ?????:

> On Thu, 2018-06-28 at 18:39 +0200, Matthias Gerstner wrote:
> > Hi,
> >   
> > > In this patch, I propose add an exception for
> > > "crypto-pkcs1pad(rsa,*)" module requests only in case of enabled
> > > integrity asymmetric keys support.  
> > 
> > I have tested the patch in my test setup and it looks good. No
> > deadlocks so far.  
> 
> I really wish we didn't have to do a string compare "crypto-
> pkcs1pad(rsa" each and every time.  Is the check once per crypto
> algorithm?

As I understood, it check once per crypto algorithm:

"crypto_alloc_tfm() will first attempt to locate an already loaded
algorithm.
...
If that fails it will send a query to any loaded crypto manager to
construct an algorithm on the fly.
A refcount is grabbed on the algorithm which is then associated with
the new transform."

https://github.com/torvalds/linux/blob/a97d8efd9d350bd9c6cf13689c7cc09049b42acd/crypto/api.c#L515

-- 
Best regards,
Mikhail Kurinnoi
