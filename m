Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964877AbeEJQKg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 12:10:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4AG9Csk010626
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 12:10:36 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hvqvtw5e8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 12:10:36 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Thu, 10 May 2018 10:10:35 -0600
References: <20180420203408.50769-1-mjg59@google.com> <1525915585.3551.302.camel@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] evm: Allow non-SHA1 digital signatures
In-reply-to: <1525915585.3551.302.camel@linux.vnet.ibm.com>
Date: Thu, 10 May 2018 13:10:20 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a7t71ogj.fsf@morokweng.localdomain>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> [Cc'ing Thiago Bauermann]
>
> On Fri, 2018-04-20 at 13:34 -0700, Matthew Garrett wrote:
>> SHA1 is reasonable in HMAC constructs, but it's desirable to be able to
>> use stronger hashes in digital signatures. Modify the EVM crypto code so
>> the hash type is imported from the digital signature and passed down to
>> the hash calculation code, and return the digest size to higher layers
>> for validation.
>
> Currently the code passes just the digest field of the
> evm_ima_xattr_data structure to evm_calc_hmac() and evm_calc_hash().
> Instead of passing three fields - hash algorithm, digest size, and
> digest - pass a structure. Consider using the existing
> ima_digest_data structure.
>
> My only concern is that Thiago is working in this area of the code.
> Thiago, any comments?

Thanks for your concern. This is not a problem for me. It will be simple
to rebase on top of this patch when I post my patches.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
