Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751986AbeA1Rwx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jan 2018 12:52:53 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0SHmeCd138821
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jan 2018 12:52:53 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fs8060p55-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jan 2018 12:52:52 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 28 Jan 2018 17:52:50 -0000
Subject: Re: [PATCH] ima-evm-utils: Add backward compatible support for
 openssl 1.1
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Date: Sun, 28 Jan 2018 12:52:47 -0500
In-Reply-To: <1517161157.3082.41.camel@HansenPartnership.com>
References: <1517157665.3082.17.camel@HansenPartnership.com>
         <1517161157.3082.41.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517161967.29187.262.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2018-01-28 at 09:39 -0800, James Bottomley wrote:
> On Sun, 2018-01-28 at 08:41 -0800, James Bottomley wrote:
> > Openssl 1.1 is really annoying in that it made certain objects opaque
> > and added accessors for the necessary components, but these accessors
> > often don't exist in 1.0 and before, so there's no way to create
> > clean code that will compile with both 1.0 and 1.1; instead you have
> > to compiled with both code bases to make sure everything is working.
> > 
> > The other problem is that since the structures are opaque, their size
> > isn't known, so having a structure declared as a variable is no
> > longer possible.
> > 
> > This change switches all uses of EVP_MD_CTX to be pointers
> > initialised with the correct EVP_MD_CTX_new() (not available in 1.0),
> > does the same for HMAC_CTX, and uses the 1.1 only primitive
> > RSA_get0_key() to extract the public modulus and exponent from an RSA
> > key.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com
> > >
> > Tested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> OK, let me try that again without the line breaks.

Definitely a lot better.

Mimi
