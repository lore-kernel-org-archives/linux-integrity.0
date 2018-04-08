Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752054AbeDHS1G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Apr 2018 14:27:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w38IOUk3100290
        for <linux-integrity@vger.kernel.org>; Sun, 8 Apr 2018 14:27:06 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h7jsmhc28-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 08 Apr 2018 14:27:06 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Sun, 8 Apr 2018 14:27:04 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w38IR1i655640092
        for <linux-integrity@vger.kernel.org>; Sun, 8 Apr 2018 18:27:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1645B2050
        for <linux-integrity@vger.kernel.org>; Sun,  8 Apr 2018 15:29:07 -0400 (EDT)
Received: from [9.49.209.157] (unknown [9.49.209.157])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP id A26D7B204D
        for <linux-integrity@vger.kernel.org>; Sun,  8 Apr 2018 15:29:07 -0400 (EDT)
Subject: Re: TPM selftest failure in 4.15
Cc: linux-integrity <linux-integrity@vger.kernel.org>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <20180201174053.GQ17053@ziepe.ca>
 <1517510764.3145.38.camel@HansenPartnership.com>
 <20180201185909.GW17053@ziepe.ca>
 <1517515204.3145.51.camel@HansenPartnership.com>
 <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
 <1518109320.21828.2.camel@HansenPartnership.com>
 <20180209100204.likckglpdx427dnl@linux.intel.com>
 <1518179200.3445.31.camel@linux.vnet.ibm.com>
 <1518193416.3930.10.camel@HansenPartnership.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Sun, 8 Apr 2018 14:27:00 -0400
MIME-Version: 1.0
In-Reply-To: <1518193416.3930.10.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8e455120-f528-9f42-46f1-6ef5a8328705@linux.vnet.ibm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 2/9/2018 11:23 AM, James Bottomley wrote:
> On Fri, 2018-02-09 at 07:26 -0500, Mimi Zohar wrote:
>> On Fri, 2018-02-09 at 12:02 +0200, Jarkko Sakkinen wrote:

> It seems that the PCRs are one of the earliest things to come
> on-line, so IMA always works.  This is on my current laptop where I'm
> running this patch with IMA: I no longer see the IMA bypass message and
> IMA comes up normally.
> 

I would expect PCRs to be available by the time IMA needs them because 
the firmware also extends to PCRs.  Therefore, the hash algorithms will 
be tested very early in boot.

I only worry about the resume from suspend case, where firmware won't be
doing extends.
