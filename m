Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39949 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIEAc0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Sep 2018 20:32:26 -0400
Received: by mail-wm0-f46.google.com with SMTP id 207-v6so5436764wme.5
        for <linux-integrity@vger.kernel.org>; Tue, 04 Sep 2018 13:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
In-Reply-To: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Tue, 4 Sep 2018 17:05:34 -0300
Message-ID: <CAN19L9Ev=qYH-+BjZPcPJExML_zZBtSSV8cvz3iOA46L72AQhg@mail.gmail.com>
Subject: Re: caps file showing wrong TCG version?
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Errata: The file I'm checking is /sys/class/tpm/tpm0/device/caps. For
some reason the sys/class/tpm/tpm0 dir seems to have a sort of
recursive structure.
El mar., 4 sept. 2018 a las 17:03, Martin Galvan
(<omgalvan.86@gmail.com>) escribio:
>
> Hi all,
>
> I have an Infineon SLB 9665 TPM chip, which according to
> https://www.infineon.com/dgdl/Infineon-OPTIGA_TPM-PB-v10_15-EN.pdf?fileId=5546d46145da30e80145efa2f0b96a8e
> uses TPM 2.0. However, /sys/class/tpm/tpm0/device/tpm/tpm0/caps is
> showing "TCG version: 1.2". I'm aware that the versioning scheme using
> by the TCG is a bit confusing (e.g. 1.2 is the "Main" spec, while 2.0
> is a "library" spec), but I'm wondering whether this is correct.
>
> Thanks
