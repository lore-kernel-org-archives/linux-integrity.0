Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:44726 "EHLO quartz.orcorp.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbdITQkU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Sep 2017 12:40:20 -0400
Date: Wed, 20 Sep 2017 10:40:10 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net, ard.biesheuvel@linaro.org,
        matt@codeblueprint.co.uk, linux-kernel@vger.kernel.org,
        mjg59@google.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net
Subject: Re: [PATCH v3 5/5] tpm: parse TPM event logs based on EFI table
Message-ID: <20170920164010.GA5249@obsidianresearch.com>
References: <20170920081340.7413-1-tweek@google.com>
 <20170920081340.7413-6-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920081340.7413-6-tweek@google.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Sep 20, 2017 at 10:13:40AM +0200, Thiebaud Weksteen wrote:
> If we are not able to retrieve the TPM event logs from the ACPI table,
> check the EFI configuration table (Linux-specific GUID).
> 
> The format version of the log is now returned by the provider function.
> 
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>

Thanks, looks good to me.

Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Jason
