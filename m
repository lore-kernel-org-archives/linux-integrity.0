Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pf1-f174.google.com ([209.85.210.174]:46579 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIECAE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Sep 2018 22:00:04 -0400
Received: by mail-pf1-f174.google.com with SMTP id u24-v6so2308841pfn.13
        for <linux-integrity@vger.kernel.org>; Tue, 04 Sep 2018 14:33:06 -0700 (PDT)
Date: Tue, 4 Sep 2018 15:33:04 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Martin Galvan <omgalvan.86@gmail.com>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Subject: Re: caps file showing wrong TCG version?
Message-ID: <20180904213304.GD350@ziepe.ca>
References: <CAN19L9E-_L-jmme8k1tLO+cKYMvGyMpspgpF1SZQOta6WwVyDw@mail.gmail.com>
 <CAN19L9Ev=qYH-+BjZPcPJExML_zZBtSSV8cvz3iOA46L72AQhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAN19L9Ev=qYH-+BjZPcPJExML_zZBtSSV8cvz3iOA46L72AQhg@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Sep 04, 2018 at 05:05:34PM -0300, Martin Galvan wrote:
> Errata: The file I'm checking is /sys/class/tpm/tpm0/device/caps. For
> some reason the sys/class/tpm/tpm0 dir seems to have a sort of
> recursive structure.

Recursive sounds bad.. what are you seeing?

Jason
