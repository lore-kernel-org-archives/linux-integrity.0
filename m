Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42320 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbeIEWDg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Sep 2018 18:03:36 -0400
Date: Wed, 5 Sep 2018 20:32:23 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Martin Galvan <omgalvan.86@gmail.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: caps file showing wrong TCG version?
Message-ID: <20180905173223.GC11368@linux.intel.com>
References: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
 <CAN19L9Ev=qYH-+BjZPcPJExML_zZBtSSV8cvz3iOA46L72AQhg@mail.gmail.com>
 <20180904213304.GD350@ziepe.ca>
 <CAN19L9GnjOR6QCZp7M=v+PnBUS2WmbPzoDX9vHVunrdB_yQOUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAN19L9GnjOR6QCZp7M=v+PnBUS2WmbPzoDX9vHVunrdB_yQOUA@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Sep 04, 2018 at 06:55:45PM -0300, Martin Galvan wrote:
> El mar., 4 sept. 2018 a las 18:33, Jason Gunthorpe (<jgg@ziepe.ca>) escribio:
> > Recursive sounds bad.. what are you seeing?
> 
> At least on my system, /sys/class/tpm/tpm0/device has a 'tpm' dir
> which seems to replicate the tpm0/device struct endlessly. Digging a
> bit deeper I see:
> 
> $ ls -l /sys/class/tpm/tpm0/device
> lrwxrwxrwx 1 root root 0 Sep  4 12:15 /sys/class/tpm/tpm0/device ->
> ../../../00:09
> 
> The 00:09 dir in turn refers to ls /sys/devices/pnp0/00:09.
> 
> On an unrelated note: I was recently told that
> /sys/class/tpm/tpm0/caps doesn't exist for TPM 2.0. This is
> inconvenient, since the manufacturer and version info exposed through
> that file can be used to detect CVE-2017-15361. Is there an equivalent
> file for TPM 2.0?

Those files do not make sense because you can get the same information
by talking to /dev/tpm0.

/Jarkko
