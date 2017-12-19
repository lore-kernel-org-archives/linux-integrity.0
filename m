Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965510AbdLSIyY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 03:54:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBJ8rxGj068205
        for <linux-integrity@vger.kernel.org>; Tue, 19 Dec 2017 03:54:23 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2exvvyeqw3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 19 Dec 2017 03:54:23 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 19 Dec 2017 03:54:21 -0500
Subject: Re: [RFC][PATCH 0/9] tpm: fix driver so that burstcount can be safely
 ignored
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko.sakkinen@linux.intel.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Tue, 19 Dec 2017 14:23:25 +0530
MIME-Version: 1.0
In-Reply-To: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7c16ebb6-b9d2-dcdd-1219-ce2702a41cd0@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 12/09/2017 12:16 AM, Alexander Steffen wrote:
> Disclaimer: This is RFC because unfortunately I do not have the time to bring it up to the usual standards. But from lying around on my hard disk it definitely won't improve, so I've decided to publish it now, to get at least some feedback or maybe for somebody else to pick it up. Since the work began some time ago, it is probably not rebased against the current state (but hopefully still applies).
>
> This is a collection of all the fixes I made during the investigation of the problems with the "ignore burstcount" change. These are mainly fixes for the wait state handling in tpm_tis_spi, that probably was not really tested so far, since the previous implementation avoided wait states as far as possible. It also includes changes to tpm_tis_core, so that it follows the specification more closely. Finally, I've included a rebased version of the original "ignore burstcount" patch. Together, those patches pass all my tests and also each intermediate step is fine (so that bisecting still works).

Thanks Alex for debugging and fixing. Sorry, I haven't been able to look 
yet because was mostly on vacation most of the time in last few weeks 
and would be for few more days in next two weeks.

Thanks & Regards,
    - Nayna

>
> Alexander Steffen (8):
>    tpm_tis_core: clean up whitespace
>    tpm_tis_core: access single TIS registers before doing complex
>      transfers
>    tpm_tis_core: correctly wait for flags to become zero
>    tpm_tis_core: send all data in single operation
>    tpm_tis_core: use XDATA_FIFO for transfers if available
>    tpm_tis_spi: fix sending wrong data during wait state handling
>    tpm_tis_spi: release CS line when wait state handling fails
>    tpm_tis_spi: add delay between wait state retries
>
> Nayna Jain (1):
>    tpm: ignore burstcount to improve tpm_tis send() performance
>
>   drivers/char/tpm/tpm_tis_core.c | 131 ++++++++++++++++++++--------------------
>   drivers/char/tpm/tpm_tis_core.h |  26 ++++----
>   drivers/char/tpm/tpm_tis_spi.c  |  21 +++++--
>   3 files changed, 95 insertions(+), 83 deletions(-)
>
