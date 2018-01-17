Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752855AbeAQRPO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jan 2018 12:15:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0HHCuSo131817
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jan 2018 12:15:14 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fj7633bju-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jan 2018 12:15:13 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 17 Jan 2018 17:15:11 -0000
Subject: Re: [RFC][PATCH 8/9] tpm_tis_spi: add delay between wait state
 retries
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        kgold@linux.vnet.ibm.com, linux-integrity@vger.kernel.org
Date: Wed, 17 Jan 2018 12:15:06 -0500
In-Reply-To: <1516055450.6607.91.camel@linux.vnet.ibm.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
         <20171208184658.9588-9-Alexander.Steffen@infineon.com>
         <1515700018.3420.13.camel@linux.vnet.ibm.com>
         <db63c75f-464d-2fbc-3e97-ea3ef162cea5@infineon.com>
         <1516055450.6607.91.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516209306.5820.19.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-01-15 at 17:30 -0500, Mimi Zohar wrote:
> > What would be a better implementation? No delay and simply retry for 
> > five seconds?
> > 
> > What TPMs are you using for your tests? At least for the TPMs that I 
> > have available for my tests (with a FIFO size of ~256 bytes) I would not 
> > expect any wait states for extend commands.
> 
> The TPM burstcount is 32.  Unfortunately, with this patch set the
> performance on the pi is worse than without it.  Without this patch
> set we're seeing ~14 secs for a thousand measurements vs. either ~38s
> or ~23s, depending on the wait sleep length introduced in patch 8/9.

>From my response, it might not have been clear that with all of the
patches, except this one 8/9 calling tpm_msleep(), the performance is
equivalent to without any of the patches.  With this patch set, but
with or without the call to tpm_msleep(), it loops 2 or 3 times.

Mimi
