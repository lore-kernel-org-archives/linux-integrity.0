Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935477AbeFMNud (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jun 2018 09:50:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DDo2p3072743
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jun 2018 09:50:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jk2skdfjv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jun 2018 09:50:32 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 14:50:30 +0100
Subject: Re: [PATCH V3 1/2] evm: Don't deadlock if a crypto algorithm is
 unavailable
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net
Date: Wed, 13 Jun 2018 09:50:13 -0400
In-Reply-To: <20180613063303.ftphuca3bagwx3dk@gondor.apana.org.au>
References: <20180608215743.224253-1-mjg59@google.com>
         <20180608215743.224253-2-mjg59@google.com>
         <20180613063303.ftphuca3bagwx3dk@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1528897813.3880.4.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-06-13 at 14:33 +0800, Herbert Xu wrote:
> On Fri, Jun 08, 2018 at 02:57:42PM -0700, Matthew Garrett wrote:
> > When EVM attempts to appraise a file signed with a crypto algorithm the
> > kernel doesn't have support for, it will cause the kernel to trigger a
> > module load. If the EVM policy includes appraisal of kernel modules this
> > will in turn call back into EVM - since EVM is holding a lock until the
> > crypto initialisation is complete, this triggers a deadlock. Add a
> > CRYPTO_NOLOAD flag and skip module loading if it's set, and add that flag
> > in the EVM case in order to fail gracefully with an error message
> > instead of deadlocking.
> > 
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks!  This patch and "evm: Allow non-SHA1 digital signatures" are
now queued in the next-integrity-queued branch.

Mimi
