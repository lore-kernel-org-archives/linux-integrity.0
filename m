Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751740AbeAZOvR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jan 2018 09:51:17 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0QEp73t084419
        for <linux-integrity@vger.kernel.org>; Fri, 26 Jan 2018 09:51:17 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fr48cnkex-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 26 Jan 2018 09:51:13 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 26 Jan 2018 14:50:03 -0000
Subject: Hidden TPM questions in the LTP IMA posts
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>
Date: Fri, 26 Jan 2018 09:49:59 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516978199.29187.43.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Jarkko,

There are a few TPM questions for the fixing the IMA Linux Test
Program (LTP) tests:

- The maximum size of the TPM 1.2 event record is unspecified.  What
is the expected maximum size?
- Is there a way of knowing the location of the TPM 1.2 PCRs without
grepping for them?

Additional question:
- Are the TPM 2.0 PCRs and event log exported by the kernel?  If not,
how are they accessed?

thanks,

Mimi
