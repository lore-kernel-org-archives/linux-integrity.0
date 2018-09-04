Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41735 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeIECXB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Sep 2018 22:23:01 -0400
Received: by mail-wr1-f48.google.com with SMTP id z96-v6so5476399wrb.8
        for <linux-integrity@vger.kernel.org>; Tue, 04 Sep 2018 14:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
 <CAN19L9Ev=qYH-+BjZPcPJExML_zZBtSSV8cvz3iOA46L72AQhg@mail.gmail.com> <20180904213304.GD350@ziepe.ca>
In-Reply-To: <20180904213304.GD350@ziepe.ca>
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Tue, 4 Sep 2018 18:55:45 -0300
Message-ID: <CAN19L9GnjOR6QCZp7M=v+PnBUS2WmbPzoDX9vHVunrdB_yQOUA@mail.gmail.com>
Subject: Re: caps file showing wrong TCG version?
To: jgg@ziepe.ca
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

El mar., 4 sept. 2018 a las 18:33, Jason Gunthorpe (<jgg@ziepe.ca>) escribio:
> Recursive sounds bad.. what are you seeing?

At least on my system, /sys/class/tpm/tpm0/device has a 'tpm' dir
which seems to replicate the tpm0/device struct endlessly. Digging a
bit deeper I see:

$ ls -l /sys/class/tpm/tpm0/device
lrwxrwxrwx 1 root root 0 Sep  4 12:15 /sys/class/tpm/tpm0/device ->
../../../00:09

The 00:09 dir in turn refers to ls /sys/devices/pnp0/00:09.

On an unrelated note: I was recently told that
/sys/class/tpm/tpm0/caps doesn't exist for TPM 2.0. This is
inconvenient, since the manufacturer and version info exposed through
that file can be used to detect CVE-2017-15361. Is there an equivalent
file for TPM 2.0?
