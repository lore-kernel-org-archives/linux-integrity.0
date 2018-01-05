Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751056AbeAEGre (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jan 2018 01:47:34 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w056j3gX063096
        for <linux-integrity@vger.kernel.org>; Fri, 5 Jan 2018 01:47:34 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2f9xubjnv7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jan 2018 01:47:33 -0500
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 5 Jan 2018 01:47:33 -0500
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/9] tpm: fix driver so that burstcount can be safely
 ignored
To: Alexander.Steffen@infineon.com, jarkko.sakkinen@linux.intel.com
Cc: kgold@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171215120439.v7fvyy2cuauhnl2h@linux.intel.com>
 <20171224204109.fobx53ffmog2a5nk@linux.intel.com>
 <97fc00fd033f46038d08b71e7f1d076c@infineon.com>
Date: Fri, 5 Jan 2018 12:16:40 +0530
MIME-Version: 1.0
In-Reply-To: <97fc00fd033f46038d08b71e7f1d076c@infineon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2554f425-f016-7026-8f0d-0bfed67dffc2@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 01/04/2018 06:41 PM, Alexander.Steffen@infineon.com wrote:
>> On Fri, Dec 15, 2017 at 02:04:39PM +0200, Jarkko Sakkinen wrote:
>>> On Fri, Dec 08, 2017 at 07:46:49PM +0100, Alexander Steffen wrote:
>>>> Disclaimer: This is RFC because unfortunately I do not have the time to
>> bring it up to the usual standards. But from lying around on my hard disk it
>> definitely won't improve, so I've decided to publish it now, to get at least
>> some feedback or maybe for somebody else to pick it up. Since the work
>> began some time ago, it is probably not rebased against the current state
>> (but hopefully still applies).
>>>> This is a collection of all the fixes I made during the investigation of the
>> problems with the "ignore burstcount" change. These are mainly fixes for the
>> wait state handling in tpm_tis_spi, that probably was not really tested so far,
>> since the previous implementation avoided wait states as far as possible. It
>> also includes changes to tpm_tis_core, so that it follows the specification
>> more closely. Finally, I've included a rebased version of the original "ignore
>> burstcount" patch. Together, those patches pass all my tests and also each
>> intermediate step is fine (so that bisecting still works).
>>>> Alexander Steffen (8):
>>>>    tpm_tis_core: clean up whitespace
>>>>    tpm_tis_core: access single TIS registers before doing complex
>>>>      transfers
>>>>    tpm_tis_core: correctly wait for flags to become zero
>>>>    tpm_tis_core: send all data in single operation
>>>>    tpm_tis_core: use XDATA_FIFO for transfers if available
>>>>    tpm_tis_spi: fix sending wrong data during wait state handling
>>>>    tpm_tis_spi: release CS line when wait state handling fails
>>>>    tpm_tis_spi: add delay between wait state retries
>>>>
>>>> Nayna Jain (1):
>>>>    tpm: ignore burstcount to improve tpm_tis send() performance
>>>>
>>>>   drivers/char/tpm/tpm_tis_core.c | 131 ++++++++++++++++++++---------
>> -----------
>>>>   drivers/char/tpm/tpm_tis_core.h |  26 ++++----
>>>>   drivers/char/tpm/tpm_tis_spi.c  |  21 +++++--
>>>>   3 files changed, 95 insertions(+), 83 deletions(-)
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>> Might not have time to review this before holidays but will do if
>>> I can.
>> Unfortunately this and your patches for broken TPMs came so late that
>> they have no chance to make into 4.16. Thus, I will postpone their
>> review after the pull request and take care of the high priority stuff
>> for that release.
> As long the "ignore burstcount" patch does not make it into 4.16 either, that's fine. Then nothing new gets broken, it just does not get any faster.

Alex, if I am right, among following 4 patches,
  
   Patch 1 - tpm: move wait_for_tpm_stat() to respective driver files
   Patch 2 - tpm: ignore burstcount to improve tpm_tis send() performance
   Patch 3 - tpm: reduce tpm polling delay in tpm_tis_core
   Patch 4 - tpm: use tpm_msleep() value as max delay

it is only the burstcount patch (Patch 2) which caused the issue.
With that, Jarkko, Alex, can we just exclude this and have other three patches pulled for 4.16 ?
I tested with these other three patches, and performance improvement is from ~41 to ~14.

Thanks & Regards,
    - Nayna

> Alexander
>
