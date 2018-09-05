Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39399 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeIEWGf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Sep 2018 18:06:35 -0400
Received: by mail-wr1-f52.google.com with SMTP id o37-v6so8530886wrf.6
        for <linux-integrity@vger.kernel.org>; Wed, 05 Sep 2018 10:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
 <CAN19L9Ev=qYH-+BjZPcPJExML_zZBtSSV8cvz3iOA46L72AQhg@mail.gmail.com>
 <20180904213304.GD350@ziepe.ca> <CAN19L9GnjOR6QCZp7M=v+PnBUS2WmbPzoDX9vHVunrdB_yQOUA@mail.gmail.com>
 <20180905173223.GC11368@linux.intel.com>
In-Reply-To: <20180905173223.GC11368@linux.intel.com>
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Wed, 5 Sep 2018 14:35:12 -0300
Message-ID: <CAN19L9GiTJnzWMPXLpkRWW2WSAvZx2-x0Co=Tf=V_-dUf4q3OQ@mail.gmail.com>
Subject: Re: caps file showing wrong TCG version?
To: jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

El mie., 5 sept. 2018 a las 14:32, Jarkko Sakkinen
(<jarkko.sakkinen@linux.intel.com>) escribio:
> Those files do not make sense because you can get the same information
> by talking to /dev/tpm0.

Wouldn't that require using a lower-level interface, though? IIRC one
of the reasons of tpm2-tools' existence is to provide a user-friendly
way to do this. I was hoping there would be some way to do this
without having to install tpm2-tools.
