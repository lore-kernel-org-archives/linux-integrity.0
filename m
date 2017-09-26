Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:45725 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935062AbdIZLRa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Sep 2017 07:17:30 -0400
Received: by mail-wr0-f175.google.com with SMTP id m18so12816749wrm.2
        for <linux-integrity@vger.kernel.org>; Tue, 26 Sep 2017 04:17:30 -0700 (PDT)
Subject: Re: [tpmdd-devel] [PATCH v3 0/5] Call GetEventLog before
 ExitBootServices
To: Thiebaud Weksteen <tweek@google.com>, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net
Cc: ard.biesheuvel@linaro.org, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        jgunthorpe@obsidianresearch.com, mjg59@google.com
References: <20170920081340.7413-1-tweek@google.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <ef8f75aa-4e63-edef-f0d3-4793b0bc6b27@redhat.com>
Date: Tue, 26 Sep 2017 13:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170920081340.7413-1-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 09/20/2017 10:13 AM, Thiebaud Weksteen via tpmdd-devel wrote:
> With TPM 1.2, the ACPI table ("TCPA") has two fields to recover the Event
> Log Area (LAML and LASA). These logs are useful to understand and rebuild
> the final values of PCRs.
> 
> With TPM 2.0, the ACPI table ("TPM2") does not contain these fields
> anymore. The recommended method is now to call the GetEventLog EFI
> protocol before ExitBootServices.
> 
> Implement this method within the EFI stub and create a copy of the logs
> for the TPM device using a Linux-specific EFI configuration table
> (LINUX_EFI_TPM_EVENT_LOG). This will create
> /sys/kernel/security/tpm0/binary_bios_measurements for TPM 2.0 devices
> (similarly to the current behaviour for TPM 1.2 devices).
> 
> Two formats for the log entries exist: TPM 1.2 (SHA1) and TPM 2.0 (Crypto
> Agile). This patch set only retrieves the first type of logs. The second
> type will be implemented in a subsequent patch set.
> 
> According to the specifications[1], once GetEventLog has been called,
> future events shall be stored in a separate EFI configuration table
> (EFI_TCG2_FINAL_EVENTS_TABLE). Events stored in this table are not
> processed in this patch set as they are stored in the Crypto Agile format.
> These could eventually be merged with the new table for a unified view
> of the logs from userspace.
> 
> [1] TCG EFI Protocol Specification, Revision 00.13, March 30, 2016
>     https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
> 
> -------------------------------------------------------------------------------
> 
> Patchset Changelog:
> 
> Version 3:
> - Move event log providers (acpi and of) to tpm_eventlog_*.c
> - Move efi changes from PATCH 3 to PATCH 2
> - Change return value of tpm_read_log_acpi and tpm_read_log_of
> - Change iounmap to memunmap calls
> - Use log_tbl as variable name for consistency
> - Fix kbuild failures
> 

Thanks for addressing the things I pointed out. For the whole patch-set:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
