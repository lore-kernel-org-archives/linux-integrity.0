Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:33599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIEWL0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Sep 2018 18:11:26 -0400
Date: Wed, 05 Sep 2018 19:40:06 +0200
In-Reply-To: <CAN19L9GiTJnzWMPXLpkRWW2WSAvZx2-x0Co=Tf=V_-dUf4q3OQ@mail.gmail.com>
References: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com> <CAN19L9Ev=qYH-+BjZPcPJExML_zZBtSSV8cvz3iOA46L72AQhg@mail.gmail.com> <20180904213304.GD350@ziepe.ca> <CAN19L9GnjOR6QCZp7M=v+PnBUS2WmbPzoDX9vHVunrdB_yQOUA@mail.gmail.com> <20180905173223.GC11368@linux.intel.com> <CAN19L9GiTJnzWMPXLpkRWW2WSAvZx2-x0Co=Tf=V_-dUf4q3OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: caps file showing wrong TCG version?
To: Martin Galvan <omgalvan.86@gmail.com>,
        jarkko.sakkinen@linux.intel.com
CC: jgg@ziepe.ca, linux-integrity@vger.kernel.org
From: Peter Huewe <peterhuewe@gmx.de>
Message-ID: <52FC8331-FC48-4141-8D4A-7C113145935C@gmx.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



Am 5. September 2018 19:35:12 MESZ schrieb Martin Galvan <omgalvan.86@gmail.com>:
>El mie., 5 sept. 2018 a las 14:32, Jarkko Sakkinen
>(<jarkko.sakkinen@linux.intel.com>) escribio:
>> Those files do not make sense because you can get the same
>information
>> by talking to /dev/tpm0.
>
>Wouldn't that require using a lower-level interface, though? IIRC one
>of the reasons of tpm2-tools' existence is to provide a user-friendly
>way to do this. I was hoping there would be some way to do this
>without having to install tpm2-tools.
If you use the tpm (and care about the cve), you probably have the tools installed anyways.
If not you can use eltt2, it has much less dependencies:
 github.com/infineon/eltt2
Peter
-- 
Sent from my mobile
