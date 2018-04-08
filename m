Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752285AbeDHU2g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Apr 2018 16:28:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w38KSJbg108802
        for <linux-integrity@vger.kernel.org>; Sun, 8 Apr 2018 16:28:36 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h7j4wdd9c-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 08 Apr 2018 16:28:35 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Sun, 8 Apr 2018 16:28:34 -0400
Subject: Re: [RFC 0/2] add integrity and security to TPM2 transactions
References: <1520057094.27452.16.camel@HansenPartnership.com>
 <20180305140431.GA9335@ziepe.ca>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Sun, 8 Apr 2018 16:28:31 -0400
MIME-Version: 1.0
To: undisclosed-recipients:;
In-Reply-To: <20180305140431.GA9335@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <144c02c4-bc76-b063-cd50-80b4df9b9982@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 3/5/2018 9:04 AM, Jason Gunthorpe wrote:
> On Fri, Mar 02, 2018 at 10:04:54PM -0800, James Bottomley wrote:
>> By now, everybody knows we have a problem with the TPM2_RS_PW easy
>> button on TPM2 in that transactions on the TPM bus can be intercepted
>> and altered.  The way to fix this is to use real sessions for HMAC
>> capabilities to ensure integrity and to use parameter and response
>> encryption to ensure confidentiality of the data flowing over the TPM
>> bus.
> 
> We have the same issue for TPM1 then right?

TPM 1.2 did not have the concept of plaintext password sessions.  If 
authorization was used, it was always with an HMAC.
