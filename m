Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:13043 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbeIEWCI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Sep 2018 18:02:08 -0400
Date: Wed, 5 Sep 2018 20:30:57 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Martin Galvan <omgalvan.86@gmail.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: caps file showing wrong TCG version?
Message-ID: <20180905173057.GB11368@linux.intel.com>
References: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Sep 04, 2018 at 05:03:40PM -0300, Martin Galvan wrote:
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

It is clearly a TPM 1.2 chip as it talks TPM 1.x protocol. The caps file
is only shown for TPM 1.x devices and it uses TPM_ORD_GET_CAP command,
which is part of the TPM 1.x protocol.

/Jarkko
