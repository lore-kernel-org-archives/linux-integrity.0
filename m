Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:32773 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbeIGS3J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Sep 2018 14:29:09 -0400
Received: by mail-wm0-f48.google.com with SMTP id r1-v6so17001431wmh.0
        for <linux-integrity@vger.kernel.org>; Fri, 07 Sep 2018 06:48:06 -0700 (PDT)
MIME-Version: 1.0
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Fri, 7 Sep 2018 10:47:53 -0300
Message-ID: <CAN19L9ERiU2sgxnR7=7smpbb_zQPg-r-+YoAZ0EuGX4yKx66OQ@mail.gmail.com>
Subject: tpm2_dump_capability not working on latest Ubuntu
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi all,

I have an Infineon SLB9665 chip, which supports TPM 2.0. I'm trying to
do a capability dump, and am always getting the same error:

# tpm2_dump_capability -c "properties-fixed"
Failed to initialize tcti context: 0x1

(I guess it would be good to use tpm2_error_str there)

I'm running Ubuntu 18.04. I'm aware that tpm2_dump_capability was
renamed to tpm2_getcap in version 3, but the tpm2-tools package that
comes with Ubuntu 18.04 seems to be version 2.1.0 according to
https://packages.ubuntu.com/bionic/tpm2-tools. Doing
tpm2_dump_capability -v doesn't show anything useful:

# tpm2_dump_capability -v
tpm2_dump_capability, version

I have the tpm2-resourcemgr daemon running, though I had to enable it
manually, because when I installed the package I noticed the
following:

Setting up libsapi-utils (1.0-1) ...
tpm2-resourcemgr.service is a disabled or a static unit, not starting it.

Does anyone know why this is happening? Other tools like Infineon's
eltt2 seem to work fine.
