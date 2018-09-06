Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:50889 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIFOhu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Sep 2018 10:37:50 -0400
Date: Thu, 6 Sep 2018 13:02:43 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Martin Galvan <omgalvan.86@gmail.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: caps file showing wrong TCG version?
Message-ID: <20180906100243.GB27302@linux.intel.com>
References: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
 <CAN19L9Ev=qYH-+BjZPcPJExML_zZBtSSV8cvz3iOA46L72AQhg@mail.gmail.com>
 <20180904213304.GD350@ziepe.ca>
 <CAN19L9GnjOR6QCZp7M=v+PnBUS2WmbPzoDX9vHVunrdB_yQOUA@mail.gmail.com>
 <20180905173223.GC11368@linux.intel.com>
 <CAN19L9GiTJnzWMPXLpkRWW2WSAvZx2-x0Co=Tf=V_-dUf4q3OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAN19L9GiTJnzWMPXLpkRWW2WSAvZx2-x0Co=Tf=V_-dUf4q3OQ@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Sep 05, 2018 at 02:35:12PM -0300, Martin Galvan wrote:
> El mie., 5 sept. 2018 a las 14:32, Jarkko Sakkinen
> (<jarkko.sakkinen@linux.intel.com>) escribio:
> > Those files do not make sense because you can get the same information
> > by talking to /dev/tpm0.
> 
> Wouldn't that require using a lower-level interface, though? IIRC one
> of the reasons of tpm2-tools' existence is to provide a user-friendly
> way to do this. I was hoping there would be some way to do this
> without having to install tpm2-tools.

Would be trivial to write utilities that talk raw TPM 2.0 protocol and
give you equivalent information.

Some sample code from my smoke tests:

  https://github.com/jsakkine-intel/tpm2-scripts

I would write such utilities in raw C though but as you can see it is
not rocket science.

/Jarkko
