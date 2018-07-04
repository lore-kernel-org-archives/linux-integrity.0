Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932745AbeGDMKY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jul 2018 08:10:24 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64C9UqM026336
        for <linux-integrity@vger.kernel.org>; Wed, 4 Jul 2018 08:10:22 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0utenhqg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 04 Jul 2018 08:10:22 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 13:10:19 +0100
Subject: Re: [PATCH] ima: Use tpm_default_chip() and call TPM functions with
 a tpm_chip
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Wed, 04 Jul 2018 08:10:03 -0400
In-Reply-To: <1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
References: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
         <1530550839.3709.46.camel@linux.vnet.ibm.com>
         <1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530706203.3452.74.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-07-03 at 19:32 +0300, Jarkko Sakkinen wrote:
> On Mon, 2018-07-02 at 13:00 -0400, Mimi Zohar wrote:
> > On Mon, 2018-07-02 at 11:24 -0400, Stefan Berger wrote:
> > > Rather than accessing the TPM functions by passing a NULL pointer for
> > > the tpm_chip, which causes a lookup for a suitable chip every time, get a
> > > hold of a tpm_chip and access the TPM functions using it. Also get rid of
> > > the ima_used_chip variable and use the new ima_tpm_chip variable instead
> > > for determining whether to call TPM functions.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > 
> > Jarkko, would you mind staging this patch with the rest of the patch
> > set?
> 
> Yes, sure, I can do that. Any additional tag?

Thanks, just these.

Mimi
