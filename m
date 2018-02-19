Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932067AbeBSVIQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 16:08:16 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1JL6oqT065680
        for <linux-integrity@vger.kernel.org>; Mon, 19 Feb 2018 16:08:16 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g82bes9qp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Feb 2018 16:08:15 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 19 Feb 2018 21:08:13 -0000
Subject: Re: [PATCH v2] tpm: fix intermittent failure with self tests
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org
Date: Mon, 19 Feb 2018 16:08:10 -0500
In-Reply-To: <1519044991.4721.7.camel@HansenPartnership.com>
References: <1518813108.4419.3.camel@HansenPartnership.com>
         <20180219123244.ucno7eaqupwko6ff@linux.intel.com>
         <1519044991.4721.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519074490.3736.27.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-19 at 07:56 -0500, James Bottomley wrote:
> On Mon, 2018-02-19 at 14:32 +0200, Jarkko Sakkinen wrote:
> > Trying to figure out how this was never merged. Sorry about that.
> > I'll take the blame from this :-( I'll test this commit ASAP.
> 
> Actually, could you test v3 (just posted).  Also, I'm going to have
> someone run v3 on another failing TPM today (the ST Micro) so I should
> get a tested-by as well if it works.

Yes, with v3 the TPM successfully initializes, before IMA, on the pi
from a cold boot.

I assume you'll clean up the patch description and comment in
tpm_transmit_check(), before upstreaming this patch.

Mimi
