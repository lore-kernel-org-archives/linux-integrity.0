Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753065AbdLHTvG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 14:51:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8Jnk7J114953
        for <linux-integrity@vger.kernel.org>; Fri, 8 Dec 2017 14:51:05 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2er0xh93g4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 14:51:04 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 12:50:59 -0700
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-integrity@vger.kernel.org
References: <20171117100724.19257-1-javierm@redhat.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 8 Dec 2017 14:51:00 -0500
MIME-Version: 1.0
In-Reply-To: <20171117100724.19257-1-javierm@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <deaa0567-4c5f-d4bd-3f27-81b8af39c681@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/17/2017 5:07 AM, Javier Martinez Canillas wrote:
> According to the TPM Library Specification, a TPM device must do a command
> header validation before processing and return a TPM_RC_COMMAND_CODE code
> if the command is not implemented and the TPM_RC_COMMAND_SIZE code if the
> command buffer size is not correct.
> 
> So user-space will expect to handle these response codes as errors, but if
> the in-kernel resource manager is used (/dev/tpmrm?) then an -EINVAL errno
> code is returned instead if the command isn't implemented or the buffer
> size isn't correct. This confuses user-space since doesn't expect that.
> 
> This is also not consistent with the behavior when not using TPM spaces
> and accessing the TPM directly (/dev/tpm?), in this case the command is
> is sent to the TPM anyways and user-space can get an error from the TPM.
> 
> Instead of returning an -EINVAL errno code when the tpm_validate_command()
> function fails, allow the command to be sent to the TPM but just don't do
> any TPM space management. That way the TPM can report back a proper error
> and the behavior be consistent when using either /dev/tpm? or /dev/tpmrm?.

At a basic level, I agree with Javier.

If the device driver cannot send the command to the TPM (e.g., if the 
size of the transmit buffer doesn't match commandSize), then the driver 
should return an error.

Beyond those, IMHO the driver should pass through well formed commands 
and return the TPM response to the user level applications.

Some reasons:

- It's what the application developer expects.

- The behavior should be (as much as possible) the same, whether one is 
using /dev/tpmrm0, /dev/tpm0, or the TPM simulator.

- The application developer can use the TPM spec (or set a breakpoint in 
the simulator) to debug.  -EINVAL requires the application developer to 
dig into kernel code.

It also seems easier for the device driver, and so potentially will 
require less maintenance.
