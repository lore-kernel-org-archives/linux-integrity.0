Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752806AbdKJNKW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Nov 2017 08:10:22 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAD6G8N018887
        for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2017 08:10:21 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e59kjgxhq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2017 08:10:19 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 10 Nov 2017 13:10:17 -0000
Subject: Re: IMA secure_boot rules and the kernel_lockdown manpage
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 10 Nov 2017 08:10:14 -0500
In-Reply-To: <28799.1510313926@warthog.procyon.org.uk>
References: <28799.1510313926@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510319414.3359.27.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-11-10 at 11:38 +0000, David Howells wrote:
> Hi Mimi,
> 
> I need to add a statement about the IMA secure_boot rules to the
> kernel_lockdown manual page.  Is this enough:
> 
> 	IMA requires the addition of the "secure_boot" rules to the policy,
> 	whether or not they are specified on the command line, for both the
> 	builtin and custom policies in secure boot lockdown mode.

Please add:
This initially enforces kernel modules, firmware, the kernel kexec
image, and the IMA policy itself are signed.

> 
> I don't know what this actually does/achieves.

Like other policies (eg. tcb, appraise_tcb) the "secure_boot" policy
can be specified on the boot command line (eg.
ima_policy="secure_boot|tcb|appraise_tcb").

Currently the builtin "secure_boot" policy is defined as:

static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
        {.action = APPRAISE, .func = MODULE_CHECK,
         .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
        {.action = APPRAISE, .func = FIRMWARE_CHECK,
         .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
        {.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
         .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
        {.action = APPRAISE, .func = POLICY_CHECK,
         .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
};

These policies can be replaced at runtime with a custom policy.
 "lockdown" mode includes these rules in the custom policy, before any
of the custom rules.

On a system with "CONFIG_IMA_READ_POLICY" enabled and commit
 2068626d1345 "ima: don't remove the securityfs policy file" in James'
next-testing branch, the current policy can be seen by cat'ing
<securityfs>/ima/policy.

Mimi
