Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752765AbeFRPSt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jun 2018 11:18:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IFIjpv018806
        for <linux-integrity@vger.kernel.org>; Mon, 18 Jun 2018 11:18:48 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jpe6qk356-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 18 Jun 2018 11:18:48 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 09:18:46 -0600
To: linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Converting IMA to always use a tpm_chip results in a lock ordering
 issue
Date: Mon, 18 Jun 2018 11:18:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5411b17c-686d-40ee-b88b-c220c81c72e1@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I have previously written about an attempt to convert the IMA code to 
look up a TPM chip and use this chip until system shutdown here:

https://sourceforge.net/p/tpmdd/mailman/message/36270737/

I have revived this effort now and seeing another problem that is 
related to lock-ordering when IMA does an initial 
tpm_chip_find_get(NULL) and holds on to this chip until shutdown. The 
lock ordering problem is relative to the lock-ordering when the hwrng is 
using the TPM, and probably other subsystems as well (trusted keys). The 
issues is as follows:

hwrng runs into tpm_chip_find_get(chip) and locks the idr and then gets 
the read lock to the ops: lock(idr) -> rlock(ops)

IMA uses the initially looked up tpm_chip and with that still holds on 
to the read lock on the ops. In tpm_pcr_extend it calls 
tpm_chip_find_get(chip), which now acquires lock(idr) and we end up 
with: rlock(ops) -> lock(idr)

It looks like no subsystem can hold onto a tpm_chip and its ops for more 
than one command since it typically will run into 
tpm_chip_find_get(chip) again. I am wondering how to solve this problem. 
Maybe by not calling tpm_chip_find_get() for an existing chip at all, so 
it would be converted to tpm_chip_find_get(void) to accomodate long-term 
consumers of a TPM that are assumed to hold onto that read-lock? This 
should work since all other subsystems, like trusted keys and IMA, 
currently call the TPM functions with a NULL pointer for the tpm_chip. 
Is there a better solution?

Another issue with holding on to the tpm_chip's ops read lock is that 
any write lock on the ops will block until a subsystem (IMA) has 
released the ops read-lock. A solution for this could be for a long-term 
TPM consumer to register itself as a consumer of the TPM chip that gets 
a notification when the chip is to be removed. A callback would release 
the chip and the read lock on the ops when this happens, though may 
require locking in that subsystem as well. In practice this wouldn't get 
called with the patches I am working on since IMA shuts down before the 
tpm chip is unregistered (if that happens during system shutdown). The 
Xen driver seems to be the only exception upon resume:

https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/xen-tpmfront.c#L388


If you have thoughts about this, please let me know.

     Stefan
