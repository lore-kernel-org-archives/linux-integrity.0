Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:3111 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933883AbdIZLpq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Sep 2017 07:45:46 -0400
Date: Tue, 26 Sep 2017 14:45:38 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net, ard.biesheuvel@linaro.org,
        matt@codeblueprint.co.uk, linux-kernel@vger.kernel.org,
        mjg59@google.com, peterhuewe@gmx.de,
        jgunthorpe@obsidianresearch.com, tpmdd@selhorst.net
Subject: Re: [PATCH v3 4/5] efi: call get_event_log before ExitBootServices
Message-ID: <20170926114538.r5hsyc5osodpaals@linux.intel.com>
References: <20170920081340.7413-1-tweek@google.com>
 <20170920081340.7413-5-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920081340.7413-5-tweek@google.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Sep 20, 2017 at 10:13:39AM +0200, Thiebaud Weksteen wrote:
> With TPM 2.0 specification, the event logs may only be accessible by
> calling an EFI Boot Service. Modify the EFI stub to copy the log area to
> a new Linux-specific EFI configuration table so it remains accessible
> once booted.
> 
> When calling this service, it is possible to specify the expected format
> of the logs: TPM 1.2 (SHA1) or TPM 2.0 ("Crypto Agile"). For now, only the
> first format is retrieved.
> 
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>

Does not apply:

Applying: tpm: move tpm_eventlog.h outside of drivers folder
Applying: tpm: rename event log provider files
Applying: tpm: add event log format version
Applying: efi: call get_event_log before ExitBootServices
error: sha1 information is lacking or useless (drivers/firmware/efi/efi.c).
error: could not build fake ancestor
Patch failed at 0004 efi: call get_event_log before ExitBootServices
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Just rebased my tree to the latest security-next.

/Jarkko
