Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49379 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751822AbdJ3LA3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 07:00:29 -0400
To: linux-integrity@vger.kernel.org, tpm2@lists.01.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Failed initialization on TUXEDO Book BU1406
Message-ID: <83cd482f-c414-c111-da35-229e53f23a58@molgen.mpg.de>
Date: Mon, 30 Oct 2017 12:00:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Dear Linux folks,


with Linux 4.14-rc6 built by the Ubuntu Linux kernel team, I have the 
issues below.

```
$ uname -a
Linux helmuth-N24-25BU 4.14.0-041400rc6-generic #201710230731 SMP Mon 
Oct 23 11:32:51 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
$ journalctl -k | grep -i tpm
Okt 30 09:34:34 helmuth-N24-25BU kernel: ACPI: TPM2 0x000000007F8B63B0 
000034 (v03        Tpm2Tabl 00000001 AMI  00000000)
Okt 30 09:34:34 helmuth-N24-25BU kernel: calling  tpm_init+0x0/0xd6 @ 1
Okt 30 09:34:34 helmuth-N24-25BU kernel: initcall tpm_init+0x0/0xd6 
returned 0 after 0 usecs
Okt 30 09:34:34 helmuth-N24-25BU kernel: tpm_tis MSFT0101:00: 2.0 TPM 
(device-id 0x1A, rev-id 16)
Okt 30 09:34:34 helmuth-N24-25BU kernel: calling 
crb_acpi_driver_init+0x0/0x1000 [tpm_crb] @ 477
Okt 30 09:34:34 helmuth-N24-25BU kernel: initcall 
crb_acpi_driver_init+0x0/0x1000 [tpm_crb] returned 0 after 970 usecs
$ tpm2_listpcrs --version
tpm2_listpcrs, version 1.1.0
$ sudo tpm2_listpcrs
Resource Mgr, resMgr, failed initialization: 0x1.  Exiting...
```

I do not think that is expected. Is that a driver or user space issue?


Kind regards,

Paul
