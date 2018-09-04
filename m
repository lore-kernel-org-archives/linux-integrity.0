Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36830 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeIEAac (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Sep 2018 20:30:32 -0400
Received: by mail-wm0-f42.google.com with SMTP id j192-v6so5512137wmj.1
        for <linux-integrity@vger.kernel.org>; Tue, 04 Sep 2018 13:03:52 -0700 (PDT)
MIME-Version: 1.0
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Tue, 4 Sep 2018 17:03:40 -0300
Message-ID: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
Subject: caps file showing wrong TCG version?
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi all,

I have an Infineon SLB 9665 TPM chip, which according to
https://www.infineon.com/dgdl/Infineon-OPTIGA_TPM-PB-v10_15-EN.pdf?fileId=5546d46145da30e80145efa2f0b96a8e
uses TPM 2.0. However, /sys/class/tpm/tpm0/device/tpm/tpm0/caps is
showing "TCG version: 1.2". I'm aware that the versioning scheme using
by the TCG is a bit confusing (e.g. 1.2 is the "Main" spec, while 2.0
is a "library" spec), but I'm wondering whether this is correct.

Thanks
