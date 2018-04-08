Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752061AbeDHUBS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Apr 2018 16:01:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w38K0nGO048788
        for <linux-integrity@vger.kernel.org>; Sun, 8 Apr 2018 16:01:18 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h7en9avgg-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 08 Apr 2018 16:01:17 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Sun, 8 Apr 2018 16:01:16 -0400
Subject: Re: [PATCH 0/5 V2] tpm: timeouts revamp
References: <20180306092503.11568-1-tomas.winkler@intel.com>
 <1520338622.3779.1.camel@linux.intel.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Sun, 8 Apr 2018 16:01:13 -0400
MIME-Version: 1.0
To: undisclosed-recipients:;
In-Reply-To: <1520338622.3779.1.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <65bd7ace-2780-6056-5363-c8325874c79f@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 3/6/2018 7:17 AM, Jarkko Sakkinen wrote:
>>
>> Second is to define timeouts for new tpm2 commands
>> defined in TCG 1.36 spec.
> 
> Where can we get that specification? I don't have that new
> version and couldn't find it from the public internet.

The published spec is 138, not 136.  You can find it here:

https://trustedcomputinggroup.org/tpm-library-specification/

I also recommend looking at either the errata or the latest draft here.

https://trustedcomputinggroup.org/specifications-public-review/
