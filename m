Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55599 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731904AbeHCPHx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Aug 2018 11:07:53 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1flZri-0004Kj-26
        for linux-integrity@vger.kernel.org; Fri, 03 Aug 2018 13:11:34 +0000
Received: by mail-it0-f69.google.com with SMTP id w132-v6so5516773ita.6
        for <linux-integrity@vger.kernel.org>; Fri, 03 Aug 2018 06:11:34 -0700 (PDT)
Date: Fri, 3 Aug 2018 08:11:29 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Eric Richter <erichte@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>
Subject: Re: [PATCH 3/4] ima: add support for KEXEC_ORIG_KERNEL_CHECK
Message-ID: <20180803131129.GS3001@ubuntu-xps13>
References: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
 <20180725233200.761-4-erichte@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725233200.761-4-erichte@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jul 25, 2018 at 06:31:59PM -0500, Eric Richter wrote:
> IMA can verify the signature of kernel images loaded with kexec_file_load,
> but can not verify images loaded with the regular kexec_load syscall.
> Therefore, the appraisal will automatically fail during kexec_load when an
> appraise policy rule is set for func=KEXEC_KERNEL_CHECK. This can be used
> to effectively disable the kexec_load syscall, while still allowing the
> kexec_file_load to operate so long as the target kernel image is signed.
> 
> However, this conflicts with CONFIG_KEXEC_VERIFY_SIG. If that option is
> enabled and there is an appraise rule set, then the target kernel would
> have to be verifiable by both IMA and the architecture specific kernel
> verification procedure.
> 
> This patch adds a new func= for IMA appraisal specifically for the original
> kexec_load syscall. Therefore, the kexec_load syscall can be effectively
> disabled via IMA policy, leaving the kexec_file_load syscall able to do its
> own signature verification, and not require it to be signed via IMA. To
> retain compatibility, the existing func=KEXEC_KERNEL_CHECK flag is
> unchanged, and thus enables appraisal for both kexec syscalls.

This seems like a roundabout way to disallow the kexec_load syscall.
Wouldn't it make more sense to simply disallow kexec_load any time
CONFIG_KEXEC_VERIFY_SIG is enabled, since it effectively renders that
option impotent? Or has that idea already been rejected?

Thanks,
Seth
