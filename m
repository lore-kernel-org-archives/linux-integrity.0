Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727076AbeI0UCh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Sep 2018 16:02:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RDfJv8043157
        for <linux-integrity@vger.kernel.org>; Thu, 27 Sep 2018 09:44:16 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ms00v168h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Sep 2018 09:44:16 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 27 Sep 2018 14:44:14 +0100
Subject: Re: [PATCH v2, RESEND 0/3] tpm: retrieve digest size of unknown
 algorithms from TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Safford <david.safford@ge.com>
Date: Thu, 27 Sep 2018 09:43:59 -0400
In-Reply-To: <8bbff5b1-f4ba-4e38-57fc-05d9ddabea5c@huawei.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
         <1537972840.3459.6.camel@linux.ibm.com>
         <1537985014.3459.24.camel@linux.ibm.com>
         <8bbff5b1-f4ba-4e38-57fc-05d9ddabea5c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538055839.3459.114.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-09-27 at 08:50 +0200, Roberto Sassu wrote:
> On 9/26/2018 8:03 PM, Mimi Zohar wrote:

> > Roberto, a similar change needs to be made for tpm_pcr_extend.  Are
> > you planning on posting those changes as well?
> 
> Yes, I was planning to send the patch after this patch set is accepted.

Great!

Mimi
