Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751826AbdJ3Sfc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 14:35:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9UIYrZl051996
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 14:35:31 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dx94ch3cf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 14:35:31 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Mon, 30 Oct 2017 14:35:30 -0400
Subject: Re: Proposal: rename tpm1_eventlog.c and tpm2_eventlog.c
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20171024222148.gwnkj5vqsyj43qer@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Tue, 31 Oct 2017 00:04:59 +0530
MIME-Version: 1.0
In-Reply-To: <20171024222148.gwnkj5vqsyj43qer@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6d3c18e4-6033-be6f-5783-fa36e7bbbd86@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 10/25/2017 03:51 AM, Jarkko Sakkinen wrote:
> I noticed when making slides for KS that the naming for event log stuff
> that the naming is so broken that it is hard to understand the code.
> Here it really would make sense to have a patch set just to clean up the
> cruft.
>
> Random examples of more senseful naming:
>
> * tpm2_bios_measurements_start() should be rather something like
>    tpm_eventlog_seq_agile_start().
> * tpm_bios_measurements_start() should be rather something like
>    tpm_eventlog_seq_sha1_start().
BIOS eventlog being exposed as securityfs files are named as
ascii_bios_measurements and binary_bios_measurements.
I thought that the function names were originally written corresponding
to the files they write into. In that context, I didn't find them 
misleading.

Still if we want to rename, I think having tpm_eventlog_seq_sha1_start() for
TPM1.2 might be confusing as even TPM2.0 supports SHA1. And there might
be systems which use only SHA1 even in the case of TPM2.0. I was 
thinking if
we can just call them as tpm2_eventlog_seq_start() and 
tpm1_eventlog_seq_start().
> Corresponding structs would be tpm_eventlog_agile_seq_ops and
> tpm_eventlog_sha1_seq_ops.
>
> Finally, I would place the file operations, being so complicated, in
> separate files:
>
> * tpm_eventlog_seq_sha1.c
> * tpm_eventlog_seq_eventlog.c
>
> And move all the management code that is right now illogically located
> in tpm1_eventlog.c to tpm_eventlog.c that would be the entry point for
> the event log.
By management code, do you mean the functions common to both TPM1.2 and 
TPM2.0 as:

tpm_bios_measurements_open()
tpm_read_log()
tpm_bios_log_setup()
tpm_bios_log_teardown()

So, do you mean to move these to tpm_eventlog.c and keep only specific 
functions in
tpm1_eventlog.c and tpm2_eventlog.c ? If so, then yeah I also agree with 
this.

Thanks & Regards,
    - Nayna
> The code is laid out so badly right now that I have really hard time
> understanding it if I haven't looked at it within last couple of weeks.
> It's really a trainwreck at the moment. We must clean up it up fast.
>
> Getting this done will help me to review patches to this area faster
> so it would be a benefit for everyone. The current structure makes every
> event log patch a pain to review.
>
> /Jarkko
>
