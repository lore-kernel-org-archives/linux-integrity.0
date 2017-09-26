Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-bl2nam02on0109.outbound.protection.outlook.com ([104.47.38.109]:2880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935846AbdIZUWg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Sep 2017 16:22:36 -0400
From: Jork Loeser <Jork.Loeser@microsoft.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: TPM 2.0 CRB driver & locality
Date: Tue, 26 Sep 2017 20:22:33 +0000
Message-ID: <CY4PR21MB0631F0BEBFEC2B222AC69320F17B0@CY4PR21MB0631.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello,

We are running Linux under Hyper-V with its emulated vTPM (you might call it synthetic TPM). While the TPM itself adheres to the spec, it does not support localities. Consequently, the I/O block does not include the locality portion, and the control register offset is hence different in the TPM2.0 ACPI table from what the driver expects. This leads to below warning: 

root@ubuntu:~# dmesg | grep tpm
[    7.849077] tpm_crb VTPM0101:00: [Firmware Bug]: Bad ACPI memory layout

I wonder if a warning message of the form "Memory layout does not comply to PC-client-spec. Disabling locality support." might be more descriptive, perhaps with an additional comment in the source code.

What do you think?
Jork
