Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:35110 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751416AbdLFMei (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Dec 2017 07:34:38 -0500
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
Message-ID: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
Date: Wed, 6 Dec 2017 13:34:35 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050104090803020500080208"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Dear Linux folks,


With Linux 4.15-rc2 built by the Ubuntu Kernel Team, the error messages 
below are shown by the Linux kernel. These are new.

```
Dez 06 13:22:24 Ixpees kernel: microcode: microcode updated early to 
revision 0x62, date = 2017-04-27
Dez 06 13:22:24 Ixpees kernel: Linux version 4.15.0-041500rc2-generic 
(kernel@gloin) (gcc version 7.2.0 (Ubuntu 7.2.0-8ubuntu3)) #201712031230 
SMP Sun Dec 3 17:32:03 UTC 2017
Dez 06 13:22:24 Ixpees kernel: Command line: 
BOOT_IMAGE=/vmlinuz-4.15.0-041500rc2-generic 
root=/dev/mapper/ubuntu--vg-root ro quiet splash vt.handoff=7
Dez 06 13:22:24 Ixpees kernel: KERNEL supported cpus:
Dez 06 13:22:24 Ixpees kernel:   Intel GenuineIntel
Dez 06 13:22:24 Ixpees kernel:   AMD AuthenticAMD
Dez 06 13:22:24 Ixpees kernel:   Centaur CentaurHauls
Dez 06 13:22:24 Ixpees kernel: x86/fpu: Supporting XSAVE feature 0x001: 
'x87 floating point registers'
Dez 06 13:22:24 Ixpees kernel: x86/fpu: Supporting XSAVE feature 0x002: 
'SSE registers'
[...]
Dez 06 13:22:24 Ixpees kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 
0xFE, rev-id 4)
Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred 
continue selftest
Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred 
continue selftest
Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred 
continue selftest
Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred 
continue selftest
Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred 
continue selftest
Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred 
continue selftest
Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred 
continue selftest
Dez 06 13:22:24 Ixpees kernel: tpm tpm0: TPM self test failed
```

Any idea what to do about those? If these are intentional, it'd be great 
to give some hint to the user, what effect this has.


Kind regards,

Paul



    [ Part 2, "S/MIME Cryptographic Signature" ]
    [ Application/PKCS7-SIGNATURE (Name: "smime.p7s") 5.3 KB. ]
    [ Unable to print this part. ]
