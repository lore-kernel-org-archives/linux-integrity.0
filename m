Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37872 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeEJOJt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 10:09:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1-v6so4657719wmb.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 07:09:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508104736.GA6132@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180508104736.GA6132@linux.intel.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Thu, 10 May 2018 09:09:47 -0500
Message-ID: <CAAi9uDuBt8K1Az7wHBR+OqhT6bL7xiKBNwh3AiZiiR_tuq5HcA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 8, 2018 at 5:47 AM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, May 04, 2018 at 08:00:22AM -0500, David R. Bild wrote:
> > Normally the system platform (i.e., BIOS/UEFI for x86) is responsible
> > for performing initialization of the TPM.  For these modules, the host
> > kernel is the platform, so we perform the initialization in the driver
> > before registering the TPM with the kernel TPM subsystem.
> >
> > The initialization consists of issuing the TPM startup command,
> > running the TPM self-test, and setting the TPM platform hierarchy
> > authorization to a random, unsaved value so that it can never be used
> > after the driver has loaded.
> >
> > Signed-off-by: David R. Bild <david.bild@xaptum.com>
>
> Have you checked what the TPM driver already does?


Yes.  It does the startup and self-test.

 However, this driver sets the platform hierarchy password *before*
giving the TPM to the TPM driver (thus, before the TPM driver can do
the startup and self-test).  Startup and self-test are prerequisites
for setting the platform hierarchy password, so this driver does those
itself too.

Best,
David
