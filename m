Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:41481 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeEDTGm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 May 2018 15:06:42 -0400
Received: by mail-io0-f194.google.com with SMTP id e12-v6so26823139iob.8
        for <linux-integrity@vger.kernel.org>; Fri, 04 May 2018 12:06:42 -0700 (PDT)
Date: Fri, 4 May 2018 13:06:38 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David R. Bild" <david.bild@xaptum.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Message-ID: <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180504130022.5231-3-david.bild@xaptum.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, May 04, 2018 at 08:00:22AM -0500, David R. Bild wrote:
> Normally the system platform (i.e., BIOS/UEFI for x86) is responsible
> for performing initialization of the TPM.  For these modules, the host
> kernel is the platform, so we perform the initialization in the driver
> before registering the TPM with the kernel TPM subsystem.
> 
> The initialization consists of issuing the TPM startup command,
> running the TPM self-test, and setting the TPM platform hierarchy
> authorization to a random, unsaved value so that it can never be used
> after the driver has loaded.

The tpm driver already does most of this stuff automatically, why
duplicate it there and why is it coded in a way that doesn't use the
existing TPM services to do it?

Make no sense to me.

Jason
