Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbeJHSb7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Oct 2018 14:31:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98BJL44058224
        for <linux-integrity@vger.kernel.org>; Mon, 8 Oct 2018 07:20:44 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n05up98vk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 07:20:43 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 12:20:41 +0100
Subject: Re: [PATCH v5 0/6] Add support for architecture specific IMA
 policies
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com, seth.forshee@canonical.com,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Date: Mon, 08 Oct 2018 07:20:25 -0400
In-Reply-To: <20181005174015.21939-1-nayna@linux.vnet.ibm.com>
References: <20181005174015.21939-1-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538997625.15382.87.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-10-05 at 23:10 +0530, Nayna Jain wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> The architecture specific policy, introduced in this patch set, permits
> different architectures to define IMA policy rules based on kernel
> configuration and system runtime information.
> 
> For example, on x86, there are two methods of verifying the kexec'ed kernel
> image signature - CONFIG_KEXEC_VERIFY_SIG and IMA appraisal policy
> KEXEC_KERNEL_CHECK. CONFIG_KEXEC_VERIFY_SIG enforces the kexec_file_load
> syscall to verify file signatures, but does not prevent the kexec_load
> syscall. The IMA KEXEC_KERNEL_CHECK policy rule verifies the kexec'ed
> kernel image, loaded via the kexec_file_load syscall, is validly signed and
> prevents loading a kernel image via the kexec_load syscall. When secure
> boot is enabled, the kexec'ed kernel image needs to be signed and the
> signature verified. In this environment, either method of verifying the
> kexec'ed kernel image is acceptable, as long as the kexec_load syscall is
> disabled.
> 
> The previous version of this patchset introduced a new IMA policy rule to
> disable the kexec_load syscall, when CONFIG_KEXEC_VERIFY_SIG was enabled,
> however that is removed from this version by introducing a different
> mechanism, as described below.
> 
> The patchset defines an arch_ima_get_secureboot() function to retrieve the
> secureboot state of the system. If secureboot is enabled and
> CONFIG_KEXEC_VERIFY_SIG is configured, it denies permission to kexec_load
> syscall.
> 
> To support architecture specific policies, a new function
> arch_get_ima_policy() is defined. This patch set defines IMA
> KERNEL_KEXEC_POLICY rules for x86 *only* if CONFIG_KEXEC_VERIFY_SIG is
> disabled and secure boot is enabled.
> 
> This patch set includes a patch, which refactors ima_init_policy() to
> remove code duplication.

Other than a couple of #ifdef's in .c files, which should be converted
to use IS_ENABLED(<config-option>), the patch set is looking really
good.

thanks!

Mimi
