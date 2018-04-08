Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751526AbeDHUE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Apr 2018 16:04:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w38K3vCt029953
        for <linux-integrity@vger.kernel.org>; Sun, 8 Apr 2018 16:04:58 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2h7jrpbkf3-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 08 Apr 2018 16:04:58 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Sun, 8 Apr 2018 16:04:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w38K4tPu64291060
        for <linux-integrity@vger.kernel.org>; Sun, 8 Apr 2018 20:04:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7239CB204D
        for <linux-integrity@vger.kernel.org>; Sun,  8 Apr 2018 17:07:01 -0400 (EDT)
Received: from [9.49.209.157] (unknown [9.49.209.157])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP id 55377B2046
        for <linux-integrity@vger.kernel.org>; Sun,  8 Apr 2018 17:07:01 -0400 (EDT)
Subject: Re: [PATCH 0/5 V2] tpm: timeouts revamp
Cc: linux-integrity@vger.kernel.org
References: <20180306092503.11568-1-tomas.winkler@intel.com>
 <1520338622.3779.1.camel@linux.intel.com>
 <031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
 <20180306140256.GC5700@linux.intel.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Sun, 8 Apr 2018 16:04:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180306140256.GC5700@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <96afa944-f784-9011-ca4f-4ef514897932@linux.vnet.ibm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 3/6/2018 9:02 AM, Jarkko Sakkinen wrote:

> 
> The only spec I've seen some timeouts is the PC Client Specification but
> I guess I've then missed the list in TPM 2.0 spefication. Where are they
> listed? I worked with Will Arthur durations based on PC Client Specification
> when TPM 2.0 support was first implemented.

Performance number like this would not be in the TPM library 
specification.  The platform specific specification, typically the
PC Client spec, would be the correct place to look.
