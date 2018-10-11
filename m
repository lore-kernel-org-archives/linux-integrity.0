Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726235AbeJKWp0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 18:45:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BFEkcF040750
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:17:49 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n2743ebt5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:17:45 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Thu, 11 Oct 2018 11:17:41 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9BFHdbZ27131984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 15:17:39 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71ACF112065
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:17:00 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AB76112069
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:17:00 -0400 (EDT)
Received: from [9.2.202.77] (unknown [9.2.202.77])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:17:00 -0400 (EDT)
Subject: Re: Question about the TPM driver
To: linux-integrity@vger.kernel.org
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
 <1536848529.3436.2.camel@HansenPartnership.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Thu, 11 Oct 2018 11:17:53 -0400
MIME-Version: 1.0
In-Reply-To: <1536848529.3436.2.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7174cf56-57f2-c545-ab85-9d9c1d3253b2@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 9/13/2018 10:22 AM, James Bottomley wrote:
> 
> Exact buffer size hasn't been thought to be an issue since you know
> that any response will fit into MAX_RESPONSE_SIZE which the current
> implementation defines to be 4096.

If a caller wishes to optimize, TPM 2.0 has these two getcapabilities.

TPM_PT_MAX_COMMAND_SIZE - the maximum value for commandSize in a command
TPM_PT_MAX_RESPONSE_SIZE - the maximum value for responseSize in a response
