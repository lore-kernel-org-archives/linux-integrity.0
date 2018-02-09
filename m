Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751099AbeBIKbt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Feb 2018 05:31:49 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w19ATbBK047596
        for <linux-integrity@vger.kernel.org>; Fri, 9 Feb 2018 05:31:48 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g19w8857n-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Feb 2018 05:31:48 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 9 Feb 2018 05:31:47 -0500
Subject: Re: TPM selftest failure in 4.15
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
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
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 16:00:44 +0530
MIME-Version: 1.0
In-Reply-To: <20180209100204.likckglpdx427dnl@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3ddc36d3-f6ec-c107-bebd-b1692fa8fa2b@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 02/09/2018 03:32 PM, Jarkko Sakkinen wrote:
> On Thu, Feb 08, 2018 at 09:02:00AM -0800, James Bottomley wrote:
>> There is an identified regression: the TPM driver will now periodically
>> fail to attach.  However, there's no point reviewing until we agree
>> what the fix is.  I was just waiting to verify this fixed my problem
>> (which means seeing the messages it spits out proving the TPM has
>> remained in self test).  I have now seen this and the driver still
>> works, so I can submit a formal patch.
> For the self-test the duration falls down to 2 seconds as the specs do
> not contain any well-defined duration for it, or at least I haven't
> found it.
>
> I see three alternative ways the fix the self-test:
>
> 1. Execute self-test with fullTest = YES.
> 2. Have a flag TPM_CHIP_TESTING that is set when the self-test is
>     started. Issue a warning on time-out. Check for this flag in
>     tpm_transmit_cmd() and tpm_write() and resend self-test command
>     if the flag is stil test before the actual command. Return -EBUSY
>     and print a warning if self-test is still active.
> 3. Increase the duration to the "correct" value if we have one.
>
> /Jarkko

IIUC, I see the duration and timeout specified in
TCG_PC_Client_Platform_TPM_Profile_PTP_Specification_Family_2.0_Revision:
Section 5.5.1.3 Command Timing: Table 15

For selftest it is given as:

Command                                      |  Duration[ms]    | 
Timeout[ms]

TPM2_SelfTest(fullTest=YES)                 1000 2000
TPM2_SelfTest(fullTest=NO) 20                        750

With that I think, TPM is expected to complete the selftest in max 2000 ms.

Thanks & Regards,
      - Nayna
