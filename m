Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751288AbdLEWDT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Dec 2017 17:03:19 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB5Lx38B139960
        for <linux-integrity@vger.kernel.org>; Tue, 5 Dec 2017 17:03:18 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ep2jtufx6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 05 Dec 2017 17:03:18 -0500
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Tue, 5 Dec 2017 17:03:17 -0500
Subject: Re: [PATCH v2 00/15] ima: digest list feature
To: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 17:03:15 -0500
MIME-Version: 1.0
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5060980f-2b70-6b77-89f2-5ef66ff4cace@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/7/2017 5:36 AM, Roberto Sassu wrote:
> 
> Digest lists aim at mitigating these issues. A digest list is a list of
> digests that are taken by IMA as reference measurements and loaded before
> files are accessed. Then, IMA compares calculated digests of accessed files
> with digests from loaded digest lists. If the digest is found, measurement,
> appraisal and audit are not performed.

If you don't do measurements (the extends), then the remote appraiser
can't determine what's running.  Doesn't that break the whole point of 
remote attestation?

> Digest lists address the first issue because the TPM is used only if the
> digest of a measured file is unknown. On a minimal system, 10 of 1400
> measurements are unknown because of mutable files (e.g. log files).
> 
> Digest lists mitigate the second issue because, since digest lists do not
> change, they don't have to be sent at every remote attestation. Sending
> unknown measurements and a reference to digest lists would be sufficient.

Typically, one would not send the entire log at every attestation.  The
algorithm I use is:

- if it's the first quote after a reboot, send the entire log, else
- if PCRs haven't changed, don't send anything, else
- send a delta since the last attestation.

Even without this obvious optimization, the transmit time is negligible 
compared to the quote signature generation time.
