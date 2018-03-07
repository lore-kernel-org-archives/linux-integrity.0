Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933474AbeCGRtA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Mar 2018 12:49:00 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w27Higag138118
        for <linux-integrity@vger.kernel.org>; Wed, 7 Mar 2018 12:48:59 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gjk4ecvu4-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 07 Mar 2018 12:48:59 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 7 Mar 2018 12:48:58 -0500
Subject: Re: [PATCH 1/3] certs: define a trusted platform keyring
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
 <31489.1520438598@warthog.procyon.org.uk>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 23:17:46 +0530
MIME-Version: 1.0
In-Reply-To: <31489.1520438598@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8873df7f-490f-28e0-249e-34bb3b133015@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 03/07/2018 09:33 PM, David Howells wrote:
> Nayna Jain <nayna@linux.vnet.ibm.com> wrote:
>
>> +		key = key_create_or_update(make_key_ref(keyring, 1),
>> +				"asymmetric",
>> +				NULL,
>> +				p,
>> +				plen,
>> +				((KEY_POS_ALL & ~KEY_POS_SETATTR) |
>> +				 KEY_USR_VIEW | KEY_USR_READ),
>> +				KEY_ALLOC_NOT_IN_QUOTA |
>> +				KEY_ALLOC_BUILT_IN |
>> +				KEY_ALLOC_BYPASS_RESTRICTION);
> There's no need to reindent here.  Please line up all the arguments: either
> push the first argument over onto the next line if you need to or line them
> all up with the char after the opening bracket.

Thanks David for the feedback. I will post the v2 version with this fix. 
Are there any other changes ?

Thanks & Regards,
    - Nayna

>
> David
>
