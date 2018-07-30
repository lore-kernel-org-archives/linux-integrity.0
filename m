Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728553AbeG3CHz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Jul 2018 22:07:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6U0Y9hK056093
        for <linux-integrity@vger.kernel.org>; Sun, 29 Jul 2018 20:35:29 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2khr5gr6db-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 29 Jul 2018 20:35:29 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 30 Jul 2018 01:35:27 +0100
Subject: Re: How to generate and load evm-key in TPM less systems
From: Mimi Zohar <zohar@linux.ibm.com>
To: rishi gupta <gupt21@gmail.com>, linux-integrity@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, zohar@linux.vnet.ibm.com
Cc: James Bottomley <jejb@linux.vnet.ibm.com>
Date: Sun, 29 Jul 2018 20:35:12 -0400
In-Reply-To: <CALUj-guObu_R6--mbiNmF_ZgGNayr5Tj3pKVtW2VC3ZWWZypsg@mail.gmail.com>
References: <CALUj-guObu_R6--mbiNmF_ZgGNayr5Tj3pKVtW2VC3ZWWZypsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1532910912.4337.75.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Cc'ing James Bottomley]

On Sun, 2018-07-29 at 23:46 +0530, rishi gupta wrote:
> Hi Integrity team,
> 
> IMA is working fine in our embedded linux product and now we are trying to
> implement EVM. Our system does not have TPM but have trustzone and crypto
> engine. My question is:
> 
> 1. What is the standard practice to generate and load evm-key in systems
> that does not have TPM.

TPMs are really cheap.   Convince your product group to include a TPM?

"encrypted" keys can be decrypted either by a "trusted" or a "user"
type key, but the latter is not considered safe and should be limited
to test environments.

Udit Agarwal recently suggested defining a new key type named "secure"
keys, but didn't explain what made them secure.  The "secure" key type
was limited to CAAM.

> 2. Suppose we have an encrypted key which has been decrypted and loaded in
> kernel. Isn't it an attacker can analyse RAM and get the evm-key. Am I
> missing something here.

No, what you're saying is true.  In a secure, locked down environment
analyzing kernel memory (should still) requires root privileges.

Mimi
