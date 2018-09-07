Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:50571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbeIGUWZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Sep 2018 16:22:25 -0400
Date: Fri, 07 Sep 2018 17:40:41 +0200
In-Reply-To: <CAN19L9ERiU2sgxnR7=7smpbb_zQPg-r-+YoAZ0EuGX4yKx66OQ@mail.gmail.com>
References: <CAN19L9ERiU2sgxnR7=7smpbb_zQPg-r-+YoAZ0EuGX4yKx66OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: tpm2_dump_capability not working on latest Ubuntu
To: Martin Galvan <omgalvan.86@gmail.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
From: Peter Huewe <peterhuewe@gmx.de>
Message-ID: <57E30E4C-786F-4273-BBAD-EEBEFE30A72F@gmx.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

Am 7. September 2018 15:47:53 MESZ schrieb Martin Galvan <omgalvan.86@gmail.com>:
>Hi all,
>
>I have an Infineon SLB9665 chip, which supports TPM 2.0. I'm trying to
>do a capability dump, and am always getting the same error:
>
># tpm2_dump_capability -c "properties-fixed"
>Failed to initialize tcti context: 0x1
>
>(I guess it would be good to use tpm2_error_str there)
>
>I'm running Ubuntu 18.04. I'm aware that tpm2_dump_capability was
>renamed to tpm2_getcap in version 3, but the tpm2-tools package that
>comes with Ubuntu 18.04 seems to be version 2.1.0 according to
>https://packages.ubuntu.com/bionic/tpm2-tools. Doing
>tpm2_dump_capability -v doesn't show anything useful:
>
># tpm2_dump_capability -v
>tpm2_dump_capability, version
>
>I have the tpm2-resourcemgr daemon running, though I had to enable it
>manually, because when I installed the package I noticed the
>following:
>
>Setting up libsapi-utils (1.0-1) ...
>tpm2-resourcemgr.service is a disabled or a static unit, not starting
>it.
>
>Does anyone know why this is happening? Other tools like Infineon's
>eltt2 seem to work fine.

The tpm2-tss mailing list or the tpm2-tools  github issue tracker are probably the better place for this question.

https://lists.01.org/mailman/listinfo/tpm2
Thanks,
Peter

-- 
Sent from my mobile
