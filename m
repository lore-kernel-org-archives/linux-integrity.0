Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4131 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726915AbeIZUXM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Sep 2018 16:23:12 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QE4HEb069994
        for <linux-integrity@vger.kernel.org>; Wed, 26 Sep 2018 10:10:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mr9gvep89-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Sep 2018 10:10:02 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 26 Sep 2018 15:10:01 +0100
Subject: Re: EXTERNAL: [PATCH v2 2/3] tpm: modify tpm_pcr_read() definition
 to pass TPM hash algorithms
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Wed, 26 Sep 2018 10:09:46 -0400
In-Reply-To: <e1d77563-81fd-36f0-648f-3325969b05af@huawei.com>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
         <20180905114202.7757-3-roberto.sassu@huawei.com>
         <F275EFAF-C940-4E44-8164-2819503DB334@nccgroup.trust>
         <e1d77563-81fd-36f0-648f-3325969b05af@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1537970986.4124.3.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-09-05 at 17:03 +0200, Roberto Sassu wrote:
> On 9/5/2018 3:43 PM, Jeremy Boone wrote:
> > Some comments on tpm2_pcr_read below.
> > 
> > The tpm2_pcr_read function uses TPM2_ST_NO_SESSIONS. This means
> that the response payload is not integrity protected with an HMAC.
> If there is a man-in-the-middle sitting on the serial bus that
> connects the TPM peripheral to the processor, they can tamper with
> the response parameters.
> > 
> > In your changes to tpm2_pcr_read, the memcpy is now become a
> variable-length operation, instead of just copying a fixed number of
> bytes. If the MITM modifies the response field out->digest_size
> before it is received by the driver, they can make it a very large
> value, forcing a buffer overflow of the out->digest array.
> > 
> > Adding a session to the PCR Read command seems like overkill in
> this case. I wouldn't recommend that as a solution here.  So to fix
> this I would suggest simply checking the digest size before the
> memcpy.
> 
> Hi Jeremy
> 
> ok, thanks.

The hash digest size checking should be based on the size stored in
the active_bank_info, either in 3/3 or as a separate patch.

Mimi
