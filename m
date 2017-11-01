Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933241AbdKAUTI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Nov 2017 16:19:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA1KJ6BI078164
        for <linux-integrity@vger.kernel.org>; Wed, 1 Nov 2017 16:19:07 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dyjdhgjnt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 01 Nov 2017 16:19:07 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Wed, 1 Nov 2017 14:19:01 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id vA1KIxaA5243350
        for <linux-integrity@vger.kernel.org>; Wed, 1 Nov 2017 13:18:59 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6056C604C
        for <linux-integrity@vger.kernel.org>; Wed,  1 Nov 2017 14:18:59 -0600 (MDT)
Received: from [9.2.54.27] (unknown [9.2.54.27])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP id 7BF9CC6043
        for <linux-integrity@vger.kernel.org>; Wed,  1 Nov 2017 14:18:59 -0600 (MDT)
To: Linix Integrity <linux-integrity@vger.kernel.org>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Subject: TPM device driver and TPM_RC_RETRY
Date: Wed, 1 Nov 2017 16:19:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f9aa2357-fae3-6201-8557-be9376ba9a77@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

TPM 2.0 issues a retry return code if the TPM cannot currently process 
the command.  Today's use case is an NV write that is rate limited to 
prevent wear out.  There could be others.

Architecturally, where should this be handled?  Is it handled today?
Where was it handled for TPM 1.2?

- device driver
- kernel resource manager
- user space TSS
- user space application

My opinion is that the user space TSS should handle it, but I'm very 
open to other opinions.

- If in the device driver, other applications would block
- The resource manager would be OK, but perhaps is complexity that we 
don't want to add.
- It seems to be a burden on applications that the TSS could handle once.
