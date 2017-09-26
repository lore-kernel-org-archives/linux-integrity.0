Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:8557 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937058AbdIZLKw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Sep 2017 07:10:52 -0400
Date: Tue, 26 Sep 2017 14:10:43 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net, ard.biesheuvel@linaro.org,
        matt@codeblueprint.co.uk, linux-kernel@vger.kernel.org,
        mjg59@google.com, peterhuewe@gmx.de,
        jgunthorpe@obsidianresearch.com, tpmdd@selhorst.net
Subject: Re: [PATCH v3 2/5] tpm: rename event log provider files
Message-ID: <20170926111043.fbcxd5ke4nsrsyir@linux.intel.com>
References: <20170920081340.7413-1-tweek@google.com>
 <20170920081340.7413-3-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920081340.7413-3-tweek@google.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Sep 20, 2017 at 10:13:37AM +0200, Thiebaud Weksteen wrote:
> Rename the current TPM Event Log provider files (ACPI and OF)
> for clarity.
> 
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> ---
>  drivers/char/tpm/Makefile                            | 4 ++--
>  drivers/char/tpm/{tpm_acpi.c => tpm_eventlog_acpi.c} | 0
>  drivers/char/tpm/{tpm_of.c => tpm_eventlog_of.c}     | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename drivers/char/tpm/{tpm_acpi.c => tpm_eventlog_acpi.c} (100%)
>  rename drivers/char/tpm/{tpm_of.c => tpm_eventlog_of.c} (100%)

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
